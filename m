Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992839AbWJUHNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992839AbWJUHNr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992840AbWJUHNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:13:47 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:18823 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992839AbWJUHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 23] autofs: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <6d99a91993946caa6b5e.1161411463@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:43 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, hpa@zytor.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the autofs filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

1 file changed, 2 insertions(+), 2 deletions(-)
fs/autofs/root.c |    4 ++--

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -45,7 +45,7 @@ static int autofs_root_readdir(struct fi
 	struct autofs_dir_ent *ent = NULL;
 	struct autofs_dirhash *dirhash;
 	struct autofs_sb_info *sbi;
-	struct inode * inode = filp->f_dentry->d_inode;
+	struct inode * inode = filp->f_path.dentry->d_inode;
 	off_t onr, nr;
 
 	lock_kernel();
@@ -557,7 +557,7 @@ static int autofs_root_ioctl(struct inod
 	case AUTOFS_IOC_SETTIMEOUT:
 		return autofs_get_set_timeout(sbi, argp);
 	case AUTOFS_IOC_EXPIRE:
-		return autofs_expire_run(inode->i_sb, sbi, filp->f_vfsmnt,
+		return autofs_expire_run(inode->i_sb, sbi, filp->f_path.mnt,
 					 argp);
 	default:
 		return -ENOSYS;


