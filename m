Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVAFWu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVAFWu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVAFWuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:50:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57102 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263059AbVAFWrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:47:37 -0500
Date: Thu, 6 Jan 2005 23:47:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ext2/xattr.c: make ext2_xattr_list static
Message-ID: <20050106224734.GE28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the needlessly global function ext2_xattr_list 
static.


diffstat output:
 fs/ext2/xattr.c |   24 ++++++++++++------------
 fs/ext2/xattr.h |    7 -------
 2 files changed, 12 insertions(+), 19 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/ext2/xattr.h.old	2005-01-06 23:17:14.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext2/xattr.h	2005-01-06 23:17:27.000000000 +0100
@@ -66,7 +66,6 @@
 extern ssize_t ext2_listxattr(struct dentry *, char *, size_t);
 
 extern int ext2_xattr_get(struct inode *, int, const char *, void *, size_t);
-extern int ext2_xattr_list(struct inode *, char *, size_t);
 extern int ext2_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
 
 extern void ext2_xattr_delete_inode(struct inode *);
@@ -87,12 +86,6 @@
 }
 
 static inline int
-ext2_xattr_list(struct inode *inode, char *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int
 ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	       const void *value, size_t size, int flags)
 {
--- linux-2.6.10-mm2-full/fs/ext2/xattr.c.old	2005-01-06 23:17:35.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/ext2/xattr.c	2005-01-06 23:18:22.000000000 +0100
@@ -137,17 +137,6 @@
 }
 
 /*
- * Inode operation listxattr()
- *
- * dentry->d_inode->i_sem: don't care
- */
-ssize_t
-ext2_listxattr(struct dentry *dentry, char *buffer, size_t size)
-{
-	return ext2_xattr_list(dentry->d_inode, buffer, size);
-}
-
-/*
  * ext2_xattr_get()
  *
  * Copy an extended attribute into the buffer
@@ -260,7 +249,7 @@
  * Returns a negative error number on failure, or the number of bytes
  * used / required on success.
  */
-int
+static int
 ext2_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
@@ -335,6 +324,17 @@
 }
 
 /*
+ * Inode operation listxattr()
+ *
+ * dentry->d_inode->i_sem: don't care
+ */
+ssize_t
+ext2_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	return ext2_xattr_list(dentry->d_inode, buffer, size);
+}
+
+/*
  * If the EXT2_FEATURE_COMPAT_EXT_ATTR feature of this file system is
  * not set, set it.
  */

