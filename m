Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936277AbWK3MQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936277AbWK3MQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936293AbWK3MQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:16:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936266AbWK3MP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:15:27 -0500
Subject: [GFS2] Change argument to gfs2_dinode_in [18/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:39 +0000
Message-Id: <1164888939.3752.340.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 891ea14712da68e282de8583e5fa14f0d3f3731e Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 31 Oct 2006 15:22:10 -0500
Subject: [PATCH] [GFS2] Change argument to gfs2_dinode_in

This is a preliminary patch to enable the removal of fields
in gfs2_dinode_host which are duplicated in struct inode.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |    2 +-
 fs/gfs2/ondisk.c            |    4 ++--
 include/linux/gfs2_ondisk.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index b861ddb..9875e93 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -229,7 +229,7 @@ int gfs2_inode_refresh(struct gfs2_inode
 		return -EIO;
 	}
 
-	gfs2_dinode_in(&ip->i_di, dibh->b_data);
+	gfs2_dinode_in(ip, dibh->b_data);
 
 	brelse(dibh);
 
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 2c50fa0..edf8756 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -155,8 +155,9 @@ void gfs2_quota_in(struct gfs2_quota_hos
 	qu->qu_value = be64_to_cpu(str->qu_value);
 }
 
-void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf)
+void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
+	struct gfs2_dinode_host *di = &ip->i_di;
 	const struct gfs2_dinode *str = buf;
 
 	gfs2_meta_header_in(&di->di_header, buf);
@@ -186,7 +187,6 @@ void gfs2_dinode_in(struct gfs2_dinode_h
 	di->di_entries = be32_to_cpu(str->di_entries);
 
 	di->di_eattr = be64_to_cpu(str->di_eattr);
-
 }
 
 void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 550effa..08d8240 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -534,8 +534,8 @@ extern void gfs2_rindex_out(const struct
 extern void gfs2_rgrp_in(struct gfs2_rgrp_host *rg, const void *buf);
 extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
 extern void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf);
-extern void gfs2_dinode_in(struct gfs2_dinode_host *di, const void *buf);
 struct gfs2_inode;
+extern void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf);
 extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
 extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *buf);
-- 
1.4.1



