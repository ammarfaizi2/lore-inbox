Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936382AbWK3MWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936382AbWK3MWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936358AbWK3MWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:22:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936368AbWK3MWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:22:02 -0500
Subject: [GFS2] mark_inode_dirty after write to stuffed file [55/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:21:48 +0000
Message-Id: <1164889308.3752.415.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From ae619320b22f8e0b2bbe4a3a5ac2f9ccf08d7ec2 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 22 Nov 2006 11:28:47 -0500
Subject: [PATCH] [GFS2] mark_inode_dirty after write to stuffed file

Writes to stuffed files were not being marked dirty correctly.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/ops_address.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
index 8676c39..d8d69a7 100644
--- a/fs/gfs2/ops_address.c
+++ b/fs/gfs2/ops_address.c
@@ -472,8 +472,10 @@ static int gfs2_commit_write(struct file
 
 		SetPageUptodate(page);
 
-		if (inode->i_size < file_size)
+		if (inode->i_size < file_size) {
 			i_size_write(inode, file_size);
+			mark_inode_dirty(inode);
+		}
 	} else {
 		if (sdp->sd_args.ar_data == GFS2_DATA_ORDERED ||
 		    gfs2_is_jdata(ip))
-- 
1.4.1



