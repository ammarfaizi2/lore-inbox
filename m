Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992891AbWJUHP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992891AbWJUHP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992889AbWJUHPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:15:01 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:26759 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992856AbWJUHOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 23] ntfs: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <d097ea981bb2c47298ab.1161411456@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:36 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, aia21@cantab.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the ntfs filesystem code.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 4 insertions(+), 4 deletions(-)
fs/ntfs/dir.c  |    6 +++---
fs/ntfs/file.c |    2 +-

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1101,7 +1101,7 @@ static int ntfs_readdir(struct file *fil
 {
 	s64 ia_pos, ia_start, prev_ia_pos, bmp_pos;
 	loff_t fpos, i_size;
-	struct inode *bmp_vi, *vdir = filp->f_dentry->d_inode;
+	struct inode *bmp_vi, *vdir = filp->f_path.dentry->d_inode;
 	struct super_block *sb = vdir->i_sb;
 	ntfs_inode *ndir = NTFS_I(vdir);
 	ntfs_volume *vol = NTFS_SB(sb);
@@ -1136,9 +1136,9 @@ static int ntfs_readdir(struct file *fil
 	if (fpos == 1) {
 		ntfs_debug("Calling filldir for .. with len 2, fpos 0x1, "
 				"inode 0x%lx, DT_DIR.",
-				(unsigned long)parent_ino(filp->f_dentry));
+				(unsigned long)parent_ino(filp->f_path.dentry));
 		rc = filldir(dirent, "..", 2, fpos,
-				parent_ino(filp->f_dentry), DT_DIR);
+				parent_ino(filp->f_path.dentry), DT_DIR);
 		if (rc)
 			goto done;
 		fpos++;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -2162,7 +2162,7 @@ static ssize_t ntfs_file_aio_write_noloc
 		goto out;
 	if (!count)
 		goto out;
-	err = remove_suid(file->f_dentry);
+	err = remove_suid(file->f_path.dentry);
 	if (err)
 		goto out;
 	file_update_time(file);


