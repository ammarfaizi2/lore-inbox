Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936263AbWK3MNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936263AbWK3MNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936256AbWK3MMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:12:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936251AbWK3MMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:12:40 -0500
Subject: [GFS2] split and annotate gfs2_rgrp [5/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:13:16 +0000
Message-Id: <1164888796.3752.312.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 68826664d12827d7a732192e2f00ba46fb899414 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 21:07:22 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_rgrp

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/incore.h            |    2 +-
 fs/gfs2/ondisk.c            |    4 ++--
 include/linux/gfs2_ondisk.h |   13 +++++++++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index bd596ba..8ca7a7f 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -68,7 +68,7 @@ struct gfs2_rgrpd {
 	struct list_head rd_recent;	/* Recently used rgrps */
 	struct gfs2_glock *rd_gl;	/* Glock for this rgrp */
 	struct gfs2_rindex rd_ri;
-	struct gfs2_rgrp rd_rg;
+	struct gfs2_rgrp_host rd_rg;
 	u64 rd_rg_vn;
 	struct gfs2_bitmap *rd_bits;
 	unsigned int rd_bh_count;
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 5b32f1a..3b156a1 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -120,7 +120,7 @@ void gfs2_rindex_print(const struct gfs2
 	pv(ri, ri_bitbytes, "%u");
 }
 
-void gfs2_rgrp_in(struct gfs2_rgrp *rg, const void *buf)
+void gfs2_rgrp_in(struct gfs2_rgrp_host *rg, const void *buf)
 {
 	const struct gfs2_rgrp *str = buf;
 
@@ -131,7 +131,7 @@ void gfs2_rgrp_in(struct gfs2_rgrp *rg, 
 	rg->rg_igeneration = be64_to_cpu(str->rg_igeneration);
 }
 
-void gfs2_rgrp_out(const struct gfs2_rgrp *rg, void *buf)
+void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf)
 {
 	struct gfs2_rgrp *str = buf;
 
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index a5d36cd..e4ca6e4 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -193,6 +193,15 @@ struct gfs2_rgrp {
 	__u8 rg_reserved[80]; /* Several fields from gfs1 now reserved */
 };
 
+struct gfs2_rgrp_host {
+	struct gfs2_meta_header rg_header;
+
+	__u32 rg_flags;
+	__u32 rg_free;
+	__u32 rg_dinodes;
+	__u64 rg_igeneration;
+};
+
 /*
  * quota structure
  */
@@ -470,8 +479,8 @@ extern void gfs2_inum_out(const struct g
 extern void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf);
 extern void gfs2_rindex_in(struct gfs2_rindex *ri, const void *buf);
 extern void gfs2_rindex_out(const struct gfs2_rindex *ri, void *buf);
-extern void gfs2_rgrp_in(struct gfs2_rgrp *rg, const void *buf);
-extern void gfs2_rgrp_out(const struct gfs2_rgrp *rg, void *buf);
+extern void gfs2_rgrp_in(struct gfs2_rgrp_host *rg, const void *buf);
+extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
 extern void gfs2_quota_in(struct gfs2_quota *qu, const void *buf);
 extern void gfs2_quota_out(const struct gfs2_quota *qu, void *buf);
 extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf);
-- 
1.4.1



