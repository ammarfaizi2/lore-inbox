Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWHKUy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWHKUy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWHKUy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:54:57 -0400
Received: from xenotime.net ([66.160.160.81]:31627 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932427AbWHKUyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:54:55 -0400
Date: Fri, 11 Aug 2006 13:57:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alex Tomas <alex@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060811135737.1abfa0f6.rdunlap@xenotime.net>
In-Reply-To: <m37j1hlyzv.fsf@bzzz.home.net>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<m37j1hlyzv.fsf@bzzz.home.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 13:29:56 +0400 Alex Tomas wrote:

>  AM> - The existing comments could benefit from some rework by a
>  AM> native English speaker.
> 
> could someone assist here, please?

See if this helps.
Patch applies on top of all ext4 patches from
http://ext2.sourceforge.net/48bitext3/patches/latest/.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Clean up comments in ext4-extents patch.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/ext4/extents.c               |  226 ++++++++++++++++++++++------------------
 include/linux/ext4_fs_extents.h |   54 ++++-----
 include/linux/ext4_jbd2.h       |    4 
 3 files changed, 157 insertions(+), 127 deletions(-)

--- linux-2618-rc4-ext4.orig/include/linux/ext4_jbd2.h
+++ linux-2618-rc4-ext4/include/linux/ext4_jbd2.h
@@ -28,8 +28,8 @@
  * indirection blocks, the group and superblock summaries, and the data
  * block to complete the transaction.
  *
- * For extents-enabled fs we may have to allocate and modify upto
- * 5 levels of tree + root which is stored in inode. */
+ * For extents-enabled fs we may have to allocate and modify up to
+ * 5 levels of tree + root which are stored in the inode. */
 
 #define EXT4_SINGLEDATA_TRANS_BLOCKS(sb)				\
 	(EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_EXTENTS)	\
--- linux-2618-rc4-ext4.orig/include/linux/ext4_fs_extents.h
+++ linux-2618-rc4-ext4/include/linux/ext4_fs_extents.h
@@ -22,29 +22,29 @@
 #include <linux/ext4_fs.h>
 
 /*
- * with AGRESSIVE_TEST defined capacity of index/leaf blocks
- * become very little, so index split, in-depth growing and
- * other hard changes happens much more often
- * this is for debug purposes only
+ * With AGRESSIVE_TEST defined, the capacity of index/leaf blocks
+ * becomes very small, so index split, in-depth growing and
+ * other hard changes happen much more often.
+ * This is for debug purposes only.
  */
 #define AGRESSIVE_TEST_
 
 /*
- * with EXTENTS_STATS defined number of blocks and extents
- * are collected in truncate path. they'll be showed at
- * umount time
+ * With EXTENTS_STATS defined, the number of blocks and extents
+ * are collected in the truncate path. They'll be shown at
+ * umount time.
  */
 #define EXTENTS_STATS__
 
 /*
- * if CHECK_BINSEARCH defined, then results of binary search
- * will be checked by linear search
+ * If CHECK_BINSEARCH is defined, then the results of the binary search
+ * will also be checked by linear search.
  */
 #define CHECK_BINSEARCH__
 
 /*
- * if EXT_DEBUG is defined you can use 'extdebug' mount option
- * to get lots of info what's going on
+ * If EXT_DEBUG is defined you can use the 'extdebug' mount option
+ * to get lots of info about what's going on.
  */
 #define EXT_DEBUG__
 #ifdef EXT_DEBUG
@@ -54,58 +54,58 @@
 #endif
 
 /*
- * if EXT_STATS is defined then stats numbers are collected
- * these number will be displayed at umount time
+ * If EXT_STATS is defined then stats numbers are collected.
+ * These number will be displayed at umount time.
  */
 #define EXT_STATS_
 
 
 /*
- * ext4_inode has i_block array (60 bytes total)
- * first 12 bytes store ext4_extent_header
- * the remain stores array of ext4_extent
+ * ext4_inode has i_block array (60 bytes total).
+ * The first 12 bytes store ext4_extent_header;
+ * the remainder stores an array of ext4_extent.
  */
 
 /*
- * this is extent on-disk structure
- * it's used at the bottom of the tree
+ * This is the extent on-disk structure.
+ * It's used at the bottom of the tree.
  */
 struct ext4_extent {
 	__le32	ee_block;	/* first logical block extent covers */
 	__le16	ee_len;		/* number of blocks covered by extent */
 	__le16	ee_start_hi;	/* high 16 bits of physical block */
-	__le32	ee_start;	/* low 32 bigs of physical block */
+	__le32	ee_start;	/* low 32 bits of physical block */
 };
 
 /*
- * this is index on-disk structure
- * it's used at all the levels, but the bottom
+ * This is index on-disk structure.
+ * It's used at all the levels except the bottom.
  */
 struct ext4_extent_idx {
 	__le32	ei_block;	/* index covers logical blocks from 'block' */
 	__le32	ei_leaf;	/* pointer to the physical block of the next *
-				 * level. leaf or next index could bet here */
+				 * level. leaf or next index could be there */
 	__le16	ei_leaf_hi;	/* high 16 bits of physical block */
 	__u16	ei_unused;
 };
 
 /*
- * each block (leaves and indexes), even inode-stored has header
+ * Each block (leaves and indexes), even inode-stored has header.
  */
 struct ext4_extent_header {
 	__le16	eh_magic;	/* probably will support different formats */
 	__le16	eh_entries;	/* number of valid entries */
 	__le16	eh_max;		/* capacity of store in entries */
-	__le16	eh_depth;	/* has tree real underlaying blocks? */
+	__le16	eh_depth;	/* has tree real underlying blocks? */
 	__le32	eh_generation;	/* generation of the tree */
 };
 
 #define EXT4_EXT_MAGIC		cpu_to_le16(0xf30a)
 
 /*
- * array of ext4_ext_path contains path to some extent
- * creation/lookup routines use it for traversal/splitting/etc
- * truncate uses it to simulate recursive walking
+ * Array of ext4_ext_path contains path to some extent.
+ * Creation/lookup routines use it for traversal/splitting/etc.
+ * Truncate uses it to simulate recursive walking.
  */
 struct ext4_ext_path {
 	ext4_fsblk_t			p_block;
--- linux-2618-rc4-ext4.orig/fs/ext4/extents.c
+++ linux-2618-rc4-ext4/fs/ext4/extents.c
@@ -44,7 +44,10 @@
 #include <asm/uaccess.h>
 
 
-/* this macro combines low and hi parts of phys. blocknr into ext4_fsblk_t */
+/*
+ * ext_pblock:
+ * combine low and high parts of physical block number into ext4_fsblk_t
+ */
 static inline ext4_fsblk_t ext_pblock(struct ext4_extent *ex)
 {
 	ext4_fsblk_t block;
@@ -55,7 +58,10 @@ static inline ext4_fsblk_t ext_pblock(st
 	return block;
 }
 
-/* this macro combines low and hi parts of phys. blocknr into ext4_fsblk_t */
+/*
+ * idx_pblock:
+ * combine low and high parts of a leaf physical block number into ext4_fsblk_t
+ */
 static inline ext4_fsblk_t idx_pblock(struct ext4_extent_idx *ix)
 {
 	ext4_fsblk_t block;
@@ -66,7 +72,11 @@ static inline ext4_fsblk_t idx_pblock(st
 	return block;
 }
 
-/* the routine stores large phys. blocknr into extent breaking it into parts */
+/*
+ * ext4_ext_store_pblock:
+ * stores a large physical block number into an extent struct,
+ * breaking it into parts
+ */
 static inline void ext4_ext_store_pblock(struct ext4_extent *ex, ext4_fsblk_t pb)
 {
 	ex->ee_start = cpu_to_le32((unsigned long) (pb & 0xffffffff));
@@ -74,7 +84,11 @@ static inline void ext4_ext_store_pblock
 		ex->ee_start_hi = cpu_to_le16((unsigned long) ((pb >> 31) >> 1) & 0xffff);
 }
 
-/* the routine stores large phys. blocknr into index breaking it into parts */
+/*
+ * ext4_idx_store_pblock:
+ * stores a large physical block number into an index struct,
+ * breaking it into parts
+ */
 static inline void ext4_idx_store_pblock(struct ext4_extent_idx *ix, ext4_fsblk_t pb)
 {
 	ix->ei_leaf = cpu_to_le32((unsigned long) (pb & 0xffffffff));
@@ -179,8 +193,8 @@ static ext4_fsblk_t ext4_ext_find_goal(s
 		if ((ex = path[depth].p_ext))
 			return ext_pblock(ex)+(block-le32_to_cpu(ex->ee_block));
 
-		/* it looks index is empty
-		 * try to find starting from index itself */
+		/* it looks like index is empty;
+		 * try to find starting block from index itself */
 		if (path[depth].p_bh)
 			return path[depth].p_bh->b_blocknr;
 	}
@@ -317,7 +331,8 @@ static void ext4_ext_drop_refs(struct ex
 }
 
 /*
- * binary search for closest index by given block
+ * ext4_ext_binsearch_idx:
+ * binary search for the closest index of the given block
  */
 static void
 ext4_ext_binsearch_idx(struct inode *inode, struct ext4_ext_path *path, int block)
@@ -375,7 +390,8 @@ ext4_ext_binsearch_idx(struct inode *ino
 }
 
 /*
- * binary search for closest extent by given block
+ * ext4_ext_binsearch:
+ * binary search for closest extent of the given block
  */
 static void
 ext4_ext_binsearch(struct inode *inode, struct ext4_ext_path *path, int block)
@@ -388,8 +404,8 @@ ext4_ext_binsearch(struct inode *inode, 
 
 	if (eh->eh_entries == 0) {
 		/*
-		 * this leaf is empty yet:
-		 *  we get such a leaf in split/add case
+		 * this leaf is empty:
+		 * we get such a leaf in split/add case
 		 */
 		return;
 	}
@@ -520,8 +536,9 @@ err:
 }
 
 /*
- * insert new index [logical;ptr] into the block at cupr
- * it check where to insert: before curp or after curp
+ * ext4_ext_insert_index:
+ * insert new index [@logical;@ptr] into the block at @curp;
+ * check where to insert: before @curp or after @curp
  */
 static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 				struct ext4_ext_path *curp,
@@ -574,13 +591,14 @@ static int ext4_ext_insert_index(handle_
 }
 
 /*
- * routine inserts new subtree into the path, using free index entry
- * at depth 'at:
- *  - allocates all needed blocks (new leaf and all intermediate index blocks)
- *  - makes decision where to split
- *  - moves remaining extens and index entries (right to the split point)
- *    into the newly allocated blocks
- *  - initialize subtree
+ * ext4_ext_split:
+ * inserts new subtree into the path, using free index entry
+ * at depth @at:
+ * - allocates all needed blocks (new leaf and all intermediate index blocks)
+ * - makes decision where to split
+ * - moves remaining extents and index entries (right to the split point)
+ *   into the newly allocated blocks
+ * - initializes subtree
  */
 static int ext4_ext_split(handle_t *handle, struct inode *inode,
 				struct ext4_ext_path *path,
@@ -598,14 +616,14 @@ static int ext4_ext_split(handle_t *hand
 	int err = 0;
 
 	/* make decision: where to split? */
-	/* FIXME: now desicion is simplest: at current extent */
+	/* FIXME: now decision is simplest: at current extent */
 
-	/* if current leaf will be splitted, then we should use
+	/* if current leaf will be split, then we should use
 	 * border from split point */
 	BUG_ON(path[depth].p_ext > EXT_MAX_EXTENT(path[depth].p_hdr));
 	if (path[depth].p_ext != EXT_MAX_EXTENT(path[depth].p_hdr)) {
 		border = path[depth].p_ext[1].ee_block;
-		ext_debug("leaf will be splitted."
+		ext_debug("leaf will be split."
 				" next leaf starts at %d\n",
 			          le32_to_cpu(border));
 	} else {
@@ -616,16 +634,16 @@ static int ext4_ext_split(handle_t *hand
 	}
 
 	/*
-	 * if error occurs, then we break processing
-	 * and turn filesystem read-only. so, index won't
+	 * If error occurs, then we break processing
+	 * and mark filesystem read-only. index won't
 	 * be inserted and tree will be in consistent
-	 * state. next mount will repair buffers too
+	 * state. Next mount will repair buffers too.
 	 */
 
 	/*
-	 * get array to track all allocated blocks
-	 * we need this to handle errors and free blocks
-	 * upon them
+	 * Get array to track all allocated blocks.
+	 * We need this to handle errors and free blocks
+	 * upon them.
 	 */
 	ablocks = kmalloc(sizeof(ext4_fsblk_t) * depth, GFP_NOFS);
 	if (!ablocks)
@@ -661,7 +679,7 @@ static int ext4_ext_split(handle_t *hand
 	neh->eh_depth = 0;
 	ex = EXT_FIRST_EXTENT(neh);
 
-	/* move remain of path[depth] to the new leaf */
+	/* move remainder of path[depth] to the new leaf */
 	BUG_ON(path[depth].p_hdr->eh_entries != path[depth].p_hdr->eh_max);
 	/* start copy from next extent */
 	/* TODO: we could do it by single memmove */
@@ -813,11 +831,12 @@ cleanup:
 }
 
 /*
- * routine implements tree growing procedure:
- *  - allocates new block
- *  - moves top-level data (index block or leaf) into the new block
- *  - initialize new top-level, creating index that points to the
- *    just created block
+ * ext4_ext_grow_indepth:
+ * implements tree growing procedure:
+ * - allocates new block
+ * - moves top-level data (index block or leaf) into the new block
+ * - initializes new top-level, creating index that points to the
+ *   just created block
  */
 static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 					struct ext4_ext_path *path,
@@ -892,8 +911,9 @@ out:
 }
 
 /*
- * routine finds empty index and adds new leaf. if no free index found
- * then it requests in-depth growing
+ * ext4_ext_create_new_leaf:
+ * finds empty index and adds new leaf.
+ * if no free index is found, then it requests in-depth growing.
  */
 static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 					struct ext4_ext_path *path,
@@ -912,8 +932,8 @@ repeat:
 		curp--;
 	}
 
-	/* we use already allocated block for index block
-	 * so, subsequent data blocks should be contigoues */
+	/* we use already allocated block for index block,
+	 * so subsequent data blocks should be contiguous */
 	if (EXT_HAS_FREE_INDEX(curp)) {
 		/* if we found index with free entry, then use that
 		 * entry: create all needed subtree and add new leaf */
@@ -943,12 +963,12 @@ repeat:
 		}
 
 		/*
-		 * only first (depth 0 -> 1) produces free space
-		 * in all other cases we have to split growed tree
+		 * only first (depth 0 -> 1) produces free space;
+		 * in all other cases we have to split the grown tree
 		 */
 		depth = ext_depth(inode);
 		if (path[depth].p_hdr->eh_entries == path[depth].p_hdr->eh_max) {
-			/* now we need split */
+			/* now we need to split */
 			goto repeat;
 		}
 	}
@@ -958,10 +978,11 @@ out:
 }
 
 /*
- * returns allocated block in subsequent extent or EXT_MAX_BLOCK
- * NOTE: it consider block number from index entry as
- * allocated block. thus, index entries have to be consistent
- * with leafs
+ * ext4_ext_next_allocated_block:
+ * returns allocated block in subsequent extent or EXT_MAX_BLOCK.
+ * NOTE: it considers block number from index entry as
+ * allocated block. Thus, index entries have to be consistent
+ * with leaves.
  */
 static unsigned long
 ext4_ext_next_allocated_block(struct ext4_ext_path *path)
@@ -993,6 +1014,7 @@ ext4_ext_next_allocated_block(struct ext
 }
 
 /*
+ * ext4_ext_next_leaf_block:
  * returns first allocated block from next leaf or EXT_MAX_BLOCK
  */
 static unsigned ext4_ext_next_leaf_block(struct inode *inode,
@@ -1021,8 +1043,9 @@ static unsigned ext4_ext_next_leaf_block
 }
 
 /*
- * if leaf gets modified and modified extent is first in the leaf
- * then we have to correct all indexes above
+ * ext4_ext_correct_indexes:
+ * if leaf gets modified and modified extent is first in the leaf,
+ * then we have to correct all indexes above.
  * TODO: do we need to correct tree in all cases?
  */
 int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
@@ -1050,7 +1073,7 @@ int ext4_ext_correct_indexes(handle_t *h
 	}
 
 	/*
-	 * TODO: we need correction if border is smaller then current one
+	 * TODO: we need correction if border is smaller than current one
 	 */
 	k = depth - 1;
 	border = path[depth].p_ext->ee_block;
@@ -1085,7 +1108,7 @@ ext4_can_extents_be_merged(struct inode 
 	/*
 	 * To allow future support for preallocated extents to be added
 	 * as an RO_COMPAT feature, refuse to merge to extents if
-	 * can result in the top bit of ee_len being set
+	 * this can result in the top bit of ee_len being set.
 	 */
 	if (le16_to_cpu(ex1->ee_len) + le16_to_cpu(ex2->ee_len) > EXT_MAX_LEN)
 		return 0;
@@ -1100,9 +1123,10 @@ ext4_can_extents_be_merged(struct inode 
 }
 
 /*
- * this routine tries to merge requsted extent into the existing
- * extent or inserts requested extent as new one into the tree,
- * creating new leaf in no-space case
+ * ext4_ext_insert_extent:
+ * tries to merge requsted extent into the existing extent or
+ * inserts requested extent as new one into the tree,
+ * creating new leaf in the no-space case.
  */
 int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 				struct ext4_ext_path *path,
@@ -1163,8 +1187,8 @@ repeat:
 	}
 
 	/*
-	 * there is no free space in found leaf
-	 * we're gonna add new leaf in the tree
+	 * There is no free space in the found leaf.
+	 * We're gonna add a new leaf in the tree.
 	 */
 	err = ext4_ext_create_new_leaf(handle, inode, path, newext);
 	if (err)
@@ -1377,7 +1401,8 @@ ext4_ext_put_in_cache(struct inode *inod
 }
 
 /*
- * this routine calculate boundaries of the gap requested block fits into
+ * ext4_ext_put_gap_in_cache:
+ * calculate boundaries of the gap that the requested block fits into
  * and cache this gap
  */
 static inline void
@@ -1452,9 +1477,10 @@ ext4_ext_in_cache(struct inode *inode, u
 }
 
 /*
- * routine removes index from the index block
- * it's used in truncate case only. thus all requests are for
- * last index in the block only
+ * ext4_ext_rm_idx:
+ * removes index from the index block.
+ * It's used in truncate case only, thus all requests are for
+ * last index in the block only.
  */
 int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path *path)
@@ -1480,11 +1506,12 @@ int ext4_ext_rm_idx(handle_t *handle, st
 }
 
 /*
- * This routine returns max. credits extent tree can consume.
+ * ext4_ext_calc_credits_for_insert:
+ * This routine returns max. credits that the extent tree can consume.
  * It should be OK for low-performance paths like ->writepage()
- * To allow many writing process to fit a single transaction,
- * caller should calculate credits under truncate_mutex and
- * pass actual path.
+ * To allow many writing processes to fit into a single transaction,
+ * the caller should calculate credits under truncate_mutex and
+ * pass the actual path.
  */
 int inline ext4_ext_calc_credits_for_insert(struct inode *inode,
 						struct ext4_ext_path *path)
@@ -1500,9 +1527,9 @@ int inline ext4_ext_calc_credits_for_ins
 	}
 
 	/*
-	 * given 32bit logical block (4294967296 blocks), max. tree
+	 * given 32-bit logical block (4294967296 blocks), max. tree
 	 * can be 4 levels in depth -- 4 * 340^4 == 53453440000.
-	 * let's also add one more level for imbalance.
+	 * Let's also add one more level for imbalance.
 	 */
 	depth = 5;
 
@@ -1510,13 +1537,13 @@ int inline ext4_ext_calc_credits_for_ins
 	needed = 2;
 
 	/*
-	 * tree can be full, so it'd need to grow in depth:
+	 * tree can be full, so it would need to grow in depth:
 	 * allocation + old root + new root
 	 */
 	needed += 2 + 1 + 1;
 
 	/*
-	 * Index split can happen, we'd need:
+	 * Index split can happen, we would need:
 	 *    allocate intermediate indexes (bitmap + group)
 	 *  + change two blocks at each level, but root (already included)
 	 */
@@ -1634,7 +1661,7 @@ ext4_ext_rm_leaf(handle_t *handle, struc
 			BUG_ON(b != ex_ee_block + ex_ee_len - 1);
 		}
 
-		/* at present, extent can't cross block group */
+		/* at present, extent can't cross block group: */
 		/* leaf + bitmap + group desc + sb + inode */
 		credits = 5;
 		if (ex == EXT_FIRST_EXTENT(eh)) {
@@ -1660,7 +1687,7 @@ ext4_ext_rm_leaf(handle_t *handle, struc
 			goto out;
 
 		if (num == 0) {
-			/* this extent is removed entirely mark slot unused */
+			/* this extent is removed; mark slot entirely unused */
 			ext4_ext_store_pblock(ex, 0);
 			eh->eh_entries = cpu_to_le16(le16_to_cpu(eh->eh_entries)-1);
 		}
@@ -1692,7 +1719,8 @@ out:
 }
 
 /*
- * returns 1 if current index have to be freed (even partial)
+ * ext4_ext_more_to_rm:
+ * returns 1 if current index has to be freed (even partial)
  */
 static int inline
 ext4_ext_more_to_rm(struct ext4_ext_path *path)
@@ -1703,7 +1731,7 @@ ext4_ext_more_to_rm(struct ext4_ext_path
 		return 0;
 
 	/*
-	 * if truncate on deeper level happened it it wasn't partial
+	 * if truncate on deeper level happened, it wasn't partial,
 	 * so we have to consider current index for truncation
 	 */
 	if (le16_to_cpu(path->p_hdr->eh_entries) == path->p_block)
@@ -1729,8 +1757,8 @@ int ext4_ext_remove_space(struct inode *
 	ext4_ext_invalidate_cache(inode);
 
 	/*
-	 * we start scanning from right side freeing all the blocks
-	 * after i_size and walking into the deep
+	 * We start scanning from right side, freeing all the blocks
+	 * after i_size and walking into the tree depth-wise.
 	 */
 	path = kmalloc(sizeof(struct ext4_ext_path) * (depth + 1), GFP_KERNEL);
 	if (path == NULL) {
@@ -1749,7 +1777,7 @@ int ext4_ext_remove_space(struct inode *
 		if (i == depth) {
 			/* this is leaf block */
 			err = ext4_ext_rm_leaf(handle, inode, path, start);
-			/* root level have p_bh == NULL, brelse() eats this */
+			/* root level has p_bh == NULL, brelse() eats this */
 			brelse(path[i].p_bh);
 			path[i].p_bh = NULL;
 			i--;
@@ -1772,14 +1800,14 @@ int ext4_ext_remove_space(struct inode *
 		BUG_ON(path[i].p_hdr->eh_magic != EXT4_EXT_MAGIC);
 
 		if (!path[i].p_idx) {
-			/* this level hasn't touched yet */
+			/* this level hasn't been touched yet */
 			path[i].p_idx = EXT_LAST_INDEX(path[i].p_hdr);
 			path[i].p_block = le16_to_cpu(path[i].p_hdr->eh_entries)+1;
 			ext_debug("init index ptr: hdr 0x%p, num %d\n",
 				  path[i].p_hdr,
 				  le16_to_cpu(path[i].p_hdr->eh_entries));
 		} else {
-			/* we've already was here, see at next index */
+			/* we were already here, see at next index */
 			path[i].p_idx--;
 		}
 
@@ -1799,19 +1827,19 @@ int ext4_ext_remove_space(struct inode *
 				break;
 			}
 
-			/* put actual number of indexes to know is this
-			 * number got changed at the next iteration */
+			/* save actual number of indexes since this
+			 * number is changed at the next iteration */
 			path[i].p_block = le16_to_cpu(path[i].p_hdr->eh_entries);
 			i++;
 		} else {
-			/* we finish processing this index, go up */
+			/* we finished processing this index, go up */
 			if (path[i].p_hdr->eh_entries == 0 && i > 0) {
-				/* index is empty, remove it
+				/* index is empty, remove it;
 				 * handle must be already prepared by the
 				 * truncatei_leaf() */
 				err = ext4_ext_rm_idx(handle, inode, path + i);
 			}
-			/* root level have p_bh == NULL, brelse() eats this */
+			/* root level has p_bh == NULL, brelse() eats this */
 			brelse(path[i].p_bh);
 			path[i].p_bh = NULL;
 			i--;
@@ -1822,8 +1850,8 @@ int ext4_ext_remove_space(struct inode *
 	/* TODO: flexible tree reduction should be here */
 	if (path->p_hdr->eh_entries == 0) {
 		/*
-		 * truncate to zero freed all the tree
-		 * so, we need to correct eh_depth
+		 * truncate to zero freed all the tree,
+		 * so we need to correct eh_depth
 		 */
 		err = ext4_ext_get_access(handle, inode, path);
 		if (err == 0) {
@@ -1911,7 +1939,7 @@ int ext4_ext_get_blocks(handle_t *handle
 		if (goal == EXT4_EXT_CACHE_GAP) {
 			if (!create) {
 				/* block isn't allocated yet and
-				 * user don't want to allocate it */
+				 * user doesn't want to allocate it */
 				goto out2;
 			}
 			/* we should allocate requested block */
@@ -1920,7 +1948,7 @@ int ext4_ext_get_blocks(handle_t *handle
 		        newblock = iblock
 		                   - le32_to_cpu(newex.ee_block)
 			           + ext_pblock(&newex);
-			/* number of remain blocks in the extent */
+			/* number of remaining blocks in the extent */
 			allocated = le16_to_cpu(newex.ee_len) -
 					(iblock - le32_to_cpu(newex.ee_block));
 			goto out;
@@ -1940,8 +1968,8 @@ int ext4_ext_get_blocks(handle_t *handle
 	depth = ext_depth(inode);
 
 	/*
-	 * consistent leaf must not be empty
-	 * this situations is possible, though, _during_ tree modification
+	 * consistent leaf must not be empty;
+	 * this situation is possible, though, _during_ tree modification;
 	 * this is why assert can't be put in ext4_ext_find_extent()
 	 */
 	BUG_ON(path[depth].p_ext == NULL && depth != 0);
@@ -1959,10 +1987,10 @@ int ext4_ext_get_blocks(handle_t *handle
 		 */
 		if (ee_len > EXT_MAX_LEN)
 			goto out2;
-		/* if found exent covers block, simple return it */
+		/* if found extent covers block, simply return it */
 	        if (iblock >= ee_block && iblock < ee_block + ee_len) {
 			newblock = iblock - ee_block + ee_start;
-			/* number of remain blocks in the extent */
+			/* number of remaining blocks in the extent */
 			allocated = ee_len - (iblock - ee_block);
 			ext_debug("%d fit into %lu:%d -> "E3FSBLK"\n", (int) iblock,
 					ee_block, ee_len, newblock);
@@ -1973,17 +2001,18 @@ int ext4_ext_get_blocks(handle_t *handle
 	}
 
 	/*
-	 * requested block isn't allocated yet
+	 * requested block isn't allocated yet;
 	 * we couldn't try to create block if create flag is zero
 	 */
 	if (!create) {
-		/* put just found gap into cache to speedup subsequest reqs */
+		/* put just found gap into cache to speed up
+		 * subsequent requests */
 		ext4_ext_put_gap_in_cache(inode, path, iblock);
 		goto out2;
 	}
 	/*
          * Okay, we need to do block allocation.  Lazily initialize the block
-         * allocation info here if necessary
+         * allocation info here if necessary.
         */
 	if (S_ISREG(inode->i_mode) && (!EXT4_I(inode)->i_block_alloc_info))
 		ext4_init_block_alloc_info(inode);
@@ -2061,9 +2090,9 @@ void ext4_ext_truncate(struct inode * in
 	ext4_ext_invalidate_cache(inode);
 
 	/*
-	 * TODO: optimization is possible here
-	 * probably we need not scaning at all,
-	 * because page truncation is enough
+	 * TODO: optimization is possible here.
+	 * Probably we need not scan at all,
+	 * because page truncation is enough.
 	 */
 	if (ext4_orphan_add(handle, inode))
 		goto out_stop;
@@ -2077,13 +2106,13 @@ void ext4_ext_truncate(struct inode * in
 	err = ext4_ext_remove_space(inode, last_block);
 
 	/* In a multi-transaction truncate, we only make the final
-	 * transaction synchronous */
+	 * transaction synchronous. */
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
 
 out_stop:
 	/*
-	 * If this was a simple ftruncate(), and the file will remain alive
+	 * If this was a simple ftruncate() and the file will remain alive,
 	 * then we need to clear up the orphan record which we created above.
 	 * However, if this was a real unlink then we were called by
 	 * ext4_delete_inode(), and we allow that function to clean up the
@@ -2097,7 +2126,8 @@ out_stop:
 }
 
 /*
- * this routine calculate max number of blocks we could modify
+ * ext4_ext_writepage_trans_blocks:
+ * calculate max number of blocks we could modify
  * in order to allocate new block for an inode
  */
 int ext4_ext_writepage_trans_blocks(struct inode *inode, int num)
@@ -2106,7 +2136,7 @@ int ext4_ext_writepage_trans_blocks(stru
 
 	needed = ext4_ext_calc_credits_for_insert(inode, NULL);
 
-	/* caller want to allocate num blocks, but note it includes sb */
+	/* caller wants to allocate num blocks, but note it includes sb */
 	needed = needed * num - (num - 1);
 
 #ifdef CONFIG_QUOTA
