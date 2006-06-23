Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933003AbWFWKzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbWFWKzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWFWKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:55:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2572 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933003AbWFWKzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:33 -0400
Date: Fri, 23 Jun 2006 12:55:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/ufs/inode.c: make 2 functions static
Message-ID: <20060623105533.GK9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ufs/inode.c         |    9 ++++++---
 include/linux/ufs_fs.h |    2 --
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.17-mm1-full/include/linux/ufs_fs.h.old	2006-06-22 16:52:18.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/ufs_fs.h	2006-06-22 16:53:11.000000000 +0200
@@ -973,13 +973,11 @@
 extern struct inode * ufs_new_inode (struct inode *, int);
 
 /* inode.c */
-extern u64  ufs_frag_map (struct inode *, sector_t);
 extern void ufs_read_inode (struct inode *);
 extern void ufs_put_inode (struct inode *);
 extern int ufs_write_inode (struct inode *, int);
 extern int ufs_sync_inode (struct inode *);
 extern void ufs_delete_inode (struct inode *);
-extern struct buffer_head * ufs_getfrag (struct inode *, unsigned, int, int *);
 extern struct buffer_head * ufs_bread (struct inode *, unsigned, int, int *);
 extern int ufs_getfrag_block (struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create);
 
--- linux-2.6.17-mm1-full/fs/ufs/inode.c.old	2006-06-22 16:52:31.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/ufs/inode.c	2006-06-22 16:55:15.000000000 +0200
@@ -41,6 +41,8 @@
 #include "swab.h"
 #include "util.h"
 
+static u64 ufs_frag_map(struct inode *inode, sector_t frag);
+
 static int ufs_block_to_path(struct inode *inode, sector_t i_block, sector_t offsets[4])
 {
 	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
@@ -80,7 +82,7 @@
  * the begining of the filesystem.
  */
 
-u64  ufs_frag_map(struct inode *inode, sector_t frag)
+static u64 ufs_frag_map(struct inode *inode, sector_t frag)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -514,8 +516,9 @@
 	goto abort;
 }
 
-struct buffer_head *ufs_getfrag(struct inode *inode, unsigned int fragment,
-				int create, int *err)
+static struct buffer_head *ufs_getfrag(struct inode *inode,
+				       unsigned int fragment,
+				       int create, int *err)
 {
 	struct buffer_head dummy;
 	int error;

