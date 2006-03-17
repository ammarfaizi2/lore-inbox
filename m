Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWCQTKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWCQTKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWCQTKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:10:07 -0500
Received: from hera.kernel.org ([140.211.167.34]:37785 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030264AbWCQTKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:10:06 -0500
Date: Fri, 17 Mar 2006 19:10:01 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603171910.k2HJA1P6006243@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: fix vfs inode derefrence before NULL check
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Fix vfs_inode dereference before NULL check
From: Eugene Teo <eugene.teo@eugeneteo.net>
Date: 1142478004 +0800

__getname, which in turn will call kmem_cache_alloc, may return NULL.

Coverity bug #977

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/vfs_inode.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

f59413fce41e7979075143d1a8b1d0359c4210bf
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3ad8455..3438e6a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1254,6 +1254,8 @@ v9fs_vfs_mknod(struct inode *dir, struct
 		return -EINVAL;
 
 	name = __getname();
+	if (!name)
+		return -EINVAL;
 	/* build extension */
 	if (S_ISBLK(mode))
 		sprintf(name, "b %u %u", MAJOR(rdev), MINOR(rdev));
-- 
1.1.0
