Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVKKIjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVKKIjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVKKIgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:08 -0500
Received: from i121.durables.org ([64.81.244.121]:6350 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932236AbVKKIgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:04 -0500
Date: Fri, 11 Nov 2005 02:35:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <3.282480653@selenic.com>
Message-Id: <4.282480653@selenic.com>
Subject: [PATCH 3/15] misc: Uninline some open.c functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uninline some open.c functions

add/remove: 3/0 grow/shrink: 0/6 up/down: 679/-1166 (-487)
function                                     old     new   delta
do_sys_truncate                                -     336    +336
do_sys_ftruncate                               -     317    +317
__put_unused_fd                                -      26     +26
put_unused_fd                                 57      49      -8
sys_close                                    150     119     -31
sys_ftruncate64                              260      26    -234
sys_ftruncate                                272      24    -248
sys_truncate                                 339      25    -314
sys_truncate64                               336       5    -331

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/fs/open.c
===================================================================
--- 2.6.14-misc.orig/fs/open.c	2005-11-01 10:54:33.000000000 -0800
+++ 2.6.14-misc/fs/open.c	2005-11-09 11:19:40.000000000 -0800
@@ -212,7 +212,7 @@ int do_truncate(struct dentry *dentry, l
 	return err;
 }
 
-static inline long do_sys_truncate(const char __user * path, loff_t length)
+static long do_sys_truncate(const char __user * path, loff_t length)
 {
 	struct nameidata nd;
 	struct inode * inode;
@@ -278,7 +278,7 @@ asmlinkage long sys_truncate(const char 
 	return do_sys_truncate(path, (long)length);
 }
 
-static inline long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+static long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 {
 	struct inode * inode;
 	struct dentry *dentry;
@@ -959,7 +959,7 @@ out:
 
 EXPORT_SYMBOL(get_unused_fd);
 
-static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
+static void __put_unused_fd(struct files_struct *files, unsigned int fd)
 {
 	struct fdtable *fdt = files_fdtable(files);
 	__FD_CLR(fd, fdt->open_fds);
