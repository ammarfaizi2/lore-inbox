Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936294AbWK3Mia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936294AbWK3Mia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936281AbWK3MOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:14:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936271AbWK3MOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:14:16 -0500
Subject: [GFS2] split and annotate gfs2_quota_change [14/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:14:57 +0000
Message-Id: <1164888897.3752.331.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From b62f963e1fdf838fed91faec21228d421a834f2d Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 23:46:46 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_quota_change

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ondisk.c            |    2 +-
 fs/gfs2/quota.c             |    2 +-
 include/linux/gfs2_ondisk.h |    8 +++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 84c59b1..2d1682d 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -297,7 +297,7 @@ void gfs2_statfs_change_out(const struct
 	str->sc_dinodes = cpu_to_be64(sc->sc_dinodes);
 }
 
-void gfs2_quota_change_in(struct gfs2_quota_change *qc, const void *buf)
+void gfs2_quota_change_in(struct gfs2_quota_change_host *qc, const void *buf)
 {
 	const struct gfs2_quota_change *str = buf;
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index e3f5b8d..009d86c 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1103,7 +1103,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp
 
 		for (y = 0; y < sdp->sd_qc_per_block && slot < sdp->sd_quota_slots;
 		     y++, slot++) {
-			struct gfs2_quota_change qc;
+			struct gfs2_quota_change_host qc;
 			struct gfs2_quota_data *qd;
 
 			gfs2_quota_change_in(&qc, bh->b_data +
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 3ce3a47..10a507d 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -517,6 +517,12 @@ struct gfs2_quota_change {
 	__be32 qc_id;
 };
 
+struct gfs2_quota_change_host {
+	__u64 qc_change;
+	__u32 qc_flags;	/* GFS2_QCF_... */
+	__u32 qc_id;
+};
+
 #ifdef __KERNEL__
 /* Translation functions */
 
@@ -537,7 +543,7 @@ extern void gfs2_inum_range_in(struct gf
 extern void gfs2_inum_range_out(const struct gfs2_inum_range_host *ir, void *buf);
 extern void gfs2_statfs_change_in(struct gfs2_statfs_change_host *sc, const void *buf);
 extern void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc, void *buf);
-extern void gfs2_quota_change_in(struct gfs2_quota_change *qc, const void *buf);
+extern void gfs2_quota_change_in(struct gfs2_quota_change_host *qc, const void *buf);
 
 /* Printing functions */
 
-- 
1.4.1



