Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSLKT7C>; Wed, 11 Dec 2002 14:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSLKT7C>; Wed, 11 Dec 2002 14:59:02 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:59400 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S264637AbSLKT7A>; Wed, 11 Dec 2002 14:59:00 -0500
Date: Wed, 11 Dec 2002 14:06:43 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/char
Message-ID: <20021211200643.GB28537@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patchset that fixes various files under drivers/char to
use C99 initializers. The patch is against 2.5.51.

Art Haas

--- linux-2.5.51/drivers/char/rio/rio_linux.c.old	2002-10-19 11:21:27.000000000 -0500
+++ linux-2.5.51/drivers/char/rio/rio_linux.c	2002-12-10 13:51:11.000000000 -0600
@@ -276,8 +276,8 @@
  */
 
 static struct file_operations rio_fw_fops = {
-	owner:		THIS_MODULE,
-	ioctl:		rio_fw_ioctl,
+	.owner		= THIS_MODULE,
+	.ioctl		= rio_fw_ioctl,
 };
 
 struct miscdevice rio_fw_device = {
--- linux-2.5.51/drivers/char/ftape/zftape/zftape-init.c.old	2002-12-10 09:33:42.000000000 -0600
+++ linux-2.5.51/drivers/char/ftape/zftape/zftape-init.c	2002-12-10 13:51:11.000000000 -0600
@@ -96,13 +96,13 @@
 
 static struct file_operations zft_cdev =
 {
-	owner:		THIS_MODULE,
-	read:		zft_read,
-	write:		zft_write,
-	ioctl:		zft_ioctl,
-	mmap:		zft_mmap,
-	open:		zft_open,
-	release:	zft_close,
+	.owner		= THIS_MODULE,
+	.read		= zft_read,
+	.write		= zft_write,
+	.ioctl		= zft_ioctl,
+	.mmap		= zft_mmap,
+	.open		= zft_open,
+	.release	= zft_close,
 };
 
 /*      Open floppy tape device
--- linux-2.5.51/drivers/char/drm/ffb_drv.c.old	2002-07-05 18:42:27.000000000 -0500
+++ linux-2.5.51/drivers/char/drm/ffb_drv.c	2002-12-10 13:51:11.000000000 -0600
@@ -28,16 +28,16 @@
 
 #define DRIVER_FOPS						\
 static struct file_operations	DRM(fops) = {			\
-	owner:   		THIS_MODULE,			\
-	open:	 		DRM(open),			\
-	flush:	 		DRM(flush),			\
-	release: 		DRM(release),			\
-	ioctl:	 		DRM(ioctl),			\
-	mmap:	 		DRM(mmap),			\
-	read:	 		DRM(read),			\
-	fasync:	 		DRM(fasync),			\
-	poll:	 		DRM(poll),			\
-	get_unmapped_area:	ffb_get_unmapped_area,		\
+	.owner   		= THIS_MODULE,			\
+	.open	 		= DRM(open),			\
+	.flush	 		= DRM(flush),			\
+	.release 		= DRM(release),			\
+	.ioctl	 		= DRM(ioctl),			\
+	.mmap	 		= DRM(mmap),			\
+	.read	 		= DRM(read),			\
+	.fasync	 		= DRM(fasync),			\
+	.poll	 		= DRM(poll),			\
+	.get_unmapped_area	= ffb_get_unmapped_area,		\
 }
 
 #define DRIVER_COUNT_CARDS()	ffb_count_card_instances()
--- linux-2.5.51/drivers/char/mwave/mwavedd.c.old	2002-11-18 01:01:56.000000000 -0600
+++ linux-2.5.51/drivers/char/mwave/mwavedd.c	2002-12-10 13:51:11.000000000 -0600
@@ -429,12 +429,12 @@
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static struct file_operations mwave_fops = {
-	owner:THIS_MODULE,
-	read:mwave_read,
-	write:mwave_write,
-	ioctl:mwave_ioctl,
-	open:mwave_open,
-	release:mwave_close
+	.owner		= THIS_MODULE,
+	.read		= mwave_read,
+	.write		= mwave_write,
+	.ioctl		= mwave_ioctl,
+	.open		= mwave_open,
+	.release	= mwave_close
 };
 #else
 static struct file_operations mwave_fops = {
--- linux-2.5.51/drivers/char/watchdog/softdog.c.old	2002-11-22 19:45:01.000000000 -0600
+++ linux-2.5.51/drivers/char/watchdog/softdog.c	2002-12-10 13:51:11.000000000 -0600
@@ -139,7 +139,7 @@
 	unsigned int cmd, unsigned long arg)
 {
 	static struct watchdog_info ident = {
-		identity: "Software Watchdog",
+		.identity = "Software Watchdog",
 	};
 	switch (cmd) {
 		default:
@@ -158,17 +158,17 @@
 }
 
 static struct file_operations softdog_fops = {
-	owner:		THIS_MODULE,
-	write:		softdog_write,
-	ioctl:		softdog_ioctl,
-	open:		softdog_open,
-	release:	softdog_release,
+	.owner		= THIS_MODULE,
+	.write		= softdog_write,
+	.ioctl		= softdog_ioctl,
+	.open		= softdog_open,
+	.release	= softdog_release,
 };
 
 static struct miscdevice softdog_miscdev = {
-	minor:		WATCHDOG_MINOR,
-	name:		"watchdog",
-	fops:		&softdog_fops,
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &softdog_fops,
 };
 
 static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.06, soft_margin: %d sec, nowayout: %d\n";
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
