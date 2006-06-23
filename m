Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWFWRZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWFWRZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWFWRZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:25:00 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:16775 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751791AbWFWRY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:24:59 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FtpMu-0002JS-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 23 Jun 2006 19:22:56 +0200)
Subject: [PATCH 2/2] fuse: comment control filesystem
References: <E1FtpMu-0002JS-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FtpOc-0002KA-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Jun 2006 19:24:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sprinkle a few comments on the not-so-trivial parts of the control
filesystem.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/control.c
===================================================================
--- linux.orig/fs/fuse/control.c	2006-06-22 17:26:44.000000000 +0200
+++ linux/fs/fuse/control.c	2006-06-23 19:18:02.000000000 +0200
@@ -13,6 +13,10 @@
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
 
+/*
+ * This is non-NULL when the single instance of the control filesystem
+ * exists.  Protected by fuse_mutex
+ */
 static struct super_block *fuse_control_sb;
 
 static struct fuse_conn *fuse_ctl_file_conn_get(struct file *file)
@@ -89,6 +93,7 @@ static struct dentry *fuse_ctl_add_dentr
 	inode->i_uid = fc->user_id;
 	inode->i_gid = fc->group_id;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	/* setting ->i_op to NULL is not allowed */
 	if (iop)
 		inode->i_op = iop;
 	inode->i_fop = fop;
@@ -98,6 +103,10 @@ static struct dentry *fuse_ctl_add_dentr
 	return dentry;
 }
 
+/*
+ * Add a connection to the control filesystem (if it exists).  Caller
+ * must host fuse_mutex
+ */
 int fuse_ctl_add_conn(struct fuse_conn *fc)
 {
 	struct dentry *parent;
@@ -128,6 +137,10 @@ int fuse_ctl_add_conn(struct fuse_conn *
 	return -ENOMEM;
 }
 
+/*
+ * Remove a connection from the control filesystem (if it exists).
+ * Caller must host fuse_mutex
+ */
 void fuse_ctl_remove_conn(struct fuse_conn *fc)
 {
 	int i;
