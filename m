Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUIMOCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUIMOCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUIMOCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:02:35 -0400
Received: from verein.lst.de ([213.95.11.210]:17102 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266786AbUIMOCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:02:31 -0400
Date: Mon, 13 Sep 2004 16:02:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix reiser4 compilation for ->permission changes
Message-ID: <20040913140226.GA23510@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove reiser4 permission.  It only ends up calling generic_permission
with no additional bits so it's completely unessecary.


--- reiser4/fs/reiser4/inode_ops.c~	2004-09-13 16:01:33.692057520 +0200
+++ reiser4/fs/reiser4/inode_ops.c	2004-09-13 16:01:48.759766880 +0200
@@ -64,7 +64,6 @@
 static int reiser4_readlink(struct dentry *, char *, int);
 static int reiser4_follow_link(struct dentry *, struct nameidata *);
 static void reiser4_truncate(struct inode *);
-static int reiser4_permission(struct inode *, int, struct nameidata *);
 static int reiser4_setattr(struct dentry *, struct iattr *);
 static int reiser4_getattr(struct vfsmount *mnt, struct dentry *, struct kstat *);
 
@@ -394,22 +393,6 @@
 	reiser4_exit_context(&ctx);
 }
 
-/* ->permission() method in reiser4_inode_operations. */
-static int
-reiser4_permission(struct inode *inode /* object */ ,
-		   int mask,	/* mode bits to check permissions
-				 * for */
-		   struct nameidata *nameidata)
-{
-	/* reiser4_context creation/destruction removed from here,
-	   because permission checks currently don't require this.
-
-	   Permission plugin have to create context itself if necessary. */
-	assert("nikita-1687", inode != NULL);
-
-	return perm_chk(inode, mask, inode, mask);
-}
-
 /* common part of both unlink and rmdir. */
 static int
 unlink_file(struct inode *parent /* parent directory */ ,
@@ -615,7 +598,6 @@
 	.readlink = NULL,
 	.follow_link = NULL,
 	.truncate = reiser4_truncate,	/* d */
-	.permission = reiser4_permission,	/* d */
 	.setattr = reiser4_setattr,	/* d */
 	.getattr = reiser4_getattr,	/* d */
 };
