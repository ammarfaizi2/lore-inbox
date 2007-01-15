Return-Path: <linux-kernel-owner+w=401wt.eu-S932341AbXAONoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbXAONoz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbXAONoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:44:54 -0500
Received: from tim.rpsys.net ([194.106.48.114]:60900 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932341AbXAONoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:44:54 -0500
Subject: Re: LEDS: S3C24XX generate name if none given
From: Richard Purdie <rpurdie@rpsys.net>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070115122654.GA25047@home.fluff.org>
References: <20070115122654.GA25047@home.fluff.org>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 13:44:28 +0000
Message-Id: <1168868669.5860.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 12:26 +0000, Ben Dooks wrote:
> Generate a name if none is passed to the S3C24XX GPIO LED driver.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> diff -urpN -X ../dontdiff linux-2.6.19/drivers/leds/leds-s3c24xx.c linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c
> --- linux-2.6.19/drivers/leds/leds-s3c24xx.c	2006-11-29 21:57:37.000000000 +0000
> +++ linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c	2007-01-04 10:22:58.000000000 +0000
> @@ -23,6 +23,8 @@
>  /* our context */
>  
>  struct s3c24xx_gpio_led {
> +	char				 name[32];
> +
>  	struct led_classdev		 cdev;

I'm not that keen on this since it wastes 32 bytes per LED when the
platform code does declare the names. If you're happy with that, its up
to you as the platform maintainer I guess but is there no nicer way to
handle this? I'm mainly concerned about people copying this code into
other drivers as then they'll all end up doing it...

Richard

