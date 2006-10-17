Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWJQWjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWJQWjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWJQWjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:39:43 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:21917 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750855AbWJQWjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:39:43 -0400
Date: Tue, 17 Oct 2006 18:39:35 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mhalcrow@us.ibm.com
Subject: [PATCH][-mm] fsstack: Fix up eCryptfs compilation
Message-ID: <20061017223935.GA2319@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

The fsstack tidy patch broke eCryptfs. This patch makes eCryptfs compile
again.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

diff -r 2187c6b08f02 fs/ecryptfs/inode.c
--- a/fs/ecryptfs/inode.c	Tue Oct 17 18:26:24 2006 -0400
+++ b/fs/ecryptfs/inode.c	Tue Oct 17 18:29:43 2006 -0400
@@ -621,9 +621,9 @@ ecryptfs_rename(struct inode *old_dir, s
 			lower_new_dir_dentry->d_inode, lower_new_dentry);
 	if (rc)
 		goto out_lock;
-	fsstack_copy_attr_all(new_dir, lower_new_dir_dentry->d_inode);
+	fsstack_copy_attr_all(new_dir, lower_new_dir_dentry->d_inode, NULL);
 	if (new_dir != old_dir)
-		fsstack_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
+		fsstack_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode, NULL);
 out_lock:
 	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
 	dput(lower_new_dentry);
@@ -908,7 +908,7 @@ static int ecryptfs_setattr(struct dentr
 	}
 	rc = notify_change(lower_dentry, ia);
 out:
-	fsstack_copy_attr_all(inode, lower_inode);
+	fsstack_copy_attr_all(inode, lower_inode, NULL);
 	return rc;
 }
 
diff -r 2187c6b08f02 fs/ecryptfs/main.c
--- a/fs/ecryptfs/main.c	Tue Oct 17 18:26:24 2006 -0400
+++ b/fs/ecryptfs/main.c	Tue Oct 17 18:31:29 2006 -0400
@@ -116,7 +116,7 @@ int ecryptfs_interpose(struct dentry *lo
 		d_add(dentry, inode);
 	else
 		d_instantiate(dentry, inode);
-	fsstack_copy_attr_all(inode, lower_inode);
+	fsstack_copy_attr_all(inode, lower_inode, NULL);
 	/* This size will be overwritten for real files w/ headers and
 	 * other metadata */
 	fsstack_copy_inode_size(inode, lower_inode);
