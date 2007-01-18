Return-Path: <linux-kernel-owner+w=401wt.eu-S1751045AbXARU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbXARU7l (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXARU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:59:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51675 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbXARU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:59:40 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       Eric Van Hensbergren <ericvh@gmail.com>
Subject: [RESEND][PATCH] 9p: fix rename return code
Date: Thu, 18 Jan 2007 14:56:40 -0600
Message-Id: <11691538004070-git-send-email-ericvh@gmail.com>
X-Mailer: git-send-email 1.5.0.rc1.gdf1b-dirty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9p doesn't handle renames between directories -- however, we were returning
EPERM instead of EXDEV when we detected this case.

Signed-off-by: Eric Van Hensbergren <ericvh@gmail.com>
---
 fs/9p/vfs_inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 18f26cd..05d30e8 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -767,7 +767,7 @@ v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	/* 9P can only handle file rename in the same directory */
 	if (memcmp(&olddirfid->qid, &newdirfid->qid, sizeof(newdirfid->qid))) {
 		dprintk(DEBUG_ERROR, "old dir and new dir are different\n");
-		retval = -EPERM;
+		retval = -EXDEV;
 		goto FreeFcallnBail;
 	}
 
-- 
1.5.0.rc1.gdf1b-dirty

