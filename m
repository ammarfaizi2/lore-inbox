Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbSI1RtE>; Sat, 28 Sep 2002 13:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262293AbSI1RtE>; Sat, 28 Sep 2002 13:49:04 -0400
Received: from mx3.airmail.net ([209.196.77.100]:5386 "EHLO mx3.airmail.net")
	by vger.kernel.org with ESMTP id <S262292AbSI1RtC>;
	Sat, 28 Sep 2002 13:49:02 -0400
Date: Sat, 28 Sep 2002 12:54:21 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializer patch for fs/ramfs
Message-ID: <20020928175421.GB22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's another small patch for converting fs/ramfs/inode.c to use
C99 designated initializers. The patch is against 2.5.39.

Art Haas

--- linux-2.5.39/fs/ramfs/inode.c.old	2002-09-16 09:34:08.000000000 -0500
+++ linux-2.5.39/fs/ramfs/inode.c	2002-09-28 10:36:22.000000000 -0500
@@ -276,35 +276,35 @@
 }
 
 static struct address_space_operations ramfs_aops = {
-	readpage:	ramfs_readpage,
-	writepage:	fail_writepage,
-	prepare_write:	ramfs_prepare_write,
-	commit_write:	ramfs_commit_write
+	.readpage	= ramfs_readpage,
+	.writepage	= fail_writepage,
+	.prepare_write	= ramfs_prepare_write,
+	.commit_write	= ramfs_commit_write
 };
 
 static struct file_operations ramfs_file_operations = {
-	read:		generic_file_read,
-	write:		generic_file_write,
-	mmap:		generic_file_mmap,
-	fsync:		ramfs_sync_file,
-	sendfile:	generic_file_sendfile,
+	.read		= generic_file_read,
+	.write		= generic_file_write,
+	.mmap		= generic_file_mmap,
+	.fsync		= ramfs_sync_file,
+	.sendfile	= generic_file_sendfile,
 };
 
 static struct inode_operations ramfs_dir_inode_operations = {
-	create:		ramfs_create,
-	lookup:		simple_lookup,
-	link:		ramfs_link,
-	unlink:		ramfs_unlink,
-	symlink:	ramfs_symlink,
-	mkdir:		ramfs_mkdir,
-	rmdir:		ramfs_rmdir,
-	mknod:		ramfs_mknod,
-	rename:		ramfs_rename,
+	.create		= ramfs_create,
+	.lookup		= simple_lookup,
+	.link		= ramfs_link,
+	.unlink		= ramfs_unlink,
+	.symlink	= ramfs_symlink,
+	.mkdir		= ramfs_mkdir,
+	.rmdir		= ramfs_rmdir,
+	.mknod		= ramfs_mknod,
+	.rename		= ramfs_rename,
 };
 
 static struct super_operations ramfs_ops = {
-	statfs:		simple_statfs,
-	drop_inode:	generic_delete_inode,
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
 };
 
 static int ramfs_fill_super(struct super_block * sb, void * data, int silent)
@@ -342,14 +342,14 @@
 }
 
 static struct file_system_type ramfs_fs_type = {
-	name:		"ramfs",
-	get_sb:		ramfs_get_sb,
-	kill_sb:	kill_litter_super,
+	.name		= "ramfs",
+	.get_sb		= ramfs_get_sb,
+	.kill_sb	= kill_litter_super,
 };
 static struct file_system_type rootfs_fs_type = {
-	name:		"rootfs",
-	get_sb:		rootfs_get_sb,
-	kill_sb:	kill_litter_super,
+	.name		= "rootfs",
+	.get_sb		= rootfs_get_sb,
+	.kill_sb	= kill_litter_super,
 };
 
 static int __init init_ramfs_fs(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
