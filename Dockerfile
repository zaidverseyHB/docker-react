#Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
#/app/build <--- all the stuff needed to copy over to run phase

#Run Phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#No need to specify run command as the nginx container will automatically startup
#as it is setup with the startup command by default