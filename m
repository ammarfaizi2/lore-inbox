Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSG1HYu>; Sun, 28 Jul 2002 03:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318934AbSG1HXz>; Sun, 28 Jul 2002 03:23:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58629 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318925AbSG1HVb>;
	Sun, 28 Jul 2002 03:21:31 -0400
Message-ID: <3D439E3C.3564EDCD@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/13] use c99 initialisers in ext3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Convert ext3 to the C99 initialiser format.  From Rusty.




 dir.c     |    8 ++++----
 file.c    |   20 ++++++++++----------
 inode.c   |   38 +++++++++++++++++++-------------------
 namei.c   |   18 +++++++++---------
 super.c   |   38 +++++++++++++++++++-------------------
 symlink.c |    4 ++--
 6 files changed, 63 insertions(+), 63 deletions(-)

--- 2.5.29/fs/ext3/dir.c~ext3-anality	Sat Jul 27 23:39:12 2002
+++ 2.5.29-akpm/fs/ext3/dir.c	Sat Jul 27 23:39:12 2002
@@ -31,10 +31,10 @@ static unsigned char ext3_filetype_table
 static int ext3_readdir(struct file *, void *, filldir_t);
 
 struct file_operations ext3_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	ext3_readdir,		/* we take BKL. needed?*/
