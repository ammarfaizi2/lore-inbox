Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTI1X1R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTI1X1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:27:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12270 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262760AbTI1X1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:27:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:27:09 +0200 (MEST)
Message-Id: <UTC200309282327.h8SNR9E25442.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] befs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
--- a/fs/befs/linuxvfs.c	Mon Sep 29 01:05:41 2003
+++ b/fs/befs/linuxvfs.c	Mon Sep 29 01:10:14 2003
@@ -39,7 +39,7 @@
 static void befs_destroy_inode(struct inode *inode);
 static int befs_init_inodecache(void);
 static void befs_destroy_inodecache(void);
-static int befs_readlink(struct dentry *, char *, int);
+static int befs_readlink(struct dentry *, char __user *, int);
 static int befs_follow_link(struct dentry *, struct nameidata *nd);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
@@ -494,7 +494,7 @@
 }
 
 static int
-befs_readlink(struct dentry *dentry, char *buffer, int buflen)
+befs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct super_block *sb = dentry->d_sb;
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);
