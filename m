Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWCJOjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCJOjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWCJOjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:39:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:272 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751360AbWCJOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:39:52 -0500
Date: Fri, 10 Mar 2006 15:39:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] reiserfs/xattr_acl.c:reiserfs_get_acl(): make size an int
Message-ID: <20060310143950.GN21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker wasn't happy seeing a size_t compared with -ENODATA 
and -ENOSYS.

Since the only place where size is set is through the result of 
reiserfs_xattr_get() which is an int, we could simply make size an int.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/fs/reiserfs/xattr_acl.c.old	2006-03-10 15:30:47.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/fs/reiserfs/xattr_acl.c	2006-03-10 15:31:49.000000000 +0100
@@ -182,7 +182,7 @@ struct posix_acl *reiserfs_get_acl(struc
 {
 	char *name, *value;
 	struct posix_acl *acl, **p_acl;
-	size_t size;
+	int size;
 	int retval;
 	struct reiserfs_inode_info *reiserfs_i = REISERFS_I(inode);
 
@@ -206,7 +206,7 @@ struct posix_acl *reiserfs_get_acl(struc
 		return posix_acl_dup(*p_acl);
 
 	size = reiserfs_xattr_get(inode, name, NULL, 0);
-	if ((int)size < 0) {
+	if (size < 0) {
 		if (size == -ENODATA || size == -ENOSYS) {
 			*p_acl = ERR_PTR(-ENODATA);
 			return NULL;

