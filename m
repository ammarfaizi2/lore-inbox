Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVAaXwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVAaXwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVAaXvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:51:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:262 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261455AbVAaXmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:18 -0500
Date: Tue, 1 Feb 2005 00:42:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hfs/: misc cleanups
Message-ID: <20050131234214.GN21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- super.c: remove the unused global variable hfs_version

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/hfs/brec.c    |   10 +++++++---
 fs/hfs/btree.h   |    3 ---
 fs/hfs/catalog.c |    2 +-
 fs/hfs/dir.c     |   20 ++++++++++----------
 fs/hfs/extent.c  |    4 ++--
 fs/hfs/hfs_fs.h  |   10 ----------
 fs/hfs/inode.c   |   13 ++++++++-----
 fs/hfs/super.c   |    4 +---
 8 files changed, 29 insertions(+), 37 deletions(-)

This patch was already sent on:
- 7 Jan 2005

--- linux-2.6.10-mm2-full/fs/hfs/btree.h.old	2005-01-07 00:09:58.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/btree.h	2005-01-07 00:11:29.000000000 +0100
@@ -111,9 +111,6 @@
 extern u16 hfs_brec_keylen(struct hfs_bnode *, u16);
 extern int hfs_brec_insert(struct hfs_find_data *, void *, int);
 extern int hfs_brec_remove(struct hfs_find_data *);
-extern struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *);
-extern int hfs_brec_update_parent(struct hfs_find_data *);
-extern int hfs_btree_inc_height(struct hfs_btree *);
 
 /* bfind.c */
 extern int hfs_find_init(struct hfs_btree *, struct hfs_find_data *);
--- linux-2.6.10-mm2-full/fs/hfs/brec.c.old	2005-01-07 00:10:19.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/brec.c	2005-01-07 00:11:49.000000000 +0100
@@ -10,6 +10,10 @@
 
 #include "btree.h"
 
+static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd);
+static int hfs_brec_update_parent(struct hfs_find_data *fd);
+static int hfs_btree_inc_height(struct hfs_btree *tree);
+
 /* Get the length and offset of the given record in the given node */
 u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
 {
@@ -211,7 +215,7 @@
 	return 0;
 }
 
-struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
+static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 {
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *new_node;
@@ -320,7 +324,7 @@
 	return new_node;
 }
 
-int hfs_brec_update_parent(struct hfs_find_data *fd)
+static int hfs_brec_update_parent(struct hfs_find_data *fd)
 {
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *new_node, *parent;
@@ -418,7 +422,7 @@
 	return 0;
 }
 
-int hfs_btree_inc_height(struct hfs_btree *tree)
+static int hfs_btree_inc_height(struct hfs_btree *tree)
 {
 	struct hfs_bnode *node, *new_node;
 	struct hfs_bnode_desc node_desc;
--- linux-2.6.10-mm2-full/fs/hfs/catalog.c.old	2005-01-07 00:12:05.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/catalog.c	2005-01-07 00:12:13.000000000 +0100
@@ -33,7 +33,7 @@
 	}
 }
 
