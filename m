Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936399AbWK3M1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936399AbWK3M1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936347AbWK3MXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:23:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936387AbWK3MXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:23:10 -0500
Subject: [GFS2] fs/gfs2/log.c:log_bmap() fix printk format warning [62/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Ryusuke Konishi <ryusuke@osrg.net>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:22:46 +0000
Message-Id: <1164889366.3752.429.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From aed3255f2267e2d1d95b9cf7f2995ce24e6c873b Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <ryusuke@osrg.net>
Date: Tue, 28 Nov 2006 02:53:22 +0900
Subject: [PATCH] [GFS2] fs/gfs2/log.c:log_bmap() fix printk format warning

Fix a printk format warning in fs/gfs2/log.c:
fs/gfs2/log.c:322: warning: format '%llu' expects type 'long long unsigned int', but argument 3 has type 'sector_t'

Signed-off-by: Ryusuke Konishi <ryusuke@osrg.net>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/log.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 7713d59..291415d 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -326,7 +326,8 @@ static u64 log_bmap(struct gfs2_sbd *sdp
 	bh_map.b_size = 1 << inode->i_blkbits;
 	error = gfs2_block_map(inode, lbn, 0, &bh_map);
 	if (error || !bh_map.b_blocknr)
-		printk(KERN_INFO "error=%d, dbn=%llu lbn=%u", error, bh_map.b_blocknr, lbn);
+		printk(KERN_INFO "error=%d, dbn=%llu lbn=%u", error,
+		       (unsigned long long)bh_map.b_blocknr, lbn);
 	gfs2_assert_withdraw(sdp, !error && bh_map.b_blocknr);
 
 	return bh_map.b_blocknr;
-- 
1.4.1



