Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSI1R7P>; Sat, 28 Sep 2002 13:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262315AbSI1R7P>; Sat, 28 Sep 2002 13:59:15 -0400
Received: from group1.mxgrp.airmail.net ([209.196.77.107]:59398 "EHLO
	mx10.airmail.net") by vger.kernel.org with ESMTP id <S262314AbSI1R7L>;
	Sat, 28 Sep 2002 13:59:11 -0400
Date: Sat, 28 Sep 2002 13:04:30 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializers for fs/ufs
Message-ID: <20020928180430.GH22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches for converting fs/ufs to use C99 initializers.
The patches are against 2.5.39.

Art Haas

--- linux-2.5.39/fs/ufs/dir.c.old	2002-08-27 19:11:04.000000000 -0500
+++ linux-2.5.39/fs/ufs/dir.c	2002-09-28 10:37:19.000000000 -0500
@@ -623,7 +623,7 @@
 }
 
 struct file_operations ufs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	ufs_readdir,
-	fsync:		file_fsync,
+	.read		= generic_read_dir,
+	.readdir	= ufs_readdir,
+	.fsync		= file_fsync,
 };
--- linux-2.5.39/fs/ufs/file.c.old	2002-08-02 08:16:30.000000000 -0500
+++ linux-2.5.39/fs/ufs/file.c	2002-09-28 10:37:19.000000000 -0500
@@ -42,14 +42,14 @@
  */
  
 struct file_operations ufs_file_operations = {
-	llseek:		generic_file_llseek,
-	read:		generic_file_read,
-	write:		generic_file_write,
-	mmap:		generic_file_mmap,
-	open:           generic_file_open,
-	sendfile:	generic_file_sendfile,
+	.llseek		= generic_file_llseek,
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+	.mmap		= generic_file_mmap,
+	.open           = generic_file_open,
+	.sendfile	= generic_file_sendfile,
 };
 
 struct inode_operations ufs_file_inode_operations = {
-	truncate:	ufs_truncate,
+	.truncate	= ufs_truncate,
 };
--- linux-2.5.39/fs/ufs/inode.c.old	2002-08-27 19:11:04.000000000 -0500
+++ linux-2.5.39/fs/ufs/inode.c	2002-09-28 10:37:19.000000000 -0500
@@ -462,12 +462,12 @@
 	return generic_block_bmap(mapping,block,ufs_getfrag_block);
 }
 struct address_space_operations ufs_aops = {
-	readpage: ufs_readpage,
-	writepage: ufs_writepage,
-	sync_page: block_sync_page,
-	prepare_write: ufs_prepare_write,
-	commit_write: generic_commit_write,
-	bmap: ufs_bmap
+	.readpage = ufs_readpage,
+	.writepage = ufs_writepage,
+	.sync_page = block_sync_page,
+	.prepare_write = ufs_prepare_write,
+	.commit_write = generic_commit_write,
+	.bmap = ufs_bmap
 };
 
 void ufs_read_inode (struct inode * inode)
--- linux-2.5.39/fs/ufs/namei.c.old	2002-08-27 19:11:04.000000000 -0500
+++ linux-2.5.39/fs/ufs/namei.c	2002-09-28 10:37:19.000000000 -0500
@@ -350,13 +350,13 @@
 }
 
 struct inode_operations ufs_dir_inode_operations = {
-	create:		ufs_create,
-	lookup:		ufs_lookup,
-	link:		ufs_link,
-	unlink:		ufs_unlink,
-	symlink:	ufs_symlink,
-	mkdir:		ufs_mkdir,
-	rmdir:		ufs_rmdir,
-	mknod:		ufs_mknod,
-	rename:		ufs_rename,
+	.create		= ufs_create,
+	.lookup		= ufs_lookup,
+	.link		= ufs_link,
+	.unlink		= ufs_unlink,
+	.symlink	= ufs_symlink,
+	.mkdir		= ufs_mkdir,
+	.rmdir		= ufs_rmdir,
+	.mknod		= ufs_mknod,
+	.rename		= ufs_rename,
 };
--- linux-2.5.39/fs/ufs/super.c.old	2002-09-16 09:34:08.000000000 -0500
+++ linux-2.5.39/fs/ufs/super.c	2002-09-28 10:37:18.000000000 -0500
@@ -1041,15 +1041,15 @@
 }
 
 static struct super_operations ufs_super_ops = {
-	alloc_inode:	ufs_alloc_inode,
-	destroy_inode:	ufs_destroy_inode,
-	read_inode:	ufs_read_inode,
-	write_inode:	ufs_write_inode,
-	delete_inode:	ufs_delete_inode,
-	put_super:	ufs_put_super,
-	write_super:	ufs_write_super,
-	statfs:		ufs_statfs,
-	remount_fs:	ufs_remount,
+	.alloc_inode	= ufs_alloc_inode,
+	.destroy_inode	= ufs_destroy_inode,
+	.read_inode	= ufs_read_inode,
+	.write_inode	= ufs_write_inode,
+	.delete_inode	= ufs_delete_inode,
+	.put_super	= ufs_put_super,
+	.write_super	= ufs_write_super,
+	.statfs		= ufs_statfs,
+	.remount_fs	= ufs_remount,
 };
 
 static struct super_block *ufs_get_sb(struct file_system_type *fs_type,
@@ -1059,11 +1059,11 @@
 }
 
 static struct file_system_type ufs_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"ufs",
-	get_sb:		ufs_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "ufs",
+	.get_sb		= ufs_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 static int __init init_ufs_fs(void)
--- linux-2.5.39/fs/ufs/symlink.c.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.39/fs/ufs/symlink.c	2002-09-28 10:37:19.000000000 -0500
@@ -41,6 +41,6 @@
 }
 
 struct inode_operations ufs_fast_symlink_inode_operations = {
-	readlink:	ufs_readlink,
-	follow_link:	ufs_follow_link,
+	.readlink	= ufs_readlink,
+	.follow_link	= ufs_follow_link,
 };
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
