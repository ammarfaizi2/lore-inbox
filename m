Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936264AbWK3MN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936264AbWK3MN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936269AbWK3MNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:13:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19335 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936264AbWK3MNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:13:44 -0500
Subject: [GFS2] split and annotate gfs2_inum [11/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:14:27 +0000
Message-Id: <1164888867.3752.325.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 629a21e7ecedf779c68dcaa9a186069f57a7c652 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 22:51:24 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_inum

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c               |    8 ++++----
 fs/gfs2/dir.h               |    8 ++++----
 fs/gfs2/incore.h            |    2 +-
 fs/gfs2/inode.c             |   22 +++++++++++-----------
 fs/gfs2/inode.h             |    4 ++--
 fs/gfs2/ondisk.c            |    6 +++---
 fs/gfs2/ops_dentry.c        |    2 +-
 fs/gfs2/ops_export.c        |    8 ++++----
 fs/gfs2/ops_export.h        |    2 +-
 fs/gfs2/ops_file.c          |    2 +-
 fs/gfs2/ops_fstype.c        |    4 ++--
 include/linux/gfs2_ondisk.h |   19 ++++++++++++-------
 12 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index e24af28..d67a376 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1194,7 +1194,7 @@ static int do_filldir_main(struct gfs2_i
 			   int *copied)
 {
 	const struct gfs2_dirent *dent, *dent_next;
-	struct gfs2_inum inum;
+	struct gfs2_inum_host inum;
 	u64 off, off_next;
 	unsigned int x, y;
 	int run = 0;
@@ -1456,7 +1456,7 @@ out:
  */
 
 int gfs2_dir_search(struct inode *dir, const struct qstr *name,
-		    struct gfs2_inum *inum, unsigned int *type)
+		    struct gfs2_inum_host *inum, unsigned int *type)
 {
 	struct buffer_head *bh;
 	struct gfs2_dirent *dent;
@@ -1531,7 +1531,7 @@ static int dir_new_leaf(struct inode *in
  */
 
 int gfs2_dir_add(struct inode *inode, const struct qstr *name,
-		 const struct gfs2_inum *inum, unsigned type)
+		 const struct gfs2_inum_host *inum, unsigned type)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct buffer_head *bh;
@@ -1666,7 +1666,7 @@ int gfs2_dir_del(struct gfs2_inode *dip,
  */
 
 int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
-		   struct gfs2_inum *inum, unsigned int new_type)
+		   struct gfs2_inum_host *inum, unsigned int new_type)
 {
 	struct buffer_head *bh;
 	struct gfs2_dirent *dent;
diff --git a/fs/gfs2/dir.h b/fs/gfs2/dir.h
index 3712334..b21b336 100644
--- a/fs/gfs2/dir.h
+++ b/fs/gfs2/dir.h
@@ -31,17 +31,17 @@ struct gfs2_inum;
 typedef int (*gfs2_filldir_t) (void *opaque,
 			      const char *name, unsigned int length,
 			      u64 offset,
-			      struct gfs2_inum *inum, unsigned int type);
+			      struct gfs2_inum_host *inum, unsigned int type);
 
 int gfs2_dir_search(struct inode *dir, const struct qstr *filename,
-		    struct gfs2_inum *inum, unsigned int *type);
+		    struct gfs2_inum_host *inum, unsigned int *type);
 int gfs2_dir_add(struct inode *inode, const struct qstr *filename,
-		 const struct gfs2_inum *inum, unsigned int type);
+		 const struct gfs2_inum_host *inum, unsigned int type);
 int gfs2_dir_del(struct gfs2_inode *dip, const struct qstr *filename);
 int gfs2_dir_read(struct inode *inode, u64 * offset, void *opaque,
 		  gfs2_filldir_t filldir);
 int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
