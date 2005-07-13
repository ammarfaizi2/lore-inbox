Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVGMSDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVGMSDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVGMSDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:18 -0400
Received: from [151.97.230.9] ([151.97.230.9]:16108 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261360AbVGMSAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:33 -0400
Subject: [patch 8/9] uml - hostfs : unuse ROOT_DEV 
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       hch@infradead.org
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:38 +0200
Message-Id: <20050713180239.2C99021E742@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Christoph Hellwig <hch@infradead.org>

Minimal patch removing uses of ROOT_DEV; next patch unexports it. I've opposed
this, but I've planned to reintroduce the functionality without using
ROOT_DEV.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/fs/hostfs/hostfs_kern.c |    9 ---------
 1 files changed, 9 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-remove-root_dev-simple fs/hostfs/hostfs_kern.c
--- linux-2.6.git-broken/fs/hostfs/hostfs_kern.c~uml-hostfs-remove-root_dev-simple	2005-07-13 19:58:18.000000000 +0200
+++ linux-2.6.git-broken-paolo/fs/hostfs/hostfs_kern.c	2005-07-13 19:58:18.000000000 +0200
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/list.h>
-#include <linux/root_dev.h>
 #include <linux/statfs.h>
 #include <linux/kdev_t.h>
 #include <asm/uaccess.h>
@@ -160,8 +159,6 @@ static int read_name(struct inode *ino, 
 	ino->i_size = i_size;
 	ino->i_blksize = i_blksize;
 	ino->i_blocks = i_blocks;
-	if((ino->i_sb->s_dev == ROOT_DEV) && (ino->i_uid == getuid()))
-		ino->i_uid = 0;
 	return(0);
 }
 
@@ -841,16 +838,10 @@ int hostfs_setattr(struct dentry *dentry
 		attrs.ia_mode = attr->ia_mode;
 	}
 	if(attr->ia_valid & ATTR_UID){
-		if((dentry->d_inode->i_sb->s_dev == ROOT_DEV) &&
-		   (attr->ia_uid == 0))
-			attr->ia_uid = getuid();
 		attrs.ia_valid |= HOSTFS_ATTR_UID;
 		attrs.ia_uid = attr->ia_uid;
 	}
 	if(attr->ia_valid & ATTR_GID){
-		if((dentry->d_inode->i_sb->s_dev == ROOT_DEV) &&
-		   (attr->ia_gid == 0))
-			attr->ia_gid = getgid();
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
 		attrs.ia_gid = attr->ia_gid;
 	}
_
