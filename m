Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWFVO0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWFVO0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWFVOZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:25:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751805AbWFVOZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:25:17 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/4] XFS: Use the dentry passed to statfs() to limit the scope of the results [try #3]
Date: Thu, 22 Jun 2006 15:24:08 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Message-Id: <20060622142408.10982.56925.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060622142358.10982.23148.stgit@warthog.cambridge.redhat.com>
References: <20060622142358.10982.23148.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch enables XFS to limit the statfs() results to the project
quota covering the dentry used as a base for call.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/xfs/linux-2.6/xfs_super.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index 4fb0fc6..9bdef9d 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -687,7 +687,8 @@ xfs_fs_statfs(
 	struct dentry		*dentry,
 	struct kstatfs		*statp)
 {
-	return -bhv_vfs_statvfs(vfs_from_sb(dentry->d_sb), statp, NULL);
+	return -bhv_vfs_statvfs(vfs_from_sb(dentry->d_sb), statp,
+				vn_from_inode(dentry->d_inode));
 }
 
 STATIC int

