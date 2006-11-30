Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936265AbWK3MMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936265AbWK3MMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936263AbWK3MMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:12:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936256AbWK3MMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:12:43 -0500
Subject: [GFS2] split and annotate gfs2_inum_range [6/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:13:28 +0000
Message-Id: <1164888808.3752.314.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From e697264709c86040271cdd7abee781d7adbb7f91 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 21:29:46 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_inum_range

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |    4 ++--
 fs/gfs2/ondisk.c            |    4 ++--
 include/linux/gfs2_ondisk.h |    9 +++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 191a3df..7eb6b44 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -436,7 +436,7 @@ static int pick_formal_ino_1(struct gfs2
 {
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_ir_inode);
 	struct buffer_head *bh;
-	struct gfs2_inum_range ir;
+	struct gfs2_inum_range_host ir;
 	int error;
 
 	error = gfs2_trans_begin(sdp, RES_DINODE, 0);
@@ -479,7 +479,7 @@ static int pick_formal_ino_2(struct gfs2
 	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_inum_inode);
 	struct gfs2_holder gh;
 	struct buffer_head *bh;
-	struct gfs2_inum_range ir;
+	struct gfs2_inum_range_host ir;
 	int error;
 
 	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 3b156a1..64f5f0c 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -263,7 +263,7 @@ void gfs2_log_header_in(struct gfs2_log_
 	lh->lh_hash = be32_to_cpu(str->lh_hash);
 }
 
-void gfs2_inum_range_in(struct gfs2_inum_range *ir, const void *buf)
+void gfs2_inum_range_in(struct gfs2_inum_range_host *ir, const void *buf)
 {
 	const struct gfs2_inum_range *str = buf;
 
@@ -271,7 +271,7 @@ void gfs2_inum_range_in(struct gfs2_inum
 	ir->ir_length = be64_to_cpu(str->ir_length);
 }
 
-void gfs2_inum_range_out(const struct gfs2_inum_range *ir, void *buf)
+void gfs2_inum_range_out(const struct gfs2_inum_range_host *ir, void *buf)
 {
 	struct gfs2_inum_range *str = buf;
 
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index e4ca6e4..c035587 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -445,6 +445,11 @@ struct gfs2_inum_range {
 	__be64 ir_length;
 };
 
+struct gfs2_inum_range_host {
+	__u64 ir_start;
+	__u64 ir_length;
+};
+
 /*
  * Statfs change
  * Describes an change to the pool of free and allocated
@@ -488,8 +493,8 @@ extern void gfs2_dinode_out(const struct
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
 extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *buf);
 extern void gfs2_log_header_in(struct gfs2_log_header *lh, const void *buf);
-extern void gfs2_inum_range_in(struct gfs2_inum_range *ir, const void *buf);
-extern void gfs2_inum_range_out(const struct gfs2_inum_range *ir, void *buf);
+extern void gfs2_inum_range_in(struct gfs2_inum_range_host *ir, const void *buf);
+extern void gfs2_inum_range_out(const struct gfs2_inum_range_host *ir, void *buf);
 extern void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, const void *buf);
 extern void gfs2_statfs_change_out(const struct gfs2_statfs_change *sc, void *buf);
 extern void gfs2_quota_change_in(struct gfs2_quota_change *qc, const void *buf);
-- 
1.4.1



