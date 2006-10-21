Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992885AbWJUHPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992885AbWJUHPM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992847AbWJUHPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:15:08 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:25991 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992854AbWJUHOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:31 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 08 of 23] isofs: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <15a2d7465501c952a2af.1161411453@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:33 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the isofs filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 3 insertions(+), 4 deletions(-)
fs/isofs/compress.c |    2 +-
fs/isofs/dir.c      |    5 ++---

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -42,7 +42,7 @@ static struct semaphore zisofs_zlib_sema
  */
 static int zisofs_readpage(struct file *file, struct page *page)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
 	unsigned int maxpage, xpage, fpage, blockindex;
 	unsigned long offset;
diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -183,7 +183,7 @@ static int do_isofs_readdir(struct inode
 
 		/* Handle the case of the '..' directory */
 		if (de->name_len[0] == 1 && de->name[0] == 1) {
-			inode_number = parent_ino(filp->f_dentry);
+			inode_number = parent_ino(filp->f_path.dentry);
 			if (filldir(dirent, "..", 2, filp->f_pos, inode_number, DT_DIR) < 0)
 				break;
 			filp->f_pos += de_len;
@@ -255,8 +255,7 @@ static int isofs_readdir(struct file *fi
 	int result;
 	char * tmpname;
 	struct iso_directory_record * tmpde;
-	struct inode *inode = filp->f_dentry->d_inode;
-
+	struct inode *inode = filp->f_path.dentry->d_inode;
 
 	tmpname = (char *)__get_free_page(GFP_KERNEL);
 	if (tmpname == NULL)


