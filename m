Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTI1Xem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTI1XeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:34:06 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46831 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262798AbTI1Xci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:32:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:32:34 +0200 (MEST)
Message-Id: <UTC200309282332.h8SNWYt07779.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] jfs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/jfs/jfs_debug.c b/fs/jfs/jfs_debug.c
--- a/fs/jfs/jfs_debug.c	Mon Sep 29 01:05:41 2003
+++ b/fs/jfs/jfs_debug.c	Mon Sep 29 01:15:00 2003
@@ -81,7 +81,7 @@
 	return len;
 }
 
-static int loglevel_write(struct file *file, const char *buffer,
+static int loglevel_write(struct file *file, const char __user *buffer,
 			unsigned long count, void *data)
 {
 	char c;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/jfs/symlink.c b/fs/jfs/symlink.c
--- a/fs/jfs/symlink.c	Mon Sep 29 01:05:41 2003
+++ b/fs/jfs/symlink.c	Mon Sep 29 01:15:00 2003
@@ -26,7 +26,7 @@
 	return vfs_follow_link(nd, s);
 }
 
-static int jfs_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int jfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	char *s = JFS_IP(dentry->d_inode)->i_inline;
 	return vfs_readlink(dentry, buffer, buflen, s);
