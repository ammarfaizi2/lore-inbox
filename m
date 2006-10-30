Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161545AbWJ3XiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161545AbWJ3XiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161548AbWJ3XiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:38:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:7311 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161545AbWJ3XiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:38:19 -0500
Date: Mon, 30 Oct 2006 17:38:18 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com
Subject: [PATCH 5/6] eCryptfs: Remove ecryptfs_umount_begin
Message-ID: <20061030233818.GD21515@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233209.GC3458@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to calling the lower umount_begin when the eCryptfs
umount_begin is called.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/super.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

fc8b627f3b892266ac9a17e011396130ab8f6ddf
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index c337c04..825757a 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -138,23 +138,6 @@ static void ecryptfs_clear_inode(struct 
 }
 
 /**
- * ecryptfs_umount_begin
- *
- * Called in do_umount().
- */
-static void ecryptfs_umount_begin(struct vfsmount *vfsmnt, int flags)
-{
-	struct vfsmount *lower_mnt =
-		ecryptfs_dentry_to_lower_mnt(vfsmnt->mnt_sb->s_root);
-	struct super_block *lower_sb;
-
-	mntput(lower_mnt);
-	lower_sb = lower_mnt->mnt_sb;
-	if (lower_sb->s_op->umount_begin)
-		lower_sb->s_op->umount_begin(lower_mnt, flags);
-}
-
-/**
  * ecryptfs_show_options
  *
  * Prints the directory we are currently mounted over.
@@ -193,6 +176,5 @@ struct super_operations ecryptfs_sops = 
 	.statfs = ecryptfs_statfs,
 	.remount_fs = NULL,
 	.clear_inode = ecryptfs_clear_inode,
-	.umount_begin = ecryptfs_umount_begin,
 	.show_options = ecryptfs_show_options
 };
-- 
1.3.3

