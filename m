Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWJTJLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWJTJLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWJTJLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:11:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33678 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932231AbWJTJLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:11:47 -0400
Subject: [PATCH 6/8] [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): don't use
	an uninitialized variable
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:18:58 +0100
Message-Id: <1161335938.27980.191.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 348acd48f050f5ba7fa917b1421ae34443be97dd Mon Sep 17 00:00:00 2001
From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 19 Oct 2006 15:20:04 +0200
Subject: [GFS2] fs/gfs2/dir.c:gfs2_dir_write_data(): don't use an uninitialized variable

In the "if (extlen)" case, "new" might be used uninitialized.

Looking at the code, it should be initialized to 0.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index ce52bd9..ead7df0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -184,7 +184,7 @@ static int gfs2_dir_write_data(struct gf
 	while (copied < size) {
 		unsigned int amount;
 		struct buffer_head *bh;
-		int new;
+		int new = 0;
 
 		amount = size - copied;
 		if (amount > sdp->sd_sb.sb_bsize - o)
-- 
1.4.1



