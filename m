Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVAQDfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVAQDfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVAQDdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:33:51 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:15620
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262544AbVAQDdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:39 -0500
Message-Id: <200501170556.j0H5u8kY006057@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/10] UML - allow ubd devices to provide partial end blocks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the file backing a ubd device is not an even blocklength, then the last
partial block is now readable, and it is padded with zeros.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/drivers/ubd_kern.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/ubd_kern.c	2005-01-16 20:37:24.000000000 -0500
+++ 2.6.10/arch/um/drivers/ubd_kern.c	2005-01-16 20:40:41.000000000 -0500
@@ -682,6 +682,8 @@
 	return 0;
 }
 
+#define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
+
 static int ubd_add(int n)
 {
 	struct ubd *dev = &ubd_dev[n];
@@ -697,6 +699,8 @@
 	if(err < 0)
 		return(err);
 
+	dev->size = ROUND_BLOCK(dev->size);
+
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
 	if(err) 
 		return(err);

