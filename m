Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVAQDfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVAQDfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVAQDdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:33:46 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:14084
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262534AbVAQDdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:36 -0500
Message-Id: <200501170556.j0H5u5kY006052@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/10] UML - Provide a release method for the ubd driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:05 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a release method for the ubd driver so that sysfs doesn't complain
when one is removed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/drivers/ubd_kern.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/ubd_kern.c	2005-01-16 13:23:29.000000000 -0500
+++ 2.6.10/arch/um/drivers/ubd_kern.c	2005-01-16 13:23:34.000000000 -0500
@@ -635,6 +635,10 @@
 	return(err);
 }
 
+static void ubd_device_release(struct device *dev)
+{
+}
+
 static int ubd_new_disk(int major, u64 size, int unit,
 			struct gendisk **disk_out)
 			
@@ -670,6 +674,7 @@
 	if (major == MAJOR_NR) {
 		ubd_dev[unit].pdev.id   = unit;
 		ubd_dev[unit].pdev.name = DRIVER_NAME;
+		ubd_dev[unit].pdev.dev.release = ubd_device_release;
 		platform_device_register(&ubd_dev[unit].pdev);
 		disk->driverfs_dev = &ubd_dev[unit].pdev.dev;
 	}

