Return-Path: <linux-kernel-owner+w=401wt.eu-S1751027AbXANBDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXANBDp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXANBDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:03:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52782 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXANBDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:03:20 -0500
Subject: [patch 10/12] mark struct inode_operations const 1
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:57:42 -0800
Message-Id: <1168736262.3123.337.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 10/12] mark struct inode_operations const

Many struct inode_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.20-rc4/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6.20-rc4/arch/powerpc/platforms/cell/spufs/inode.c
@@ -220,7 +220,7 @@ static int spufs_dir_close(struct inode 
 	return dcache_dir_close(inode, file);
 }
 
-struct inode_operations spufs_dir_inode_operations = {
+const struct inode_operations spufs_dir_inode_operations = {
 	.lookup = simple_lookup,
 };
 
Index: linux-2.6.20-rc4/fs/9p/vfs_inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/9p/vfs_inode.c
+++ linux-2.6.20-rc4/fs/9p/vfs_inode.c
@@ -41,10 +41,10 @@
 #include "v9fs_vfs.h"
 #include "fid.h"
 
-static struct inode_operations v9fs_dir_inode_operations;
-static struct inode_operations v9fs_dir_inode_operations_ext;
-static struct inode_operations v9fs_file_inode_operations;
-static struct inode_operations v9fs_symlink_inode_operations;
+static const struct inode_operations v9fs_dir_inode_operations;
+static const struct inode_operations v9fs_dir_inode_operations_ext;
+static const struct inode_operations v9fs_file_inode_operations;
+static const struct inode_operations v9fs_symlink_inode_operations;
 
 /**
  * unixmode2p9mode - convert unix mode bits to plan 9
@@ -1274,7 +1274,7 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	return retval;
 }
 
-static struct inode_operations v9fs_dir_inode_operations_ext = {
+static const struct inode_operations v9fs_dir_inode_operations_ext = {
 	.create = v9fs_vfs_create,
 	.lookup = v9fs_vfs_lookup,
 	.symlink = v9fs_vfs_symlink,
@@ -1289,7 +1289,7 @@ static struct inode_operations v9fs_dir_
 	.setattr = v9fs_vfs_setattr,
 };
 
-static struct inode_operations v9fs_dir_inode_operations = {
+static const struct inode_operations v9fs_dir_inode_operations = {
 	.create = v9fs_vfs_create,
 	.lookup = v9fs_vfs_lookup,
 	.unlink = v9fs_vfs_unlink,
@@ -1301,12 +1301,12 @@ static struct inode_operations v9fs_dir_
 	.setattr = v9fs_vfs_setattr,
 };
 
-static struct inode_operations v9fs_file_inode_operations = {
+static const struct inode_operations v9fs_file_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,
 };
 
-static struct inode_operations v9fs_symlink_inode_operations = {
+static const struct inode_operations v9fs_symlink_inode_operations = {
 	.readlink = v9fs_vfs_readlink,
 	.follow_link = v9fs_vfs_follow_link,
 	.put_link = v9fs_vfs_put_link,
Index: linux-2.6.20-rc4/fs/adfs/adfs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/adfs/adfs.h
+++ linux-2.6.20-rc4/fs/adfs/adfs.h
@@ -84,7 +84,7 @@ void __adfs_error(struct super_block *sb
  */
 
 /* dir_*.c */
-extern struct inode_operations adfs_dir_inode_operations;
+extern const struct inode_operations adfs_dir_inode_operations;
 extern const struct file_operations adfs_dir_operations;
 extern struct dentry_operations adfs_dentry_operations;
 extern struct adfs_dir_ops adfs_f_dir_ops;
@@ -93,7 +93,7 @@ extern struct adfs_dir_ops adfs_fplus_di
 extern int adfs_dir_update(struct super_block *sb, struct object_info *obj);
 
 /* file.c */
-extern struct inode_operations adfs_file_inode_operations;
+extern const struct inode_operations adfs_file_inode_operations;
 extern const struct file_operations adfs_file_operations;
 
 static inline __u32 signed_asl(__u32 val, signed int shift)
Index: linux-2.6.20-rc4/fs/adfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/adfs/dir.c
+++ linux-2.6.20-rc4/fs/adfs/dir.c
@@ -295,7 +295,7 @@ adfs_lookup(struct inode *dir, struct de
 /*
  * directories can handle most operations...
  */
-struct inode_operations adfs_dir_inode_operations = {
+const struct inode_operations adfs_dir_inode_operations = {
 	.lookup		= adfs_lookup,
 	.setattr	= adfs_notify_change,
 };
Index: linux-2.6.20-rc4/fs/adfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/adfs/file.c
+++ linux-2.6.20-rc4/fs/adfs/file.c
@@ -36,6 +36,6 @@ const struct file_operations adfs_file_o
 	.sendfile	= generic_file_sendfile,
 };
 
-struct inode_operations adfs_file_inode_operations = {
+const struct inode_operations adfs_file_inode_operations = {
 	.setattr	= adfs_notify_change,
 };
Index: linux-2.6.20-rc4/fs/affs/affs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/affs/affs.h
+++ linux-2.6.20-rc4/fs/affs/affs.h
@@ -188,9 +188,9 @@ extern void   affs_dir_truncate(struct i
 
 /* jump tables */
 
-extern struct inode_operations	 affs_file_inode_operations;
-extern struct inode_operations	 affs_dir_inode_operations;
-extern struct inode_operations   affs_symlink_inode_operations;
+extern const struct inode_operations	 affs_file_inode_operations;
+extern const struct inode_operations	 affs_dir_inode_operations;
+extern const struct inode_operations   affs_symlink_inode_operations;
 extern const struct file_operations	 affs_file_operations;
 extern const struct file_operations	 affs_file_operations_ofs;
 extern const struct file_operations	 affs_dir_operations;
Index: linux-2.6.20-rc4/fs/affs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/affs/dir.c
+++ linux-2.6.20-rc4/fs/affs/dir.c
@@ -26,7 +26,7 @@ const struct file_operations affs_dir_op
 /*
  * directories can handle most operations...
  */
-struct inode_operations affs_dir_inode_operations = {
+const struct inode_operations affs_dir_inode_operations = {
 	.create		= affs_create,
 	.lookup		= affs_lookup,
 	.link		= affs_link,
Index: linux-2.6.20-rc4/fs/affs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/affs/file.c
+++ linux-2.6.20-rc4/fs/affs/file.c
@@ -38,7 +38,7 @@ const struct file_operations affs_file_o
 	.sendfile	= generic_file_sendfile,
 };
 
-struct inode_operations affs_file_inode_operations = {
+const struct inode_operations affs_file_inode_operations = {
 	.truncate	= affs_truncate,
 	.setattr	= affs_notify_change,
 };
Index: linux-2.6.20-rc4/fs/affs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/affs/inode.c
+++ linux-2.6.20-rc4/fs/affs/inode.c
@@ -12,7 +12,7 @@
 
 #include "affs.h"
 
-extern struct inode_operations affs_symlink_inode_operations;
+extern const struct inode_operations affs_symlink_inode_operations;
 extern struct timezone sys_tz;
 
 void
Index: linux-2.6.20-rc4/fs/affs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/affs/symlink.c
+++ linux-2.6.20-rc4/fs/affs/symlink.c
@@ -70,7 +70,7 @@ const struct address_space_operations af
 	.readpage	= affs_symlink_readpage,
 };
 
-struct inode_operations affs_symlink_inode_operations = {
+const struct inode_operations affs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/afs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/afs/dir.c
+++ linux-2.6.20-rc4/fs/afs/dir.c
@@ -37,7 +37,7 @@ const struct file_operations afs_dir_fil
 	.readdir	= afs_dir_readdir,
 };
 
-struct inode_operations afs_dir_inode_operations = {
+const struct inode_operations afs_dir_inode_operations = {
 	.lookup		= afs_dir_lookup,
 	.getattr	= afs_inode_getattr,
 #if 0 /* TODO */
Index: linux-2.6.20-rc4/fs/afs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/afs/file.c
+++ linux-2.6.20-rc4/fs/afs/file.c
@@ -30,7 +30,7 @@ static int afs_file_readpage(struct file
 static void afs_file_invalidatepage(struct page *page, unsigned long offset);
 static int afs_file_releasepage(struct page *page, gfp_t gfp_flags);
 
-struct inode_operations afs_file_inode_operations = {
+const struct inode_operations afs_file_inode_operations = {
 	.getattr	= afs_inode_getattr,
 };
 
Index: linux-2.6.20-rc4/fs/afs/internal.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/afs/internal.h
+++ linux-2.6.20-rc4/fs/afs/internal.h
@@ -63,14 +63,14 @@ extern struct cachefs_index_def afs_cach
 /*
  * dir.c
  */
-extern struct inode_operations afs_dir_inode_operations;
+extern const struct inode_operations afs_dir_inode_operations;
 extern const struct file_operations afs_dir_file_operations;
 
 /*
  * file.c
  */
 extern const struct address_space_operations afs_fs_aops;
-extern struct inode_operations afs_file_inode_operations;
+extern const struct inode_operations afs_file_inode_operations;
 
 #ifdef AFS_CACHING_SUPPORT
 extern int afs_cache_get_page_cookie(struct page *page,
@@ -104,7 +104,7 @@ extern struct cachefs_netfs afs_cache_ne
 /*
  * mntpt.c
  */
-extern struct inode_operations afs_mntpt_inode_operations;
+extern const struct inode_operations afs_mntpt_inode_operations;
 extern const struct file_operations afs_mntpt_file_operations;
 extern struct afs_timer afs_mntpt_expiry_timer;
 extern struct afs_timer_ops afs_mntpt_expiry_timer_ops;
Index: linux-2.6.20-rc4/fs/afs/mntpt.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/afs/mntpt.c
+++ linux-2.6.20-rc4/fs/afs/mntpt.c
@@ -36,7 +36,7 @@ const struct file_operations afs_mntpt_f
 	.open		= afs_mntpt_open,
 };
 
-struct inode_operations afs_mntpt_inode_operations = {
+const struct inode_operations afs_mntpt_inode_operations = {
 	.lookup		= afs_mntpt_lookup,
 	.follow_link	= afs_mntpt_follow_link,
 	.readlink	= page_readlink,
Index: linux-2.6.20-rc4/fs/autofs/autofs_i.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/autofs/autofs_i.h
+++ linux-2.6.20-rc4/fs/autofs/autofs_i.h
@@ -142,8 +142,8 @@ struct autofs_dir_ent *autofs_expire(str
 
 /* Operations structures */
 
-extern struct inode_operations autofs_root_inode_operations;
-extern struct inode_operations autofs_symlink_inode_operations;
+extern const struct inode_operations autofs_root_inode_operations;
+extern const struct inode_operations autofs_symlink_inode_operations;
 extern const struct file_operations autofs_root_operations;
 
 /* Initializing function */
Index: linux-2.6.20-rc4/fs/autofs/root.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/autofs/root.c
+++ linux-2.6.20-rc4/fs/autofs/root.c
@@ -32,7 +32,7 @@ const struct file_operations autofs_root
 	.ioctl		= autofs_root_ioctl,
 };
 
-struct inode_operations autofs_root_inode_operations = {
+const struct inode_operations autofs_root_inode_operations = {
         .lookup		= autofs_root_lookup,
         .unlink		= autofs_root_unlink,
         .symlink	= autofs_root_symlink,
Index: linux-2.6.20-rc4/fs/autofs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/autofs/symlink.c
+++ linux-2.6.20-rc4/fs/autofs/symlink.c
@@ -20,7 +20,7 @@ static void *autofs_follow_link(struct d
 	return NULL;
 }
 
-struct inode_operations autofs_symlink_inode_operations = {
+const struct inode_operations autofs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= autofs_follow_link
 };
Index: linux-2.6.20-rc4/fs/autofs4/autofs_i.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/autofs4/autofs_i.h
+++ linux-2.6.20-rc4/fs/autofs4/autofs_i.h
@@ -168,11 +168,11 @@ int autofs4_expire_multi(struct super_bl
 
 /* Operations structures */
 
-extern struct inode_operations autofs4_symlink_inode_operations;
-extern struct inode_operations autofs4_dir_inode_operations;
-extern struct inode_operations autofs4_root_inode_operations;
-extern struct inode_operations autofs4_indirect_root_inode_operations;
-extern struct inode_operations autofs4_direct_root_inode_operations;
+extern const struct inode_operations autofs4_symlink_inode_operations;
+extern const struct inode_operations autofs4_dir_inode_operations;
+extern const struct inode_operations autofs4_root_inode_operations;
+extern const struct inode_operations autofs4_indirect_root_inode_operations;
+extern const struct inode_operations autofs4_direct_root_inode_operations;
 extern const struct file_operations autofs4_dir_operations;
 extern const struct file_operations autofs4_root_operations;
 
Index: linux-2.6.20-rc4/fs/autofs4/root.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/autofs4/root.c
+++ linux-2.6.20-rc4/fs/autofs4/root.c
@@ -47,7 +47,7 @@ const struct file_operations autofs4_dir
 	.readdir	= autofs4_dir_readdir,
 };
 
-struct inode_operations autofs4_indirect_root_inode_operations = {
+const struct inode_operations autofs4_indirect_root_inode_operations = {
 	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
@@ -55,7 +55,7 @@ struct inode_operations autofs4_indirect
 	.rmdir		= autofs4_dir_rmdir,
 };
 
-struct inode_operations autofs4_direct_root_inode_operations = {
+const struct inode_operations autofs4_direct_root_inode_operations = {
 	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.mkdir		= autofs4_dir_mkdir,
@@ -63,7 +63,7 @@ struct inode_operations autofs4_direct_r
 	.follow_link	= autofs4_follow_link,
 };
 
-struct inode_operations autofs4_dir_inode_operations = {
+const struct inode_operations autofs4_dir_inode_operations = {
 	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
Index: linux-2.6.20-rc4/fs/autofs4/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/autofs4/symlink.c
+++ linux-2.6.20-rc4/fs/autofs4/symlink.c
@@ -19,7 +19,7 @@ static void *autofs4_follow_link(struct 
 	return NULL;
 }
 
-struct inode_operations autofs4_symlink_inode_operations = {
+const struct inode_operations autofs4_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= autofs4_follow_link
 };
Index: linux-2.6.20-rc4/fs/bad_inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/bad_inode.c
+++ linux-2.6.20-rc4/fs/bad_inode.c
@@ -291,7 +291,7 @@ static int bad_inode_removexattr(struct 
 	return -EIO;
 }
 
-static struct inode_operations bad_inode_ops =
+static const struct inode_operations bad_inode_ops =
 {
 	.create		= bad_inode_create,
 	.lookup		= bad_inode_lookup,
Index: linux-2.6.20-rc4/fs/befs/linuxvfs.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/befs/linuxvfs.c
+++ linux-2.6.20-rc4/fs/befs/linuxvfs.c
@@ -68,7 +68,7 @@ static const struct file_operations befs
 	.readdir	= befs_readdir,
 };
 
-static struct inode_operations befs_dir_inode_operations = {
+static const struct inode_operations befs_dir_inode_operations = {
 	.lookup		= befs_lookup,
 };
 
@@ -78,7 +78,7 @@ static const struct address_space_operat
 	.bmap		= befs_bmap,
 };
 
-static struct inode_operations befs_symlink_inode_operations = {
+static const struct inode_operations befs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= befs_follow_link,
 	.put_link	= befs_put_link,
Index: linux-2.6.20-rc4/fs/bfs/bfs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/bfs/bfs.h
+++ linux-2.6.20-rc4/fs/bfs/bfs.h
@@ -48,12 +48,12 @@ static inline struct bfs_inode_info *BFS
 
 
 /* file.c */
-extern struct inode_operations bfs_file_inops;
+extern const struct inode_operations bfs_file_inops;
 extern const struct file_operations bfs_file_operations;
 extern const struct address_space_operations bfs_aops;
 
 /* dir.c */
-extern struct inode_operations bfs_dir_inops;
+extern const struct inode_operations bfs_dir_inops;
 extern const struct file_operations bfs_dir_operations;
 
 #endif /* _FS_BFS_BFS_H */
Index: linux-2.6.20-rc4/fs/bfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/bfs/dir.c
+++ linux-2.6.20-rc4/fs/bfs/dir.c
@@ -260,7 +260,7 @@ end_rename:
 	return error;
 }
 
-struct inode_operations bfs_dir_inops = {
+const struct inode_operations bfs_dir_inops = {
 	.create			= bfs_create,
 	.lookup			= bfs_lookup,
 	.link			= bfs_link,
Index: linux-2.6.20-rc4/fs/bfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/bfs/file.c
+++ linux-2.6.20-rc4/fs/bfs/file.c
@@ -164,4 +164,4 @@ const struct address_space_operations bf
 	.bmap		= bfs_bmap,
 };
 
-struct inode_operations bfs_file_inops;
+const struct inode_operations bfs_file_inops;
Index: linux-2.6.20-rc4/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/cifs/cifsfs.c
+++ linux-2.6.20-rc4/fs/cifs/cifsfs.c
@@ -525,7 +525,7 @@ static struct file_system_type cifs_fs_t
 	.kill_sb = kill_anon_super,
 	/*  .fs_flags */
 };
-struct inode_operations cifs_dir_inode_ops = {
+const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.lookup = cifs_lookup,
 	.getattr = cifs_getattr,
@@ -547,7 +547,7 @@ struct inode_operations cifs_dir_inode_o
 #endif
 };
 
-struct inode_operations cifs_file_inode_ops = {
+const struct inode_operations cifs_file_inode_ops = {
 /*	revalidate:cifs_revalidate, */
 	.setattr = cifs_setattr,
 	.getattr = cifs_getattr, /* do we need this anymore? */
@@ -561,7 +561,7 @@ struct inode_operations cifs_file_inode_
 #endif 
 };
 
-struct inode_operations cifs_symlink_inode_ops = {
+const struct inode_operations cifs_symlink_inode_ops = {
 	.readlink = generic_readlink, 
 	.follow_link = cifs_follow_link,
 	.put_link = cifs_put_link,
Index: linux-2.6.20-rc4/fs/cifs/cifsfs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/cifs/cifsfs.h
+++ linux-2.6.20-rc4/fs/cifs/cifsfs.h
@@ -42,7 +42,7 @@ extern void cifs_delete_inode(struct ino
 /* extern void cifs_write_inode(struct inode *); *//* BB not needed yet */
 
 /* Functions related to inodes */
-extern struct inode_operations cifs_dir_inode_ops;
+extern const struct inode_operations cifs_dir_inode_ops;
 extern int cifs_create(struct inode *, struct dentry *, int, 
 		       struct nameidata *);
 extern struct dentry * cifs_lookup(struct inode *, struct dentry *,
@@ -58,8 +58,8 @@ extern int cifs_revalidate(struct dentry
 extern int cifs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 extern int cifs_setattr(struct dentry *, struct iattr *);
 
-extern struct inode_operations cifs_file_inode_ops;
-extern struct inode_operations cifs_symlink_inode_ops;
+extern const struct inode_operations cifs_file_inode_ops;
+extern const struct inode_operations cifs_symlink_inode_ops;
 
 /* Functions related to files and directories */
 extern const struct file_operations cifs_file_ops;
Index: linux-2.6.20-rc4/fs/coda/cnode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/coda/cnode.c
+++ linux-2.6.20-rc4/fs/coda/cnode.c
@@ -16,7 +16,7 @@ static inline int coda_fideq(struct Coda
 	return memcmp(fid1, fid2, sizeof(*fid1)) == 0;
 }
 
-static struct inode_operations coda_symlink_inode_operations = {
+static const struct inode_operations coda_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/coda/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/coda/dir.c
+++ linux-2.6.20-rc4/fs/coda/dir.c
@@ -66,7 +66,7 @@ static struct dentry_operations coda_den
 	.d_delete	= coda_dentry_delete,
 };
 
-struct inode_operations coda_dir_inode_operations =
+const struct inode_operations coda_dir_inode_operations =
 {
 	.create		= coda_create,
 	.lookup		= coda_lookup,
Index: linux-2.6.20-rc4/fs/coda/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/coda/inode.c
+++ linux-2.6.20-rc4/fs/coda/inode.c
@@ -271,7 +271,7 @@ int coda_setattr(struct dentry *de, stru
 	return error;
 }
 
-struct inode_operations coda_file_inode_operations = {
+const struct inode_operations coda_file_inode_operations = {
 	.permission	= coda_permission,
 	.getattr	= coda_getattr,
 	.setattr	= coda_setattr,
Index: linux-2.6.20-rc4/fs/coda/pioctl.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/coda/pioctl.c
+++ linux-2.6.20-rc4/fs/coda/pioctl.c
@@ -30,7 +30,7 @@ static int coda_pioctl(struct inode * in
                        unsigned int cmd, unsigned long user_data);
 
 /* exported from this file */
-struct inode_operations coda_ioctl_inode_operations =
+const struct inode_operations coda_ioctl_inode_operations =
 {
 	.permission	= coda_ioctl_permission,
 	.setattr	= coda_setattr,
Index: linux-2.6.20-rc4/fs/configfs/configfs_internal.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/configfs/configfs_internal.h
+++ linux-2.6.20-rc4/fs/configfs/configfs_internal.h
@@ -75,8 +75,8 @@ extern struct super_block * configfs_sb;
 extern const struct file_operations configfs_dir_operations;
 extern const struct file_operations configfs_file_operations;
 extern const struct file_operations bin_fops;
-extern struct inode_operations configfs_dir_inode_operations;
-extern struct inode_operations configfs_symlink_inode_operations;
+extern const struct inode_operations configfs_dir_inode_operations;
+extern const struct inode_operations configfs_symlink_inode_operations;
 
 extern int configfs_symlink(struct inode *dir, struct dentry *dentry,
 			    const char *symname);
Index: linux-2.6.20-rc4/fs/configfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/configfs/dir.c
+++ linux-2.6.20-rc4/fs/configfs/dir.c
@@ -931,7 +931,7 @@ static int configfs_rmdir(struct inode *
 	return 0;
 }
 
-struct inode_operations configfs_dir_inode_operations = {
+const struct inode_operations configfs_dir_inode_operations = {
 	.mkdir		= configfs_mkdir,
 	.rmdir		= configfs_rmdir,
 	.symlink	= configfs_symlink,
Index: linux-2.6.20-rc4/fs/configfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/configfs/inode.c
+++ linux-2.6.20-rc4/fs/configfs/inode.c
@@ -49,7 +49,7 @@ static struct backing_dev_info configfs_
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
-static struct inode_operations configfs_inode_operations ={
+static const struct inode_operations configfs_inode_operations ={
 	.setattr	= configfs_setattr,
 };
 
Index: linux-2.6.20-rc4/fs/configfs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/configfs/symlink.c
+++ linux-2.6.20-rc4/fs/configfs/symlink.c
@@ -272,7 +272,7 @@ static void configfs_put_link(struct den
 	}
 }
 
-struct inode_operations configfs_symlink_inode_operations = {
+const struct inode_operations configfs_symlink_inode_operations = {
 	.follow_link = configfs_follow_link,
 	.readlink = generic_readlink,
 	.put_link = configfs_put_link,
Index: linux-2.6.20-rc4/fs/cramfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/cramfs/inode.c
+++ linux-2.6.20-rc4/fs/cramfs/inode.c
@@ -28,7 +28,7 @@
 #include <asm/uaccess.h>
 
 static struct super_operations cramfs_ops;
-static struct inode_operations cramfs_dir_inode_operations;
+static const struct inode_operations cramfs_dir_inode_operations;
 static const struct file_operations cramfs_directory_operations;
 static const struct address_space_operations cramfs_aops;
 
@@ -518,7 +518,7 @@ static const struct file_operations cram
 	.readdir	= cramfs_readdir,
 };
 
-static struct inode_operations cramfs_dir_inode_operations = {
+static const struct inode_operations cramfs_dir_inode_operations = {
 	.lookup		= cramfs_lookup,
 };
 
Index: linux-2.6.20-rc4/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ecryptfs/ecryptfs_kernel.h
+++ linux-2.6.20-rc4/fs/ecryptfs/ecryptfs_kernel.h
@@ -385,9 +385,9 @@ void __ecryptfs_printk(const char *fmt, 
 
 extern const struct file_operations ecryptfs_main_fops;
 extern const struct file_operations ecryptfs_dir_fops;
-extern struct inode_operations ecryptfs_main_iops;
-extern struct inode_operations ecryptfs_dir_iops;
-extern struct inode_operations ecryptfs_symlink_iops;
+extern const struct inode_operations ecryptfs_main_iops;
+extern const struct inode_operations ecryptfs_dir_iops;
+extern const struct inode_operations ecryptfs_symlink_iops;
 extern struct super_operations ecryptfs_sops;
 extern struct dentry_operations ecryptfs_dops;
 extern struct address_space_operations ecryptfs_aops;
Index: linux-2.6.20-rc4/fs/ecryptfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ecryptfs/inode.c
+++ linux-2.6.20-rc4/fs/ecryptfs/inode.c
@@ -972,7 +972,7 @@ int ecryptfs_inode_set(struct inode *ino
 	return 0;
 }
 
-struct inode_operations ecryptfs_symlink_iops = {
+const struct inode_operations ecryptfs_symlink_iops = {
 	.readlink = ecryptfs_readlink,
 	.follow_link = ecryptfs_follow_link,
 	.put_link = ecryptfs_put_link,
@@ -984,7 +984,7 @@ struct inode_operations ecryptfs_symlink
 	.removexattr = ecryptfs_removexattr
 };
 
-struct inode_operations ecryptfs_dir_iops = {
+const struct inode_operations ecryptfs_dir_iops = {
 	.create = ecryptfs_create,
 	.lookup = ecryptfs_lookup,
 	.link = ecryptfs_link,
@@ -1002,7 +1002,7 @@ struct inode_operations ecryptfs_dir_iop
 	.removexattr = ecryptfs_removexattr
 };
 
-struct inode_operations ecryptfs_main_iops = {
+const struct inode_operations ecryptfs_main_iops = {
 	.permission = ecryptfs_permission,
 	.setattr = ecryptfs_setattr,
 	.setxattr = ecryptfs_setxattr,
Index: linux-2.6.20-rc4/fs/efs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/efs/dir.c
+++ linux-2.6.20-rc4/fs/efs/dir.c
@@ -15,7 +15,7 @@ const struct file_operations efs_dir_ope
 	.readdir	= efs_readdir,
 };
 
-struct inode_operations efs_dir_inode_operations = {
+const struct inode_operations efs_dir_inode_operations = {
 	.lookup		= efs_lookup,
 };
 
Index: linux-2.6.20-rc4/fs/ext2/ext2.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext2/ext2.h
+++ linux-2.6.20-rc4/fs/ext2/ext2.h
@@ -158,7 +158,7 @@ extern void ext2_write_super (struct sup
 extern const struct file_operations ext2_dir_operations;
 
 /* file.c */
-extern struct inode_operations ext2_file_inode_operations;
+extern const struct inode_operations ext2_file_inode_operations;
 extern const struct file_operations ext2_file_operations;
 extern const struct file_operations ext2_xip_file_operations;
 
@@ -168,9 +168,9 @@ extern const struct address_space_operat
 extern const struct address_space_operations ext2_nobh_aops;
 
 /* namei.c */
-extern struct inode_operations ext2_dir_inode_operations;
-extern struct inode_operations ext2_special_inode_operations;
+extern const struct inode_operations ext2_dir_inode_operations;
+extern const struct inode_operations ext2_special_inode_operations;
 
 /* symlink.c */
-extern struct inode_operations ext2_fast_symlink_inode_operations;
-extern struct inode_operations ext2_symlink_inode_operations;
+extern const struct inode_operations ext2_fast_symlink_inode_operations;
+extern const struct inode_operations ext2_symlink_inode_operations;
Index: linux-2.6.20-rc4/fs/ext2/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext2/file.c
+++ linux-2.6.20-rc4/fs/ext2/file.c
@@ -75,7 +75,7 @@ const struct file_operations ext2_xip_fi
 };
 #endif
 
-struct inode_operations ext2_file_inode_operations = {
+const struct inode_operations ext2_file_inode_operations = {
 	.truncate	= ext2_truncate,
 #ifdef CONFIG_EXT2_FS_XATTR
 	.setxattr	= generic_setxattr,
Index: linux-2.6.20-rc4/fs/ext2/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext2/namei.c
+++ linux-2.6.20-rc4/fs/ext2/namei.c
@@ -373,7 +373,7 @@ out:
 	return err;
 }
 
-struct inode_operations ext2_dir_inode_operations = {
+const struct inode_operations ext2_dir_inode_operations = {
 	.create		= ext2_create,
 	.lookup		= ext2_lookup,
 	.link		= ext2_link,
@@ -393,7 +393,7 @@ struct inode_operations ext2_dir_inode_o
 	.permission	= ext2_permission,
 };
 
-struct inode_operations ext2_special_inode_operations = {
+const struct inode_operations ext2_special_inode_operations = {
 #ifdef CONFIG_EXT2_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
Index: linux-2.6.20-rc4/fs/ext2/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext2/symlink.c
+++ linux-2.6.20-rc4/fs/ext2/symlink.c
@@ -28,7 +28,7 @@ static void *ext2_follow_link(struct den
 	return NULL;
 }
 
-struct inode_operations ext2_symlink_inode_operations = {
+const struct inode_operations ext2_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
@@ -40,7 +40,7 @@ struct inode_operations ext2_symlink_ino
 #endif
 };
  
-struct inode_operations ext2_fast_symlink_inode_operations = {
+const struct inode_operations ext2_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ext2_follow_link,
 #ifdef CONFIG_EXT2_FS_XATTR
Index: linux-2.6.20-rc4/fs/ext3/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext3/file.c
+++ linux-2.6.20-rc4/fs/ext3/file.c
@@ -125,7 +125,7 @@ const struct file_operations ext3_file_o
 	.splice_write	= generic_file_splice_write,
 };
 
-struct inode_operations ext3_file_inode_operations = {
+const struct inode_operations ext3_file_inode_operations = {
 	.truncate	= ext3_truncate,
 	.setattr	= ext3_setattr,
 #ifdef CONFIG_EXT3_FS_XATTR
Index: linux-2.6.20-rc4/fs/ext3/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext3/namei.c
+++ linux-2.6.20-rc4/fs/ext3/namei.c
@@ -2374,7 +2374,7 @@ end_rename:
 /*
  * directories can handle most operations...
  */
-struct inode_operations ext3_dir_inode_operations = {
+const struct inode_operations ext3_dir_inode_operations = {
 	.create		= ext3_create,
 	.lookup		= ext3_lookup,
 	.link		= ext3_link,
@@ -2394,7 +2394,7 @@ struct inode_operations ext3_dir_inode_o
 	.permission	= ext3_permission,
 };
 
-struct inode_operations ext3_special_inode_operations = {
+const struct inode_operations ext3_special_inode_operations = {
 	.setattr	= ext3_setattr,
 #ifdef CONFIG_EXT3_FS_XATTR
 	.setxattr	= generic_setxattr,
Index: linux-2.6.20-rc4/fs/ext3/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext3/symlink.c
+++ linux-2.6.20-rc4/fs/ext3/symlink.c
@@ -30,7 +30,7 @@ static void * ext3_follow_link(struct de
 	return NULL;
 }
 
-struct inode_operations ext3_symlink_inode_operations = {
+const struct inode_operations ext3_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
@@ -42,7 +42,7 @@ struct inode_operations ext3_symlink_ino
 #endif
 };
 
-struct inode_operations ext3_fast_symlink_inode_operations = {
+const struct inode_operations ext3_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ext3_follow_link,
 #ifdef CONFIG_EXT3_FS_XATTR
Index: linux-2.6.20-rc4/fs/ext4/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext4/file.c
+++ linux-2.6.20-rc4/fs/ext4/file.c
@@ -125,7 +125,7 @@ const struct file_operations ext4_file_o
 	.splice_write	= generic_file_splice_write,
 };
 
-struct inode_operations ext4_file_inode_operations = {
+const struct inode_operations ext4_file_inode_operations = {
 	.truncate	= ext4_truncate,
 	.setattr	= ext4_setattr,
 #ifdef CONFIG_EXT4DEV_FS_XATTR
Index: linux-2.6.20-rc4/fs/ext4/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext4/namei.c
+++ linux-2.6.20-rc4/fs/ext4/namei.c
@@ -2372,7 +2372,7 @@ end_rename:
 /*
  * directories can handle most operations...
  */
-struct inode_operations ext4_dir_inode_operations = {
+const struct inode_operations ext4_dir_inode_operations = {
 	.create		= ext4_create,
 	.lookup		= ext4_lookup,
 	.link		= ext4_link,
@@ -2392,7 +2392,7 @@ struct inode_operations ext4_dir_inode_o
 	.permission	= ext4_permission,
 };
 
-struct inode_operations ext4_special_inode_operations = {
+const struct inode_operations ext4_special_inode_operations = {
 	.setattr	= ext4_setattr,
 #ifdef CONFIG_EXT4DEV_FS_XATTR
 	.setxattr	= generic_setxattr,
Index: linux-2.6.20-rc4/fs/ext4/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ext4/symlink.c
+++ linux-2.6.20-rc4/fs/ext4/symlink.c
@@ -30,7 +30,7 @@ static void * ext4_follow_link(struct de
 	return NULL;
 }
 
-struct inode_operations ext4_symlink_inode_operations = {
+const struct inode_operations ext4_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
@@ -42,7 +42,7 @@ struct inode_operations ext4_symlink_ino
 #endif
 };
 
-struct inode_operations ext4_fast_symlink_inode_operations = {
+const struct inode_operations ext4_fast_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= ext4_follow_link,
 #ifdef CONFIG_EXT4DEV_FS_XATTR
Index: linux-2.6.20-rc4/fs/fat/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/fat/file.c
+++ linux-2.6.20-rc4/fs/fat/file.c
@@ -312,7 +312,7 @@ int fat_getattr(struct vfsmount *mnt, st
 }
 EXPORT_SYMBOL_GPL(fat_getattr);
 
-struct inode_operations fat_file_inode_operations = {
+const struct inode_operations fat_file_inode_operations = {
 	.truncate	= fat_truncate,
 	.setattr	= fat_notify_change,
 	.getattr	= fat_getattr,
Index: linux-2.6.20-rc4/fs/fat/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/fat/inode.c
+++ linux-2.6.20-rc4/fs/fat/inode.c
@@ -1151,7 +1151,7 @@ static int fat_read_root(struct inode *i
  * Read the super block of an MS-DOS FS.
  */
 int fat_fill_super(struct super_block *sb, void *data, int silent,
-		   struct inode_operations *fs_dir_inode_ops, int isvfat)
+		   const struct inode_operations *fs_dir_inode_ops, int isvfat)
 {
 	struct inode *root_inode = NULL;
 	struct buffer_head *bh;
Index: linux-2.6.20-rc4/fs/freevxfs/vxfs_extern.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/freevxfs/vxfs_extern.h
+++ linux-2.6.20-rc4/fs/freevxfs/vxfs_extern.h
@@ -62,7 +62,7 @@ extern void			vxfs_read_inode(struct ino
 extern void			vxfs_clear_inode(struct inode *);
 
 /* vxfs_lookup.c */
-extern struct inode_operations	vxfs_dir_inode_ops;
+extern const struct inode_operations	vxfs_dir_inode_ops;
 extern const struct file_operations	vxfs_dir_operations;
 
 /* vxfs_olt.c */
Index: linux-2.6.20-rc4/fs/freevxfs/vxfs_immed.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/freevxfs/vxfs_immed.c
+++ linux-2.6.20-rc4/fs/freevxfs/vxfs_immed.c
@@ -48,7 +48,7 @@ static int	vxfs_immed_readpage(struct fi
  * Unliked all other operations we do not go through the pagecache,
  * but do all work directly on the inode.
  */
-struct inode_operations vxfs_immed_symlink_iops = {
+const struct inode_operations vxfs_immed_symlink_iops = {
 	.readlink =		generic_readlink,
 	.follow_link =		vxfs_immed_follow_link,
 };
Index: linux-2.6.20-rc4/fs/freevxfs/vxfs_inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/freevxfs/vxfs_inode.c
+++ linux-2.6.20-rc4/fs/freevxfs/vxfs_inode.c
@@ -44,7 +44,7 @@
 extern const struct address_space_operations vxfs_aops;
 extern const struct address_space_operations vxfs_immed_aops;
 
-extern struct inode_operations vxfs_immed_symlink_iops;
+extern const struct inode_operations vxfs_immed_symlink_iops;
 
 struct kmem_cache		*vxfs_inode_cachep;
 
Index: linux-2.6.20-rc4/fs/freevxfs/vxfs_lookup.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/freevxfs/vxfs_lookup.c
+++ linux-2.6.20-rc4/fs/freevxfs/vxfs_lookup.c
@@ -52,7 +52,7 @@
 static struct dentry *	vxfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 static int		vxfs_readdir(struct file *, void *, filldir_t);
 
-struct inode_operations vxfs_dir_inode_ops = {
+const struct inode_operations vxfs_dir_inode_ops = {
 	.lookup =		vxfs_lookup,
 };
 
Index: linux-2.6.20-rc4/fs/fuse/control.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/fuse/control.c
+++ linux-2.6.20-rc4/fs/fuse/control.c
@@ -73,7 +73,7 @@ static struct dentry *fuse_ctl_add_dentr
 					  struct fuse_conn *fc,
 					  const char *name,
 					  int mode, int nlink,
-					  struct inode_operations *iop,
+					  const struct inode_operations *iop,
 					  const struct file_operations *fop)
 {
 	struct dentry *dentry;
Index: linux-2.6.20-rc4/fs/fuse/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/fuse/dir.c
+++ linux-2.6.20-rc4/fs/fuse/dir.c
@@ -1242,7 +1242,7 @@ static int fuse_removexattr(struct dentr
 	return err;
 }
 
-static struct inode_operations fuse_dir_inode_operations = {
+static const struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
 	.mkdir		= fuse_mkdir,
 	.symlink	= fuse_symlink,
@@ -1270,7 +1270,7 @@ static const struct file_operations fuse
 	.fsync		= fuse_dir_fsync,
 };
 
-static struct inode_operations fuse_common_inode_operations = {
+static const struct inode_operations fuse_common_inode_operations = {
 	.setattr	= fuse_setattr,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
@@ -1280,7 +1280,7 @@ static struct inode_operations fuse_comm
 	.removexattr	= fuse_removexattr,
 };
 
-static struct inode_operations fuse_symlink_inode_operations = {
+static const struct inode_operations fuse_symlink_inode_operations = {
 	.setattr	= fuse_setattr,
 	.follow_link	= fuse_follow_link,
 	.put_link	= fuse_put_link,


