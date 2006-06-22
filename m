Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWFVWJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWFVWJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVWJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:09:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:10179 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751902AbWFVWJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:09:48 -0400
Date: Thu, 22 Jun 2006 17:09:45 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eCryptfs: Remove debugging cruft
Message-ID: <20060622220945.GD2817@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We let a few debugging statements slip into patch
``ecryptfs-more-intelligent-use-of-tfm-objects''. This patch removes
some extra printk's in the log on mount and unmount.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |    1 -
 fs/ecryptfs/main.c   |    3 ---
 fs/ecryptfs/super.c  |    1 -
 3 files changed, 0 insertions(+), 5 deletions(-)

2d3209f0eb0011f12115d50283b9728e5045a9d1
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 626a4c7..427f470 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -186,7 +186,6 @@ void ecryptfs_destruct_crypt_stat(struct
 void ecryptfs_destruct_mount_crypt_stat(
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat)
 {
-	printk(KERN_INFO "%s\n", __FUNCTION__);
 	if (mount_crypt_stat->global_auth_tok_key)
 		key_put(mount_crypt_stat->global_auth_tok_key);
 	if (mount_crypt_stat->global_key_tfm)
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 7598ba0..3592834 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -536,9 +536,6 @@ out:
  */
 static void ecryptfs_kill_block_super(struct super_block *sb)
 {
-	printk(KERN_INFO "%s\n", __FUNCTION__);
-/*	ecryptfs_destruct_mount_crypt_stat(
-	&(ecryptfs_superblock_to_private(sb)->mount_crypt_stat)); */
 	generic_shutdown_super(sb);
 }
 
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index b60bf07..afca9c6 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -108,7 +108,6 @@ static void ecryptfs_put_super(struct su
 {
 	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
 
-	printk(KERN_INFO "%s\n", __FUNCTION__);
 	mntput(sb_info->lower_mnt);
 	ecryptfs_destruct_mount_crypt_stat(&sb_info->mount_crypt_stat);
 	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
-- 
1.3.3

