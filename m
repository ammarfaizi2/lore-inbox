Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVAaXxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVAaXxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVAaXwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:52:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1542 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261456AbVAaXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:26 -0500
Date: Tue, 1 Feb 2005 00:42:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hpfs/: make some code static
Message-ID: <20050131234218.GO21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/hpfs/alloc.c   |    4 +++-
 fs/hpfs/dentry.c  |    6 +++---
 fs/hpfs/dnode.c   |   14 ++++++++------
 fs/hpfs/hpfs_fn.h |    4 ----
 fs/hpfs/inode.c   |    2 +-
 fs/hpfs/name.c    |    4 ++--
 fs/hpfs/super.c   |    6 +++---
 7 files changed, 20 insertions(+), 20 deletions(-)

This patch was already sent on:
- 7 Jan 2005

--- linux-2.6.10-mm2-full/fs/hpfs/hpfs_fn.h.old	2005-01-07 00:49:31.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/hpfs_fn.h	2005-01-07 00:52:55.000000000 +0100
@@ -202,7 +202,6 @@
 
 int hpfs_chk_sectors(struct super_block *, secno, int, char *);
 secno hpfs_alloc_sector(struct super_block *, secno, unsigned, int, int);
-int hpfs_alloc_if_possible_nolock(struct super_block *, secno);
 int hpfs_alloc_if_possible(struct super_block *, secno);
 void hpfs_free_sectors(struct super_block *, secno, unsigned);
 int hpfs_check_free_dnodes(struct super_block *, int);
@@ -247,8 +246,6 @@
 void hpfs_add_pos(struct inode *, loff_t *);
 void hpfs_del_pos(struct inode *, loff_t *);
 struct hpfs_dirent *hpfs_add_de(struct super_block *, struct dnode *, unsigned char *, unsigned, secno);
-void hpfs_delete_de(struct super_block *, struct dnode *, struct hpfs_dirent *);
-int hpfs_add_to_dnode(struct inode *, dnode_secno, unsigned char *, unsigned, struct hpfs_dirent *, dnode_secno);
 int hpfs_add_dirent(struct inode *, unsigned char *, unsigned, struct hpfs_dirent *, int);
 int hpfs_remove_dirent(struct inode *, dnode_secno, struct hpfs_dirent *, struct quad_buffer_head *, int);
 void hpfs_count_dnodes(struct super_block *, dnode_secno, int *, int *, int *);
@@ -276,7 +273,6 @@
 
 void hpfs_init_inode(struct inode *);
 void hpfs_read_inode(struct inode *);
-void hpfs_write_inode_ea(struct inode *, struct fnode *);
 void hpfs_write_inode(struct inode *);
 void hpfs_write_inode_nolock(struct inode *);
 int hpfs_notify_change(struct dentry *, struct iattr *);
--- linux-2.6.10-mm2-full/fs/hpfs/alloc.c.old	2005-01-07 00:49:42.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/alloc.c	2005-01-07 00:50:06.000000000 +0100
@@ -8,6 +8,8 @@
 
 #include "hpfs_fn.h"
 
+static int hpfs_alloc_if_possible_nolock(struct super_block *s, secno sec);
+
 /*
  * Check if a sector is allocated in bitmap
  * This is really slow. Turned on only if chk==2
@@ -243,7 +245,7 @@
 
 /* Alloc sector if it's free */
 
-int hpfs_alloc_if_possible_nolock(struct super_block *s, secno sec)
+static int hpfs_alloc_if_possible_nolock(struct super_block *s, secno sec)
 {
 	struct quad_buffer_head qbh;
 	unsigned *bmp;
--- linux-2.6.10-mm2-full/fs/hpfs/dentry.c.old	2005-01-07 00:50:19.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/dentry.c	2005-01-07 00:50:57.000000000 +0100
@@ -12,7 +12,7 @@
  * Note: the dentry argument is the parent dentry.
  */
 
-int hpfs_hash_dentry(struct dentry *dentry, struct qstr *qstr)
+static int hpfs_hash_dentry(struct dentry *dentry, struct qstr *qstr)
 {
 	unsigned long	 hash;
 	int		 i;
@@ -34,7 +34,7 @@
 	return 0;
 }
 
-int hpfs_compare_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
+static int hpfs_compare_dentry(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
 	unsigned al=a->len;
 	unsigned bl=b->len;
@@ -49,7 +49,7 @@
 	return 0;
 }
 
-struct dentry_operations hpfs_dentry_operations = {
+static struct dentry_operations hpfs_dentry_operations = {
 	.d_hash		= hpfs_hash_dentry,
 	.d_compare	= hpfs_compare_dentry,
 };
--- linux-2.6.10-mm2-full/fs/hpfs/dnode.c.old	2005-01-07 00:51:23.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/dnode.c	2005-01-07 00:52:44.000000000 +0100
@@ -78,7 +78,7 @@
 	return;
 }
 
-void hpfs_pos_subst(loff_t *p, loff_t f, loff_t t)
+static void hpfs_pos_subst(loff_t *p, loff_t f, loff_t t)
 {
 	if (*p == f) *p = t;
 }
@@ -88,7 +88,7 @@
 	if ((*p & ~0x3f) == (f & ~0x3f)) *p = (t & ~0x3f) | (*p & 0x3f);
 }*/
 