-int hfs_cat_build_record(hfs_cat_rec *rec, u32 cnid, struct inode *inode)
+static int hfs_cat_build_record(hfs_cat_rec *rec, u32 cnid, struct inode *inode)
 {
 	__be32 mtime = hfs_mtime();
 
--- linux-2.6.10-mm2-full/fs/hfs/dir.c.old	2005-01-07 00:12:28.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/dir.c	2005-01-07 00:14:20.000000000 +0100
@@ -17,8 +17,8 @@
 /*
  * hfs_lookup()
  */
-struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
-			  struct nameidata *nd)
+static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
+				 struct nameidata *nd)
 {
 	hfs_cat_rec rec;
 	struct hfs_find_data fd;
@@ -51,7 +51,7 @@
 /*
  * hfs_readdir
  */
-int hfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
+static int hfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
@@ -177,8 +177,8 @@
  * a directory and return a corresponding inode, given the inode for
  * the directory and the name (and its length) of the new file.
  */
-int hfs_create(struct inode *dir, struct dentry *dentry, int mode,
-	       struct nameidata *nd)
+static int hfs_create(struct inode *dir, struct dentry *dentry, int mode,
+		      struct nameidata *nd)
 {
 	struct inode *inode;
 	int res;
@@ -207,7 +207,7 @@
  * in a directory, given the inode for the parent directory and the
  * name (and its length) of the new directory.
  */
-int hfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+static int hfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct inode *inode;
 	int res;
@@ -236,7 +236,7 @@
  * file, given the inode for the parent directory and the name
  * (and its length) of the existing file.
  */
-int hfs_unlink(struct inode *dir, struct dentry *dentry)
+static int hfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode;
 	int res;
@@ -262,7 +262,7 @@
  * directory, given the inode for the parent directory and the name
  * (and its length) of the existing directory.
  */
-int hfs_rmdir(struct inode *dir, struct dentry *dentry)
+static int hfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode;
 	int res;
@@ -291,8 +291,8 @@
  * new file/directory.
  * XXX: how do you handle must_be dir?
  */
-int hfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+static int hfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		      struct inode *new_dir, struct dentry *new_dentry)
 {
 	int res;
 
--- linux-2.6.10-mm2-full/fs/hfs/extent.c.old	2005-01-07 00:14:37.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/extent.c	2005-01-07 00:14:45.000000000 +0100
@@ -231,8 +231,8 @@
 	return -EIO;
 }
 
-int hfs_free_extents(struct super_block *sb, struct hfs_extent *extent,
-		     u16 offset, u16 block_nr)
+static int hfs_free_extents(struct super_block *sb, struct hfs_extent *extent,
+			    u16 offset, u16 block_nr)
 {
 	u16 count, start;
 	int i;
--- linux-2.6.10-mm2-full/fs/hfs/hfs_fs.h.old	2005-01-07 00:15:07.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/hfs_fs.h	2005-01-07 00:32:19.000000000 +0100
@@ -174,12 +174,6 @@
 extern struct file_operations hfs_dir_operations;
 extern struct inode_operations hfs_dir_inode_operations;
 
-extern int hfs_mkdir(struct inode *, struct dentry *, int);
-extern int hfs_unlink(struct inode *, struct dentry *);
-extern int hfs_rmdir(struct inode *, struct dentry *);
-extern int hfs_rename(struct inode *, struct dentry *,
-		      struct inode *, struct dentry *);
-
 /* extent.c */
 extern int hfs_ext_keycmp(const btree_key *, const btree_key *);
 extern int hfs_free_fork(struct super_block *, struct hfs_cat_file *, int);
@@ -187,10 +181,6 @@
 extern int hfs_extend_file(struct inode *);
 extern void hfs_file_truncate(struct inode *);
 
-/* file.c */
-extern struct inode_operations hfs_file_inode_operations;
-extern struct file_operations hfs_file_operations;
-
 extern int hfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
 /* inode.c */
--- linux-2.6.10-mm2-full/fs/hfs/inode.c.old	2005-01-07 00:15:24.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/inode.c	2005-01-07 00:27:23.000000000 +0100
@@ -18,6 +18,9 @@
 #include "hfs_fs.h"
 #include "btree.h"
 
+static struct file_operations hfs_file_operations;
+static struct inode_operations hfs_file_inode_operations;
+
 /*================ Variable-like macros ================*/
 
 #define HFS_VALID_MODE_BITS  (S_IFREG | S_IFDIR | S_IRWXUGO)
@@ -43,7 +46,7 @@
 	return generic_block_bmap(mapping, block, hfs_get_block);
 }
 
-int hfs_releasepage(struct page *page, int mask)
+static int hfs_releasepage(struct page *page, int mask)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
@@ -259,7 +262,7 @@
 	hfs_cat_rec *rec;
 };
 
-int hfs_test_inode(struct inode *inode, void *data)
+static int hfs_test_inode(struct inode *inode, void *data)
 {
 	struct hfs_iget_data *idata = data;
 	hfs_cat_rec *rec;
@@ -279,7 +282,7 @@
 /*
  * hfs_read_inode
  */
-int hfs_read_inode(struct inode *inode, void *data)
+static int hfs_read_inode(struct inode *inode, void *data)
 {
 	struct hfs_iget_data *idata = data;
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
@@ -611,7 +614,7 @@
 }
 
 
-struct file_operations hfs_file_operations = {
+static struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
 	.write		= generic_file_write,
@@ -622,7 +625,7 @@
 	.release	= hfs_file_release,
 };
 
-struct inode_operations hfs_file_inode_operations = {
+static struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.truncate	= hfs_file_truncate,
 	.setattr	= hfs_inode_setattr,
--- linux-2.6.10-mm2-full/fs/hfs/super.c.old	2005-01-07 00:27:35.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfs/super.c	2005-01-07 00:27:55.000000000 +0100
@@ -21,8 +21,6 @@
 #include "hfs_fs.h"
 #include "btree.h"
 
-const char hfs_version[]="0.96";
-
 static kmem_cache_t *hfs_inode_cachep;
 
 MODULE_LICENSE("GPL");
@@ -92,7 +90,7 @@
 	return 0;
 }
 
-int hfs_remount(struct super_block *sb, int *flags, char *data)
+static int hfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	*flags |= MS_NODIRATIME;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))

