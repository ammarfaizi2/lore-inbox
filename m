Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270989AbUJUVcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270989AbUJUVcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270972AbUJUVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:21:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:5528 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S270928AbUJUVRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:17:44 -0400
Date: Thu, 21 Oct 2004 16:17:18 -0500
From: mike.miller@hp.com
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch 1/2] cciss: cleans up warnings in the 32/64 bit conversions
Message-ID: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 2 for 20041021.
This patch cleans up some warnings in the 32-bit to 64-bit conversions.
Please consider this for inclusion. Built against 2.4.28-pre4.
Please apply in order.

 cciss.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

Signed off by Mike Miller.
-------------------------------------------------------------------------------
diff -burNp lx2428-pre4.orig/drivers/block/cciss.c lx2428-pre4/drivers/block/cciss.c
--- lx2428-pre4.orig/drivers/block/cciss.c	2004-10-21 09:14:27.388939808 -0500
+++ lx2428-pre4/drivers/block/cciss.c	2004-10-21 09:27:05.810642184 -0500
@@ -532,10 +532,9 @@ register_ioctl32_conversion(unsigned int
 extern int unregister_ioctl32_conversion(unsigned int cmd);
 
 static int cciss_ioctl32_passthru(unsigned int fd, unsigned cmd, unsigned long arg, struct file *file);
-static int cciss_ioctl32_big_passthru(unsigned int fd, unsigned cmd, unsigned long arg, 
-	struct file *file);
+static int cciss_ioctl32_big_passthru(unsigned int fd, unsigned cmd, unsigned long arg, struct file *file);
 
-typedef long (*handler_type) (unsigned int, unsigned int, unsigned long,
+typedef int (*handler_type) (unsigned int, unsigned int, unsigned long,
 				struct file *);
 
 static struct ioctl32_map {
@@ -611,7 +610,7 @@ int cciss_ioctl32_passthru(unsigned int 
 	err |= copy_from_user(&arg64.Request, &arg32->Request, sizeof(arg64.Request));
 	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
 	err |= get_user(arg64.buf_size, &arg32->buf_size);
-	err |= get_user(arg64.buf, &arg32->buf);
+	err |= get_user((__u64) arg64.buf, &arg32->buf);
 	if (err) 
 		return -EFAULT; 
 
@@ -641,7 +640,7 @@ int cciss_ioctl32_big_passthru(unsigned 
 	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
 	err |= get_user(arg64.buf_size, &arg32->buf_size);
 	err |= get_user(arg64.malloc_size, &arg32->malloc_size);
-	err |= get_user(arg64.buf, &arg32->buf);
+	err |= get_user((__u64) arg64.buf, &arg32->buf);
 	if (err) return -EFAULT; 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
