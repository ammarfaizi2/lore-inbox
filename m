Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262307AbSI1R6B>; Sat, 28 Sep 2002 13:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262308AbSI1R6B>; Sat, 28 Sep 2002 13:58:01 -0400
Received: from group1.mxgrp.airmail.net ([209.196.77.109]:36358 "EHLO
	mx12.airmail.net") by vger.kernel.org with ESMTP id <S262307AbSI1R55>;
	Sat, 28 Sep 2002 13:57:57 -0400
Date: Sat, 28 Sep 2002 13:03:16 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializer patches for fs/isofs
Message-ID: <20020928180316.GG22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches for fixing fs/isofs to use C99 initializers.
Patches are against 2.5.39.

Art Haas

--- linux-2.5.39/fs/isofs/compress.c.old	2002-07-05 18:42:04.000000000 -0500
+++ linux-2.5.39/fs/isofs/compress.c	2002-09-28 10:36:31.000000000 -0500
@@ -325,7 +325,7 @@
 }
 
 struct address_space_operations zisofs_aops = {
-	readpage: zisofs_readpage,
+	.readpage = zisofs_readpage,
 	/* No sync_page operation supported? */
 	/* No bmap operation supported */
 };
--- linux-2.5.39/fs/isofs/dir.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.39/fs/isofs/dir.c	2002-09-28 10:36:31.000000000 -0500
@@ -29,8 +29,8 @@
 
 struct file_operations isofs_dir_operations =
 {
-	read:		generic_read_dir,
-	readdir:	isofs_readdir,
+	.read		= generic_read_dir,
+	.readdir	= isofs_readdir,
 };
 
 /*
@@ -38,7 +38,7 @@
  */
 struct inode_operations isofs_dir_inode_operations =
 {
-	lookup:		isofs_lookup,
+	.lookup		= isofs_lookup,
 };
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
--- linux-2.5.39/fs/isofs/inode.c.old	2002-07-05 18:42:37.000000000 -0500
+++ linux-2.5.39/fs/isofs/inode.c	2002-09-28 10:36:31.000000000 -0500
@@ -124,11 +124,11 @@
 }
 
 static struct super_operations isofs_sops = {
-	alloc_inode:	isofs_alloc_inode,
-	destroy_inode:	isofs_destroy_inode,
-	read_inode:	isofs_read_inode,
-	put_super:	isofs_put_super,
-	statfs:		isofs_statfs,
+	.alloc_inode	= isofs_alloc_inode,
+	.destroy_inode	= isofs_destroy_inode,
+	.read_inode	= isofs_read_inode,
+	.put_super	= isofs_put_super,
+	.statfs		= isofs_statfs,
 };
 
 /* the export_operations structure for describing
@@ -148,21 +148,21 @@
 
 static struct dentry_operations isofs_dentry_ops[] = {
 	{
-		d_hash:		isofs_hash,
-		d_compare:	isofs_dentry_cmp,
+		.d_hash		= isofs_hash,
+		.d_compare	= isofs_dentry_cmp,
 	},
 	{
-		d_hash:		isofs_hashi,
-		d_compare:	isofs_dentry_cmpi,
+		.d_hash		= isofs_hashi,
+		.d_compare	= isofs_dentry_cmpi,
 	},
 #ifdef CONFIG_JOLIET
 	{
-		d_hash:		isofs_hash_ms,
-		d_compare:	isofs_dentry_cmp_ms,
+		.d_hash		= isofs_hash_ms,
+		.d_compare	= isofs_dentry_cmp_ms,
 	},
 	{
-		d_hash:		isofs_hashi_ms,
-		d_compare:	isofs_dentry_cmpi_ms,
+		.d_hash		= isofs_hashi_ms,
+		.d_compare	= isofs_dentry_cmpi_ms,
 	}
 #endif
 };
@@ -1063,9 +1063,9 @@
 }
 
 static struct address_space_operations isofs_aops = {
-	readpage: isofs_readpage,
-	sync_page: block_sync_page,
-	bmap: _isofs_bmap
+	.readpage = isofs_readpage,
+	.sync_page = block_sync_page,
+	.bmap = _isofs_bmap
 };
 
 static inline void test_and_set_uid(uid_t *p, uid_t value)
@@ -1430,11 +1430,11 @@
 }
 
 static struct file_system_type iso9660_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"iso9660",
-	get_sb:		isofs_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "iso9660",
+	.get_sb		= isofs_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 static int __init init_iso9660_fs(void)
--- linux-2.5.39/fs/isofs/rock.c.old	2002-07-05 18:42:01.000000000 -0500
+++ linux-2.5.39/fs/isofs/rock.c	2002-09-28 10:36:31.000000000 -0500
@@ -590,5 +590,5 @@
 }
 
 struct address_space_operations isofs_symlink_aops = {
-	readpage:	rock_ridge_symlink_readpage
+	.readpage	= rock_ridge_symlink_readpage
 };
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
