Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVF2HyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVF2HyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVF2Hwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:52:53 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26274 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262470AbVF2HvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:51:15 -0400
Date: Wed, 29 Jun 2005 10:51:07 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
In-Reply-To: <20050629072115.GA17261@infradead.org>
Message-ID: <Pine.LNX.4.58.0506291050180.12567@sbz-30.cs.Helsinki.FI>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
 <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
 <20050628163114.6594e1e1.akpm@osdl.org> <20050629070729.GB16850@infradead.org>
 <20050629001717.65fb272c.akpm@osdl.org> <20050629072115.GA17261@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 12:17:17AM -0700, Andrew Morton wrote:
> > Come to think of it, it could be a problem if the comnpiler was silly and
> > built an entire temporary on the stack and the copied it over.  Hopefull it
> > won't do that.

On Wed, 29 Jun 2005, Christoph Hellwig wrote:
> that patch is fine except for the second to last patch which should be
> droped.

Andrew, here's an updated patch.

This patch addresses the following minor issues:

  - Typo in printk
  - Redundant casts
  - Use kcalloc instead of kmalloc and memset
  - Parenthesis around return value
  - Use inline instead of __inline__

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 vxfs_bmap.c   |    2 +-
 vxfs_lookup.c |    8 ++++----
 vxfs_olt.c    |   10 +++++-----
 vxfs_super.c  |    7 +++----
 4 files changed, 13 insertions(+), 14 deletions(-)

Index: 2.6-git/fs/freevxfs/vxfs_bmap.c
===================================================================
--- 2.6-git.orig/fs/freevxfs/vxfs_bmap.c
+++ 2.6-git/fs/freevxfs/vxfs_bmap.c
@@ -101,7 +101,7 @@ vxfs_bmap_ext4(struct inode *ip, long bn
 	return 0;
 
 fail_size:
-	printk("vxfs: indirect extent to big!\n");
+	printk("vxfs: indirect extent too big!\n");
 fail_buf:
 	return 0;
 }
Index: 2.6-git/fs/freevxfs/vxfs_lookup.c
===================================================================
--- 2.6-git.orig/fs/freevxfs/vxfs_lookup.c
+++ 2.6-git/fs/freevxfs/vxfs_lookup.c
@@ -61,13 +61,13 @@ struct file_operations vxfs_dir_operatio
 };
 
  
-static __inline__ u_long
+static inline u_long
 dir_pages(struct inode *inode)
 {
 	return (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 }
  
-static __inline__ u_long
+static inline u_long
 dir_blocks(struct inode *ip)
 {
 	u_long			bsize = ip->i_sb->s_blocksize;
@@ -79,7 +79,7 @@ dir_blocks(struct inode *ip)
  *
  * len <= VXFS_NAMELEN and de != NULL are guaranteed by caller.
  */
-static __inline__ int
+static inline int
 vxfs_match(int len, const char * const name, struct vxfs_direct *de)
 {
 	if (len != de->d_namelen)
@@ -89,7 +89,7 @@ vxfs_match(int len, const char * const n
 	return !memcmp(name, de->d_name, len);
 }
 
-static __inline__ struct vxfs_direct *
+static inline struct vxfs_direct *
 vxfs_next_entry(struct vxfs_direct *de)
 {
 	return ((struct vxfs_direct *)((char*)de + de->d_reclen));
Index: 2.6-git/fs/freevxfs/vxfs_olt.c
===================================================================
--- 2.6-git.orig/fs/freevxfs/vxfs_olt.c
+++ 2.6-git/fs/freevxfs/vxfs_olt.c
@@ -38,7 +38,7 @@
 #include "vxfs_olt.h"
 
 
-static __inline__ void
+static inline void
 vxfs_get_fshead(struct vxfs_oltfshead *fshp, struct vxfs_sb_info *infp)
 {
 	if (infp->vsi_fshino)
@@ -46,7 +46,7 @@ vxfs_get_fshead(struct vxfs_oltfshead *f
 	infp->vsi_fshino = fshp->olt_fsino[0];
 }
 
-static __inline__ void
+static inline void
 vxfs_get_ilist(struct vxfs_oltilist *ilistp, struct vxfs_sb_info *infp)
 {
 	if (infp->vsi_iext)
@@ -54,7 +54,7 @@ vxfs_get_ilist(struct vxfs_oltilist *ili
 	infp->vsi_iext = ilistp->olt_iext[0]; 
 }
 
-static __inline__ u_long
+static inline u_long
 vxfs_oblock(struct super_block *sbp, daddr_t block, u_long bsize)
 {
 	if (sbp->s_blocksize % bsize)
@@ -104,8 +104,8 @@ vxfs_read_olt(struct super_block *sbp, u
 		goto fail;
 	}
 
-	oaddr = (char *)bp->b_data + op->olt_size;
-	eaddr = (char *)bp->b_data + (infp->vsi_oltsize * sbp->s_blocksize);
+	oaddr = bp->b_data + op->olt_size;
+	eaddr = bp->b_data + (infp->vsi_oltsize * sbp->s_blocksize);
 
 	while (oaddr < eaddr) {
 		struct vxfs_oltcommon	*ocp =
Index: 2.6-git/fs/freevxfs/vxfs_super.c
===================================================================
--- 2.6-git.orig/fs/freevxfs/vxfs_super.c
+++ 2.6-git/fs/freevxfs/vxfs_super.c
@@ -155,12 +155,11 @@ static int vxfs_fill_super(struct super_
 
 	sbp->s_flags |= MS_RDONLY;
 
-	infp = kmalloc(sizeof(*infp), GFP_KERNEL);
+	infp = kcalloc(1, sizeof(*infp), GFP_KERNEL);
 	if (!infp) {
 		printk(KERN_WARNING "vxfs: unable to allocate incore superblock\n");
 		return -ENOMEM;
 	}
-	memset(infp, 0, sizeof(*infp));
 
 	bsize = sb_min_blocksize(sbp, BLOCK_SIZE);
 	if (!bsize) {
@@ -196,7 +195,7 @@ static int vxfs_fill_super(struct super_
 #endif
 
 	sbp->s_magic = rsbp->vs_magic;
-	sbp->s_fs_info = (void *)infp;
+	sbp->s_fs_info = infp;
 
 	infp->vsi_raw = rsbp;
 	infp->vsi_bp = bp;
@@ -263,7 +262,7 @@ vxfs_init(void)
 			sizeof(struct vxfs_inode_info), 0, 
 			SLAB_RECLAIM_ACCOUNT, NULL, NULL);
 	if (vxfs_inode_cachep)
-		return (register_filesystem(&vxfs_fs_type));
+		return register_filesystem(&vxfs_fs_type);
 	return -ENOMEM;
 }
 
