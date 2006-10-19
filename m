Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945961AbWJSBsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945961AbWJSBsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945965AbWJSBsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:48:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:14057 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1945961AbWJSBsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:48:02 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 4] struct path: Rename Reiserfs's struct path
Message-Id: <c247133482046c3d12f8.1161219428@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161219427@thor.fsl.cs.sunysb.edu>
Date: Wed, 18 Oct 2006 20:57:08 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, chris.mason@oracle.com,
       ezk@cs.sunysb.edu, penberg@cs.helsinki.fi, dm-devel@redhat.com,
       mingo@redhat.com, reiserfs-dev@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Rename Reiserfs's struct path to struct treepath to prevent name collision
between it and struct path from fs/namei.c.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

7 files changed, 58 insertions(+), 58 deletions(-)
fs/reiserfs/bitmap.c          |    2 -
fs/reiserfs/fix_node.c        |    6 ++---
fs/reiserfs/inode.c           |   12 +++++------
fs/reiserfs/namei.c           |    6 ++---
fs/reiserfs/stree.c           |   42 +++++++++++++++++++--------------------
fs/reiserfs/tail_conversion.c |    4 +--
include/linux/reiserfs_fs.h   |   44 ++++++++++++++++++++---------------------

diff --git a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c
+++ b/fs/reiserfs/bitmap.c
@@ -708,7 +708,7 @@ static void oid_groups(reiserfs_blocknr_
  */
 static int get_left_neighbor(reiserfs_blocknr_hint_t * hint)
 {
-	struct path *path;
+	struct treepath *path;
 	struct buffer_head *bh;
 	struct item_head *ih;
 	int pos_in_item;
diff --git a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
--- a/fs/reiserfs/fix_node.c
+++ b/fs/reiserfs/fix_node.c
@@ -957,7 +957,7 @@ static int get_far_parent(struct tree_ba
 {
 	struct buffer_head *p_s_parent;
 	INITIALIZE_PATH(s_path_to_neighbor_father);
-	struct path *p_s_path = p_s_tb->tb_path;
+	struct treepath *p_s_path = p_s_tb->tb_path;
 	struct cpu_key s_lr_father_key;
 	int n_counter,
 	    n_position = INT_MAX,
@@ -1074,7 +1074,7 @@ static int get_far_parent(struct tree_ba
  */
 static int get_parents(struct tree_balance *p_s_tb, int n_h)
 {
-	struct path *p_s_path = p_s_tb->tb_path;
+	struct treepath *p_s_path = p_s_tb->tb_path;
 	int n_position,
 	    n_ret_value,
 	    n_path_offset = PATH_H_PATH_OFFSET(p_s_tb->tb_path, n_h);
@@ -1885,7 +1885,7 @@ static int get_direct_parent(struct tree
 static int get_direct_parent(struct tree_balance *p_s_tb, int n_h)
 {
 	struct buffer_head *p_s_bh;
-	struct path *p_s_path = p_s_tb->tb_path;
+	struct treepath *p_s_path = p_s_tb->tb_path;
 	int n_position,
 	    n_path_offset = PATH_H_PATH_OFFSET(p_s_tb->tb_path, n_h);
 
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -207,7 +207,7 @@ static int file_capable(struct inode *in
 }
 
 /*static*/ int restart_transaction(struct reiserfs_transaction_handle *th,
-				   struct inode *inode, struct path *path)
+				   struct inode *inode, struct treepath *path)
 {
 	struct super_block *s = th->t_super;
 	int len = th->t_blocks_allocated;
@@ -569,7 +569,7 @@ static inline int _allocate_block(struct
 				  long block,
 				  struct inode *inode,
 				  b_blocknr_t * allocated_block_nr,
-				  struct path *path, int flags)
+				  struct treepath *path, int flags)
 {
 	BUG_ON(!th->t_trans_id);
 
@@ -1109,7 +1109,7 @@ static inline ulong to_fake_used_blocks(
 //
 
 // called by read_locked_inode
-static void init_inode(struct inode *inode, struct path *path)
+static void init_inode(struct inode *inode, struct treepath *path)
 {
 	struct buffer_head *bh;
 	struct item_head *ih;
@@ -1286,7 +1286,7 @@ static void inode2sd_v1(void *sd, struct
 /* NOTE, you must prepare the buffer head before sending it here,
 ** and then log it after the call
 */
-static void update_stat_data(struct path *path, struct inode *inode,
+static void update_stat_data(struct treepath *path, struct inode *inode,
 			     loff_t size)
 {
 	struct buffer_head *bh;
@@ -1655,7 +1655,7 @@ int reiserfs_write_inode(struct inode *i
    containing "." and ".." entries */
 static int reiserfs_new_directory(struct reiserfs_transaction_handle *th,
 				  struct inode *inode,
-				  struct item_head *ih, struct path *path,
+				  struct item_head *ih, struct treepath *path,
 				  struct inode *dir)
 {
 	struct super_block *sb = th->t_super;
@@ -1714,7 +1714,7 @@ static int reiserfs_new_directory(struct
    containing the body of symlink */
 static int reiserfs_new_symlink(struct reiserfs_transaction_handle *th, struct inode *inode,	/* Inode of symlink */
 				struct item_head *ih,
-				struct path *path, const char *symname,
+				struct treepath *path, const char *symname,
 				int item_len)
 {
 	struct super_block *sb = th->t_super;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -54,7 +54,7 @@ static int bin_search_in_dir_item(struct
 
 // comment?  maybe something like set de to point to what the path points to?
 static inline void set_de_item_location(struct reiserfs_dir_entry *de,
-					struct path *path)
+					struct treepath *path)
 {
 	de->de_bh = get_last_bh(path);
 	de->de_ih = get_ih(path);
@@ -113,7 +113,7 @@ entry position in the item
 
 /* The function is NOT SCHEDULE-SAFE! */
 int search_by_entry_key(struct super_block *sb, const struct cpu_key *key,
-			struct path *path, struct reiserfs_dir_entry *de)
+			struct treepath *path, struct reiserfs_dir_entry *de)
 {
 	int retval;
 
@@ -282,7 +282,7 @@ static int linear_search_in_dir_item(str
 // may return NAME_FOUND, NAME_FOUND_INVISIBLE, NAME_NOT_FOUND
 // FIXME: should add something like IOERROR
 static int reiserfs_find_entry(struct inode *dir, const char *name, int namelen,
-			       struct path *path_to_entry,
+			       struct treepath *path_to_entry,
 			       struct reiserfs_dir_entry *de)
 {
 	struct cpu_key key_to_search;
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -244,7 +244,7 @@ static const struct reiserfs_key MAX_KEY
    of the path, and going upwards.  We must check the path's validity at each step.  If the key is not in
    the path, there is no delimiting key in the tree (buffer is first or last buffer in tree), and in this
    case we return a special key, either MIN_KEY or MAX_KEY. */
-static inline const struct reiserfs_key *get_lkey(const struct path
+static inline const struct reiserfs_key *get_lkey(const struct treepath
 						  *p_s_chk_path,
 						  const struct super_block
 						  *p_s_sb)
@@ -290,7 +290,7 @@ static inline const struct reiserfs_key 
 }
 
 /* Get delimiting key of the buffer at the path and its right neighbor. */
-inline const struct reiserfs_key *get_rkey(const struct path *p_s_chk_path,
+inline const struct reiserfs_key *get_rkey(const struct treepath *p_s_chk_path,
 					   const struct super_block *p_s_sb)
 {
 	int n_position, n_path_offset = p_s_chk_path->path_length;
@@ -337,7 +337,7 @@ inline const struct reiserfs_key *get_rk
    the path.  These delimiting keys are stored at least one level above that buffer in the tree. If the
    buffer is the first or last node in the tree order then one of the delimiting keys may be absent, and in
    this case get_lkey and get_rkey return a special key which is MIN_KEY or MAX_KEY. */
-static inline int key_in_buffer(struct path *p_s_chk_path,	/* Path which should be checked.  */
+static inline int key_in_buffer(struct treepath *p_s_chk_path,	/* Path which should be checked.  */
 				const struct cpu_key *p_s_key,	/* Key which should be checked.   */
 				struct super_block *p_s_sb	/* Super block pointer.           */
     )
@@ -374,7 +374,7 @@ inline void decrement_bcount(struct buff
 }
 
 /* Decrement b_count field of the all buffers in the path. */
-void decrement_counters_in_path(struct path *p_s_search_path)
+void decrement_counters_in_path(struct treepath *p_s_search_path)
 {
 	int n_path_offset = p_s_search_path->path_length;
 
@@ -391,7 +391,7 @@ void decrement_counters_in_path(struct p
 	p_s_search_path->path_length = ILLEGAL_PATH_ELEMENT_OFFSET;
 }
 
-int reiserfs_check_path(struct path *p)
+int reiserfs_check_path(struct treepath *p)
 {
 	RFALSE(p->path_length != ILLEGAL_PATH_ELEMENT_OFFSET,
 	       "path not properly relsed");
@@ -403,7 +403,7 @@ int reiserfs_check_path(struct path *p)
 **
 ** only called from fix_nodes()
 */
-void pathrelse_and_restore(struct super_block *s, struct path *p_s_search_path)
+void pathrelse_and_restore(struct super_block *s, struct treepath *p_s_search_path)
 {
 	int n_path_offset = p_s_search_path->path_length;
 
@@ -421,7 +421,7 @@ void pathrelse_and_restore(struct super_
 }
 
 /* Release all buffers in the path. */
-void pathrelse(struct path *p_s_search_path)
+void pathrelse(struct treepath *p_s_search_path)
 {
 	int n_path_offset = p_s_search_path->path_length;
 
@@ -602,7 +602,7 @@ static void search_by_key_reada(struct s
    correctness of the bottom of the path */
 /* The function is NOT SCHEDULE-SAFE! */
 int search_by_key(struct super_block *p_s_sb, const struct cpu_key *p_s_key,	/* Key to search. */
-		  struct path *p_s_search_path,	/* This structure was
+		  struct treepath *p_s_search_path,/* This structure was
 						   allocated and initialized
 						   by the calling
 						   function. It is filled up
@@ -813,7 +813,7 @@ int search_by_key(struct super_block *p_
 /* The function is NOT SCHEDULE-SAFE! */
 int search_for_position_by_key(struct super_block *p_s_sb,	/* Pointer to the super block.          */
 			       const struct cpu_key *p_cpu_key,	/* Key to search (cpu variable)         */
-			       struct path *p_s_search_path	/* Filled up by this function.          */
+			       struct treepath *p_s_search_path	/* Filled up by this function.          */
     )
 {
 	struct item_head *p_le_ih;	/* pointer to on-disk structure */
@@ -884,7 +884,7 @@ int search_for_position_by_key(struct su
 }
 
 /* Compare given item and item pointed to by the path. */
-int comp_items(const struct item_head *stored_ih, const struct path *p_s_path)
+int comp_items(const struct item_head *stored_ih, const struct treepath *p_s_path)
 {
 	struct buffer_head *p_s_bh;
 	struct item_head *ih;
@@ -911,7 +911,7 @@ int comp_items(const struct item_head *s
 #define block_in_use(bh) (buffer_locked(bh) || (held_by_others(bh)))
 
 // prepare for delete or cut of direct item
-static inline int prepare_for_direct_item(struct path *path,
+static inline int prepare_for_direct_item(struct treepath *path,
 					  struct item_head *le_ih,
 					  struct inode *inode,
 					  loff_t new_file_length, int *cut_size)
@@ -952,7 +952,7 @@ static inline int prepare_for_direct_ite
 	return M_CUT;		/* Cut from this item. */
 }
 
-static inline int prepare_for_direntry_item(struct path *path,
+static inline int prepare_for_direntry_item(struct treepath *path,
 					    struct item_head *le_ih,
 					    struct inode *inode,
 					    loff_t new_file_length,
@@ -987,7 +987,7 @@ static inline int prepare_for_direntry_i
     In case of file truncate calculate whether this item must be deleted/truncated or last
     unformatted node of this item will be converted to a direct item.
     This function returns a determination of what balance mode the calling function should employ. */
-static char prepare_for_delete_or_cut(struct reiserfs_transaction_handle *th, struct inode *inode, struct path *p_s_path, const struct cpu_key *p_s_item_key, int *p_n_removed,	/* Number of unformatted nodes which were removed
+static char prepare_for_delete_or_cut(struct reiserfs_transaction_handle *th, struct inode *inode, struct treepath *p_s_path, const struct cpu_key *p_s_item_key, int *p_n_removed,	/* Number of unformatted nodes which were removed
 																						   from end of the file. */
 				      int *p_n_cut_size, unsigned long long n_new_file_length	/* MAX_KEY_OFFSET in case of delete. */
     )
@@ -1125,7 +1125,7 @@ static void init_tb_struct(struct reiser
 static void init_tb_struct(struct reiserfs_transaction_handle *th,
 			   struct tree_balance *p_s_tb,
 			   struct super_block *p_s_sb,
-			   struct path *p_s_path, int n_size)
+			   struct treepath *p_s_path, int n_size)
 {
 
 	BUG_ON(!th->t_trans_id);
@@ -1176,7 +1176,7 @@ char head2type(struct item_head *ih)
 #endif
 
 /* Delete object item. */
-int reiserfs_delete_item(struct reiserfs_transaction_handle *th, struct path *p_s_path,	/* Path to the deleted item. */
+int reiserfs_delete_item(struct reiserfs_transaction_handle *th, struct treepath *p_s_path,	/* Path to the deleted item. */
 			 const struct cpu_key *p_s_item_key,	/* Key to search for the deleted item.  */
 			 struct inode *p_s_inode,	/* inode is here just to update i_blocks and quotas */
 			 struct buffer_head *p_s_un_bh)
@@ -1468,7 +1468,7 @@ static int maybe_indirect_to_direct(stru
 static int maybe_indirect_to_direct(struct reiserfs_transaction_handle *th,
 				    struct inode *p_s_inode,
 				    struct page *page,
-				    struct path *p_s_path,
+				    struct treepath *p_s_path,
 				    const struct cpu_key *p_s_item_key,
 				    loff_t n_new_file_size, char *p_c_mode)
 {
@@ -1503,7 +1503,7 @@ static int maybe_indirect_to_direct(stru
    pointer being converted. Therefore we have to delete inserted
    direct item(s) */
 static void indirect_to_direct_roll_back(struct reiserfs_transaction_handle *th,
-					 struct inode *inode, struct path *path)
+					 struct inode *inode, struct treepath *path)
 {
 	struct cpu_key tail_key;
 	int tail_len;
@@ -1545,7 +1545,7 @@ static void indirect_to_direct_roll_back
 
 /* (Truncate or cut entry) or delete object item. Returns < 0 on failure */
 int reiserfs_cut_from_item(struct reiserfs_transaction_handle *th,
-			   struct path *p_s_path,
+			   struct treepath *p_s_path,
 			   struct cpu_key *p_s_item_key,
 			   struct inode *p_s_inode,
 			   struct page *page, loff_t n_new_file_size)
@@ -1920,7 +1920,7 @@ int reiserfs_do_truncate(struct reiserfs
 
 #ifdef CONFIG_REISERFS_CHECK
 // this makes sure, that we __append__, not overwrite or add holes
-static void check_research_for_paste(struct path *path,
+static void check_research_for_paste(struct treepath *path,
 				     const struct cpu_key *p_s_key)
 {
 	struct item_head *found_ih = get_ih(path);
@@ -1954,7 +1954,7 @@ static void check_research_for_paste(str
 #endif				/* config reiserfs check */
 
 /* Paste bytes to the existing item. Returns bytes number pasted into the item. */
-int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th, struct path *p_s_search_path,	/* Path to the pasted item.          */
+int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th, struct treepath *p_s_search_path,	/* Path to the pasted item.          */
 			     const struct cpu_key *p_s_key,	/* Key to search for the needed item. */
 			     struct inode *inode,	/* Inode item belongs to */
 			     const char *p_c_body,	/* Pointer to the bytes to paste.    */
@@ -2036,7 +2036,7 @@ int reiserfs_paste_into_item(struct reis
 }
 
 /* Insert new item into the buffer at the path. */
-int reiserfs_insert_item(struct reiserfs_transaction_handle *th, struct path *p_s_path,	/* Path to the inserteded item.         */
+int reiserfs_insert_item(struct reiserfs_transaction_handle *th, struct treepath *p_s_path,	/* Path to the inserteded item.         */
 			 const struct cpu_key *key, struct item_head *p_s_ih,	/* Pointer to the item header to insert. */
 			 struct inode *inode, const char *p_c_body)
 {				/* Pointer to the bytes to insert.      */
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -15,7 +15,7 @@
 /* path points to first direct item of the file regarless of how many of
    them are there */
 int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
-		    struct path *path, struct buffer_head *unbh,
+		    struct treepath *path, struct buffer_head *unbh,
 		    loff_t tail_offset)
 {
 	struct super_block *sb = inode->i_sb;
@@ -171,7 +171,7 @@ void reiserfs_unmap_buffer(struct buffer
    what we expect from it (number of cut bytes). But when tail remains
    in the unformatted node, we set mode to SKIP_BALANCING and unlock
    inode */
-int indirect2direct(struct reiserfs_transaction_handle *th, struct inode *p_s_inode, struct page *page, struct path *p_s_path,	/* path to the indirect item. */
+int indirect2direct(struct reiserfs_transaction_handle *th, struct inode *p_s_inode, struct page *page, struct treepath *p_s_path,	/* path to the indirect item. */
 		    const struct cpu_key *p_s_item_key,	/* Key to look for unformatted node pointer to be cut. */
 		    loff_t n_new_file_size,	/* New file size. */
 		    char *p_c_mode)
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -1159,7 +1159,7 @@ znodes are the way! */
 #define PATH_READA	0x1	/* do read ahead */
 #define PATH_READA_BACK 0x2	/* read backwards */
 
-struct path {
+struct treepath {
 	int path_length;	/* Length of the array above.   */
 	int reada;
 	struct path_element path_elements[EXTENDED_MAX_HEIGHT];	/* Array of the path elements.  */
@@ -1169,7 +1169,7 @@ struct path {
 #define pos_in_item(path) ((path)->pos_in_item)
 
 #define INITIALIZE_PATH(var) \
-struct path var = {.path_length = ILLEGAL_PATH_ELEMENT_OFFSET, .reada = 0,}
+struct treepath var = {.path_length = ILLEGAL_PATH_ELEMENT_OFFSET, .reada = 0,}
 
 /* Get path element by path and path position. */
 #define PATH_OFFSET_PELEMENT(p_s_path,n_offset)  ((p_s_path)->path_elements +(n_offset))
@@ -1327,7 +1327,7 @@ struct tree_balance {
 	int need_balance_dirty;
 	struct super_block *tb_sb;
 	struct reiserfs_transaction_handle *transaction_handle;
-	struct path *tb_path;
+	struct treepath *tb_path;
 	struct buffer_head *L[MAX_HEIGHT];	/* array of left neighbors of nodes in the path */
 	struct buffer_head *R[MAX_HEIGHT];	/* array of right neighbors of nodes in the path */
 	struct buffer_head *FL[MAX_HEIGHT];	/* array of fathers of the left  neighbors      */
@@ -1793,41 +1793,41 @@ static inline void copy_key(struct reise
 	memcpy(to, from, KEY_SIZE);
 }
 
-int comp_items(const struct item_head *stored_ih, const struct path *p_s_path);
-const struct reiserfs_key *get_rkey(const struct path *p_s_chk_path,
+int comp_items(const struct item_head *stored_ih, const struct treepath *p_s_path);
+const struct reiserfs_key *get_rkey(const struct treepath *p_s_chk_path,
 				    const struct super_block *p_s_sb);
 int search_by_key(struct super_block *, const struct cpu_key *,
-		  struct path *, int);
+		  struct treepath *, int);
 #define search_item(s,key,path) search_by_key (s, key, path, DISK_LEAF_NODE_LEVEL)
 int search_for_position_by_key(struct super_block *p_s_sb,
 			       const struct cpu_key *p_s_cpu_key,
-			       struct path *p_s_search_path);
+			       struct treepath *p_s_search_path);
 extern void decrement_bcount(struct buffer_head *p_s_bh);
-void decrement_counters_in_path(struct path *p_s_search_path);
-void pathrelse(struct path *p_s_search_path);
-int reiserfs_check_path(struct path *p);
-void pathrelse_and_restore(struct super_block *s, struct path *p_s_search_path);
+void decrement_counters_in_path(struct treepath *p_s_search_path);
+void pathrelse(struct treepath *p_s_search_path);
+int reiserfs_check_path(struct treepath *p);
+void pathrelse_and_restore(struct super_block *s, struct treepath *p_s_search_path);
 
 int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
-			 struct path *path,
+			 struct treepath *path,
 			 const struct cpu_key *key,
 			 struct item_head *ih,
 			 struct inode *inode, const char *body);
 
 int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
-			     struct path *path,
+			     struct treepath *path,
 			     const struct cpu_key *key,
 			     struct inode *inode,
 			     const char *body, int paste_size);
 
 int reiserfs_cut_from_item(struct reiserfs_transaction_handle *th,
-			   struct path *path,
+			   struct treepath *path,
 			   struct cpu_key *key,
 			   struct inode *inode,
 			   struct page *page, loff_t new_file_size);
 
 int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
-			 struct path *path,
+			 struct treepath *path,
 			 const struct cpu_key *key,
 			 struct inode *inode, struct buffer_head *p_s_un_bh);
 
@@ -1858,7 +1858,7 @@ void padd_item(char *item, int total_len
 #define GET_BLOCK_NO_DANGLE   16	/* don't leave any transactions running */
 
 int restart_transaction(struct reiserfs_transaction_handle *th,
-			struct inode *inode, struct path *path);
+			struct inode *inode, struct treepath *path);
 void reiserfs_read_locked_inode(struct inode *inode,
 				struct reiserfs_iget_args *args);
 int reiserfs_find_actor(struct inode *inode, void *p);
@@ -1905,7 +1905,7 @@ int reiserfs_setattr(struct dentry *dent
 /* namei.c */
 void set_de_name_and_namelen(struct reiserfs_dir_entry *de);
 int search_by_entry_key(struct super_block *sb, const struct cpu_key *key,
-			struct path *path, struct reiserfs_dir_entry *de);
+			struct treepath *path, struct reiserfs_dir_entry *de);
 struct dentry *reiserfs_get_parent(struct dentry *);
 /* procfs.c */
 
@@ -1956,9 +1956,9 @@ extern const struct file_operations reis
 
 /* tail_conversion.c */
 int direct2indirect(struct reiserfs_transaction_handle *, struct inode *,
-		    struct path *, struct buffer_head *, loff_t);
+		    struct treepath *, struct buffer_head *, loff_t);
 int indirect2direct(struct reiserfs_transaction_handle *, struct inode *,
-		    struct page *, struct path *, const struct cpu_key *,
+		    struct page *, struct treepath *, const struct cpu_key *,
 		    loff_t, char *);
 void reiserfs_unmap_buffer(struct buffer_head *);
 
@@ -2045,7 +2045,7 @@ struct __reiserfs_blocknr_hint {
 	struct inode *inode;	/* inode passed to allocator, if we allocate unf. nodes */
 	long block;		/* file offset, in blocks */
 	struct in_core_key key;
-	struct path *path;	/* search path, used by allocator to deternine search_start by
+	struct treepath *path;	/* search path, used by allocator to deternine search_start by
 				 * various ways */
 	struct reiserfs_transaction_handle *th;	/* transaction handle is needed to log super blocks and
 						 * bitmap blocks changes  */
@@ -2101,7 +2101,7 @@ static inline int reiserfs_new_unf_block
 static inline int reiserfs_new_unf_blocknrs(struct reiserfs_transaction_handle
 					    *th, struct inode *inode,
 					    b_blocknr_t * new_blocknrs,
-					    struct path *path, long block)
+					    struct treepath *path, long block)
 {
 	reiserfs_blocknr_hint_t hint = {
 		.th = th,
@@ -2118,7 +2118,7 @@ static inline int reiserfs_new_unf_block
 static inline int reiserfs_new_unf_blocknrs2(struct reiserfs_transaction_handle
 					     *th, struct inode *inode,
 					     b_blocknr_t * new_blocknrs,
-					     struct path *path, long block)
+					     struct treepath *path, long block)
 {
 	reiserfs_blocknr_hint_t hint = {
 		.th = th,


