Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSI1Rrj>; Sat, 28 Sep 2002 13:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbSI1Rrj>; Sat, 28 Sep 2002 13:47:39 -0400
Received: from group1.mxgrp.airmail.net ([209.196.77.106]:42511 "EHLO
	mx9.airmail.net") by vger.kernel.org with ESMTP id <S262289AbSI1Rrh>;
	Sat, 28 Sep 2002 13:47:37 -0400
Date: Sat, 28 Sep 2002 12:52:55 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializer patch for fs/openpromfs
Message-ID: <20020928175255.GA22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patch for fixing the fs/openpromfs/inode.c file to
use C99 designated initializers. Patch against 2.5.39. 

Usually I'll send a patch like this to Rusty Russell, but as he's
away for a while, I'll post it to the list. Enjoy!

Art Haas

--- linux-2.5.39/fs/openpromfs/inode.c.old	2002-08-31 21:57:36.000000000 -0500
+++ linux-2.5.39/fs/openpromfs/inode.c	2002-09-28 10:36:22.000000000 -0500
@@ -582,28 +582,28 @@
 }
 
 static struct file_operations openpromfs_prop_ops = {
-	read:		property_read,
-	write:		property_write,
-	release:	property_release,
+	.read		= property_read,
+	.write		= property_write,
+	.release	= property_release,
 };
 
 static struct file_operations openpromfs_nodenum_ops = {
-	read:		nodenum_read,
+	.read		= nodenum_read,
 };
 
 static struct file_operations openprom_operations = {
-	read:		generic_read_dir,
-	readdir:	openpromfs_readdir,
+	.read		= generic_read_dir,
+	.readdir	= openpromfs_readdir,
 };
 
 static struct inode_operations openprom_alias_inode_operations = {
-	create:		openpromfs_create,
-	lookup:		openpromfs_lookup,
-	unlink:		openpromfs_unlink,
+	.create		= openpromfs_create,
+	.lookup		= openpromfs_lookup,
+	.unlink		= openpromfs_unlink,
 };
 
 static struct inode_operations openprom_inode_operations = {
-	lookup:		openpromfs_lookup,
+	.lookup		= openpromfs_lookup,
 };
 
 static int lookup_children(u16 n, const char * name, int len)
@@ -1026,8 +1026,8 @@
 }
 
 static struct super_operations openprom_sops = { 
-	read_inode:	openprom_read_inode,
-	statfs:		simple_statfs,
+	.read_inode	= openprom_read_inode,
+	.statfs		= simple_statfs,
 };
 
 static int openprom_fill_super(struct super_block *s, void *data, int silent)
@@ -1059,10 +1059,10 @@
 }
 
 static struct file_system_type openprom_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"openpromfs",
-	get_sb:		openprom_get_sb,
-	kill_sb:	kill_anon_super,
+	.owner		= THIS_MODULE,
+	.name		= "openpromfs",
+	.get_sb		= openprom_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 static int __init init_openprom_fs(void)
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
