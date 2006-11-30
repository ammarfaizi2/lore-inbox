Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936249AbWK3MSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936249AbWK3MSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936320AbWK3MS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:18:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52362 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936303AbWK3MSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:18:07 -0500
Subject: [GFS2] Inode number is constant [34/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:17:59 +0000
Message-Id: <1164889079.3752.372.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From e7c698d74fc9e0e76b3086062b0519df3601ff52 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 8 Nov 2006 13:52:05 -0500
Subject: [PATCH] [GFS2] Inode number is constant

Since the inode number is constant, we don't need to keep updating
it everytime we refresh the other inode fields.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 56b39be..19b2736 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -50,7 +50,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
 	struct inode *inode = &ip->i_inode;
 	struct gfs2_dinode_host *di = &ip->i_di;
 
-	inode->i_ino = ip->i_num.no_addr;
 	i_size_write(inode, di->di_size);
 	inode->i_blocks = di->di_blocks <<
 		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
@@ -73,6 +72,7 @@ static int iget_set(struct inode *inode,
 	struct gfs2_inum_host *inum = opaque;
 
 	ip->i_num = *inum;
+	inode->i_ino = inum->no_addr;
 	return 0;
 }
 
-- 
1.4.1



