Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVAKX7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVAKX7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVAKXl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:41:29 -0500
Received: from coderock.org ([193.77.147.115]:4806 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262934AbVAKXfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:14 -0500
Subject: [patch 05/11] media/radio-zoltrix: replace sleep_delay() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:04 +0100
Message-Id: <20050111233505.38A5B1F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep() instead of sleep_delay() so that the driver
sleeps as the comment indicated. I assumed that two sleep_delay()s in a
row indicated sleeping for 20ms. Please let me know if this is
incorrect.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/media/radio/radio-zoltrix.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff -puN drivers/media/radio/radio-zoltrix.c~msleep-drivers_media_radio_radio-zoltrix drivers/media/radio/radio-zoltrix.c
--- kj/drivers/media/radio/radio-zoltrix.c~msleep-drivers_media_radio_radio-zoltrix	2005-01-10 17:59:58.000000000 +0100
+++ kj-domen/drivers/media/radio/radio-zoltrix.c	2005-01-10 17:59:58.000000000 +0100
@@ -29,7 +29,7 @@
 #include <linux/module.h>	/* Modules                        */
 #include <linux/init.h>		/* Initdata                       */
 #include <linux/ioport.h>	/* check_region, request_region   */
-#include <linux/delay.h>	/* udelay                 */
+#include <linux/delay.h>	/* udelay, msleep                 */
 #include <asm/io.h>		/* outb, outb_p                   */
 #include <asm/uaccess.h>	/* copy to/from user              */
 #include <linux/videodev.h>	/* kernel radio structs           */
@@ -51,15 +51,6 @@ struct zol_device {
 	struct semaphore lock;
 };
 
-
-/* local things */
-
-static void sleep_delay(void)
-{
-	/* Sleep nicely for +/- 10 mS */
-	schedule();
-}
-
 static int zol_setvol(struct zol_device *dev, int vol)
 {
 	dev->curvol = vol;
@@ -76,7 +67,7 @@ static int zol_setvol(struct zol_device 
 	}
 
 	outb(dev->curvol-1, io);
-	sleep_delay();
+	msleep(10);
 	inb(io + 2);
 	up(&dev->lock);
 	return 0;
@@ -176,11 +167,10 @@ static int zol_getsigstr(struct zol_devi
 	down(&dev->lock);
 	outb(0x00, io);         /* This stuff I found to do nothing */
 	outb(dev->curvol, io);
-	sleep_delay();
-	sleep_delay();
+	msleep(20);
 
 	a = inb(io);
-	sleep_delay();
+	msleep(10);
 	b = inb(io);
 
 	up(&dev->lock);
@@ -202,11 +192,10 @@ static int zol_is_stereo (struct zol_dev
 	
 	outb(0x00, io);
 	outb(dev->curvol, io);
-	sleep_delay();
-	sleep_delay();
+	msleep(20);
 
 	x1 = inb(io);
-	sleep_delay();
+	msleep(10);
 	x2 = inb(io);
 
 	up(&dev->lock);
@@ -368,8 +357,7 @@ static int __init zoltrix_init(void)
 
 	outb(0, io);
 	outb(0, io);
-	sleep_delay();
-	sleep_delay();
+	msleep(20);
 	inb(io + 3);
 
 	zoltrix_unit.curvol = 0;
_
