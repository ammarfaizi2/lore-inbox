Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319203AbSIKQMm>; Wed, 11 Sep 2002 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319199AbSIKQLI>; Wed, 11 Sep 2002 12:11:08 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:18614 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S319204AbSIKQHA> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:07:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (6/10): xpram driver.
Date: Wed, 11 Sep 2002 18:08:49 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111802.58996.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
a fix for the xpram driver, remove the reference to xpram_release.

blue skies,
  Martin.

diff -urN linux-2.5.34/drivers/s390/block/xpram.c linux-2.5.34-s390/drivers/s390/block/xpram.c
--- linux-2.5.34/drivers/s390/block/xpram.c	Mon Sep  9 19:35:14 2002
+++ linux-2.5.34-s390/drivers/s390/block/xpram.c	Tue Aug 27 17:44:53 2002
@@ -15,7 +15,6 @@
  *   Device specific file operations
  *        xpram_iotcl
  *        xpram_open
- *        xpram_release
  *
  * "ad-hoc" partitioning:
  *    the expanded memory can be partitioned among several devices 
@@ -36,6 +35,7 @@
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/device.h>
+#include <linux/bio.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
@@ -328,7 +328,6 @@
 	return 0;
 }
 
-
 static int xpram_ioctl (struct inode *inode, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
@@ -354,14 +353,12 @@
 	put_user(4, &geo->start);
 	return 0;
 }
-}
 
 static struct block_device_operations xpram_devops =
 {
 	owner:   THIS_MODULE,
 	ioctl:   xpram_ioctl,
 	open:    xpram_open,
-	release: xpram_release,
 };
 
 /*

