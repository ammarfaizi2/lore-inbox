Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265431AbSKARmN>; Fri, 1 Nov 2002 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265438AbSKARmN>; Fri, 1 Nov 2002 12:42:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265431AbSKARmM>;
	Fri, 1 Nov 2002 12:42:12 -0500
Subject: [PATCH] trivial fix for raw compiled as module 2.5.45
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <jens@suse.de>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 09:48:30 -0800
Message-Id: <1036172910.3316.68.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't compile raw.c as module because blkdev_ioctl is not exported.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.877   -> 1.878  
#	drivers/block/ioctl.c	1.51    -> 1.52   
#	drivers/block/Makefile	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/01	shemminger@osdl.org	1.878
# Export block dev to allow raw to be built as a module
# --------------------------------------------
#
diff -Nru a/drivers/block/Makefile b/drivers/block/Makefile
--- a/drivers/block/Makefile	Fri Nov  1 09:45:40 2002
+++ b/drivers/block/Makefile	Fri Nov  1 09:45:40 2002
@@ -8,8 +8,8 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= elevator.o ll_rw_blk.o loop.o genhd.o acsi.o \
-		   scsi_ioctl.o deadline-iosched.o
+export-objs	:= elevator.o ll_rw_blk.o ioctl.o loop.o genhd.o acsi.o \
+		   scsi_ioctl.o deadline-iosched.o 
 
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
 
diff -Nru a/drivers/block/ioctl.c b/drivers/block/ioctl.c
--- a/drivers/block/ioctl.c	Fri Nov  1 09:45:40 2002
+++ b/drivers/block/ioctl.c	Fri Nov  1 09:45:40 2002
@@ -1,4 +1,5 @@
 #include <linux/sched.h>		/* for capable() */
+#include <linux/module.h>
 #include <linux/blk.h>			/* for set_device_ro() */
 #include <linux/blkpg.h>
 #include <linux/backing-dev.h>
@@ -214,3 +215,5 @@
 	}
 	return -ENOTTY;
 }
+
+EXPORT_SYMBOL(blkdev_ioctl);