-	ioctl:		ext3_ioctl,		/* BKL held */
-	fsync:		ext3_sync_file,		/* BKL held */
+	.read		= generic_read_dir,
+	.readdir	= ext3_readdir,		/* we take BKL. needed?*/
+	.ioctl		= ext3_ioctl,		/* BKL held */
+	.fsync		= ext3_sync_file,		/* BKL held */
 };
 
 int ext3_check_dir_entry (const char * function, struct inode * dir,
--- 2.5.29/fs/ext3/file.c~ext3-anality	Sat Jul 27 23:39:12 2002
+++ 2.5.29-akpm/fs/ext3/file.c	Sat Jul 27 23:39:12 2002
@@ -76,18 +76,18 @@ ext3_file_write(struct file *file, const
 }
 
 struct file_operations ext3_file_operations = {
-	llseek:		generic_file_llseek,	/* BKL held */
-	read:		generic_file_read,	/* BKL not held.  Don't need */
-	write:		ext3_file_write,	/* BKL not held.  Don't need */
-	ioctl:		ext3_ioctl,		/* BKL held */
-	mmap:		generic_file_mmap,
-	open:		ext3_open_file,		/* BKL not held.  Don't need */
-	release:	ext3_release_file,	/* BKL not held.  Don't need */
-	fsync:		ext3_sync_file,		/* BKL held */
+	.llseek		= generic_file_llseek,	/* BKL held */
+	.read		= generic_file_read,	/* BKL not held.  Don't need */
+	.write		= ext3_file_write,	/* BKL not held.  Don't need */
+	.ioctl		= ext3_ioctl,		/* BKL held */
+	.mmap		= generic_file_mmap,
+	.open		= ext3_open_file,		/* BKL not held.  Don't need */
+	.release	= ext3_release_file,	/* BKL not held.  Don't need */
+	.fsync		= ext3_sync_file,		/* BKL held */
 };
 
 struct inode_operations ext3_file_inode_operations = {
-	truncate:	ext3_truncate,		/* BKL held */
-	setattr:	ext3_setattr,		/* BKL held */
+	.truncate	= ext3_truncate,		/* BKL held */
+	.setattr	= ext3_setattr,		/* BKL held */
 };
 
--- 2.5.29/fs/ext3/inode.c~ext3-anality	Sat Jul 27 23:39:12 2002
+++ 2.5.29-akpm/fs/ext3/inode.c	Sat Jul 27 23:39:12 2002
@@ -1378,15 +1378,15 @@ static int ext3_releasepage(struct page 
 
 
 struct address_space_operations ext3_aops = {
-	readpage:	ext3_readpage,		/* BKL not held.  Don't need */
-	readpages:	ext3_readpages,		/* BKL not held.  Don't need */
-	writepage:	ext3_writepage,		/* BKL not held.  We take it */
-	sync_page:	block_sync_page,
-	prepare_write:	ext3_prepare_write,	/* BKL not held.  We take it */
-	commit_write:	ext3_commit_write,	/* BKL not held.  We take it */
-	bmap:		ext3_bmap,		/* BKL held */
-	invalidatepage:	ext3_invalidatepage,	/* BKL not held.  Don't need */
-	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
+	.readpage	= ext3_readpage,		/* BKL not held.  Don't need */
+	.readpages	= ext3_readpages,		/* BKL not held.  Don't need */
+	.writepage	= ext3_writepage,		/* BKL not held.  We take it */
+	.sync_page	= block_sync_page,
+	.prepare_write	= ext3_prepare_write,	/* BKL not held.  We take it */
+	.commit_write	= ext3_commit_write,	/* BKL not held.  We take it */
+	.bmap		= ext3_bmap,		/* BKL held */
+	.invalidatepage	= ext3_invalidatepage,	/* BKL not held.  Don't need */
+	.releasepage	= ext3_releasepage,	/* BKL not held.  Don't need */
 };
 
 /* For writeback mode, we can use mpage_writepages() */
@@ -1405,16 +1405,16 @@ ext3_writepages(struct address_space *ma
 }
 
 struct address_space_operations ext3_writeback_aops = {
-	readpage:	ext3_readpage,		/* BKL not held.  Don't need */
-	readpages:	ext3_readpages,		/* BKL not held.  Don't need */
-	writepage:	ext3_writepage,		/* BKL not held.  We take it */
-	writepages:	ext3_writepages,	/* BKL not held.  Don't need */
-	sync_page:	block_sync_page,
-	prepare_write:	ext3_prepare_write,	/* BKL not held.  We take it */
-	commit_write:	ext3_commit_write,	/* BKL not held.  We take it */
-	bmap:		ext3_bmap,		/* BKL held */
-	invalidatepage:	ext3_invalidatepage,	/* BKL not held.  Don't need */
-	releasepage:	ext3_releasepage,	/* BKL not held.  Don't need */
+	.readpage	= ext3_readpage,		/* BKL not held.  Don't need */
+	.readpages	= ext3_readpages,		/* BKL not held.  Don't need */
+	.writepage	= ext3_writepage,		/* BKL not held.  We take it */
+	.writepages	= ext3_writepages,	/* BKL not held.  Don't need */
+	.sync_page	= block_sync_page,
+	.prepare_write	= ext3_prepare_write,	/* BKL not held.  We take it */
+	.commit_write	= ext3_commit_write,	/* BKL not held.  We take it */
+	.bmap		= ext3_bmap,		/* BKL held */
+	.invalidatepage	= ext3_invalidatepage,	/* BKL not held.  Don't need */
+	.releasepage	= ext3_releasepage,	/* BKL not held.  Don't need */
 };
 
 /*
--- 2.5.29/fs/ext3/namei.c~ext3-anality	Sat Jul 27 23:39:12 2002
+++ 2.5.29-akpm/fs/ext3/namei.c	Sat Jul 27 23:39:12 2002
@@ -1194,13 +1194,13 @@ end_rename:
  * directories can handle most operations...
  */
 struct inode_operations ext3_dir_inode_operations = {
-	create:		ext3_create,
-	lookup:		ext3_lookup,
-	link:		ext3_link,
-	unlink:		ext3_unlink,
-	symlink:	ext3_symlink,
-	mkdir:		ext3_mkdir,
-	rmdir:		ext3_rmdir,
-	mknod:		ext3_mknod,
-	rename:		ext3_rename,
+	.create		= ext3_create,
+	.lookup		= ext3_lookup,
+	.link		= ext3_link,
+	.unlink		= ext3_unlink,
+	.symlink	= ext3_symlink,
+	.mkdir		= ext3_mkdir,
+	.rmdir		= ext3_rmdir,
+	.mknod		= ext3_mknod,
+	.rename		= ext3_rename,
 };
--- 2.5.29/fs/ext3/super.c~ext3-anality	Sat Jul 27 23:39:12 2002
+++ 2.5.29-akpm/fs/ext3/super.c	Sat Jul 27 23:39:12 2002
@@ -489,24 +489,24 @@ static void destroy_inodecache(void)
 }
 
 static struct super_operations ext3_sops = {
-	alloc_inode:	ext3_alloc_inode,
-	destroy_inode:	ext3_destroy_inode,
-	read_inode:	ext3_read_inode,	/* BKL held */
-	write_inode:	ext3_write_inode,	/* BKL not held.  Don't need */
-	dirty_inode:	ext3_dirty_inode,	/* BKL not held.  We take it */
-	put_inode:	ext3_put_inode,		/* BKL not held.  Don't need */
-	delete_inode:	ext3_delete_inode,	/* BKL not held.  We take it */
-	put_super:	ext3_put_super,		/* BKL held */
-	write_super:	ext3_write_super,	/* BKL not held. We take it. Needed? */
-	write_super_lockfs: ext3_write_super_lockfs, /* BKL not held. Take it */
-	unlockfs:	ext3_unlockfs,		/* BKL not held.  We take it */
-	statfs:		ext3_statfs,		/* BKL not held. */
-	remount_fs:	ext3_remount,		/* BKL held */
+	.alloc_inode	= ext3_alloc_inode,
+	.destroy_inode	= ext3_destroy_inode,
+	.read_inode	= ext3_read_inode,	/* BKL held */
+	.write_inode	= ext3_write_inode,	/* BKL not held.  Don't need */
+	.dirty_inode	= ext3_dirty_inode,	/* BKL not held.  We take it */
+	.put_inode	= ext3_put_inode,		/* BKL not held.  Don't need */
+	.delete_inode	= ext3_delete_inode,	/* BKL not held.  We take it */
+	.put_super	= ext3_put_super,		/* BKL held */
+	.write_super	= ext3_write_super,	/* BKL not held. We take it. Needed? */
+	.write_super_lockfs = ext3_write_super_lockfs, /* BKL not held. Take it */
+	.unlockfs	= ext3_unlockfs,		/* BKL not held.  We take it */
+	.statfs		= ext3_statfs,		/* BKL not held. */
+	.remount_fs	= ext3_remount,		/* BKL held */
 };
 
 struct dentry *ext3_get_parent(struct dentry *child);
 static struct export_operations ext3_export_ops = {
-	get_parent: ext3_get_parent,
+	.get_parent = ext3_get_parent,
 };
 
 
@@ -1770,11 +1770,11 @@ static struct super_block *ext3_get_sb(s
 }
 
 static struct file_system_type ext3_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"ext3",
-	get_sb:		ext3_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "ext3",
+	.get_sb		= ext3_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 static int __init init_ext3_fs(void)
--- 2.5.29/fs/ext3/symlink.c~ext3-anality	Sat Jul 27 23:39:12 2002
+++ 2.5.29-akpm/fs/ext3/symlink.c	Sat Jul 27 23:39:12 2002
@@ -34,6 +34,6 @@ static int ext3_follow_link(struct dentr
 }
 
 struct inode_operations ext3_fast_symlink_inode_operations = {
-	readlink:	ext3_readlink,		/* BKL not held.  Don't need */
-	follow_link:	ext3_follow_link,	/* BKL not held.  Don't need */
+	.readlink	= ext3_readlink,		/* BKL not held.  Don't need */
+	.follow_link	= ext3_follow_link,	/* BKL not held.  Don't need */
 };

.
