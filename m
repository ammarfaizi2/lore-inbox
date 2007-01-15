Return-Path: <linux-kernel-owner+w=401wt.eu-S932240AbXAOM1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbXAOM1K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXAOM1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:27:10 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:50241 "EHLO
	aeryn.fluff.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbXAOM1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:27:09 -0500
Date: Mon, 15 Jan 2007 12:26:54 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: rpurdie@rpsys.net, linux-kernel@vger.kernel.org
Subject: LEDS: S3C24XX generate name if none given
Message-ID: <20070115122654.GA25047@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generate a name if none is passed to the S3C24XX GPIO LED driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.19/drivers/leds/leds-s3c24xx.c linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c
--- linux-2.6.19/drivers/leds/leds-s3c24xx.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c	2007-01-04 10:22:58.000000000 +0000
@@ -23,6 +23,8 @@
 /* our context */
 
 struct s3c24xx_gpio_led {
+	char				 name[32];
+
 	struct led_classdev		 cdev;
 	struct s3c24xx_led_platdata	*pdata;
 };
@@ -85,6 +87,14 @@ static int s3c24xx_led_probe(struct plat
 
 	led->pdata = pdata;
 
+	/* create name if we where not passed one */
+
+	if (led->cdev.name == NULL) {
+		snprintf(led->name, sizeof(led->name), "%s.%d",
+			 dev->name, dev->id);
+		led->cdev.name = led->name;
+	}
+
 	/* no point in having a pull-up if we are always driving */
 
 	if (pdata->flags & S3C24XX_LEDF_TRISTATE) {
