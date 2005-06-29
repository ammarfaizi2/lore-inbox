Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVF2HUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVF2HUC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVF2HTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:19:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbVF2HS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:18:28 -0400
Date: Wed, 29 Jun 2005 00:17:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: penberg@cs.helsinki.fi, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Message-Id: <20050629001717.65fb272c.akpm@osdl.org>
In-Reply-To: <20050629070729.GB16850@infradead.org>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
	<iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
	<20050628163114.6594e1e1.akpm@osdl.org>
	<20050629070729.GB16850@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 28, 2005 at 04:31:14PM -0700, Andrew Morton wrote:
> > Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > >
> > > This patch addresses the following minor issues:
> > > 
> > >   - Typo in printk
> > >   - Redundant casts
> > >   - Use C99 struct initializers instead of memset
> > >   - Parenthesis around return value
> > >   - Use inline instead of __inline__
> > 
> > That struct initialisation:
> > 
> > > +	*infp = (struct vxfs_sb_info) {
> > > +		.vsi_raw = rsbp,
> > > +		.vsi_bp = bp,
> > > +		.vsi_oltext = rsbp->vs_oltext[0],
> > > +		.vsi_oltsize = rsbp->vs_oltsize,
> > > +	};
> > >  
> > 
> > Is a bit unconventional, but it doesn't alter the size of the .o file, so
> > whatever.
> 
> It looks rather horrible, I wouldn't call that a cleanup.  Where's the
> full patch?

Come to think of it, it could be a problem if the comnpiler was silly and
built an entire temporary on the stack and the copied it over.  Hopefull it
won't do that.


From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch addresses the following minor issues:

  - Typo in printk
  - Redundant casts
  - Use C99 struct initializers instead of memset
  - Parenthesis around return value
  - Use inline instead of __inline__

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/freevxfs/vxfs_bmap.c   |    2 +-
 fs/freevxfs/vxfs_lookup.c |    8 ++++----
 fs/freevxfs/vxfs_olt.c    |   10 +++++-----
 fs/freevxfs/vxfs_super.c  |   15 ++++++++-------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff -puN fs/freevxfs/vxfs_bmap.c~freevxfs-minor-cleanups fs/freevxfs/vxfs_bmap.c
--- 25/fs/freevxfs/vxfs_bmap.c~freevxfs-minor-cleanups	Tue Jun 28 16:31:21 2005
+++ 25-akpm/fs/freevxfs/vxfs_bmap.c	Tue Jun 28 16:31:21 2005
@@ -101,7 +101,7 @@ vxfs_bmap_ext4(struct inode *ip, long bn
 	return 0;
 
 fail_size:
-	printk("vxfs: indirect extent to big!\n");
+	printk("vxfs: indirect extent too big!\n");
 fail_buf:
 	return 0;
 }
diff -puN fs/freevxfs/vxfs_lookup.c~freevxfs-minor-cleanups fs/freevxfs/vxfs_lookup.c
--- 25/fs/freevxfs/vxfs_lookup.c~freevxfs-minor-cleanups	Tue Jun 28 16:31:21 2005
+++ 25-akpm/fs/freevxfs/vxfs_lookup.c	Tue Jun 28 16:31:21 2005
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
diff -puN fs/freevxfs/vxfs_olt.c~freevxfs-minor-cleanups fs/freevxfs/vxfs_olt.c
--- 25/fs/freevxfs/vxfs_olt.c~freevxfs-minor-cleanups	Tue Jun 28 16:31:21 2005
+++ 25-akpm/fs/freevxfs/vxfs_olt.c	Tue Jun 28 16:31:21 2005
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
diff -puN fs/freevxfs/vxfs_super.c~freevxfs-minor-cleanups fs/freevxfs/vxfs_super.c
--- 25/fs/freevxfs/vxfs_super.c~freevxfs-minor-cleanups	Tue Jun 28 16:31:21 2005
+++ 25-akpm/fs/freevxfs/vxfs_super.c	Tue Jun 28 16:31:21 2005
@@ -160,7 +160,6 @@ static int vxfs_fill_super(struct super_
 		printk(KERN_WARNING "vxfs: unable to allocate incore superblock\n");
 		return -ENOMEM;
 	}
-	memset(infp, 0, sizeof(*infp));
 
 	bsize = sb_min_blocksize(sbp, BLOCK_SIZE);
 	if (!bsize) {
@@ -196,12 +195,14 @@ static int vxfs_fill_super(struct super_
 #endif
 
 	sbp->s_magic = rsbp->vs_magic;
-	sbp->s_fs_info = (void *)infp;
+	sbp->s_fs_info = infp;
 
-	infp->vsi_raw = rsbp;
-	infp->vsi_bp = bp;
-	infp->vsi_oltext = rsbp->vs_oltext[0];
-	infp->vsi_oltsize = rsbp->vs_oltsize;
+	*infp = (struct vxfs_sb_info) {
+		.vsi_raw = rsbp,
+		.vsi_bp = bp,
+		.vsi_oltext = rsbp->vs_oltext[0],
+		.vsi_oltsize = rsbp->vs_oltsize,
+	};
 
 	if (!sb_set_blocksize(sbp, rsbp->vs_bsize)) {
 		printk(KERN_WARNING "vxfs: unable to set final block size\n");
@@ -263,7 +264,7 @@ vxfs_init(void)
 			sizeof(struct vxfs_inode_info), 0, 
 			SLAB_RECLAIM_ACCOUNT, NULL, NULL);
 	if (vxfs_inode_cachep)
-		return (register_filesystem(&vxfs_fs_type));
+		return register_filesystem(&vxfs_fs_type);
 	return -ENOMEM;
 }
 
_

