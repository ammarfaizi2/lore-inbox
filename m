Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSJMJp1>; Sun, 13 Oct 2002 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbSJMJp1>; Sun, 13 Oct 2002 05:45:27 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:26300 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S261478AbSJMJpZ>;
	Sun, 13 Oct 2002 05:45:25 -0400
Date: Sun, 13 Oct 2002 11:50:57 +0200
From: Anders Larsen <al@alarsen.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] 2.5.42 qnx4fs (1/2): ISO C initializers
Message-ID: <20021013095057.GA1337@errol.alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
please apply this this patch (contributed by Art Haas), which changes
the structure initializers in the qnx4fs code to the new ISO C style
used by the rest of the kernel.

Cheers
 Anders (qnx4fs maintainer)

diff -ur linux-2.5.42.orig/fs/qnx4/dir.c linux-2.5.42/fs/qnx4/dir.c
--- linux-2.5.42.orig/fs/qnx4/dir.c	Tue Oct  1 09:07:09 2002
+++ linux-2.5.42/fs/qnx4/dir.c	Sun Oct 13 10:49:04 2002
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
diff -ur linux-2.5.42.orig/fs/qnx4/file.c linux-2.5.42/fs/qnx4/file.c
--- linux-2.5.42.orig/fs/qnx4/file.c	Tue Oct  1 09:06:30 2002
+++ linux-2.5.42/fs/qnx4/file.c	Sun Oct 13 10:49:04 2002
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
diff -ur linux-2.5.42.orig/fs/qnx4/inode.c linux-2.5.42/fs/qnx4/inode.c
--- linux-2.5.42.orig/fs/qnx4/inode.c	Sun Oct 13 10:45:57 2002
+++ linux-2.5.42/fs/qnx4/inode.c	Sun Oct 13 10:49:04 2002
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
