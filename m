Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992847AbWJUHPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992847AbWJUHPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992892AbWJUHPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:15:05 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:26247 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992847AbWJUHOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 04 of 23] ext2: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <286436231407f4e5422e.1161411449@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:29 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org,
       ext2-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the ext2 filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 2 insertions(+), 2 deletions(-)
fs/ext2/dir.c   |    2 +-
fs/ext2/ioctl.c |    2 +-

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -248,7 +248,7 @@ ext2_readdir (struct file * filp, void *
 ext2_readdir (struct file * filp, void * dirent, filldir_t filldir)
 {
 	loff_t pos = filp->f_pos;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
 	unsigned int offset = pos & ~PAGE_CACHE_MASK;
 	unsigned long n = pos >> PAGE_CACHE_SHIFT;
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -86,7 +86,7 @@ int ext2_ioctl (struct inode * inode, st
 #ifdef CONFIG_COMPAT
 long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	int ret;
 
 	/* These are just misnamed, they actually get/put from/to user an int */


