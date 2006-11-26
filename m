Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967300AbWKZFbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967300AbWKZFbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 00:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935242AbWKZFbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 00:31:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935240AbWKZFbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 00:31:24 -0500
Date: Sun, 26 Nov 2006 06:31:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove fs/jffs2/ioctl.c
Message-ID: <20061126053126.GJ15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/jffs2/ioctl.c is already for so long in the "might be used later" 
state that I doubt it will ever be actually used...

And if it will ever be used, reverting this patch will be trivial.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jffs2/Makefile   |    2 +-
 fs/jffs2/dir.c      |    1 -
 fs/jffs2/file.c     |    1 -
 fs/jffs2/ioctl.c    |   23 -----------------------
 fs/jffs2/os-linux.h |    3 ---
 5 files changed, 1 insertion(+), 29 deletions(-)

--- linux-2.6.14-rc5-mm1-full/fs/jffs2/os-linux.h.old	2005-11-01 20:28:24.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/jffs2/os-linux.h	2005-11-01 20:28:31.000000000 +0100
@@ -147,9 +147,6 @@
 int jffs2_fsync(struct file *, struct dentry *, int);
 int jffs2_do_readpage_unlock (struct inode *inode, struct page *pg);
 
-/* ioctl.c */
-int jffs2_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
-
 /* symlink.c */
 extern struct inode_operations jffs2_symlink_inode_operations;
 
--- linux-2.6.14-rc5-mm1-full/fs/jffs2/dir.c.old	2005-11-01 20:28:39.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/jffs2/dir.c	2005-11-01 20:28:43.000000000 +0100
@@ -41,7 +41,6 @@
 {
 	.read =		generic_read_dir,
 	.readdir =	jffs2_readdir,
-	.ioctl =	jffs2_ioctl,
 	.fsync =	jffs2_fsync
 };
 
--- linux-2.6.14-rc5-mm1-full/fs/jffs2/Makefile.old	2005-11-01 20:31:23.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/jffs2/Makefile	2005-11-01 20:31:41.000000000 +0100
@@ -6,7 +6,7 @@
 
 obj-$(CONFIG_JFFS2_FS) += jffs2.o
 
-jffs2-y	:= compr.o dir.o file.o ioctl.o nodelist.o malloc.o
+jffs2-y	:= compr.o dir.o file.o nodelist.o malloc.o
 jffs2-y	+= read.o nodemgmt.o readinode.o write.o scan.o gc.o
 jffs2-y	+= symlink.o build.o erase.o background.o fs.o writev.o
 jffs2-y	+= super.o
--- linux-2.6.15-rc5-mm2-full/fs/jffs2/ioctl.c	2005-12-11 15:01:46.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,23 +0,0 @@
-/*
- * JFFS2 -- Journalling Flash File System, Version 2.
- *
- * Copyright (C) 2001-2003 Red Hat, Inc.
- *
- * Created by David Woodhouse <dwmw2@infradead.org>
- *
- * For licensing information, see the file 'LICENCE' in this directory.
- *
- * $Id: ioctl.c,v 1.10 2005/11/07 11:14:40 gleixner Exp $
- *
- */
-
-#include <linux/fs.h>
-
-int jffs2_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
-{
-	/* Later, this will provide for lsattr.jffs2 and chattr.jffs2, which
-	   will include compression support etc. */
-	return -ENOTTY;
-}
-
--- linux-2.6.19-rc6-mm1/fs/jffs2/file.c.old	2006-11-26 05:55:29.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/jffs2/file.c	2006-11-26 05:53:06.000000000 +0100
@@ -46,7 +46,6 @@
  	.aio_read =	generic_file_aio_read,
  	.write =	do_sync_write,
  	.aio_write =	generic_file_aio_write,
-	.ioctl =	jffs2_ioctl,
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
 	.sendfile =	generic_file_sendfile

