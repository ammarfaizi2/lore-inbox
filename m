Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUIAX0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUIAX0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUIAXWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:22:43 -0400
Received: from baikonur.stro.at ([213.239.196.228]:35545 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267594AbUIAXQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:44 -0400
Subject: [patch 11/14]  radio/radio-zoltrix: replace 	sleep_delay() with schedule()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:38 +0200
Message-ID: <E1C2eLH-0002rZ-CX@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replaced sleep_delay() with schedule() in all locations. Removed definition of sleep_delay().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-zoltrix.c |   24 ++++--------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff -puN drivers/media/radio/radio-zoltrix.c~msleep-drivers_media_radio-zoltrix drivers/media/radio/radio-zoltrix.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-zoltrix.c~msleep-drivers_media_radio-zoltrix	2004-09-01 19:35:14.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-zoltrix.c	2004-09-01 19:35:14.000000000 +0200
@@ -54,12 +54,6 @@ struct zol_device {
 
 /* local things */
 
-static void sleep_delay(void)
-{
-	/* Sleep nicely for +/- 10 mS */
-	schedule();
-}
-
 static int zol_setvol(struct zol_device *dev, int vol)
 {
 	dev->curvol = vol;
@@ -76,7 +70,7 @@ static int zol_setvol(struct zol_device 
 	}
 
 	outb(dev->curvol-1, io);
-	sleep_delay();
+	schedule();
 	inb(io + 2);
 	up(&dev->lock);
 	return 0;
@@ -176,11 +170,11 @@ int zol_getsigstr(struct zol_device *dev
 	down(&dev->lock);
 	outb(0x00, io);         /* This stuff I found to do nothing */
 	outb(dev->curvol, io);
-	sleep_delay();
-	sleep_delay();
+	schedule();
+	schedule();
 
 	a = inb(io);
-	sleep_delay();
+	schedule();
 	b = inb(io);
 
 	up(&dev->lock);
@@ -202,11 +196,11 @@ int zol_is_stereo (struct zol_device *de
 	
 	outb(0x00, io);
 	outb(dev->curvol, io);
-	sleep_delay();
-	sleep_delay();
+	schedule();
+	schedule();
 
 	x1 = inb(io);
-	sleep_delay();
+	schedule();
 	x2 = inb(io);
 
 	up(&dev->lock);
@@ -368,8 +362,8 @@ static int __init zoltrix_init(void)
 
 	outb(0, io);
 	outb(0, io);
-	sleep_delay();
-	sleep_delay();
+	schedule();
+	schedule();
 	inb(io + 3);
 
 	zoltrix_unit.curvol = 0;

_
