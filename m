Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbSIWMve>; Mon, 23 Sep 2002 08:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbSIWMve>; Mon, 23 Sep 2002 08:51:34 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:56989 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261653AbSIWMvc>; Mon, 23 Sep 2002 08:51:32 -0400
Date: Mon, 23 Sep 2002 07:56:25 -0500
From: David Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200209231256.g8NCuPbx001961@kleikamp.austin.ibm.com>
To: marcelo@conectiva.com.br
Subject: [PATCH] JFS: Fix compiler errors in xattr.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch can be pulled from bk://jfs.bkbits.net/linux-2.4

JFS won't compile without this fix.  I had unintentionally pushed some
changes to the BK tree you pulled from.  I hadn't pushed this one,
thinking the earlier ones weren't there.  Please take this one ASAP.

Thanks,
Shaggy

--------------------------------------------------------------
ChangeSet@1.661.1.8, 2002-09-20 15:38:11-05:00, shaggy@kleikamp.austin.ibm.com
  JFS: Fix compiler errors in xattr.c
  
  Fix errors due to header differences between mainline kernel and
  acl.bestbits.org patches.

 fs/jfs/xattr.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
--------------------------------------------------------------

diff -Nru a/fs/jfs/xattr.c b/fs/jfs/xattr.c
--- a/fs/jfs/xattr.c	Mon Sep 23 07:42:33 2002
+++ b/fs/jfs/xattr.c	Mon Sep 23 07:42:33 2002
@@ -640,7 +640,7 @@
 }
 
 static int can_set_xattr(struct inode *inode, const char *name,
-			 const void *value, size_t value_len)
+			 void *value, size_t value_len)
 {
 	if (IS_RDONLY(inode))
 		return -EROFS;
@@ -650,7 +650,7 @@
 
 	if((strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) != 0) &&
 	   (strncmp(name, XATTR_OS2_PREFIX, XATTR_OS2_PREFIX_LEN) != 0))
-		return -ENOTSUP;
+		return -EOPNOTSUPP;
 
 	if (!S_ISREG(inode->i_mode) &&
 	    (!S_ISDIR(inode->i_mode) || inode->i_mode &S_ISVTX))
@@ -659,7 +659,7 @@
 	return permission(inode, MAY_WRITE);
 }
 
-int __jfs_setxattr(struct inode *inode, const char *name, const void *value,
+int __jfs_setxattr(struct inode *inode, const char *name, void *value,
 		   size_t value_len, int flags)
 {
 	struct jfs_ea_list *ealist;
@@ -798,7 +798,7 @@
 	return rc;
 }
 
-int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+int jfs_setxattr(struct dentry *dentry, const char *name, void *value,
 		 size_t value_len, int flags)
 {
 	if (value == NULL) {	/* empty EA, do not remove */
