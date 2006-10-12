Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWJLRNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWJLRNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWJLRNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:13:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750976AbWJLRNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:13:40 -0400
Subject: [PATCH 2/7] [GFS2] Fix uninitialised variable
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 12 Oct 2006 18:18:59 +0100
Message-Id: <1160673539.11901.818.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From f5c54804d9e3bb23d8924af09d9ca1c8de9560b6 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 10 Oct 2006 13:45:15 -0400
Subject: [GFS2] Fix uninitialised variable

This fixes a bug where, in certain cases an uninitialised variable
could cause a dereference of a NULL pointer in gfs2_commit_write().
Also a typo in a comment is fixed at the same time.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_address.c |    1 +
 fs/gfs2/rgrp.h        |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index bdf56cf..99c9337 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -385,6 +385,7 @@ static int gfs2_prepare_write(struct fil
 		goto out_unlock;
 
 
+	ip->i_alloc.al_requested = 0;
 	if (alloc_required) {
 		al = gfs2_alloc_get(ip);
 
diff --git a/fs/gfs2/rgrp.h b/fs/gfs2/rgrp.h
index 9eedfd1..b01e0cf 100644
--- a/fs/gfs2/rgrp.h
+++ b/fs/gfs2/rgrp.h
@@ -32,7 +32,7 @@ void gfs2_rgrp_repolish_clones(struct gf
 struct gfs2_alloc *gfs2_alloc_get(struct gfs2_inode *ip);
 static inline void gfs2_alloc_put(struct gfs2_inode *ip)
 {
-	return; /* Se we can see where ip->i_alloc is used */
+	return; /* So we can see where ip->i_alloc is used */
 }
 
 int gfs2_inplace_reserve_i(struct gfs2_inode *ip,
-- 
1.4.1



