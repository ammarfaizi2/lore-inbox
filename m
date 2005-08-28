Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVH1VfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVH1VfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVH1VfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:35:23 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:25032 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750762AbVH1VfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:35:22 -0400
Subject: PATCH 2.6.13-rc7-mm1] v9fs: adjust follow_link and put_link to
	match new VFS API
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 16:35:05 -0500
Message-Id: <1125264905.17501.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: adjust follow_link and put_link to match new VFS API

In 2.6.13-rc7 the prototypes for follow_link and put_link were changed
to include support for a cookie to help reclaim resources.  This patch
adjusts their definitions in the v9fs implementation.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 30bdd61e96418043a07d2da71bcd757a0341113f
tree 3e268ece4b911b960b47b47182972d8f439667da
parent e189afc5ed8102a56f74cb5be91a6bf3e478a06a
author Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005 16:33:42
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005
16:33:42 -0500

 fs/9p/vfs_inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1089,7 +1089,7 @@ static int v9fs_vfs_readlink(struct dent
  *
  */
 
-static int v9fs_vfs_follow_link(struct dentry *dentry, struct nameidata
*nd)
+static void *v9fs_vfs_follow_link(struct dentry *dentry, struct
nameidata *nd)
 {
 	int len = 0;
 	char *link = __getname();
@@ -1109,7 +1109,7 @@ static int v9fs_vfs_follow_link(struct d
 	}
 	nd_set_link(nd, link);
 
-	return 0;
+	return NULL;
 }
 
 /**
@@ -1119,7 +1119,7 @@ static int v9fs_vfs_follow_link(struct d
  *
  */
 
-static void v9fs_vfs_put_link(struct dentry *dentry, struct nameidata
*nd)
+static void v9fs_vfs_put_link(struct dentry *dentry, struct nameidata
*nd, void *p)
 {
 	char *s = nd_get_link(nd);
 


