Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936306AbWLDMfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936306AbWLDMfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936279AbWLDMej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:34:39 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45534 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936275AbWLDMee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:34:34 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 07/35] struct path: Move struct path from fs/namei.c into include/linux
Date: Mon,  4 Dec 2006 07:30:40 -0500
Message-Id: <11652354691570-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Moved struct path from fs/namei.c to include/linux/namei.h. This allows many
places in the VFS, as well as any stackable filesystem to easily keep track
of dentry-vfsmount pairs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---
 fs/namei.c            |    5 -----
 include/linux/namei.h |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 28d49b3..8a7b923 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -570,11 +570,6 @@ fail:
 	return PTR_ERR(link);
 }
 
-struct path {
-	struct vfsmount *mnt;
-	struct dentry *dentry;
-};
-
 static inline void dput_path(struct path *path, struct nameidata *nd)
 {
 	dput(path->dentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index f5f1960..d39a5a6 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -29,6 +29,11 @@ struct nameidata {
 	} intent;
 };
 
+struct path {
+	struct vfsmount *mnt;
+	struct dentry *dentry;
+};
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */
-- 
1.4.3.3

