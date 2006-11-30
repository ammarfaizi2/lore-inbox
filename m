Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936279AbWK3MjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936279AbWK3MjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936268AbWK3MNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:13:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13447 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936251AbWK3MNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:13:38 -0500
Subject: [GFS2] split and annotate gfs_rindex [10/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:14:10 +0000
Message-Id: <1164888850.3752.323.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 1e81c4c3e0f55c95b6278a827262b80debd0dc7e Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 22:51:24 -0400
Subject: [PATCH] [GFS2] split and annotate gfs_rindex

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/incore.h            |    2 +-
 fs/gfs2/ondisk.c            |    4 ++--
 fs/gfs2/rgrp.c              |    2 +-
 include/linux/gfs2_ondisk.h |   14 +++++++++++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e69f339..e4afc2c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -67,7 +67,7 @@ struct gfs2_rgrpd {
 	struct list_head rd_list_mru;
 	struct list_head rd_recent;	/* Recently used rgrps */
 	struct gfs2_glock *rd_gl;	/* Glock for this rgrp */
-	struct gfs2_rindex rd_ri;
+	struct gfs2_rindex_host rd_ri;
 	struct gfs2_rgrp_host rd_rg;
 	u64 rd_rg_vn;
 	struct gfs2_bitmap *rd_bits;
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index b5aa7ab..c4e099d 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -97,7 +97,7 @@ void gfs2_sb_in(struct gfs2_sb_host *sb,
 	memcpy(sb->sb_locktable, str->sb_locktable, GFS2_LOCKNAME_LEN);
 }
 
-void gfs2_rindex_in(struct gfs2_rindex *ri, const void *buf)
+void gfs2_rindex_in(struct gfs2_rindex_host *ri, const void *buf)
 {
 	const struct gfs2_rindex *str = buf;
 
@@ -109,7 +109,7 @@ void gfs2_rindex_in(struct gfs2_rindex *
 
 }
 
-void gfs2_rindex_print(const struct gfs2_rindex *ri)
+void gfs2_rindex_print(const struct gfs2_rindex_host *ri)
 {
 	printk(KERN_INFO "  ri_addr = %llu\n", (unsigned long long)ri->ri_addr);
 	pv(ri, ri_length, "%u");
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index b261385..07dfd63 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -253,7 +253,7 @@ void gfs2_rgrp_verify(struct gfs2_rgrpd 
 
 }
 
-static inline int rgrp_contains_block(struct gfs2_rindex *ri, u64 block)
+static inline int rgrp_contains_block(struct gfs2_rindex_host *ri, u64 block)
 {
 	u64 first = ri->ri_data0;
 	u64 last = first + ri->ri_data;
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 76eb9e1..7dd5e4c 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -168,6 +168,14 @@ struct gfs2_rindex {
 	__u8 ri_reserved[64];
 };
 
+struct gfs2_rindex_host {
+	__u64 ri_addr;	/* grp block disk address */
+	__u64 ri_data0;	/* first data location */
+	__u32 ri_length;	/* length of rgrp header in fs blocks */
+	__u32 ri_data;	/* num of data blocks in rgrp */
+	__u32 ri_bitbytes;	/* number of bytes in data bitmaps */
+};
+
 /*
  * resource group header structure
  */
@@ -498,8 +506,8 @@ #ifdef __KERNEL__
 extern void gfs2_inum_in(struct gfs2_inum *no, const void *buf);
 extern void gfs2_inum_out(const struct gfs2_inum *no, void *buf);
 extern void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf);
-extern void gfs2_rindex_in(struct gfs2_rindex *ri, const void *buf);
-extern void gfs2_rindex_out(const struct gfs2_rindex *ri, void *buf);
+extern void gfs2_rindex_in(struct gfs2_rindex_host *ri, const void *buf);
+extern void gfs2_rindex_out(const struct gfs2_rindex_host *ri, void *buf);
 extern void gfs2_rgrp_in(struct gfs2_rgrp_host *rg, const void *buf);
 extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
 extern void gfs2_quota_in(struct gfs2_quota *qu, const void *buf);
@@ -517,7 +525,7 @@ extern void gfs2_quota_change_in(struct 
 
 /* Printing functions */
 
-extern void gfs2_rindex_print(const struct gfs2_rindex *ri);
+extern void gfs2_rindex_print(const struct gfs2_rindex_host *ri);
 extern void gfs2_dinode_print(const struct gfs2_dinode_host *di);
 
 #endif /* __KERNEL__ */
-- 
1.4.1



