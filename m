Return-Path: <linux-kernel-owner+w=401wt.eu-S1751058AbXANBEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbXANBEG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXANBEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:04:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52793 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXANBEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:04:00 -0500
Subject: [patch 11/12] mark struct inode_operations const 2
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:58:11 -0800
Message-Id: <1168736291.3123.339.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 11/12] mark struct inode_operations const

Many struct inode_operations in the kernel can be "const". Marking them const
moves these to the .rodata section, which avoids false sharing with
potential dirty data. In addition it'll catch accidental writes at compile
time to these shared resources.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.20-rc4/fs/gfs2/ops_inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/gfs2/ops_inode.c
+++ linux-2.6.20-rc4/fs/gfs2/ops_inode.c
@@ -1084,7 +1084,7 @@ static int gfs2_removexattr(struct dentr
 	return gfs2_ea_remove(GFS2_I(dentry->d_inode), &er);
 }
 
-struct inode_operations gfs2_file_iops = {
+const struct inode_operations gfs2_file_iops = {
 	.permission = gfs2_permission,
 	.setattr = gfs2_setattr,
 	.getattr = gfs2_getattr,
@@ -1094,7 +1094,7 @@ struct inode_operations gfs2_file_iops =
 	.removexattr = gfs2_removexattr,
 };
 
-struct inode_operations gfs2_dev_iops = {
+const struct inode_operations gfs2_dev_iops = {
 	.permission = gfs2_permission,
 	.setattr = gfs2_setattr,
 	.getattr = gfs2_getattr,
@@ -1104,7 +1104,7 @@ struct inode_operations gfs2_dev_iops = 
 	.removexattr = gfs2_removexattr,
 };
 
-struct inode_operations gfs2_dir_iops = {
+const struct inode_operations gfs2_dir_iops = {
 	.create = gfs2_create,
 	.lookup = gfs2_lookup,
 	.link = gfs2_link,
@@ -1123,7 +1123,7 @@ struct inode_operations gfs2_dir_iops = 
 	.removexattr = gfs2_removexattr,
 };
 
-struct inode_operations gfs2_symlink_iops = {
+const struct inode_operations gfs2_symlink_iops = {
 	.readlink = gfs2_readlink,
 	.follow_link = gfs2_follow_link,
 	.permission = gfs2_permission,
Index: linux-2.6.20-rc4/fs/gfs2/ops_inode.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/gfs2/ops_inode.h
+++ linux-2.6.20-rc4/fs/gfs2/ops_inode.h
@@ -12,9 +12,9 @@
 
 #include <linux/fs.h>
 
-extern struct inode_operations gfs2_file_iops;
-extern struct inode_operations gfs2_dir_iops;
-extern struct inode_operations gfs2_symlink_iops;
-extern struct inode_operations gfs2_dev_iops;
+extern const struct inode_operations gfs2_file_iops;
+extern const struct inode_operations gfs2_dir_iops;
+extern const struct inode_operations gfs2_symlink_iops;
+extern const struct inode_operations gfs2_dev_iops;
 
 #endif /* __OPS_INODE_DOT_H__ */
Index: linux-2.6.20-rc4/fs/hfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hfs/dir.c
+++ linux-2.6.20-rc4/fs/hfs/dir.c
@@ -320,7 +320,7 @@ const struct file_operations hfs_dir_ope
 	.release	= hfs_dir_release,
 };
 
-struct inode_operations hfs_dir_inode_operations = {
+const struct inode_operations hfs_dir_inode_operations = {
 	.create		= hfs_create,
 	.lookup		= hfs_lookup,
 	.unlink		= hfs_unlink,
Index: linux-2.6.20-rc4/fs/hfs/hfs_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/hfs/hfs_fs.h
+++ linux-2.6.20-rc4/fs/hfs/hfs_fs.h
@@ -170,7 +170,7 @@ extern void hfs_cat_build_key(struct sup
 
 /* dir.c */
 extern const struct file_operations hfs_dir_operations;
-extern struct inode_operations hfs_dir_inode_operations;
+extern const struct inode_operations hfs_dir_inode_operations;
 
 /* extent.c */
 extern int hfs_ext_keycmp(const btree_key *, const btree_key *);
Index: linux-2.6.20-rc4/fs/hfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hfs/inode.c
+++ linux-2.6.20-rc4/fs/hfs/inode.c
@@ -18,7 +18,7 @@
 #include "btree.h"
 
 static const struct file_operations hfs_file_operations;
-static struct inode_operations hfs_file_inode_operations;
+static const struct inode_operations hfs_file_inode_operations;
 
 /*================ Variable-like macros ================*/
 
@@ -612,7 +612,7 @@ static const struct file_operations hfs_
 	.release	= hfs_file_release,
 };
 
-static struct inode_operations hfs_file_inode_operations = {
+static const struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.truncate	= hfs_file_truncate,
 	.setattr	= hfs_inode_setattr,
Index: linux-2.6.20-rc4/fs/hfsplus/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hfsplus/dir.c
+++ linux-2.6.20-rc4/fs/hfsplus/dir.c
@@ -471,7 +471,7 @@ static int hfsplus_rename(struct inode *
 	return res;
 }
 
-struct inode_operations hfsplus_dir_inode_operations = {
+const struct inode_operations hfsplus_dir_inode_operations = {
 	.lookup		= hfsplus_lookup,
 	.create		= hfsplus_create,
 	.link		= hfsplus_link,
Index: linux-2.6.20-rc4/fs/hfsplus/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hfsplus/inode.c
+++ linux-2.6.20-rc4/fs/hfsplus/inode.c
@@ -268,10 +268,10 @@ static int hfsplus_file_release(struct i
 	return 0;
 }
 
-extern struct inode_operations hfsplus_dir_inode_operations;
+extern const struct inode_operations hfsplus_dir_inode_operations;
 extern struct file_operations hfsplus_dir_operations;
 
-static struct inode_operations hfsplus_file_inode_operations = {
+static const struct inode_operations hfsplus_file_inode_operations = {
 	.lookup		= hfsplus_file_lookup,
 	.truncate	= hfsplus_file_truncate,
 	.permission	= hfsplus_permission,
Index: linux-2.6.20-rc4/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hostfs/hostfs_kern.c
+++ linux-2.6.20-rc4/fs/hostfs/hostfs_kern.c
@@ -52,8 +52,8 @@ static int append = 0;
 
 #define HOSTFS_SUPER_MAGIC 0x00c0ffee
 
-static struct inode_operations hostfs_iops;
-static struct inode_operations hostfs_dir_iops;
+static const struct inode_operations hostfs_iops;
+static const struct inode_operations hostfs_dir_iops;
 static const struct address_space_operations hostfs_link_aops;
 
 #ifndef MODULE
@@ -880,7 +880,7 @@ int hostfs_getattr(struct vfsmount *mnt,
 	return(0);
 }
 
-static struct inode_operations hostfs_iops = {
+static const struct inode_operations hostfs_iops = {
 	.create		= hostfs_create,
 	.link		= hostfs_link,
 	.unlink		= hostfs_unlink,
@@ -894,7 +894,7 @@ static struct inode_operations hostfs_io
 	.getattr	= hostfs_getattr,
 };
 
-static struct inode_operations hostfs_dir_iops = {
+static const struct inode_operations hostfs_dir_iops = {
 	.create		= hostfs_create,
 	.lookup		= hostfs_lookup,
 	.link		= hostfs_link,
Index: linux-2.6.20-rc4/fs/hpfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hpfs/file.c
+++ linux-2.6.20-rc4/fs/hpfs/file.c
@@ -132,7 +132,7 @@ const struct file_operations hpfs_file_o
 	.sendfile	= generic_file_sendfile,
 };
 
-struct inode_operations hpfs_file_iops =
+const struct inode_operations hpfs_file_iops =
 {
 	.truncate	= hpfs_truncate,
 	.setattr	= hpfs_notify_change,
Index: linux-2.6.20-rc4/fs/hpfs/hpfs_fn.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/hpfs/hpfs_fn.h
+++ linux-2.6.20-rc4/fs/hpfs/hpfs_fn.h
@@ -266,7 +266,7 @@ void hpfs_set_ea(struct inode *, struct 
 
 int hpfs_file_fsync(struct file *, struct dentry *, int);
 extern const struct file_operations hpfs_file_ops;
-extern struct inode_operations hpfs_file_iops;
+extern const struct inode_operations hpfs_file_iops;
 extern const struct address_space_operations hpfs_aops;
 
 /* inode.c */
@@ -302,7 +302,7 @@ void hpfs_decide_conv(struct inode *, un
 
 /* namei.c */
 
-extern struct inode_operations hpfs_dir_iops;
+extern const struct inode_operations hpfs_dir_iops;
 extern const struct address_space_operations hpfs_symlink_aops;
 
 static inline struct hpfs_inode_info *hpfs_i(struct inode *inode)
Index: linux-2.6.20-rc4/fs/hpfs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hpfs/namei.c
+++ linux-2.6.20-rc4/fs/hpfs/namei.c
@@ -659,7 +659,7 @@ end1:
 	return err;
 }
 
-struct inode_operations hpfs_dir_iops =
+const struct inode_operations hpfs_dir_iops =
 {
 	.create		= hpfs_create,
 	.lookup		= hpfs_lookup,
Index: linux-2.6.20-rc4/fs/hppfs/hppfs_kern.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hppfs/hppfs_kern.c
+++ linux-2.6.20-rc4/fs/hppfs/hppfs_kern.c
@@ -212,7 +212,7 @@ static struct dentry *hppfs_lookup(struc
 	return(ERR_PTR(err));
 }
 
-static struct inode_operations hppfs_file_iops = {
+static const struct inode_operations hppfs_file_iops = {
 };
 
 static ssize_t read_proc(struct file *file, char __user *buf, ssize_t count,
@@ -693,11 +693,11 @@ static void* hppfs_follow_link(struct de
 	return ret;
 }
 
-static struct inode_operations hppfs_dir_iops = {
+static const struct inode_operations hppfs_dir_iops = {
 	.lookup		= hppfs_lookup,
 };
 
-static struct inode_operations hppfs_link_iops = {
+static const struct inode_operations hppfs_link_iops = {
 	.readlink	= hppfs_readlink,
 	.follow_link	= hppfs_follow_link,
 };
Index: linux-2.6.20-rc4/fs/hugetlbfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/hugetlbfs/inode.c
+++ linux-2.6.20-rc4/fs/hugetlbfs/inode.c
@@ -36,8 +36,8 @@
 static struct super_operations hugetlbfs_ops;
 static const struct address_space_operations hugetlbfs_aops;
 const struct file_operations hugetlbfs_file_operations;
-static struct inode_operations hugetlbfs_dir_inode_operations;
-static struct inode_operations hugetlbfs_inode_operations;
+static const struct inode_operations hugetlbfs_dir_inode_operations;
+static const struct inode_operations hugetlbfs_inode_operations;
 
 static struct backing_dev_info hugetlbfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -560,7 +560,7 @@ const struct file_operations hugetlbfs_f
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 };
 
-static struct inode_operations hugetlbfs_dir_inode_operations = {
+static const struct inode_operations hugetlbfs_dir_inode_operations = {
 	.create		= hugetlbfs_create,
 	.lookup		= simple_lookup,
 	.link		= simple_link,
@@ -573,7 +573,7 @@ static struct inode_operations hugetlbfs
 	.setattr	= hugetlbfs_setattr,
 };
 
-static struct inode_operations hugetlbfs_inode_operations = {
+static const struct inode_operations hugetlbfs_inode_operations = {
 	.setattr	= hugetlbfs_setattr,
 };
 
Index: linux-2.6.20-rc4/fs/isofs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/isofs/dir.c
+++ linux-2.6.20-rc4/fs/isofs/dir.c
@@ -24,7 +24,7 @@ const struct file_operations isofs_dir_o
 /*
  * directories can handle most operations...
  */
-struct inode_operations isofs_dir_inode_operations =
+const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup		= isofs_lookup,
 };
Index: linux-2.6.20-rc4/fs/isofs/isofs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/isofs/isofs.h
+++ linux-2.6.20-rc4/fs/isofs/isofs.h
@@ -174,7 +174,7 @@ isofs_normalize_block_and_offset(struct 
 	}
 }
 
-extern struct inode_operations isofs_dir_inode_operations;
+extern const struct inode_operations isofs_dir_inode_operations;
 extern const struct file_operations isofs_dir_operations;
 extern const struct address_space_operations isofs_symlink_aops;
 extern struct export_operations isofs_export_ops;
Index: linux-2.6.20-rc4/fs/jffs/inode-v23.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jffs/inode-v23.c
+++ linux-2.6.20-rc4/fs/jffs/inode-v23.c
@@ -56,9 +56,9 @@ static int jffs_remove(struct inode *dir
 
 static struct super_operations jffs_ops;
 static const struct file_operations jffs_file_operations;
-static struct inode_operations jffs_file_inode_operations;
+static const struct inode_operations jffs_file_inode_operations;
 static const struct file_operations jffs_dir_operations;
-static struct inode_operations jffs_dir_inode_operations;
+static const struct inode_operations jffs_dir_inode_operations;
 static const struct address_space_operations jffs_address_operations;
 
 struct kmem_cache     *node_cache = NULL;
@@ -1642,7 +1642,7 @@ static const struct file_operations jffs
 };
 
 
-static struct inode_operations jffs_file_inode_operations =
+static const struct inode_operations jffs_file_inode_operations =
 {
 	.lookup		= jffs_lookup,          /* lookup */
 	.setattr	= jffs_setattr,
@@ -1655,7 +1655,7 @@ static const struct file_operations jffs
 };
 
 
-static struct inode_operations jffs_dir_inode_operations =
+static const struct inode_operations jffs_dir_inode_operations =
 {
 	.create		= jffs_create,
 	.lookup		= jffs_lookup,
Index: linux-2.6.20-rc4/fs/jffs2/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jffs2/dir.c
+++ linux-2.6.20-rc4/fs/jffs2/dir.c
@@ -46,7 +46,7 @@ const struct file_operations jffs2_dir_o
 };
 
 
-struct inode_operations jffs2_dir_inode_operations =
+const struct inode_operations jffs2_dir_inode_operations =
 {
 	.create =	jffs2_create,
 	.lookup =	jffs2_lookup,
Index: linux-2.6.20-rc4/fs/jffs2/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jffs2/file.c
+++ linux-2.6.20-rc4/fs/jffs2/file.c
@@ -54,7 +54,7 @@ const struct file_operations jffs2_file_
 
 /* jffs2_file_inode_operations */
 
-struct inode_operations jffs2_file_inode_operations =
+const struct inode_operations jffs2_file_inode_operations =
 {
 	.permission =	jffs2_permission,
 	.setattr =	jffs2_setattr,
Index: linux-2.6.20-rc4/fs/jffs2/os-linux.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/jffs2/os-linux.h
+++ linux-2.6.20-rc4/fs/jffs2/os-linux.h
@@ -153,11 +153,11 @@ void jffs2_garbage_collect_trigger(struc
 
 /* dir.c */
 extern const struct file_operations jffs2_dir_operations;
-extern struct inode_operations jffs2_dir_inode_operations;
+extern const struct inode_operations jffs2_dir_inode_operations;
 
 /* file.c */
 extern const struct file_operations jffs2_file_operations;
-extern struct inode_operations jffs2_file_inode_operations;
+extern const struct inode_operations jffs2_file_inode_operations;
 extern const struct address_space_operations jffs2_file_address_operations;
 int jffs2_fsync(struct file *, struct dentry *, int);
 int jffs2_do_readpage_unlock (struct inode *inode, struct page *pg);
@@ -166,7 +166,7 @@ int jffs2_do_readpage_unlock (struct ino
 int jffs2_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
 
 /* symlink.c */
-extern struct inode_operations jffs2_symlink_inode_operations;
+extern const struct inode_operations jffs2_symlink_inode_operations;
 
 /* fs.c */
 int jffs2_setattr (struct dentry *, struct iattr *);
Index: linux-2.6.20-rc4/fs/jffs2/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jffs2/symlink.c
+++ linux-2.6.20-rc4/fs/jffs2/symlink.c
@@ -20,7 +20,7 @@
 
 static void *jffs2_follow_link(struct dentry *dentry, struct nameidata *nd);
 
-struct inode_operations jffs2_symlink_inode_operations =
+const struct inode_operations jffs2_symlink_inode_operations =
 {
 	.readlink =	generic_readlink,
 	.follow_link =	jffs2_follow_link,
Index: linux-2.6.20-rc4/fs/jfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jfs/file.c
+++ linux-2.6.20-rc4/fs/jfs/file.c
@@ -88,7 +88,7 @@ static int jfs_release(struct inode *ino
 	return 0;
 }
 
-struct inode_operations jfs_file_inode_operations = {
+const struct inode_operations jfs_file_inode_operations = {
 	.truncate	= jfs_truncate,
 	.setxattr	= jfs_setxattr,
 	.getxattr	= jfs_getxattr,
Index: linux-2.6.20-rc4/fs/jfs/jfs_inode.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/jfs/jfs_inode.h
+++ linux-2.6.20-rc4/fs/jfs/jfs_inode.h
@@ -35,10 +35,10 @@ extern void jfs_set_inode_flags(struct i
 extern int jfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
 extern const struct address_space_operations jfs_aops;
-extern struct inode_operations jfs_dir_inode_operations;
+extern const struct inode_operations jfs_dir_inode_operations;
 extern const struct file_operations jfs_dir_operations;
-extern struct inode_operations jfs_file_inode_operations;
+extern const struct inode_operations jfs_file_inode_operations;
 extern const struct file_operations jfs_file_operations;
-extern struct inode_operations jfs_symlink_inode_operations;
+extern const struct inode_operations jfs_symlink_inode_operations;
 extern struct dentry_operations jfs_ci_dentry_operations;
 #endif				/* _H_JFS_INODE */
Index: linux-2.6.20-rc4/fs/jfs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jfs/namei.c
+++ linux-2.6.20-rc4/fs/jfs/namei.c
@@ -1495,7 +1495,7 @@ struct dentry *jfs_get_parent(struct den
 	return parent;
 }
 
-struct inode_operations jfs_dir_inode_operations = {
+const struct inode_operations jfs_dir_inode_operations = {
 	.create		= jfs_create,
 	.lookup		= jfs_lookup,
 	.link		= jfs_link,
Index: linux-2.6.20-rc4/fs/jfs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/jfs/symlink.c
+++ linux-2.6.20-rc4/fs/jfs/symlink.c
@@ -29,7 +29,7 @@ static void *jfs_follow_link(struct dent
 	return NULL;
 }
 
-struct inode_operations jfs_symlink_inode_operations = {
+const struct inode_operations jfs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= jfs_follow_link,
 	.setxattr	= jfs_setxattr,
Index: linux-2.6.20-rc4/fs/libfs.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/libfs.c
+++ linux-2.6.20-rc4/fs/libfs.c
@@ -186,7 +186,7 @@ const struct file_operations simple_dir_
 	.fsync		= simple_sync_file,
 };
 
-struct inode_operations simple_dir_inode_operations = {
+const struct inode_operations simple_dir_inode_operations = {
 	.lookup		= simple_lookup,
 };
 
Index: linux-2.6.20-rc4/fs/minix/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/minix/file.c
+++ linux-2.6.20-rc4/fs/minix/file.c
@@ -26,7 +26,7 @@ const struct file_operations minix_file_
 	.sendfile	= generic_file_sendfile,
 };
 
-struct inode_operations minix_file_inode_operations = {
+const struct inode_operations minix_file_inode_operations = {
 	.truncate	= minix_truncate,
 	.getattr	= minix_getattr,
 };
Index: linux-2.6.20-rc4/fs/minix/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/minix/inode.c
+++ linux-2.6.20-rc4/fs/minix/inode.c
@@ -344,7 +344,7 @@ static const struct address_space_operat
 	.bmap = minix_bmap
 };
 
-static struct inode_operations minix_symlink_inode_operations = {
+static const struct inode_operations minix_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/minix/minix.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/minix/minix.h
+++ linux-2.6.20-rc4/fs/minix/minix.h
@@ -79,8 +79,8 @@ extern ino_t minix_inode_by_name(struct 
 
 extern int minix_sync_file(struct file *, struct dentry *, int);
 
-extern struct inode_operations minix_file_inode_operations;
-extern struct inode_operations minix_dir_inode_operations;
+extern const struct inode_operations minix_file_inode_operations;
+extern const struct inode_operations minix_dir_inode_operations;
 extern const struct file_operations minix_file_operations;
 extern const struct file_operations minix_dir_operations;
 extern struct dentry_operations minix_dentry_operations;
Index: linux-2.6.20-rc4/fs/minix/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/minix/namei.c
+++ linux-2.6.20-rc4/fs/minix/namei.c
@@ -291,7 +291,7 @@ out:
 /*
  * directories can handle most operations...
  */
-struct inode_operations minix_dir_inode_operations = {
+const struct inode_operations minix_dir_inode_operations = {
 	.create		= minix_create,
 	.lookup		= minix_lookup,
 	.link		= minix_link,
Index: linux-2.6.20-rc4/fs/msdos/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/msdos/namei.c
+++ linux-2.6.20-rc4/fs/msdos/namei.c
@@ -646,7 +646,7 @@ out:
 	return err;
 }
 
-static struct inode_operations msdos_dir_inode_operations = {
+static const struct inode_operations msdos_dir_inode_operations = {
 	.create		= msdos_create,
 	.lookup		= msdos_lookup,
 	.unlink		= msdos_unlink,
Index: linux-2.6.20-rc4/fs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/namei.c
+++ linux-2.6.20-rc4/fs/namei.c
@@ -2744,7 +2744,7 @@ int page_symlink(struct inode *inode, co
 			mapping_gfp_mask(inode->i_mapping));
 }
 
-struct inode_operations page_symlink_inode_operations = {
+const struct inode_operations page_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/ncpfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ncpfs/dir.c
+++ linux-2.6.20-rc4/fs/ncpfs/dir.c
@@ -58,7 +58,7 @@ const struct file_operations ncp_dir_ope
 #endif
 };
 
-struct inode_operations ncp_dir_inode_operations =
+const struct inode_operations ncp_dir_inode_operations =
 {
 	.create		= ncp_create,
 	.lookup		= ncp_lookup,
Index: linux-2.6.20-rc4/fs/ncpfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ncpfs/file.c
+++ linux-2.6.20-rc4/fs/ncpfs/file.c
@@ -297,7 +297,7 @@ const struct file_operations ncp_file_op
 	.fsync		= ncp_fsync,
 };
 
-struct inode_operations ncp_file_inode_operations =
+const struct inode_operations ncp_file_inode_operations =
 {
 	.setattr	= ncp_notify_change,
 };
Index: linux-2.6.20-rc4/fs/ncpfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ncpfs/inode.c
+++ linux-2.6.20-rc4/fs/ncpfs/inode.c
@@ -229,7 +229,7 @@ static void ncp_set_attr(struct inode *i
 }
 
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
-static struct inode_operations ncp_symlink_inode_operations = {
+static const struct inode_operations ncp_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= page_follow_link_light,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/nfs/dir.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/nfs/dir.c
+++ linux-2.6.20-rc4/fs/nfs/dir.c
@@ -65,7 +65,7 @@ const struct file_operations nfs_dir_ope
 	.fsync		= nfs_fsync_dir,
 };
 
-struct inode_operations nfs_dir_inode_operations = {
+const struct inode_operations nfs_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_lookup,
 	.link		= nfs_link,
@@ -81,7 +81,7 @@ struct inode_operations nfs_dir_inode_op
 };
 
 #ifdef CONFIG_NFS_V3
-struct inode_operations nfs3_dir_inode_operations = {
+const struct inode_operations nfs3_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_lookup,
 	.link		= nfs_link,
@@ -104,7 +104,7 @@ struct inode_operations nfs3_dir_inode_o
 #ifdef CONFIG_NFS_V4
 
 static struct dentry *nfs_atomic_lookup(struct inode *, struct dentry *, struct nameidata *);
-struct inode_operations nfs4_dir_inode_operations = {
+const struct inode_operations nfs4_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_atomic_lookup,
 	.link		= nfs_link,
Index: linux-2.6.20-rc4/fs/nfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/nfs/file.c
+++ linux-2.6.20-rc4/fs/nfs/file.c
@@ -68,14 +68,14 @@ const struct file_operations nfs_file_op
 	.check_flags	= nfs_check_flags,
 };
 
-struct inode_operations nfs_file_inode_operations = {
+const struct inode_operations nfs_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 };
 
 #ifdef CONFIG_NFS_V3
-struct inode_operations nfs3_file_inode_operations = {
+const struct inode_operations nfs3_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
Index: linux-2.6.20-rc4/fs/nfs/namespace.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/nfs/namespace.c
+++ linux-2.6.20-rc4/fs/nfs/namespace.c
@@ -155,12 +155,12 @@ out_follow:
 	goto out;
 }
 
-struct inode_operations nfs_mountpoint_inode_operations = {
+const struct inode_operations nfs_mountpoint_inode_operations = {
 	.follow_link	= nfs_follow_mountpoint,
 	.getattr	= nfs_getattr,
 };
 
-struct inode_operations nfs_referral_inode_operations = {
+const struct inode_operations nfs_referral_inode_operations = {
 	.follow_link	= nfs_follow_mountpoint,
 };
 
Index: linux-2.6.20-rc4/fs/nfs/nfs4_fs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/nfs/nfs4_fs.h
+++ linux-2.6.20-rc4/fs/nfs/nfs4_fs.h
@@ -151,7 +151,7 @@ struct nfs4_state_recovery_ops {
 };
 
 extern struct dentry_operations nfs4_dentry_operations;
-extern struct inode_operations nfs4_dir_inode_operations;
+extern const struct inode_operations nfs4_dir_inode_operations;
 
 /* inode.c */
 extern ssize_t nfs4_getxattr(struct dentry *, const char *, void *, size_t);
Index: linux-2.6.20-rc4/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.20-rc4/fs/nfs/nfs4proc.c
@@ -3625,7 +3625,7 @@ struct nfs4_state_recovery_ops nfs4_netw
 	.recover_lock	= nfs4_lock_expired,
 };
 
-static struct inode_operations nfs4_file_inode_operations = {
+static const struct inode_operations nfs4_file_inode_operations = {
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
Index: linux-2.6.20-rc4/fs/nfs/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/nfs/symlink.c
+++ linux-2.6.20-rc4/fs/nfs/symlink.c
@@ -76,7 +76,7 @@ read_failed:
 /*
  * symlinks can't do much...
  */
-struct inode_operations nfs_symlink_inode_operations = {
+const struct inode_operations nfs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= nfs_follow_link,
 	.put_link	= page_put_link,
Index: linux-2.6.20-rc4/fs/ntfs/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ntfs/file.c
+++ linux-2.6.20-rc4/fs/ntfs/file.c
@@ -2328,7 +2328,7 @@ const struct file_operations ntfs_file_o
 						    the data source. */
 };
 
-struct inode_operations ntfs_file_inode_ops = {
+const struct inode_operations ntfs_file_inode_ops = {
 #ifdef NTFS_RW
 	.truncate	= ntfs_truncate_vfs,
 	.setattr	= ntfs_setattr,
@@ -2337,4 +2337,4 @@ struct inode_operations ntfs_file_inode_
 
 const struct file_operations ntfs_empty_file_ops = {};
 
-struct inode_operations ntfs_empty_inode_ops = {};
+const struct inode_operations ntfs_empty_inode_ops = {};
Index: linux-2.6.20-rc4/fs/ntfs/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ntfs/namei.c
+++ linux-2.6.20-rc4/fs/ntfs/namei.c
@@ -359,7 +359,7 @@ err_out:
 /**
  * Inode operations for directories.
  */
-struct inode_operations ntfs_dir_inode_ops = {
+const struct inode_operations ntfs_dir_inode_ops = {
 	.lookup	= ntfs_lookup,	/* VFS: Lookup directory. */
 };
 
Index: linux-2.6.20-rc4/fs/ntfs/ntfs.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ntfs/ntfs.h
+++ linux-2.6.20-rc4/fs/ntfs/ntfs.h
@@ -61,13 +61,13 @@ extern const struct address_space_operat
 extern const struct address_space_operations ntfs_mst_aops;
 
 extern const struct  file_operations ntfs_file_ops;
-extern struct inode_operations ntfs_file_inode_ops;
+extern const struct inode_operations ntfs_file_inode_ops;
 
 extern const struct  file_operations ntfs_dir_ops;
-extern struct inode_operations ntfs_dir_inode_ops;
+extern const struct inode_operations ntfs_dir_inode_ops;
 
 extern const struct  file_operations ntfs_empty_file_ops;
-extern struct inode_operations ntfs_empty_inode_ops;
+extern const struct inode_operations ntfs_empty_inode_ops;
 
 extern struct export_operations ntfs_export_ops;
 
Index: linux-2.6.20-rc4/fs/ocfs2/dlm/dlmfs.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/dlm/dlmfs.c
+++ linux-2.6.20-rc4/fs/ocfs2/dlm/dlmfs.c
@@ -63,9 +63,9 @@
 
 static struct super_operations dlmfs_ops;
 static const struct file_operations dlmfs_file_operations;
-static struct inode_operations dlmfs_dir_inode_operations;
-static struct inode_operations dlmfs_root_inode_operations;
-static struct inode_operations dlmfs_file_inode_operations;
+static const struct inode_operations dlmfs_dir_inode_operations;
+static const struct inode_operations dlmfs_root_inode_operations;
+static const struct inode_operations dlmfs_file_inode_operations;
 static struct kmem_cache *dlmfs_inode_cache;
 
 struct workqueue_struct *user_dlm_worker;
@@ -547,14 +547,14 @@ static const struct file_operations dlmf
 	.write		= dlmfs_file_write,
 };
 
-static struct inode_operations dlmfs_dir_inode_operations = {
+static const struct inode_operations dlmfs_dir_inode_operations = {
 	.create		= dlmfs_create,
 	.lookup		= simple_lookup,
 	.unlink		= dlmfs_unlink,
 };
 
 /* this way we can restrict mkdir to only the toplevel of the fs. */
-static struct inode_operations dlmfs_root_inode_operations = {
+static const struct inode_operations dlmfs_root_inode_operations = {
 	.lookup		= simple_lookup,
 	.mkdir		= dlmfs_mkdir,
 	.rmdir		= simple_rmdir,
@@ -568,7 +568,7 @@ static struct super_operations dlmfs_ops
 	.drop_inode	= generic_delete_inode,
 };
 
-static struct inode_operations dlmfs_file_inode_operations = {
+static const struct inode_operations dlmfs_file_inode_operations = {
 	.getattr	= simple_getattr,
 };
 
Index: linux-2.6.20-rc4/fs/ocfs2/file.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/file.c
+++ linux-2.6.20-rc4/fs/ocfs2/file.c
@@ -1365,13 +1365,13 @@ bail:
 	return ret;
 }
 
-struct inode_operations ocfs2_file_iops = {
+const struct inode_operations ocfs2_file_iops = {
 	.setattr	= ocfs2_setattr,
 	.getattr	= ocfs2_getattr,
 	.permission	= ocfs2_permission,
 };
 
-struct inode_operations ocfs2_special_file_iops = {
+const struct inode_operations ocfs2_special_file_iops = {
 	.setattr	= ocfs2_setattr,
 	.getattr	= ocfs2_getattr,
 	.permission	= ocfs2_permission,
Index: linux-2.6.20-rc4/fs/ocfs2/file.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/file.h
+++ linux-2.6.20-rc4/fs/ocfs2/file.h
@@ -28,8 +28,8 @@
 
 extern const struct file_operations ocfs2_fops;
 extern const struct file_operations ocfs2_dops;
-extern struct inode_operations ocfs2_file_iops;
-extern struct inode_operations ocfs2_special_file_iops;
+extern const struct inode_operations ocfs2_file_iops;
+extern const struct inode_operations ocfs2_special_file_iops;
 struct ocfs2_alloc_context;
 
 enum ocfs2_alloc_restarted {
Index: linux-2.6.20-rc4/fs/ocfs2/namei.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/namei.c
+++ linux-2.6.20-rc4/fs/ocfs2/namei.c
@@ -2301,7 +2301,7 @@ leave:
 	return status;
 }
 
-struct inode_operations ocfs2_dir_iops = {
+const struct inode_operations ocfs2_dir_iops = {
 	.create		= ocfs2_create,
 	.lookup		= ocfs2_lookup,
 	.link		= ocfs2_link,
Index: linux-2.6.20-rc4/fs/ocfs2/namei.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/namei.h
+++ linux-2.6.20-rc4/fs/ocfs2/namei.h
@@ -26,7 +26,7 @@
 #ifndef OCFS2_NAMEI_H
 #define OCFS2_NAMEI_H
 
-extern struct inode_operations ocfs2_dir_iops;
+extern const struct inode_operations ocfs2_dir_iops;
 
 struct dentry *ocfs2_get_parent(struct dentry *child);
 
Index: linux-2.6.20-rc4/fs/ocfs2/symlink.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/symlink.c
+++ linux-2.6.20-rc4/fs/ocfs2/symlink.c
@@ -171,12 +171,12 @@ bail:
 	return ERR_PTR(status);
 }
 
-struct inode_operations ocfs2_symlink_inode_operations = {
+const struct inode_operations ocfs2_symlink_inode_operations = {
 	.readlink	= page_readlink,
 	.follow_link	= ocfs2_follow_link,
 	.getattr	= ocfs2_getattr,
 };
-struct inode_operations ocfs2_fast_symlink_inode_operations = {
+const struct inode_operations ocfs2_fast_symlink_inode_operations = {
 	.readlink	= ocfs2_readlink,
 	.follow_link	= ocfs2_follow_link,
 	.getattr	= ocfs2_getattr,
Index: linux-2.6.20-rc4/fs/ocfs2/symlink.h
===================================================================
--- linux-2.6.20-rc4.orig/fs/ocfs2/symlink.h
+++ linux-2.6.20-rc4/fs/ocfs2/symlink.h
@@ -26,8 +26,8 @@
 #ifndef OCFS2_SYMLINK_H
 #define OCFS2_SYMLINK_H
 
-extern struct inode_operations ocfs2_symlink_inode_operations;
-extern struct inode_operations ocfs2_fast_symlink_inode_operations;
+extern const struct inode_operations ocfs2_symlink_inode_operations;
+extern const struct inode_operations ocfs2_fast_symlink_inode_operations;
 
 /*
  * Test whether an inode is a fast symlink.
Index: linux-2.6.20-rc4/fs/openpromfs/inode.c
===================================================================
--- linux-2.6.20-rc4.orig/fs/openpromfs/inode.c
+++ linux-2.6.20-rc4/fs/openpromfs/inode.c
@@ -169,7 +169,7 @@ static const struct file_operations open
 
 static struct dentry *openpromfs_lookup(struct inode *, struct dentry *, struct nameidata *);
 
-static struct inode_operations openprom_inode_operations = {
+static const struct inode_operations openprom_inode_operations = {
 	.lookup		= openpromfs_lookup,
 };
 
Index: linux-2.6.20-rc4/ipc/mqueue.c
===================================================================
--- linux-2.6.20-rc4.orig/ipc/mqueue.c
+++ linux-2.6.20-rc4/ipc/mqueue.c
@@ -84,7 +84,7 @@ struct mqueue_inode_info {
 	unsigned long qsize; /* size of queue in memory (sum of all msgs) */
 };
 
-static struct inode_operations mqueue_dir_inode_operations;
+static const struct inode_operations mqueue_dir_inode_operations;
 static const struct file_operations mqueue_file_operations;
 static struct super_operations mqueue_super_ops;
 static void remove_notification(struct mqueue_inode_info *info);
@@ -1160,7 +1160,7 @@ out:
 	return ret;
 }
 
-static struct inode_operations mqueue_dir_inode_operations = {
+static const struct inode_operations mqueue_dir_inode_operations = {
 	.lookup = simple_lookup,
 	.create = mqueue_create,
 	.unlink = mqueue_unlink,
Index: linux-2.6.20-rc4/kernel/cpuset.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/cpuset.c
+++ linux-2.6.20-rc4/kernel/cpuset.c
@@ -1540,7 +1540,7 @@ static const struct file_operations cpus
 	.release = cpuset_file_release,
 };
 
-static struct inode_operations cpuset_dir_inode_operations = {
+static const struct inode_operations cpuset_dir_inode_operations = {
 	.lookup = simple_lookup,
 	.mkdir = cpuset_mkdir,
 	.rmdir = cpuset_rmdir,
Index: linux-2.6.20-rc4/mm/shmem.c
===================================================================
--- linux-2.6.20-rc4.orig/mm/shmem.c
+++ linux-2.6.20-rc4/mm/shmem.c
@@ -178,9 +178,9 @@ static inline void shmem_unacct_blocks(u
 static struct super_operations shmem_ops;
 static const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
-static struct inode_operations shmem_inode_operations;
-static struct inode_operations shmem_dir_inode_operations;
-static struct inode_operations shmem_special_inode_operations;
+static const struct inode_operations shmem_inode_operations;
+static const struct inode_operations shmem_dir_inode_operations;
+static const struct inode_operations shmem_special_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info  __read_mostly = {
@@ -1410,8 +1410,8 @@ shmem_get_inode(struct super_block *sb, 
 }
 
 #ifdef CONFIG_TMPFS
-static struct inode_operations shmem_symlink_inode_operations;
-static struct inode_operations shmem_symlink_inline_operations;
+static const struct inode_operations shmem_symlink_inode_operations;
+static const struct inode_operations shmem_symlink_inline_operations;
 
 /*
  * Normally tmpfs makes no use of shmem_prepare_write, but it
@@ -1904,12 +1904,12 @@ static void shmem_put_link(struct dentry
 	}
 }
 
-static struct inode_operations shmem_symlink_inline_operations = {
+static const struct inode_operations shmem_symlink_inline_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link_inline,
 };
 
-static struct inode_operations shmem_symlink_inode_operations = {
+static const struct inode_operations shmem_symlink_inode_operations = {
 	.truncate	= shmem_truncate,
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link,
@@ -2335,7 +2335,7 @@ static const struct file_operations shme
 #endif
 };
 
-static struct inode_operations shmem_inode_operations = {
+static const struct inode_operations shmem_inode_operations = {
 	.truncate	= shmem_truncate,
 	.setattr	= shmem_notify_change,
 	.truncate_range	= shmem_truncate_range,
@@ -2349,7 +2349,7 @@ static struct inode_operations shmem_ino
 
 };
 
-static struct inode_operations shmem_dir_inode_operations = {
+static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.create		= shmem_create,
 	.lookup		= simple_lookup,
@@ -2371,7 +2371,7 @@ static struct inode_operations shmem_dir
 #endif
 };
 
-static struct inode_operations shmem_special_inode_operations = {
+static const struct inode_operations shmem_special_inode_operations = {
 #ifdef CONFIG_TMPFS_POSIX_ACL
 	.setattr	= shmem_notify_change,
 	.setxattr	= generic_setxattr,


