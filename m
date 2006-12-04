Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936294AbWLDMkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936294AbWLDMkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936272AbWLDMkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:40:23 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:2271 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936294AbWLDMfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:22 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 11/35] fsstack: Fix up ecryptfs's fsstack usage
Date: Mon,  4 Dec 2006 07:30:44 -0500
Message-Id: <11652354693808-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Fix up a stray ecryptfs_copy_attr_all call and remove prototypes for
ecryptfs_copy_* as they no longer exist.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---
 fs/ecryptfs/dentry.c          |    2 +-
 fs/ecryptfs/ecryptfs_kernel.h |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 52d1e36..b0352d8 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -61,7 +61,7 @@ static int ecryptfs_d_revalidate(struct
 		struct inode *lower_inode =
 			ecryptfs_inode_to_lower(dentry->d_inode);
 
-		ecryptfs_copy_attr_all(dentry->d_inode, lower_inode);
+		fsstack_copy_attr_all(dentry->d_inode, lower_inode, NULL);
 	}
 out:
 	return rc;
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 870a65b..afb64bd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -28,6 +28,7 @@
 
 #include <keys/user-type.h>
 #include <linux/fs.h>
+#include <linux/fs_stack.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
 
@@ -413,9 +414,6 @@ int ecryptfs_encode_filename(struct ecry
 			     const char *name, int length,
 			     char **encoded_name);
 struct dentry *ecryptfs_lower_dentry(struct dentry *this_dentry);
-void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src);
-void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src);
-void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src);
 void ecryptfs_dump_hex(char *data, int bytes);
 int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
 			int sg_size);
-- 
1.4.3.3

