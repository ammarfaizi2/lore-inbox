Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936352AbWK3Mev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936352AbWK3Mev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936299AbWK3MRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:17:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936302AbWK3MR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:17:26 -0500
Subject: [GFS2] Tidy up 0 initialisations in inode.c [29/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:17:03 +0000
Message-Id: <1164889023.3752.362.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 294caaa3b8304c0a14c5039691caf23363bd9369 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 2 Nov 2006 11:59:28 -0500
Subject: [PATCH] [GFS2] Tidy up 0 initialisations in inode.c

We don't need to use endian conversions for 0 initialisations
when creating a new on-disk inode.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index e467780..faf9b9e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -673,15 +673,15 @@ static void init_dinode(struct gfs2_inod
 	di->di_mode = cpu_to_be32(mode);
 	di->di_uid = cpu_to_be32(uid);
 	di->di_gid = cpu_to_be32(gid);
-	di->di_nlink = cpu_to_be32(0);
-	di->di_size = cpu_to_be64(0);
+	di->di_nlink = 0;
+	di->di_size = 0;
 	di->di_blocks = cpu_to_be64(1);
 	di->di_atime = di->di_mtime = di->di_ctime = cpu_to_be64(get_seconds());
 	di->di_major = cpu_to_be32(MAJOR(dev));
 	di->di_minor = cpu_to_be32(MINOR(dev));
 	di->di_goal_meta = di->di_goal_data = cpu_to_be64(inum->no_addr);
 	di->di_generation = cpu_to_be64(*generation);
-	di->di_flags = cpu_to_be32(0);
+	di->di_flags = 0;
 
 	if (S_ISREG(mode)) {
 		if ((dip->i_di.di_flags & GFS2_DIF_INHERIT_JDATA) ||
@@ -699,13 +699,13 @@ static void init_dinode(struct gfs2_inod
 
 	di->__pad1 = 0;
 	di->di_payload_format = cpu_to_be32(S_ISDIR(mode) ? GFS2_FORMAT_DE : 0);
-	di->di_height = cpu_to_be32(0);
+	di->di_height = 0;
 	di->__pad2 = 0;
 	di->__pad3 = 0;
-	di->di_depth = cpu_to_be16(0);
-	di->di_entries = cpu_to_be32(0);
+	di->di_depth = 0;
+	di->di_entries = 0;
 	memset(&di->__pad4, 0, sizeof(di->__pad4));
-	di->di_eattr = cpu_to_be64(0);
+	di->di_eattr = 0;
 	memset(&di->di_reserved, 0, sizeof(di->di_reserved));
 
 	brelse(dibh);
-- 
1.4.1



