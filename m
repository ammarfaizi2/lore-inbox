Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSHCSOG>; Sat, 3 Aug 2002 14:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSHCSNB>; Sat, 3 Aug 2002 14:13:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10256 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317641AbSHCSMy>; Sat, 3 Aug 2002 14:12:54 -0400
To: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 8: 2.5.29-rd
Message-Id: <E17b3Rq-0006wY-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch adds support for "initrd=start,size" on the kernel command
line.  This allows us (the ARM folk) to give details of the initrd
on the (default) command line rather than hard-coding such stuff
into the kernel proper.

 drivers/block/rd.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions

diff -urN orig/drivers/block/rd.c linux/drivers/block/rd.c
--- orig/drivers/block/rd.c	Thu Jul 25 20:13:26 2002
+++ linux/drivers/block/rd.c	Fri Aug  2 17:34:53 2002
@@ -349,6 +349,25 @@
 	release:	initrd_release,
 };
 
+/*
+ * Add function to specify initrd address as initrd=start,size
+ *   start is a phyical address
+ *   size is the size of the initrd ramdisk
+ */
+
+static int __init setup_initrd(char *str)
+{
+	unsigned long start = memparse(str, &str);
+
+	if (str && *str == ',') {
+		initrd_start = (unsigned long)phys_to_virt(start);
+		initrd_end = initrd_start + memparse(str + 1, &str);
+	}
+	return 1;
+}
+
+__setup("initrd=", setup_initrd);
+
 #endif
 
 

