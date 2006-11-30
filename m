Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936272AbWK3MNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936272AbWK3MNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936269AbWK3MNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:13:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936256AbWK3MNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:13:10 -0500
Subject: [GFS2] split and annotate gfs2_log_head [7/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:13:41 +0000
Message-Id: <1164888821.3752.316.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 551676226163379c217e8ec54bd287eab9b8521e Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 21:47:13 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_log_head

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/glops.c             |    2 +-
 fs/gfs2/incore.h            |    2 +-
 fs/gfs2/lops.c              |    4 ++--
 fs/gfs2/lops.h              |    2 +-
 fs/gfs2/ondisk.c            |    2 +-
 fs/gfs2/recovery.c          |   22 +++++++++++-----------
 fs/gfs2/recovery.h          |    2 +-
 fs/gfs2/super.c             |    4 ++--
 include/linux/gfs2_ondisk.h |   12 +++++++++++-
 9 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 41a6b68..5406b19 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -491,7 +491,7 @@ static void trans_go_xmote_bh(struct gfs
 	struct gfs2_sbd *sdp = gl->gl_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
 	struct gfs2_glock *j_gl = ip->i_gl;
-	struct gfs2_log_header head;
+	struct gfs2_log_header_host head;
 	int error;
 
 	if (gl->gl_state != LM_ST_UNLOCKED &&
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 8ca7a7f..e69f339 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -41,7 +41,7 @@ struct gfs2_log_operations {
 	void (*lo_before_commit) (struct gfs2_sbd *sdp);
 	void (*lo_after_commit) (struct gfs2_sbd *sdp, struct gfs2_ail *ai);
 	void (*lo_before_scan) (struct gfs2_jdesc *jd,
-				struct gfs2_log_header *head, int pass);
+				struct gfs2_log_header_host *head, int pass);
 	int (*lo_scan_elements) (struct gfs2_jdesc *jd, unsigned int start,
 				 struct gfs2_log_descriptor *ld, __be64 *ptr,
 				 int pass);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index ab6d111..8a654cd 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -182,7 +182,7 @@ static void buf_lo_after_commit(struct g
 }
 
 static void buf_lo_before_scan(struct gfs2_jdesc *jd,
-			       struct gfs2_log_header *head, int pass)
+			       struct gfs2_log_header_host *head, int pass)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 
@@ -328,7 +328,7 @@ static void revoke_lo_before_commit(stru
 }
 
 static void revoke_lo_before_scan(struct gfs2_jdesc *jd,
-				  struct gfs2_log_header *head, int pass)
+				  struct gfs2_log_header_host *head, int pass)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index 5839c05..965bc65 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -60,7 +60,7 @@ static inline void lops_after_commit(str
 }
 
 static inline void lops_before_scan(struct gfs2_jdesc *jd,
-				    struct gfs2_log_header *head,
+				    struct gfs2_log_header_host *head,
 				    unsigned int pass)
 {
 	int x;
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 64f5f0c..84b1ebc 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -251,7 +251,7 @@ void gfs2_dinode_print(const struct gfs2
 	printk(KERN_INFO "  di_eattr = %llu\n", (unsigned long long)di->di_eattr);
 }
 
-void gfs2_log_header_in(struct gfs2_log_header *lh, const void *buf)
+void gfs2_log_header_in(struct gfs2_log_header_host *lh, const void *buf)
 {
 	const struct gfs2_log_header *str = buf;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 62cd223..4478162 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -132,10 +132,10 @@ void gfs2_revoke_clean(struct gfs2_sbd *
  */
 
 static int get_log_header(struct gfs2_jdesc *jd, unsigned int blk,
-			  struct gfs2_log_header *head)
+			  struct gfs2_log_header_host *head)
 {
 	struct buffer_head *bh;
-	struct gfs2_log_header lh;
+	struct gfs2_log_header_host lh;
 	u32 hash;
 	int error;
 
@@ -143,7 +143,7 @@ static int get_log_header(struct gfs2_jd
 	if (error)
 		return error;
 
-	memcpy(&lh, bh->b_data, sizeof(struct gfs2_log_header));
+	memcpy(&lh, bh->b_data, sizeof(struct gfs2_log_header));	/* XXX */
 	lh.lh_hash = 0;
 	hash = gfs2_disk_hash((char *)&lh, sizeof(struct gfs2_log_header));
 	gfs2_log_header_in(&lh, bh->b_data);
@@ -174,7 +174,7 @@ static int get_log_header(struct gfs2_jd
  */
 
 static int find_good_lh(struct gfs2_jdesc *jd, unsigned int *blk,
-			struct gfs2_log_header *head)
+			struct gfs2_log_header_host *head)
 {
 	unsigned int orig_blk = *blk;
 	int error;
@@ -205,10 +205,10 @@ static int find_good_lh(struct gfs2_jdes
  * Returns: errno
  */
 
-static int jhead_scan(struct gfs2_jdesc *jd, struct gfs2_log_header *head)
+static int jhead_scan(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 {
 	unsigned int blk = head->lh_blkno;
-	struct gfs2_log_header lh;
+	struct gfs2_log_header_host lh;
 	int error;
 
 	for (;;) {
@@ -245,9 +245,9 @@ static int jhead_scan(struct gfs2_jdesc 
  * Returns: errno
  */
 
-int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header *head)
+int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 {
-	struct gfs2_log_header lh_1, lh_m;
+	struct gfs2_log_header_host lh_1, lh_m;
 	u32 blk_1, blk_2, blk_m;
 	int error;
 
@@ -320,7 +320,7 @@ static int foreach_descriptor(struct gfs
 		length = be32_to_cpu(ld->ld_length);
 
 		if (be32_to_cpu(ld->ld_header.mh_type) == GFS2_METATYPE_LH) {
-			struct gfs2_log_header lh;
+			struct gfs2_log_header_host lh;
 			error = get_log_header(jd, start, &lh);
 			if (!error) {
 				gfs2_replay_incr_blk(sdp, &start);
@@ -363,7 +363,7 @@ static int foreach_descriptor(struct gfs
  * Returns: errno
  */
 
-static int clean_journal(struct gfs2_jdesc *jd, struct gfs2_log_header *head)
+static int clean_journal(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 {
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
@@ -425,7 +425,7 @@ int gfs2_recover_journal(struct gfs2_jde
 {
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	struct gfs2_log_header head;
+	struct gfs2_log_header_host head;
 	struct gfs2_holder j_gh, ji_gh, t_gh;
 	unsigned long t;
 	int ro = 0;
diff --git a/fs/gfs2/recovery.h b/fs/gfs2/recovery.h
index 961feed..f7235e6 100644
--- a/fs/gfs2/recovery.h
+++ b/fs/gfs2/recovery.h
@@ -26,7 +26,7 @@ int gfs2_revoke_check(struct gfs2_sbd *s
 void gfs2_revoke_clean(struct gfs2_sbd *sdp);
 
 int gfs2_find_jhead(struct gfs2_jdesc *jd,
-		    struct gfs2_log_header *head);
+		    struct gfs2_log_header_host *head);
 int gfs2_recover_journal(struct gfs2_jdesc *gfs2_jd);
 void gfs2_check_journals(struct gfs2_sbd *sdp);
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 52aa322..0faf563 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -508,7 +508,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
 	struct gfs2_glock *j_gl = ip->i_gl;
 	struct gfs2_holder t_gh;
-	struct gfs2_log_header head;
+	struct gfs2_log_header_host head;
 	int error;
 
 	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_SHARED,
@@ -873,7 +873,7 @@ static int gfs2_lock_fs_check_clean(stru
 	struct gfs2_jdesc *jd;
 	struct lfcc *lfcc;
 	LIST_HEAD(list);
-	struct gfs2_log_header lh;
+	struct gfs2_log_header_host lh;
 	int error;
 
 	error = gfs2_jindex_hold(sdp, &ji_gh);
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index c035587..fb69a64 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -405,6 +405,16 @@ struct gfs2_log_header {
 	__be32 lh_hash;
 };
 
+struct gfs2_log_header_host {
+	struct gfs2_meta_header lh_header;
+
+	__u64 lh_sequence;	/* Sequence number of this transaction */
+	__u32 lh_flags;	/* GFS2_LOG_HEAD_... */
+	__u32 lh_tail;		/* Block number of log tail */
+	__u32 lh_blkno;
+	__u32 lh_hash;
+};
+
 /*
  * Log type descriptor
  */
@@ -492,7 +502,7 @@ extern void gfs2_dinode_in(struct gfs2_d
 extern void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf);
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
 extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *buf);
-extern void gfs2_log_header_in(struct gfs2_log_header *lh, const void *buf);
+extern void gfs2_log_header_in(struct gfs2_log_header_host *lh, const void *buf);
 extern void gfs2_inum_range_in(struct gfs2_inum_range_host *ir, const void *buf);
 extern void gfs2_inum_range_out(const struct gfs2_inum_range_host *ir, void *buf);
 extern void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, const void *buf);
-- 
1.4.1



