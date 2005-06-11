Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVFKIRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVFKIRE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVFKIRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:17:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:2244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261651AbVFKHsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:45 -0400
Subject: [PATCH] Remove the miscdevice devfs_name field as it's no longer needed
In-Reply-To: <11184761113852@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <11184761112634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/microcode.c        |    1 -
 arch/sh/kernel/cpu/sh4/sq.c         |    1 -
 drivers/block/pktcdvd.c             |    1 -
 drivers/char/misc.c                 |    4 ----
 drivers/char/mmtimer.c              |    1 -
 drivers/md/dm-ioctl.c               |    1 -
 drivers/media/radio/miropcm20-rds.c |    1 -
 drivers/net/tun.c                   |    1 -
 drivers/s390/char/monreader.c       |    1 -
 drivers/s390/crypto/z90main.c       |    1 -
 include/linux/miscdevice.h          |    1 -
 11 files changed, 14 deletions(-)

--- gregkh-2.6.orig/arch/i386/kernel/microcode.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/arch/i386/kernel/microcode.c	2005-06-10 23:37:21.000000000 -0700
@@ -480,7 +480,6 @@
 static struct miscdevice microcode_dev = {
 	.minor		= MICROCODE_MINOR,
 	.name		= "microcode",
-	.devfs_name	= "cpu/microcode",
 	.fops		= &microcode_fops,
 };
 
--- gregkh-2.6.orig/drivers/block/pktcdvd.c	2005-06-10 23:29:01.000000000 -0700
+++ gregkh-2.6/drivers/block/pktcdvd.c	2005-06-10 23:37:21.000000000 -0700
@@ -2633,7 +2633,6 @@
 static struct miscdevice pkt_misc = {
 	.minor 		= MISC_DYNAMIC_MINOR,
 	.name  		= "pktcdvd",
-	.devfs_name 	= "pktcdvd/control",
 	.fops  		= &pkt_ctl_fops
 };
 
--- gregkh-2.6.orig/drivers/char/misc.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/misc.c	2005-06-10 23:37:21.000000000 -0700
@@ -231,10 +231,6 @@
 
 	if (misc->minor < DYNAMIC_MINORS)
 		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
-	if (misc->devfs_name[0] == '\0') {
-		snprintf(misc->devfs_name, sizeof(misc->devfs_name),
-				"misc/%s", misc->name);
-	}
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
 	misc->class = class_device_create(misc_class, dev, misc->dev,
--- gregkh-2.6.orig/drivers/media/radio/miropcm20-rds.c	2005-06-10 23:29:01.000000000 -0700
+++ gregkh-2.6/drivers/media/radio/miropcm20-rds.c	2005-06-10 23:37:21.000000000 -0700
@@ -114,7 +114,6 @@
 static struct miscdevice rds_miscdev = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "radiotext",
-	.devfs_name	= "v4l/rds/radiotext",
 	.fops		= &rds_fops,
 };
 
--- gregkh-2.6.orig/drivers/net/tun.c	2005-06-10 23:29:01.000000000 -0700
+++ gregkh-2.6/drivers/net/tun.c	2005-06-10 23:37:21.000000000 -0700
@@ -759,7 +759,6 @@
 	.minor = TUN_MINOR,
 	.name = "tun",
 	.fops = &tun_fops,
-	.devfs_name = "net/tun",
 };
 
 /* ethtool interface */
--- gregkh-2.6.orig/drivers/s390/char/monreader.c	2005-06-10 23:29:01.000000000 -0700
+++ gregkh-2.6/drivers/s390/char/monreader.c	2005-06-10 23:37:21.000000000 -0700
@@ -588,7 +588,6 @@
 
 static struct miscdevice mon_dev = {
 	.name       = "monreader",
-	.devfs_name = "monreader",
 	.fops       = &mon_fops,
 	.minor      = MISC_DYNAMIC_MINOR,
 };
--- gregkh-2.6.orig/include/linux/miscdevice.h	2005-06-10 23:29:01.000000000 -0700
+++ gregkh-2.6/include/linux/miscdevice.h	2005-06-10 23:37:21.000000000 -0700
@@ -40,7 +40,6 @@
 	struct list_head list;
 	struct device *dev;
 	struct class_device *class;
-	char devfs_name[64];
 };
 
 extern int misc_register(struct miscdevice * misc);
--- gregkh-2.6.orig/drivers/md/dm-ioctl.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/md/dm-ioctl.c	2005-06-10 23:37:21.000000000 -0700
@@ -1350,7 +1350,6 @@
 static struct miscdevice _dm_misc = {
 	.minor 		= MISC_DYNAMIC_MINOR,
 	.name  		= DM_NAME,
-	.devfs_name 	= "mapper/control",
 	.fops  		= &_ctl_fops
 };
 
--- gregkh-2.6.orig/drivers/s390/crypto/z90main.c	2005-06-10 23:29:01.000000000 -0700
+++ gregkh-2.6/drivers/s390/crypto/z90main.c	2005-06-10 23:37:21.000000000 -0700
@@ -449,7 +449,6 @@
 	.minor	    = Z90CRYPT_MINOR,
 	.name	    = DEV_NAME,
 	.fops	    = &z90crypt_fops,
-	.devfs_name = DEV_NAME
 };
 #endif
 
--- gregkh-2.6.orig/arch/sh/kernel/cpu/sh4/sq.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/arch/sh/kernel/cpu/sh4/sq.c	2005-06-10 23:37:21.000000000 -0700
@@ -417,7 +417,6 @@
 static struct miscdevice sq_dev = {
 	.minor		= STORE_QUEUE_MINOR,
 	.name		= "sq",
-	.devfs_name	= "cpu/sq",
 	.fops		= &sq_fops,
 };
 
--- gregkh-2.6.orig/drivers/char/mmtimer.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/mmtimer.c	2005-06-10 23:37:21.000000000 -0700
@@ -704,7 +704,6 @@
 		return -1;
 	}
 
-	strcpy(mmtimer_miscdev.devfs_name, MMTIMER_NAME);
 	if (misc_register(&mmtimer_miscdev)) {
 		printk(KERN_ERR "%s: failed to register device\n",
 		       MMTIMER_NAME);