-void hpfs_pos_ins(loff_t *p, loff_t d, loff_t c)
+static void hpfs_pos_ins(loff_t *p, loff_t d, loff_t c)
 {
 	if ((*p & ~0x3f) == (d & ~0x3f) && (*p & 0x3f) >= (d & 0x3f)) {
 		int n = (*p & 0x3f) + c;
@@ -97,7 +97,7 @@
 	}
 }
 
-void hpfs_pos_del(loff_t *p, loff_t d, loff_t c)
+static void hpfs_pos_del(loff_t *p, loff_t d, loff_t c)
 {
 	if ((*p & ~0x3f) == (d & ~0x3f) && (*p & 0x3f) >= (d & 0x3f)) {
 		int n = (*p & 0x3f) - c;
@@ -189,7 +189,8 @@
 
 /* Delete dirent and don't care about its subtree */
 
-void hpfs_delete_de(struct super_block *s, struct dnode *d, struct hpfs_dirent *de)
+static void hpfs_delete_de(struct super_block *s, struct dnode *d,
+			   struct hpfs_dirent *de)
 {
 	if (de->last) {
 		hpfs_error(s, "attempt to delete last dirent in dnode %08x", d->self);
@@ -221,8 +222,9 @@
 
 /* Add an entry to dnode and do dnode splitting if required */
 
-int hpfs_add_to_dnode(struct inode *i, dnode_secno dno, unsigned char *name, unsigned namelen,
-		      struct hpfs_dirent *new_de, dnode_secno down_ptr)
+static int hpfs_add_to_dnode(struct inode *i, dnode_secno dno,
+			     unsigned char *name, unsigned namelen,
+			     struct hpfs_dirent *new_de, dnode_secno down_ptr)
 {
 	struct quad_buffer_head qbh, qbh1, qbh2;
 	struct dnode *d, *ad, *rd, *nd = NULL;
--- linux-2.6.10-mm2-full/fs/hpfs/inode.c.old	2005-01-07 00:53:03.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/inode.c	2005-01-07 00:53:08.000000000 +0100
@@ -141,7 +141,7 @@
 	brelse(bh);
 }
 
-void hpfs_write_inode_ea(struct inode *i, struct fnode *fnode)
+static void hpfs_write_inode_ea(struct inode *i, struct fnode *fnode)
 {
 	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
 	/*if (fnode->acl_size_l || fnode->acl_size_s) {
--- linux-2.6.10-mm2-full/fs/hpfs/name.c.old	2005-01-07 00:53:26.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/name.c	2005-01-07 00:53:43.000000000 +0100
@@ -8,12 +8,12 @@
 
 #include "hpfs_fn.h"
 
-char *text_postfix[]={
+static char *text_postfix[]={
 ".ASM", ".BAS", ".BAT", ".C", ".CC", ".CFG", ".CMD", ".CON", ".CPP", ".DEF",
 ".DOC", ".DPR", ".ERX", ".H", ".HPP", ".HTM", ".HTML", ".JAVA", ".LOG", ".PAS",
 ".RC", ".TEX", ".TXT", ".Y", ""};
 
-char *text_prefix[]={
+static char *text_prefix[]={
 "AUTOEXEC.", "CHANGES", "COPYING", "CONFIG.", "CREDITS", "FAQ", "FILE_ID.DIZ",
 "MAKEFILE", "READ.ME", "README", "TERMCAP", ""};
 
--- linux-2.6.10-mm2-full/fs/hpfs/super.c.old	2005-01-07 00:53:57.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hpfs/super.c	2005-01-07 00:54:15.000000000 +0100
@@ -246,9 +246,9 @@
 	{Opt_err, NULL},
 };
 
-int parse_opts(char *opts, uid_t *uid, gid_t *gid, umode_t *umask,
-	       int *lowercase, int *conv, int *eas, int *chk, int *errs,
-	       int *chkdsk, int *timeshift)
+static int parse_opts(char *opts, uid_t *uid, gid_t *gid, umode_t *umask,
+		      int *lowercase, int *conv, int *eas, int *chk, int *errs,
+		      int *chkdsk, int *timeshift)
 {
 	char *p;
 	int option;

