Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936275AbWK3MO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936275AbWK3MO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936269AbWK3MN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:13:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936273AbWK3MNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:13:55 -0500
Subject: [GFS2] split and annotate gfs2_quota [12/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:14:36 +0000
Message-Id: <1164888876.3752.327.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b5bc9e8b065dbcd4c675e8c158d6e524f221b8e1 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 23:31:55 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_quota

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ondisk.c            |    2 +-
 fs/gfs2/quota.c             |    2 +-
 include/linux/gfs2_ondisk.h |    9 +++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 32f592f..5db0737 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -144,7 +144,7 @@ void gfs2_rgrp_out(const struct gfs2_rgr
 	memset(&str->rg_reserved, 0, sizeof(str->rg_reserved));
 }
 
-void gfs2_quota_in(struct gfs2_quota *qu, const void *buf)
+void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf)
 {
 	const struct gfs2_quota *str = buf;
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index a3deae7..e3f5b8d 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -743,7 +743,7 @@ static int do_glock(struct gfs2_quota_da
 	struct gfs2_sbd *sdp = qd->qd_gl->gl_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
 	struct gfs2_holder i_gh;
-	struct gfs2_quota q;
+	struct gfs2_quota_host q;
 	char buf[sizeof(struct gfs2_quota)];
 	struct file_ra_state ra_state;
 	int error;
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index b16df6e..431e03b 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -232,6 +232,12 @@ struct gfs2_quota {
 	__u8 qu_reserved[64];
 };
 
+struct gfs2_quota_host {
+	__u64 qu_limit;
+	__u64 qu_warn;
+	__u64 qu_value;
+};
+
 /*
  * dinode structure
  */
@@ -515,8 +521,7 @@ extern void gfs2_rindex_in(struct gfs2_r
 extern void gfs2_rindex_out(const struct gfs2_rindex_host *ri, void *buf);
 extern void gfs2_rgrp_in(struct gfs2_rgrp_host *rg, const void *buf);
 extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
-extern void gfs2_quota_in(struct gfs2_quota *qu, const void *buf);
-extern void gfs2_quota_out(const struct gfs2_quota *qu, void *buf);
+extern void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf);
 extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf);
 extern void gfs2_dinode_out(const struct gfs2_dinode_host *di, void *buf);
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
-- 
1.4.1



