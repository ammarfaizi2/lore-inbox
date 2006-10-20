Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWJTJMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWJTJMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWJTJMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:12:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932234AbWJTJL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:11:56 -0400
Subject: [PATCH 7/8] [GFS2] fs/gfs2/ops_fstype.c:fill_super_meta(): fix
	NULL dereference
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 20 Oct 2006 10:19:04 +0100
Message-Id: <1161335944.27980.193.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From bbbe4512735eb0f15f09ffd14876091a8e91bc69 Mon Sep 17 00:00:00 2001
From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 19 Oct 2006 15:27:00 +0200
Subject: [GFS2] fs/gfs2/ops_fstype.c:fill_super_meta(): fix NULL dereference

Don't dereference new->s_root when we do know it's NULL.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_fstype.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e99444d..882873a 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -794,8 +794,8 @@ static int fill_super_meta(struct super_
 		fs_err(sdp, "can't get root dentry\n");
 		error = -ENOMEM;
 		iput(inode);
-	}
-	new->s_root->d_op = &gfs2_dops;
+	} else
+		new->s_root->d_op = &gfs2_dops;
 
 	return error;
 }
-- 
1.4.1



