Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbTCKVKZ>; Tue, 11 Mar 2003 16:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbTCKVKY>; Tue, 11 Mar 2003 16:10:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13805 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261622AbTCKVKQ>;
	Tue, 11 Mar 2003 16:10:16 -0500
Date: Tue, 11 Mar 2003 21:20:58 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move EXPORT_SYMBOL from kernel/ksyms.c to fs/namei.c
Message-ID: <20030311212058.GJ16414@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move EXPORT_SYMBOL() from kernel/ksyms.c to fs/namei.c.
Also make vfs_rename_dir and vfs_rename_other static since they're not
used anywhere else.

diff -urpNX ../dontdiff linux-2.5.64-flA/fs/namei.c linux-2.5.64-flock/fs/namei.c
--- linux-2.5.64-flA/fs/namei.c	2003-02-20 22:47:18.000000000 -0500
+++ linux-2.5.64-flock/fs/namei.c	2003-03-11 10:27:16.000000000 -0500
@@ -23,6 +23,7 @@
 #include <linux/dnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
+#include <linux/module.h>
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <asm/namei.h>
@@ -1858,7 +1859,7 @@ exit:
  *	   ->i_sem on parents, which works but leads to some truely excessive
  *	   locking].
  */
-int vfs_rename_dir(struct inode *old_dir, struct dentry *old_dentry,
+static int vfs_rename_dir(struct inode *old_dir, struct dentry *old_dentry,
 	       struct inode *new_dir, struct dentry *new_dentry)
 {
 	int error = 0;
@@ -1903,7 +1904,7 @@ int vfs_rename_dir(struct inode *old_dir
 	return error;
 }
 
-int vfs_rename_other(struct inode *old_dir, struct dentry *old_dentry,
+static int vfs_rename_other(struct inode *old_dir, struct dentry *old_dentry,
 	       struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct inode *target;
@@ -2219,3 +2220,32 @@ struct inode_operations page_symlink_ino
 	.readlink	= page_readlink,
 	.follow_link	= page_follow_link,
 };
+
+EXPORT_SYMBOL(getname);
+EXPORT_SYMBOL(vfs_permission);
+EXPORT_SYMBOL(permission);
+EXPORT_SYMBOL(get_write_access);
+EXPORT_SYMBOL(path_release);
+EXPORT_SYMBOL(follow_up);
+EXPORT_SYMBOL(follow_down);
+EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(path_lookup);
+EXPORT_SYMBOL(lookup_hash);
+EXPORT_SYMBOL(lookup_one_len);
+EXPORT_SYMBOL(__user_walk);
+EXPORT_SYMBOL(lock_rename);
+EXPORT_SYMBOL(unlock_rename);
+EXPORT_SYMBOL(vfs_create);
+EXPORT_SYMBOL(vfs_mknod);
+EXPORT_SYMBOL(vfs_mkdir);
+EXPORT_SYMBOL(vfs_rmdir);
+EXPORT_SYMBOL(vfs_unlink);
+EXPORT_SYMBOL(vfs_symlink);
+EXPORT_SYMBOL(vfs_link);
+EXPORT_SYMBOL(vfs_rename);
+EXPORT_SYMBOL(vfs_readlink);
+EXPORT_SYMBOL(vfs_follow_link);
+EXPORT_SYMBOL(page_readlink);
+EXPORT_SYMBOL(page_follow_link);
+EXPORT_SYMBOL(page_symlink);
+EXPORT_SYMBOL(page_symlink_inode_operations);
diff -urpNX ../dontdiff linux-2.5.64-flA/kernel/ksyms.c linux-2.5.64-flock/kernel/ksyms.c
--- linux-2.5.64-flA/kernel/ksyms.c	2003-03-11 10:03:47.000000000 -0500
+++ linux-2.5.64-flock/kernel/ksyms.c	2003-03-11 10:19:30.000000000 -0500
@@ -139,7 +139,6 @@ EXPORT_SYMBOL(get_fs_type);
 EXPORT_SYMBOL(user_get_super);
 EXPORT_SYMBOL(get_super);
 EXPORT_SYMBOL(drop_super);
-EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(names_cachep);
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(fget);
@@ -147,15 +146,7 @@ EXPORT_SYMBOL(igrab);
 EXPORT_SYMBOL(iunique);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
-EXPORT_SYMBOL(follow_up);
-EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
-EXPORT_SYMBOL(path_lookup);
-EXPORT_SYMBOL(path_walk);
-EXPORT_SYMBOL(path_release);
-EXPORT_SYMBOL(__user_walk);
-EXPORT_SYMBOL(lookup_one_len);
-EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(sys_close);
 EXPORT_SYMBOL(dcache_lock);
 EXPORT_SYMBOL(dparent_lock);
@@ -191,8 +182,6 @@ EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_bdev);
-EXPORT_SYMBOL(permission);
-EXPORT_SYMBOL(vfs_permission);
 EXPORT_SYMBOL(inode_setattr);
 EXPORT_SYMBOL(inode_change_ok);
 EXPORT_SYMBOL(write_inode_now);
@@ -248,14 +237,6 @@ EXPORT_SYMBOL(vfs_read);
 EXPORT_SYMBOL(vfs_readv);
 EXPORT_SYMBOL(vfs_write);
 EXPORT_SYMBOL(vfs_writev);
-EXPORT_SYMBOL(vfs_create);
-EXPORT_SYMBOL(vfs_mkdir);
-EXPORT_SYMBOL(vfs_mknod);
-EXPORT_SYMBOL(vfs_symlink);
-EXPORT_SYMBOL(vfs_link);
-EXPORT_SYMBOL(vfs_rmdir);
-EXPORT_SYMBOL(vfs_unlink);
-EXPORT_SYMBOL(vfs_rename);
 EXPORT_SYMBOL(vfs_statfs);
 EXPORT_SYMBOL(vfs_fstat);
 EXPORT_SYMBOL(vfs_stat);
@@ -265,8 +246,6 @@ EXPORT_SYMBOL(inode_add_bytes);
 EXPORT_SYMBOL(inode_sub_bytes);
 EXPORT_SYMBOL(inode_get_bytes);
 EXPORT_SYMBOL(inode_set_bytes);
-EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(unlock_rename);
 EXPORT_SYMBOL(generic_read_dir);
 EXPORT_SYMBOL(generic_fillattr);
 EXPORT_SYMBOL(generic_file_llseek);
@@ -283,12 +262,6 @@ EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(read_cache_pages);
 EXPORT_SYMBOL(mark_page_accessed);
-EXPORT_SYMBOL(vfs_readlink);
-EXPORT_SYMBOL(vfs_follow_link);
-EXPORT_SYMBOL(page_readlink);
-EXPORT_SYMBOL(page_follow_link);
-EXPORT_SYMBOL(page_symlink_inode_operations);
-EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(vfs_readdir);
 EXPORT_SYMBOL(__break_lease);
 EXPORT_SYMBOL(lease_get_mtime);
@@ -576,9 +549,6 @@ EXPORT_SYMBOL(kill_fasync);
 
 EXPORT_SYMBOL(partition_name);
 
-/* binfmt_aout */
-EXPORT_SYMBOL(get_write_access);
-
 /* library functions */
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
