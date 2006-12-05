Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968650AbWLETWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968650AbWLETWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968653AbWLETWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:22:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54746 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968650AbWLETWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:22:36 -0500
Date: Tue, 5 Dec 2006 14:22:32 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fsstack: Fix up ecryptfs's fsstack usage
Message-ID: <20061205192231.GD2240@filer.fsl.cs.sunysb.edu>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205191824.GB2240@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205191824.GB2240@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

