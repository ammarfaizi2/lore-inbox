Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWJSBsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWJSBsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945971AbWJSBsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:48:36 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:16105 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1945967AbWJSBsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:48:31 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 4] struct path: make eCryptfs a user of struct path
Message-Id: <df6379bb85af6916b4af.1161219431@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161219427@thor.fsl.cs.sunysb.edu>
Date: Wed, 18 Oct 2006 20:57:11 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, chris.mason@oracle.com,
       ezk@cs.sunysb.edu, penberg@cs.helsinki.fi, dm-devel@redhat.com,
       mingo@redhat.com, reiserfs-dev@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Convert eCryptfs dentry-vfsmount pairs in dentry private data to struct
path.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

1 file changed, 6 insertions(+), 6 deletions(-)
fs/ecryptfs/ecryptfs_kernel.h |   12 ++++++------

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -28,6 +28,7 @@
 
 #include <keys/user-type.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/scatterlist.h>
 
 /* Version verification for shared data structures w/ userspace */
@@ -226,8 +227,7 @@ struct ecryptfs_inode_info {
 /* dentry private data. Each dentry must keep track of a lower
  * vfsmount too. */
 struct ecryptfs_dentry_info {
-	struct dentry *wdi_dentry;
-	struct vfsmount *lower_mnt;
+	struct path lower_path;
 	struct ecryptfs_crypt_stat *crypt_stat;
 };
 
@@ -354,26 +354,26 @@ static inline struct dentry *
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
 


