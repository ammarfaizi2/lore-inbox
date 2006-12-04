Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936335AbWLDMiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936335AbWLDMiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936395AbWLDMiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:38:00 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:19679 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936313AbWLDMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:36:17 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com
Subject: [PATCH 02/35] fsstack: Remove unneeded wrapper
Date: Mon,  4 Dec 2006 07:30:35 -0500
Message-Id: <11652354682199-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Remove unneeded wrapper.

Cc: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 fs/stack.c               |   10 ++++------
 include/linux/fs_stack.h |   12 ++----------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/stack.c b/fs/stack.c
index 5f6f12d..03987f2 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -11,13 +11,13 @@ void fsstack_copy_inode_size(struct inod
 	i_size_write(dst, i_size_read((struct inode *)src));
 	dst->i_blocks = src->i_blocks;
 }
+EXPORT_SYMBOL_GPL(fsstack_copy_inode_size);
 
 /* copy all attributes; get_nlinks is optional way to override the i_nlink
  * copying
  */
-void __fsstack_copy_attr_all(struct inode *dest,
-			     const struct inode *src,
-			     int (*get_nlinks)(struct inode *))
+void fsstack_copy_attr_all(struct inode *dest, const struct inode *src,
+				int (*get_nlinks)(struct inode *))
 {
 	if (!get_nlinks)
 		dest->i_nlink = src->i_nlink;
@@ -34,6 +34,4 @@ void __fsstack_copy_attr_all(struct inod
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
 }
-
-EXPORT_SYMBOL_GPL(fsstack_copy_inode_size);
-EXPORT_SYMBOL_GPL(__fsstack_copy_attr_all);
+EXPORT_SYMBOL_GPL(fsstack_copy_attr_all);
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 56b3e09..bb516ce 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -8,9 +8,8 @@
 #include <linux/fs.h>
 
 /* externs for fs/stack.c */
-extern void __fsstack_copy_attr_all(struct inode *dest,
-				    const struct inode *src,
-				    int (*get_nlinks)(struct inode *));
+extern void fsstack_copy_attr_all(struct inode *dest, const struct inode *src,
+				int (*get_nlinks)(struct inode *));
 
 extern void fsstack_copy_inode_size(struct inode *dst, const struct inode *src);
 
@@ -29,11 +28,4 @@ static inline void fsstack_copy_attr_tim
 	dest->i_ctime = src->i_ctime;
 }
 
-static inline void fsstack_copy_attr_all(struct inode *dest,
-					 const struct inode *src)
-{
-	__fsstack_copy_attr_all(dest, src, NULL);
-}
-
 #endif /* _LINUX_FS_STACK_H */
-
-- 
1.4.3.3

