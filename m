Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVDUBNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDUBNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 21:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVDUBNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 21:13:33 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:11717 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261544AbVDUBKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 21:10:48 -0400
Date: Thu, 21 Apr 2005 03:10:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] squashfs: (void*)ify squashfs_get_cached_block
Message-ID: <20050421011045.GC29755@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050421010817.GB29755@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c    |   58 ++++++++++++++++++++++++-------------------------
 fs/squashfs/squashfs.h |    2 -
 2 files changed, 30 insertions(+), 30 deletions(-)

--- linux-2.6.12-rc2cow/fs/squashfs/inode.c~squashfs_cu3	2005-04-20 16:34:43.619956672 +0200
+++ linux-2.6.12-rc2cow/fs/squashfs/inode.c	2005-04-20 16:40:47.498638704 +0200
@@ -280,7 +280,7 @@ read_failure:
 }
 
 
-int squashfs_get_cached_block(struct super_block *s, char *buffer,
+int squashfs_get_cached_block(struct super_block *s, void *buffer,
 				unsigned int block, unsigned int offset,
 				int length, unsigned int *next_block,
 				unsigned int *next_offset)
@@ -399,14 +399,14 @@ static int get_fragment_location(struct 
 	if (msBlk->swap) {
 		squashfs_fragment_entry sfragment_entry;
 
-		if (!squashfs_get_cached_block(s, (char *) &sfragment_entry,
+		if (!squashfs_get_cached_block(s, &sfragment_entry,
 					start_block, offset,
 					sizeof(sfragment_entry), &start_block,
 					&offset))
 			return 0;
 		SQUASHFS_SWAP_FRAGMENT_ENTRY(&fragment_entry, &sfragment_entry);
 	} else
-		if (!squashfs_get_cached_block(s, (char *) &fragment_entry,
+		if (!squashfs_get_cached_block(s, &fragment_entry,
 					start_block, offset,
 					sizeof(fragment_entry), &start_block,
 					&offset))
@@ -549,14 +549,14 @@ static struct inode *squashfs_iget(struc
 	if (msBlk->swap) {
 		squashfs_base_inode_header sinodeb;
 
-		if (!squashfs_get_cached_block(s, (char *) &sinodeb, block,
+		if (!squashfs_get_cached_block(s, &sinodeb, block,
 					offset, sizeof(sinodeb), &next_block,
 					&next_offset))
 			goto failed_read;
 		SQUASHFS_SWAP_BASE_INODE_HEADER(&inodeb, &sinodeb,
 					sizeof(sinodeb));
 	} else
-		if (!squashfs_get_cached_block(s, (char *) &inodeb, block,
+		if (!squashfs_get_cached_block(s, &inodeb, block,
 					offset, sizeof(inodeb), &next_block,
 					&next_offset))
 			goto failed_read;
@@ -569,7 +569,7 @@ static struct inode *squashfs_iget(struc
 			if (msBlk->swap) {
 				squashfs_reg_inode_header sinodep;
 
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&sinodep, block, offset,
 						sizeof(sinodep), &next_block,
 						&next_offset))
@@ -577,7 +577,7 @@ static struct inode *squashfs_iget(struc
 				SQUASHFS_SWAP_REG_INODE_HEADER(&inodep,
 								&sinodep);
 			} else
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&inodep, block, offset,
 						sizeof(inodep), &next_block,
 						&next_offset))
@@ -624,7 +624,7 @@ static struct inode *squashfs_iget(struc
 			if (msBlk->swap) {
 				squashfs_dir_inode_header sinodep;
 
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&sinodep, block, offset,
 						sizeof(sinodep), &next_block,
 						&next_offset))
@@ -632,7 +632,7 @@ static struct inode *squashfs_iget(struc
 				SQUASHFS_SWAP_DIR_INODE_HEADER(&inodep,
 								&sinodep);
 			} else
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&inodep, block, offset,
 						sizeof(inodep), &next_block,
 						&next_offset))
@@ -664,7 +664,7 @@ static struct inode *squashfs_iget(struc
 			if (msBlk->swap) {
 				squashfs_ldir_inode_header sinodep;
 
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&sinodep, block, offset,
 						sizeof(sinodep), &next_block,
 						&next_offset))
@@ -672,7 +672,7 @@ static struct inode *squashfs_iget(struc
 				SQUASHFS_SWAP_LDIR_INODE_HEADER(&inodep,
 								&sinodep);
 			} else
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&inodep, block, offset,
 						sizeof(inodep), &next_block,
 						&next_offset))
@@ -708,7 +708,7 @@ static struct inode *squashfs_iget(struc
 			if (msBlk->swap) {
 				squashfs_symlink_inode_header sinodep;
 
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&sinodep, block, offset,
 						sizeof(sinodep), &next_block,
 						&next_offset))
@@ -716,7 +716,7 @@ static struct inode *squashfs_iget(struc
 				SQUASHFS_SWAP_SYMLINK_INODE_HEADER(&inodep,
 								&sinodep);
 			} else
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&inodep, block, offset,
 						sizeof(inodep), &next_block,
 						&next_offset))
@@ -745,7 +745,7 @@ static struct inode *squashfs_iget(struc
 			if (msBlk->swap) {
 				squashfs_dev_inode_header sinodep;
 
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&sinodep, block, offset,
 						sizeof(sinodep), &next_block,
 						&next_offset))
@@ -753,7 +753,7 @@ static struct inode *squashfs_iget(struc
 				SQUASHFS_SWAP_DEV_INODE_HEADER(&inodep,
 					&sinodep);
 			} else	
-				if (!squashfs_get_cached_block(s, (char *)
+				if (!squashfs_get_cached_block(s,
 						&inodep, block, offset,
 						sizeof(inodep), &next_block,
 						&next_offset))
@@ -1139,7 +1139,7 @@ static unsigned int read_blocklist(struc
 		if (msBlk->swap) {
 			unsigned char sblock_list[SIZE];
 
-			if (!squashfs_get_cached_block(inode->i_sb, (char *)
+			if (!squashfs_get_cached_block(inode->i_sb,
 					sblock_list, block_ptr,
 					offset, blocks << 2, &block_ptr,
 					&offset)) {
@@ -1150,7 +1150,7 @@ static unsigned int read_blocklist(struc
 			SQUASHFS_SWAP_INTS(((unsigned int *)block_list),
 					((unsigned int *)sblock_list), blocks);
 		} else
-			if (!squashfs_get_cached_block(inode->i_sb, (char *)
+			if (!squashfs_get_cached_block(inode->i_sb,
 					block_list, block_ptr, offset,
 					blocks << 2, &block_ptr,
 					&offset)) {
@@ -1366,13 +1366,13 @@ static int get_dir_index_using_offset(st
 	for (i = 0; i < i_count; i++) {
 		if (msBlk->swap) {
 			squashfs_dir_index sindex;
-			squashfs_get_cached_block(s, (char *) &sindex,
+			squashfs_get_cached_block(s, &sindex,
 					index_start, index_offset,
 					sizeof(sindex), &index_start,
 					&index_offset);
 			SQUASHFS_SWAP_DIR_INDEX(&index, &sindex);
 		} else
-			squashfs_get_cached_block(s, (char *) &index,
+			squashfs_get_cached_block(s, &index,
 					index_start, index_offset,
 					sizeof(index), &index_start,
 					&index_offset);
@@ -1414,13 +1414,13 @@ static int get_dir_index_using_name(stru
 	for (i = 0; i < i_count; i++) {
 		if (msBlk->swap) {
 			squashfs_dir_index sindex;
-			squashfs_get_cached_block(s, (char *) &sindex,
+			squashfs_get_cached_block(s, &sindex,
 					index_start, index_offset,
 					sizeof(sindex), &index_start,
 					&index_offset);
 			SQUASHFS_SWAP_DIR_INDEX(index, &sindex);
 		} else
-			squashfs_get_cached_block(s, (char *) index,
+			squashfs_get_cached_block(s, index,
 					index_start, index_offset,
 					sizeof(squashfs_dir_index),
 					&index_start, &index_offset);
@@ -1472,7 +1472,7 @@ static int squashfs_readdir(struct file 
 		if (msBlk->swap) {
 			squashfs_dir_header sdirh;
 			
-			if (!squashfs_get_cached_block(i->i_sb, (char *) &sdirh,
+			if (!squashfs_get_cached_block(i->i_sb, &sdirh,
 					next_block, next_offset, sizeof(sdirh),
 					&next_block, &next_offset))
 				goto failed_read;
@@ -1480,7 +1480,7 @@ static int squashfs_readdir(struct file 
 			length += sizeof(sdirh);
 			SQUASHFS_SWAP_DIR_HEADER(&dirh, &sdirh);
 		} else {
-			if (!squashfs_get_cached_block(i->i_sb, (char *) &dirh,
+			if (!squashfs_get_cached_block(i->i_sb, &dirh,
 					next_block, next_offset, sizeof(dirh),
 					&next_block, &next_offset))
 				goto failed_read;
@@ -1492,7 +1492,7 @@ static int squashfs_readdir(struct file 
 		while (dir_count--) {
 			if (msBlk->swap) {
 				squashfs_dir_entry sdire;
-				if (!squashfs_get_cached_block(i->i_sb, (char *)
+				if (!squashfs_get_cached_block(i->i_sb,
 						&sdire, next_block, next_offset,
 						sizeof(sdire), &next_block,
 						&next_offset))
@@ -1501,7 +1501,7 @@ static int squashfs_readdir(struct file 
 				length += sizeof(sdire);
 				SQUASHFS_SWAP_DIR_ENTRY(dire, &sdire);
 			} else {
-				if (!squashfs_get_cached_block(i->i_sb, (char *)
+				if (!squashfs_get_cached_block(i->i_sb,
 						dire, next_block, next_offset,
 						sizeof(*dire), &next_block,
 						&next_offset))
@@ -1587,7 +1587,7 @@ static struct dentry *squashfs_lookup(st
 		/* read directory header */
 		if (msBlk->swap) {
 			squashfs_dir_header sdirh;
-			if (!squashfs_get_cached_block(i->i_sb, (char *) &sdirh,
+			if (!squashfs_get_cached_block(i->i_sb, &sdirh,
 					next_block, next_offset, sizeof(sdirh),
 					&next_block, &next_offset))
 				goto failed_read;
@@ -1595,7 +1595,7 @@ static struct dentry *squashfs_lookup(st
 			length += sizeof(sdirh);
 			SQUASHFS_SWAP_DIR_HEADER(&dirh, &sdirh);
 		} else {
-			if (!squashfs_get_cached_block(i->i_sb, (char *) &dirh,
+			if (!squashfs_get_cached_block(i->i_sb, &dirh,
 					next_block, next_offset, sizeof(dirh),
 					&next_block, &next_offset))
 				goto failed_read;
@@ -1607,7 +1607,7 @@ static struct dentry *squashfs_lookup(st
 		while (dir_count--) {
 			if (msBlk->swap) {
 				squashfs_dir_entry sdire;
-				if (!squashfs_get_cached_block(i->i_sb, (char *)
+				if (!squashfs_get_cached_block(i->i_sb,
 						&sdire, next_block,next_offset,
 						sizeof(sdire), &next_block,
 						&next_offset))
@@ -1616,7 +1616,7 @@ static struct dentry *squashfs_lookup(st
 				length += sizeof(sdire);
 				SQUASHFS_SWAP_DIR_ENTRY(dire, &sdire);
 			} else {
-				if (!squashfs_get_cached_block(i->i_sb, (char *)
+				if (!squashfs_get_cached_block(i->i_sb,
 						dire, next_block,next_offset,
 						sizeof(*dire), &next_block,
 						&next_offset))
--- linux-2.6.12-rc2cow/fs/squashfs/squashfs.h~squashfs_cu3	2005-04-20 07:52:50.000000000 +0200
+++ linux-2.6.12-rc2cow/fs/squashfs/squashfs.h	2005-04-20 16:37:15.900806464 +0200
@@ -40,7 +40,7 @@
 extern unsigned int squashfs_read_data(struct super_block *s, char *buffer,
 				unsigned int index, unsigned int length,
 				unsigned int *next_index);
-extern int squashfs_get_cached_block(struct super_block *s, char *buffer,
+extern int squashfs_get_cached_block(struct super_block *s, void *buffer,
 				unsigned int block, unsigned int offset,
 				int length, unsigned int *next_block,
 				unsigned int *next_offset);
