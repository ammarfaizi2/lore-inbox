Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277820AbUKATiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277820AbUKATiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUKATh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:37:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291947AbUKATat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:49 -0500
Date: Mon, 1 Nov 2004 19:30:22 GMT
Message-Id: <200411011930.iA1JUM1S023248@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 13/14] FRV: Convert extern inline -> static inline
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch converts a bunch of extern inline functions to be static
inline to permit the kernel to be compiled with -O0 for easier debugging.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-inline-2610rc1bk10.diff
 bio.h               |    8 ++++----
 blkdev.h            |    2 +-
 byteorder/generic.h |    2 +-
 quotaops.h          |   36 ++++++++++++++++++------------------
 sysrq.h             |    4 ++--
 5 files changed, 26 insertions(+), 26 deletions(-)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/bio.h linux-2.6.10-rc1-bk10-frv/include/linux/bio.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/bio.h	2004-10-19 10:42:16.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/include/linux/bio.h	2004-11-01 11:47:05.089638733 +0000
@@ -280,9 +280,9 @@
  * bvec_kmap_irq and bvec_kunmap_irq!!
  *
  * This function MUST be inlined - it plays with the CPU interrupt flags.
- * Hence the `extern inline'.
+ * Hence the `static inline'.
  */
-extern inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
+static inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
 {
 	unsigned long addr;
 
@@ -298,7 +298,7 @@
 	return (char *) addr + bvec->bv_offset;
 }
 
-extern inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
+static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 {
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
 
@@ -311,7 +311,7 @@
 #define bvec_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
 #endif
 
-extern inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
+static inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
 				   unsigned long *flags)
 {
 	return bvec_kmap_irq(bio_iovec_idx(bio, idx), flags);
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/blkdev.h linux-2.6.10-rc1-bk10-frv/include/linux/blkdev.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/blkdev.h	2004-11-01 11:45:33.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/include/linux/blkdev.h	2004-11-01 11:47:05.097638067 +0000
@@ -685,7 +685,7 @@
 	return bits;
 }
 
-extern inline unsigned int block_size(struct block_device *bdev)
+static inline unsigned int block_size(struct block_device *bdev)
 {
 	return bdev->bd_block_size;
 }
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/byteorder/generic.h linux-2.6.10-rc1-bk10-frv/include/linux/byteorder/generic.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/byteorder/generic.h	2004-10-19 10:42:16.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/include/linux/byteorder/generic.h	2004-11-01 11:47:05.099637901 +0000
@@ -152,7 +152,7 @@
 extern __u16			ntohs(__be16);
 extern __be16			htons(__u16);
 
-#if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
+#if defined(__GNUC__) && (__GNUC__ >= 2) // && defined(__OPTIMIZE__)
 
 #define ___htonl(x) __cpu_to_be32(x)
 #define ___htons(x) __cpu_to_be16(x)
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/quotaops.h linux-2.6.10-rc1-bk10-frv/include/linux/quotaops.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/quotaops.h	2004-09-16 12:06:22.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/include/linux/quotaops.h	2004-11-01 11:47:05.127635570 +0000
@@ -59,7 +59,7 @@
 
 /* It is better to call this function outside of any transaction as it might
  * need a lot of space in journal for dquot structure allocation. */
-static __inline__ void DQUOT_INIT(struct inode *inode)
+static inline void DQUOT_INIT(struct inode *inode)
 {
 	BUG_ON(!inode->i_sb);
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
@@ -67,7 +67,7 @@
 }
 
 /* The same as with DQUOT_INIT */
-static __inline__ void DQUOT_DROP(struct inode *inode)
+static inline void DQUOT_DROP(struct inode *inode)
 {
 	/* Here we can get arbitrary inode from clear_inode() so we have
 	 * to be careful. OTOH we don't need locking as quota operations
@@ -90,7 +90,7 @@
 
 /* The following allocation/freeing/transfer functions *must* be called inside
  * a transaction (deadlocks possible otherwise) */
-static __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		/* Used space is updated in alloc_space() */
@@ -102,7 +102,7 @@
 	return 0;
 }
 
-static __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	int ret;
         if (!(ret =  DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr)))
@@ -110,7 +110,7 @@
 	return ret;
 }
 
-static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		/* Used space is updated in alloc_space() */
@@ -122,7 +122,7 @@
 	return 0;
 }
 
-static __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	int ret;
 	if (!(ret = DQUOT_ALLOC_SPACE_NODIRTY(inode, nr)))
@@ -130,7 +130,7 @@
 	return ret;
 }
 
-static __inline__ int DQUOT_ALLOC_INODE(struct inode *inode)
+static inline int DQUOT_ALLOC_INODE(struct inode *inode)
 {
 	if (sb_any_quota_enabled(inode->i_sb)) {
 		DQUOT_INIT(inode);
@@ -140,7 +140,7 @@
 	return 0;
 }
 
-static __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_space(inode, nr);
@@ -148,19 +148,19 @@
 		inode_sub_bytes(inode, nr);
 }
 
-static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 }
 
-static __inline__ void DQUOT_FREE_INODE(struct inode *inode)
+static inline void DQUOT_FREE_INODE(struct inode *inode)
 {
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_inode(inode, 1);
 }
 
-static __inline__ int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
+static inline int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
 {
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
 		DQUOT_INIT(inode);
@@ -173,7 +173,7 @@
 /* The following two functions cannot be called inside a transaction */
 #define DQUOT_SYNC(sb)	sync_dquots(sb, -1)
 
-static __inline__ int DQUOT_OFF(struct super_block *sb)
+static inline int DQUOT_OFF(struct super_block *sb)
 {
 	int ret = -ENOSYS;
 
@@ -197,38 +197,38 @@
 #define DQUOT_SYNC(sb)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_add_bytes(inode, nr);
 	return 0;
 }
 
-extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_add_bytes(inode, nr);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_sub_bytes(inode, nr);
 }
 
-extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/sysrq.h linux-2.6.10-rc1-bk10-frv/include/linux/sysrq.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/sysrq.h	2004-06-18 13:44:05.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/include/linux/sysrq.h	2004-11-01 11:47:05.133635071 +0000
@@ -41,7 +41,7 @@
 struct sysrq_key_op *__sysrq_get_key_op (int key);
 void __sysrq_put_key_op (int key, struct sysrq_key_op *op_p);
 
-extern __inline__ int
+static inline int
 __sysrq_swap_key_ops_nolock(int key, struct sysrq_key_op *insert_op_p,
 				struct sysrq_key_op *remove_op_p)
 {
@@ -55,7 +55,7 @@
 	return retval;
 }
 
-extern __inline__ int
+static inline int
 __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
 				struct sysrq_key_op *remove_op_p) {
 	int retval;
