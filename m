Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936296AbWLDMkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936296AbWLDMkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936272AbWLDMfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:35:21 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:63198 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936313AbWLDMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:13 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 08/35] struct path: make eCryptfs a user of struct path
Date: Mon,  4 Dec 2006 07:30:41 -0500
Message-Id: <11652354692470-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Convert eCryptfs dentry-vfsmount pairs in dentry private data to struct
path.

Cc: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---
 fs/ecryptfs/ecryptfs_kernel.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index f992533..870a65b 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -28,6 +28,7 @@
 
 #include <keys/user-type.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/scatterlist.h>
 
 /* Version verification for shared data structures w/ userspace */
@@ -227,8 +228,7 @@ struct ecryptfs_inode_info {
 /* dentry private data. Each dentry must keep track of a lower
  * vfsmount too. */
 struct ecryptfs_dentry_info {
-	struct dentry *wdi_dentry;
-	struct vfsmount *lower_mnt;
+	struct path lower_path;
 	struct ecryptfs_crypt_stat *crypt_stat;
 };
 
@@ -355,26 +355,26 @@ ecryptfs_set_dentry_private(struct dentr
 static inline struct dentry *
 ecryptfs_dentry_to_lower(struct dentry *dentry)
 {
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->wdi_dentry;
+	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
 }
 
 static inline void
 ecryptfs_set_dentry_lower(struct dentry *dentry, struct dentry *lower_dentry)
 {
-	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->wdi_dentry =
+	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry =
 		lower_dentry;
 }
 
 static inline struct vfsmount *
 ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
 {
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_mnt;
+	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt;
 }
 
 static inline void
 ecryptfs_set_dentry_lower_mnt(struct dentry *dentry, struct vfsmount *lower_mnt)
 {
-	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_mnt =
+	((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt =
 		lower_mnt;
 }
 
-- 
1.4.3.3

