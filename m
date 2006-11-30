Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936266AbWK3Miu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936266AbWK3Miu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936251AbWK3MNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:13:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936256AbWK3MNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:13:25 -0500
Subject: [GFS2] split and annotate gfs2_meta_header [9/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:13:58 +0000
Message-Id: <1164888838.3752.320.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From e928a76f959e89884f6186bb6f846c533847d5df Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 21:57:23 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_meta_header

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ondisk.c            |    6 +++---
 include/linux/gfs2_ondisk.h |   14 ++++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 84b1ebc..b5aa7ab 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -54,7 +54,7 @@ static void gfs2_inum_print(const struct
 	printk(KERN_INFO "  no_addr = %llu\n", (unsigned long long)no->no_addr);
 }
 
-static void gfs2_meta_header_in(struct gfs2_meta_header *mh, const void *buf)
+static void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf)
 {
 	const struct gfs2_meta_header *str = buf;
 
@@ -63,7 +63,7 @@ static void gfs2_meta_header_in(struct g
 	mh->mh_format = be32_to_cpu(str->mh_format);
 }
 
-static void gfs2_meta_header_out(const struct gfs2_meta_header *mh, void *buf)
+static void gfs2_meta_header_out(const struct gfs2_meta_header_host *mh, void *buf)
 {
 	struct gfs2_meta_header *str = buf;
 
@@ -72,7 +72,7 @@ static void gfs2_meta_header_out(const s
 	str->mh_format = cpu_to_be32(mh->mh_format);
 }
 
-static void gfs2_meta_header_print(const struct gfs2_meta_header *mh)
+static void gfs2_meta_header_print(const struct gfs2_meta_header_host *mh)
 {
 	pv(mh, mh_magic, "0x%.8X");
 	pv(mh, mh_type, "%u");
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index fb69a64..76eb9e1 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -89,6 +89,12 @@ struct gfs2_meta_header {
 	__be32 __pad1;		/* Was incarnation number in gfs1 */
 };
 
+struct gfs2_meta_header_host {
+	__u32 mh_magic;
+	__u32 mh_type;
+	__u32 mh_format;
+};
+
 /*
  * super-block structure
  *
@@ -129,7 +135,7 @@ struct gfs2_sb {
 };
 
 struct gfs2_sb_host {
-	struct gfs2_meta_header sb_header;
+	struct gfs2_meta_header_host sb_header;
 
 	__u32 sb_fs_format;
 	__u32 sb_multihost_format;
@@ -194,7 +200,7 @@ struct gfs2_rgrp {
 };
 
 struct gfs2_rgrp_host {
-	struct gfs2_meta_header rg_header;
+	struct gfs2_meta_header_host rg_header;
 
 	__u32 rg_flags;
 	__u32 rg_free;
@@ -297,7 +303,7 @@ struct gfs2_dinode {
 };
 
 struct gfs2_dinode_host {
-	struct gfs2_meta_header di_header;
+	struct gfs2_meta_header_host di_header;
 
 	struct gfs2_inum di_num;
 
@@ -406,7 +412,7 @@ struct gfs2_log_header {
 };
 
 struct gfs2_log_header_host {
-	struct gfs2_meta_header lh_header;
+	struct gfs2_meta_header_host lh_header;
 
 	__u64 lh_sequence;	/* Sequence number of this transaction */
 	__u32 lh_flags;	/* GFS2_LOG_HEAD_... */
-- 
1.4.1



