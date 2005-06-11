Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVFKUXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVFKUXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVFKUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:22:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59398 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261825AbVFKUWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:22:19 -0400
Date: Sat, 11 Jun 2005 22:22:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/ch.c: remove devfs stuff
Message-ID: <20050611202211.GO3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems very unlikely that this driver will go into any stable kernel 
before devfs will be removed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc6-mm1-full/drivers/scsi/ch.c.old	2005-06-11 21:02:32.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/scsi/ch.c	2005-06-11 21:03:57.000000000 +0200
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
 #include <linux/completion.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/chio.h>			/* here are all the ioctls */
@@ -940,8 +939,6 @@
 	if (init)
 		ch_init_elem(ch);
 
-	devfs_mk_cdev(MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
-		      S_IFCHR | S_IRUGO | S_IWUGO, ch->name);
 	class_device_create(ch_sysfs_class,
 			    MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
 			    dev, "s%s", ch->name);
@@ -974,7 +971,6 @@
 
 	class_device_destroy(ch_sysfs_class,
 			     MKDEV(SCSI_CHANGER_MAJOR,ch->minor));
-	devfs_remove(ch->name);
 	kfree(ch->dt);
 	kfree(ch);
 	ch_devcount--;

