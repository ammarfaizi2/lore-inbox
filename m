Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWCPWn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWCPWn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWCPWn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:43:57 -0500
Received: from hera.kernel.org ([140.211.167.34]:61844 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964883AbWCPWn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:43:57 -0500
Date: Thu, 16 Mar 2006 22:43:27 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603162243.k2GMhRRh030701@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: fix overzealous dropping of dentry
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: fix overzealous dropping of dentry which breaks dcache

There was a d_drop in dir_release which caused problems as it
invalidated dcache entries too soon.  This was likely a part of
the wierd cwd behavior folks were seeing.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/vfs_dir.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

bd84607c9914674d9415a22e9bc1237f0edd74de
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index ae6d032..cd5eeb0 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -202,7 +202,6 @@ int v9fs_dir_release(struct inode *inode
 		filp->private_data = NULL;
 	}
 
-	d_drop(filp->f_dentry);
 	return 0;
 }
 
-- 
1.1.0
