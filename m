Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945963AbWJSBrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945963AbWJSBrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWJSBrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:47:52 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:10473 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1945960AbWJSBrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:47:51 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 4] struct path: Move struct path from fs/namei.c into
	include/linux
Message-Id: <17ebaa342f0525a5f34e.1161219430@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161219427@thor.fsl.cs.sunysb.edu>
Date: Wed, 18 Oct 2006 20:57:10 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, chris.mason@oracle.com,
       ezk@cs.sunysb.edu, penberg@cs.helsinki.fi, dm-devel@redhat.com,
       mingo@redhat.com, reiserfs-dev@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Moved struct path from fs/namei.c to include/linux/namei.h. This allows many
places in the VFS, as well as any stackable filesystem to easily keep track
of dentry-vfsmount pairs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 5 insertions(+), 5 deletions(-)
fs/namei.c            |    5 -----
include/linux/namei.h |    5 +++++

diff --git a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -569,11 +569,6 @@ fail:
 	path_release(nd);
 	return PTR_ERR(link);
 }
-
-struct path {
-	struct vfsmount *mnt;
-	struct dentry *dentry;
-};
 
 static inline void dput_path(struct path *path, struct nameidata *nd)
 {
diff --git a/include/linux/namei.h b/include/linux/namei.h
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -27,6 +27,11 @@ struct nameidata {
 	union {
 		struct open_intent open;
 	} intent;
+};
+
+struct path {
+	struct vfsmount *mnt;
+	struct dentry *dentry;
 };
 
 /*


