Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVLKSHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVLKSHE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVLKSHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:07:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4876 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750765AbVLKSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:07:03 -0500
Date: Sun, 11 Dec 2005 19:07:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove fs/jffs2/ioctl.c
Message-ID: <20051211180702.GO23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't seem to be any reason for keeping fs/jffs2/ioctl.c .


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 Nov 2005

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
--- linux-2.6.15-rc5-mm2-full/fs/jffs2/file.c.old	2005-12-11 17:27:26.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/fs/jffs2/file.c	2005-12-11 17:28:21.000000000 +0100
@@ -48,7 +48,6 @@
 	.writev =	generic_file_writev,
 	.aio_read =	generic_file_aio_read,
 	.aio_write =	generic_file_aio_write,
-	.ioctl =	jffs2_ioctl,
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
 	.sendfile =	generic_file_sendfile
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
