Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262305AbSI1Rxv>; Sat, 28 Sep 2002 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262301AbSI1Rxu>; Sat, 28 Sep 2002 13:53:50 -0400
Received: from mx2.airmail.net ([209.196.77.99]:7429 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S262300AbSI1Rxr>;
	Sat, 28 Sep 2002 13:53:47 -0400
Date: Sat, 28 Sep 2002 12:59:07 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializer patch for fs/romfs
Message-ID: <20020928175907.GE22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patch for fixing fs/romfs/inode.c to C99 designated
initializers. Patch is against 2.5.39.

Art Haas

--- linux-2.5.39/fs/romfs/inode.c.old	2002-08-31 21:57:37.000000000 -0500
+++ linux-2.5.39/fs/romfs/inode.c	2002-09-28 10:36:22.000000000 -0500
@@ -456,16 +456,16 @@
 /* Mapping from our types to the kernel */
 
 static struct address_space_operations romfs_aops = {
-	readpage: romfs_readpage
+	.readpage = romfs_readpage
 };
 
 static struct file_operations romfs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	romfs_readdir,
+	.read		= generic_read_dir,
+	.readdir	= romfs_readdir,
 };
 
 static struct inode_operations romfs_dir_inode_operations = {
-	lookup:		romfs_lookup,
+	.lookup		= romfs_lookup,
 };
 
 static mode_t romfs_modemap[] =
@@ -590,10 +590,10 @@
 }
 
 static struct super_operations romfs_ops = {
-	alloc_inode:	romfs_alloc_inode,
-	destroy_inode:	romfs_destroy_inode,
-	read_inode:	romfs_read_inode,
-	statfs:		romfs_statfs,
+	.alloc_inode	= romfs_alloc_inode,
+	.destroy_inode	= romfs_destroy_inode,
+	.read_inode	= romfs_read_inode,
+	.statfs		= romfs_statfs,
 };
 
 static struct super_block *romfs_get_sb(struct file_system_type *fs_type,
@@ -603,11 +603,11 @@
 }
 
 static struct file_system_type romfs_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"romfs",
-	get_sb:		romfs_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "romfs",
+	.get_sb		= romfs_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 static int __init init_romfs_fs(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
