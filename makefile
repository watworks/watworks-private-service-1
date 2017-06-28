dev-up:
	docker-compose up -d

dev-down:
	docker-compose down

dev-rebuild: dev-down
	docker-compose up --build -d

deps-install:
	docker-compose run app composer install

deps-update:
	docker-compose run app composer update

repl:
	docker-compose run app vendor/bin/psysh src/app.php
	
test:
	docker-compose run app vendor/bin/phpunit --colors=auto

format:
	docker-compose run app vendor/bin/php-cs-fixer fix .

build:
	# force rebuilding deps to ensure only required deps are included
	# in the built image
	docker-compose run app rm -rf vendor/*
	docker-compose run app composer install --no-dev
	docker build -t watworks-private-service-1 .

publish: build
	echo TODO

.PHONY: dev-up dev-down deps-install deps-update repl test format build publish