-		   struct gfs2_inum *new_inum, unsigned int new_type);
+		   struct gfs2_inum_host *new_inum, unsigned int new_type);
 
 int gfs2_dir_exhash_dealloc(struct gfs2_inode *dip);
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e4afc2c..20c9b4f 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -224,7 +224,7 @@ enum {
 
 struct gfs2_inode {
 	struct inode i_inode;
-	struct gfs2_inum i_num;
+	struct gfs2_inum_host i_num;
 
 	unsigned long i_flags;		/* GIF_... */
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 7eb6b44..dadd1f3 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -112,7 +112,7 @@ void gfs2_inode_attr_out(struct gfs2_ino
 static int iget_test(struct inode *inode, void *opaque)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_inum *inum = opaque;
+	struct gfs2_inum_host *inum = opaque;
 
 	if (ip && ip->i_num.no_addr == inum->no_addr)
 		return 1;
@@ -123,19 +123,19 @@ static int iget_test(struct inode *inode
 static int iget_set(struct inode *inode, void *opaque)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_inum *inum = opaque;
+	struct gfs2_inum_host *inum = opaque;
 
 	ip->i_num = *inum;
 	return 0;
 }
 
-struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum *inum)
+struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum_host *inum)
 {
 	return ilookup5(sb, (unsigned long)inum->no_formal_ino,
 			iget_test, inum);
 }
 
-static struct inode *gfs2_iget(struct super_block *sb, struct gfs2_inum *inum)
+static struct inode *gfs2_iget(struct super_block *sb, struct gfs2_inum_host *inum)
 {
 	return iget5_locked(sb, (unsigned long)inum->no_formal_ino,
 		     iget_test, iget_set, inum);
@@ -150,7 +150,7 @@ static struct inode *gfs2_iget(struct su
  * Returns: A VFS inode, or an error
  */
 
-struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum *inum, unsigned int type)
+struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum_host *inum, unsigned int type)
 {
 	struct inode *inode = gfs2_iget(sb, inum);
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -394,7 +394,7 @@ struct inode *gfs2_lookupi(struct inode 
 	struct super_block *sb = dir->i_sb;
 	struct gfs2_inode *dip = GFS2_I(dir);
 	struct gfs2_holder d_gh;
-	struct gfs2_inum inum;
+	struct gfs2_inum_host inum;
 	unsigned int type;
 	int error = 0;
 	struct inode *inode = NULL;
@@ -610,7 +610,7 @@ static void munge_mode_uid_gid(struct gf
 		*gid = current->fsgid;
 }
 
-static int alloc_dinode(struct gfs2_inode *dip, struct gfs2_inum *inum,
+static int alloc_dinode(struct gfs2_inode *dip, struct gfs2_inum_host *inum,
 			u64 *generation)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
@@ -650,7 +650,7 @@ out:
  */
 
 static void init_dinode(struct gfs2_inode *dip, struct gfs2_glock *gl,
-			const struct gfs2_inum *inum, unsigned int mode,
+			const struct gfs2_inum_host *inum, unsigned int mode,
 			unsigned int uid, unsigned int gid,
 			const u64 *generation)
 {
@@ -707,7 +707,7 @@ static void init_dinode(struct gfs2_inod
 }
 
 static int make_dinode(struct gfs2_inode *dip, struct gfs2_glock *gl,
-		       unsigned int mode, const struct gfs2_inum *inum,
+		       unsigned int mode, const struct gfs2_inum_host *inum,
 		       const u64 *generation)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
@@ -866,7 +866,7 @@ struct inode *gfs2_createi(struct gfs2_h
 	struct gfs2_inode *dip = ghs->gh_gl->gl_object;
 	struct inode *dir = &dip->i_inode;
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
-	struct gfs2_inum inum;
+	struct gfs2_inum_host inum;
 	int error;
 	u64 generation;
 
@@ -1018,7 +1018,7 @@ int gfs2_rmdiri(struct gfs2_inode *dip, 
 int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
 		   struct gfs2_inode *ip)
 {
-	struct gfs2_inum inum;
+	struct gfs2_inum_host inum;
 	unsigned int type;
 	int error;
 
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index f5d8617..d699b92 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -27,8 +27,8 @@ static inline int gfs2_is_dir(struct gfs
 
 void gfs2_inode_attr_in(struct gfs2_inode *ip);
 void gfs2_inode_attr_out(struct gfs2_inode *ip);
-struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum *inum, unsigned type);
-struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum *inum);
+struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum_host *inum, unsigned type);
+struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum_host *inum);
 
 int gfs2_inode_refresh(struct gfs2_inode *ip);
 
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index c4e099d..32f592f 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -32,7 +32,7 @@ #define pv(struct, member, fmt) printk(K
  * first arg: the cpu-order structure
  */
 
-void gfs2_inum_in(struct gfs2_inum *no, const void *buf)
+void gfs2_inum_in(struct gfs2_inum_host *no, const void *buf)
 {
 	const struct gfs2_inum *str = buf;
 
@@ -40,7 +40,7 @@ void gfs2_inum_in(struct gfs2_inum *no, 
 	no->no_addr = be64_to_cpu(str->no_addr);
 }
 
-void gfs2_inum_out(const struct gfs2_inum *no, void *buf)
+void gfs2_inum_out(const struct gfs2_inum_host *no, void *buf)
 {
 	struct gfs2_inum *str = buf;
 
@@ -48,7 +48,7 @@ void gfs2_inum_out(const struct gfs2_inu
 	str->no_addr = cpu_to_be64(no->no_addr);
 }
 
-static void gfs2_inum_print(const struct gfs2_inum *no)
+static void gfs2_inum_print(const struct gfs2_inum_host *no)
 {
 	printk(KERN_INFO "  no_formal_ino = %llu\n", (unsigned long long)no->no_formal_ino);
 	printk(KERN_INFO "  no_addr = %llu\n", (unsigned long long)no->no_addr);
diff --git a/fs/gfs2/ops_dentry.c b/fs/gfs2/ops_dentry.c
index 00041b1..c36f9e3 100644
--- a/fs/gfs2/ops_dentry.c
+++ b/fs/gfs2/ops_dentry.c
@@ -43,7 +43,7 @@ static int gfs2_drevalidate(struct dentr
 	struct inode *inode = dentry->d_inode;
 	struct gfs2_holder d_gh;
 	struct gfs2_inode *ip;
-	struct gfs2_inum inum;
+	struct gfs2_inum_host inum;
 	unsigned int type;
 	int error;
 
diff --git a/fs/gfs2/ops_export.c b/fs/gfs2/ops_export.c
index 86127d9..33423a5 100644
--- a/fs/gfs2/ops_export.c
+++ b/fs/gfs2/ops_export.c
@@ -35,7 +35,7 @@ static struct dentry *gfs2_decode_fh(str
 				     void *context)
 {
 	struct gfs2_fh_obj fh_obj;
-	struct gfs2_inum *this, parent;
+	struct gfs2_inum_host *this, parent;
 
 	if (fh_type != fh_len)
 		return NULL;
@@ -114,12 +114,12 @@ static int gfs2_encode_fh(struct dentry 
 }
 
 struct get_name_filldir {
-	struct gfs2_inum inum;
+	struct gfs2_inum_host inum;
 	char *name;
 };
 
 static int get_name_filldir(void *opaque, const char *name, unsigned int length,
-			    u64 offset, struct gfs2_inum *inum,
+			    u64 offset, struct gfs2_inum_host *inum,
 			    unsigned int type)
 {
 	struct get_name_filldir *gnfd = (struct get_name_filldir *)opaque;
@@ -202,7 +202,7 @@ static struct dentry *gfs2_get_dentry(st
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_fh_obj *fh_obj = (struct gfs2_fh_obj *)inum_obj;
-	struct gfs2_inum *inum = &fh_obj->this;
+	struct gfs2_inum_host *inum = &fh_obj->this;
 	struct gfs2_holder i_gh, ri_gh, rgd_gh;
 	struct gfs2_rgrpd *rgd;
 	struct inode *inode;
diff --git a/fs/gfs2/ops_export.h b/fs/gfs2/ops_export.h
index 09aca50..f925a95 100644
--- a/fs/gfs2/ops_export.h
+++ b/fs/gfs2/ops_export.h
@@ -15,7 +15,7 @@ #define GFS2_LARGE_FH_SIZE 10
 
 extern struct export_operations gfs2_export_ops;
 struct gfs2_fh_obj {
-	struct gfs2_inum this;
+	struct gfs2_inum_host this;
 	__u32            imode;
 };
 
diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index 3064f13..359965c 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -139,7 +139,7 @@ static loff_t gfs2_llseek(struct file *f
  */
 
 static int filldir_func(void *opaque, const char *name, unsigned int length,
-			u64 offset, struct gfs2_inum *inum,
+			u64 offset, struct gfs2_inum_host *inum,
 			unsigned int type)
 {
 	struct filldir_reg *fdr = (struct filldir_reg *)opaque;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 882873a..d14e139 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -237,7 +237,7 @@ fail:
 }
 
 static struct inode *gfs2_lookup_root(struct super_block *sb,
-				      struct gfs2_inum *inum)
+				      struct gfs2_inum_host *inum)
 {
 	return gfs2_inode_lookup(sb, inum, DT_DIR);
 }
@@ -246,7 +246,7 @@ static int init_sb(struct gfs2_sbd *sdp,
 {
 	struct super_block *sb = sdp->sd_vfs;
 	struct gfs2_holder sb_gh;
-	struct gfs2_inum *inum;
+	struct gfs2_inum_host *inum;
 	struct inode *inode;
 	int error = 0;
 
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 7dd5e4c..b16df6e 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -54,8 +54,13 @@ struct gfs2_inum {
 	__be64 no_addr;
 };
 
-static inline int gfs2_inum_equal(const struct gfs2_inum *ino1,
-				  const struct gfs2_inum *ino2)
+struct gfs2_inum_host {
+	__u64 no_formal_ino;
+	__u64 no_addr;
+};
+
+static inline int gfs2_inum_equal(const struct gfs2_inum_host *ino1,
+				  const struct gfs2_inum_host *ino2)
 {
 	return ino1->no_formal_ino == ino2->no_formal_ino &&
 	       ino1->no_addr == ino2->no_addr;
@@ -143,8 +148,8 @@ struct gfs2_sb_host {
 	__u32 sb_bsize;
 	__u32 sb_bsize_shift;
 
-	struct gfs2_inum sb_master_dir; /* Was jindex dinode in gfs1 */
-	struct gfs2_inum sb_root_dir;
+	struct gfs2_inum_host sb_master_dir; /* Was jindex dinode in gfs1 */
+	struct gfs2_inum_host sb_root_dir;
 
 	char sb_lockproto[GFS2_LOCKNAME_LEN];
 	char sb_locktable[GFS2_LOCKNAME_LEN];
@@ -313,7 +318,7 @@ struct gfs2_dinode {
 struct gfs2_dinode_host {
 	struct gfs2_meta_header_host di_header;
 
-	struct gfs2_inum di_num;
+	struct gfs2_inum_host di_num;
 
 	__u32 di_mode;	/* mode of file */
 	__u32 di_uid;	/* owner's user id */
@@ -503,8 +508,8 @@ struct gfs2_quota_change {
 #ifdef __KERNEL__
 /* Translation functions */
 
-extern void gfs2_inum_in(struct gfs2_inum *no, const void *buf);
-extern void gfs2_inum_out(const struct gfs2_inum *no, void *buf);
+extern void gfs2_inum_in(struct gfs2_inum_host *no, const void *buf);
+extern void gfs2_inum_out(const struct gfs2_inum_host *no, void *buf);
 extern void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf);
 extern void gfs2_rindex_in(struct gfs2_rindex_host *ri, const void *buf);
 extern void gfs2_rindex_out(const struct gfs2_rindex_host *ri, void *buf);
-- 
1.4.1



