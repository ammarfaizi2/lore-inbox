Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265208AbSKEUhw>; Tue, 5 Nov 2002 15:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265209AbSKEUhw>; Tue, 5 Nov 2002 15:37:52 -0500
Received: from group1.mxgrp.airmail.net ([209.196.77.109]:23050 "EHLO
	mx12.airmail.net") by vger.kernel.org with ESMTP id <S265208AbSKEUht>;
	Tue, 5 Nov 2002 15:37:49 -0500
Date: Tue, 5 Nov 2002 14:44:22 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for fs/umsdos
Message-ID: <20021105204422.GC32444@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small set of patches that switch fs/umsdos to use C99
designated initializers. The patches are against 2.5.46.

Mail to the listed maintainer Matija Nalis <mnalis-umsdos@voyager.hr>
bounces for me. :-(

Art Haas

--- linux-2.5.46/fs/umsdos/dir.c.old	2002-07-05 18:42:23.000000000 -0500
+++ linux-2.5.46/fs/umsdos/dir.c	2002-11-05 09:35:59.000000000 -0600
@@ -48,8 +48,8 @@
 
 struct dentry_operations umsdos_dentry_operations =
 {
-	d_revalidate:	umsdos_dentry_validate,
-	d_delete:	umsdos_dentry_dput,
+	.d_revalidate	= umsdos_dentry_validate,
+	.d_delete	= umsdos_dentry_dput,
 };
 
 struct UMSDOS_DIR_ONCE {
@@ -790,21 +790,21 @@
 
 struct file_operations umsdos_dir_operations =
 {
-	read:		generic_read_dir,
-	readdir:	UMSDOS_readdir,
-	ioctl:		UMSDOS_ioctl_dir,
+	.read		= generic_read_dir,
+	.readdir	= UMSDOS_readdir,
+	.ioctl		= UMSDOS_ioctl_dir,
 };
 
 struct inode_operations umsdos_dir_inode_operations =
 {
-	create:		UMSDOS_create,
-	lookup:		UMSDOS_lookup,
-	link:		UMSDOS_link,
-	unlink:		UMSDOS_unlink,
-	symlink:	UMSDOS_symlink,
-	mkdir:		UMSDOS_mkdir,
-	rmdir:		UMSDOS_rmdir,
-	mknod:		UMSDOS_mknod,
-	rename:		UMSDOS_rename,
-	setattr:	UMSDOS_notify_change,
+	.create		= UMSDOS_create,
+	.lookup		= UMSDOS_lookup,
+	.link		= UMSDOS_link,
+	.unlink		= UMSDOS_unlink,
+	.symlink	= UMSDOS_symlink,
+	.mkdir		= UMSDOS_mkdir,
+	.rmdir		= UMSDOS_rmdir,
+	.mknod		= UMSDOS_mknod,
+	.rename		= UMSDOS_rename,
+	.setattr	= UMSDOS_notify_change,
 };
--- linux-2.5.46/fs/umsdos/inode.c.old	2002-07-05 18:42:04.000000000 -0500
+++ linux-2.5.46/fs/umsdos/inode.c	2002-11-05 09:35:59.000000000 -0600
@@ -108,14 +108,14 @@
 }
 
 static struct inode_operations umsdos_file_inode_operations = {
-	truncate:	fat_truncate,
-	setattr:	UMSDOS_notify_change,
+	.truncate	= fat_truncate,
+	.setattr	= UMSDOS_notify_change,
 };
 
 static struct inode_operations umsdos_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	setattr:	UMSDOS_notify_change,
+	.readlink	= page_readlink,
+	.follow_link	= page_follow_link,
+	.setattr	= UMSDOS_notify_change,
 };
 
 /*
@@ -335,12 +335,12 @@
 
 static struct super_operations umsdos_sops =
 {
-	write_inode:	UMSDOS_write_inode,
-	put_inode:	UMSDOS_put_inode,
-	delete_inode:	fat_delete_inode,
-	put_super:	UMSDOS_put_super,
-	statfs:		UMSDOS_statfs,
-	clear_inode:	fat_clear_inode,
+	.write_inode	= UMSDOS_write_inode,
+	.put_inode	= UMSDOS_put_inode,
+	.delete_inode	= fat_delete_inode,
+	.put_super	= UMSDOS_put_super,
+	.statfs		= UMSDOS_statfs,
+	.clear_inode	= fat_clear_inode,
 };
 
 int UMSDOS_statfs(struct super_block *sb,struct statfs *buf)
--- linux-2.5.46/fs/umsdos/rdir.c.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.46/fs/umsdos/rdir.c	2002-11-05 09:35:59.000000000 -0600
@@ -231,18 +231,18 @@
  */
 struct file_operations umsdos_rdir_operations =
 {
-	read:		generic_read_dir,
-	readdir:	UMSDOS_rreaddir,
-	ioctl:		UMSDOS_ioctl_dir,
+	.read		= generic_read_dir,
+	.readdir	= UMSDOS_rreaddir,
+	.ioctl		= UMSDOS_ioctl_dir,
 };
 
 struct inode_operations umsdos_rdir_inode_operations =
 {
-	create:		msdos_create,
-	lookup:		UMSDOS_rlookup,
-	unlink:		msdos_unlink,
-	mkdir:		msdos_mkdir,
-	rmdir:		UMSDOS_rrmdir,
-	rename:		msdos_rename,
-	setattr:	UMSDOS_notify_change,
+	.create		= msdos_create,
+	.lookup		= UMSDOS_rlookup,
+	.unlink		= msdos_unlink,
+	.mkdir		= msdos_mkdir,
+	.rmdir		= UMSDOS_rrmdir,
+	.rename		= msdos_rename,
+	.setattr	= UMSDOS_notify_change,
 };
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
