Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbSJDVaJ>; Fri, 4 Oct 2002 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261869AbSJDVaF>; Fri, 4 Oct 2002 17:30:05 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:14827 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S261804AbSJDV37>;
	Fri, 4 Oct 2002 17:29:59 -0400
Date: Fri, 4 Oct 2002 23:35:28 +0200
From: Anders Larsen <al@alarsen.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Art Haas <ahaas@neosoft.com>
Subject: [PATCH][2.nd RESEND] 2.5.40 qnx4fs (1/2): ISO C initializers
Message-ID: <20021004213528.GC12158@errol.alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
this patch (contributed by Art Haas) changes the structure initializers
in the qnx4fs code to the new ISO C style.
Please apply - this time the patch should be formally correct.

The patches I sent 5 and 10 minutes ago (same subject) got garbled, sorry.
Will fix my mailer   <:-o

Cheers
 Anders (maintainer)

diff -ur linux-2.5.40-vanilla/fs/qnx4/dir.c linux-2.5.40/fs/qnx4/dir.c
--- linux-2.5.40-vanilla/fs/qnx4/dir.c	Tue Oct  1 09:07:09 2002
+++ linux-2.5.40/fs/qnx4/dir.c	Fri Oct  4 22:09:55 2002
@@ -85,17 +85,17 @@
 
 struct file_operations qnx4_dir_operations =
 {
-	read:		generic_read_dir,
-	readdir:	qnx4_readdir,
-	fsync:		file_fsync,
+	.read		= generic_read_dir,
+	.readdir	= qnx4_readdir,
+	.fsync		= file_fsync,
 };
 
 struct inode_operations qnx4_dir_inode_operations =
 {
-	lookup:		qnx4_lookup,
+	.lookup		= qnx4_lookup,
 #ifdef CONFIG_QNX4FS_RW
-	create:		qnx4_create,
-	unlink:		qnx4_unlink,
-	rmdir:		qnx4_rmdir,
+	.create		= qnx4_create,
+	.unlink		= qnx4_unlink,
+	.rmdir		= qnx4_rmdir,
 #endif
 };
diff -ur linux-2.5.40-vanilla/fs/qnx4/file.c linux-2.5.40/fs/qnx4/file.c
--- linux-2.5.40-vanilla/fs/qnx4/file.c	Tue Oct  1 09:06:30 2002
+++ linux-2.5.40/fs/qnx4/file.c	Fri Oct  4 22:21:30 2002
@@ -24,21 +24,19 @@
  */
 struct file_operations qnx4_file_operations =
 {
-	llseek:			generic_file_llseek,
-	read:			generic_file_read,
+	.llseek		= generic_file_llseek,
+	.read		= generic_file_read,
+	.mmap		= generic_file_mmap,
+	.sendfile	= generic_file_sendfile,
 #ifdef CONFIG_QNX4FS_RW
-	write:			generic_file_write,
+	.write		= generic_file_write,
+	.fsync		= qnx4_sync_file,
 #endif
-	mmap:			generic_file_mmap,
-#ifdef CONFIG_QNX4FS_RW
-	fsync:			qnx4_sync_file,
-#endif
-	sendfile:		generic_file_sendfile,
 };
 
 struct inode_operations qnx4_file_inode_operations =
 {
 #ifdef CONFIG_QNX4FS_RW
-	truncate:		qnx4_truncate,
+	.truncate	= qnx4_truncate,
 #endif
 };
diff -ur linux-2.5.40-vanilla/fs/qnx4/inode.c linux-2.5.40/fs/qnx4/inode.c
--- linux-2.5.40-vanilla/fs/qnx4/inode.c	Tue Oct  1 09:06:28 2002
+++ linux-2.5.40/fs/qnx4/inode.c	Fri Oct  4 22:23:09 2002
@@ -131,19 +131,17 @@
 
 static struct super_operations qnx4_sops =
 {
-	alloc_inode:	qnx4_alloc_inode,
-	destroy_inode:	qnx4_destroy_inode,
-	read_inode:	qnx4_read_inode,
+	.alloc_inode	= qnx4_alloc_inode,
+	.destroy_inode	= qnx4_destroy_inode,
+	.read_inode	= qnx4_read_inode,
+	.put_super	= qnx4_put_super,
+	.statfs		= qnx4_statfs,
+	.remount_fs	= qnx4_remount,
 #ifdef CONFIG_QNX4FS_RW
-	write_inode:	qnx4_write_inode,
-	delete_inode:	qnx4_delete_inode,
+	.write_inode	= qnx4_write_inode,
+	.delete_inode	= qnx4_delete_inode,
+	.write_super	= qnx4_write_super,
 #endif
-	put_super:	qnx4_put_super,
-#ifdef CONFIG_QNX4FS_RW
-	write_super:	qnx4_write_super,
-#endif
-	statfs:		qnx4_statfs,
-	remount_fs:	qnx4_remount,
 };
 
 static int qnx4_remount(struct super_block *sb, int *flags, char *data)
@@ -449,12 +447,12 @@
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
 struct address_space_operations qnx4_aops = {
-	readpage: qnx4_readpage,
-	writepage: qnx4_writepage,
-	sync_page: block_sync_page,
-	prepare_write: qnx4_prepare_write,
-	commit_write: generic_commit_write,
-	bmap: qnx4_bmap
+	.readpage	= qnx4_readpage,
+	.writepage	= qnx4_writepage,
+	.sync_page	= block_sync_page,
+	.prepare_write	= qnx4_prepare_write,
+	.commit_write	= generic_commit_write,
+	.bmap		= qnx4_bmap
 };
 
 static void qnx4_read_inode(struct inode *inode)
@@ -564,11 +562,11 @@
 }
 
 static struct file_system_type qnx4_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"qnx4",
-	get_sb:		qnx4_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "qnx4",
+	.get_sb		= qnx4_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 static int __init init_qnx4_fs(void)

