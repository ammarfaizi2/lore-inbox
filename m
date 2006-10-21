Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992835AbWJUHUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992835AbWJUHUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992845AbWJUHUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:20:50 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:22919 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992840AbWJUHNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:48 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 23] affs: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <cc65ab5d80e077921828.1161411462@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:42 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the affs filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

1 file changed, 2 insertions(+), 2 deletions(-)
fs/affs/dir.c |    4 ++--

diff --git a/fs/affs/dir.c b/fs/affs/dir.c
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -41,7 +41,7 @@ static int
 static int
 affs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
-	struct inode		*inode = filp->f_dentry->d_inode;
+	struct inode		*inode = filp->f_path.dentry->d_inode;
 	struct super_block	*sb = inode->i_sb;
 	struct buffer_head	*dir_bh;
 	struct buffer_head	*fh_bh;
@@ -71,7 +71,7 @@ affs_readdir(struct file *filp, void *di
 		stored++;
 	}
 	if (f_pos == 1) {
-		if (filldir(dirent, "..", 2, f_pos, parent_ino(filp->f_dentry), DT_DIR) < 0)
+		if (filldir(dirent, "..", 2, f_pos, parent_ino(filp->f_path.dentry), DT_DIR) < 0)
 			return stored;
 		filp->f_pos = f_pos = 2;
 		stored++;


