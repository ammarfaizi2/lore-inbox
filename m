Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315865AbSEGPNd>; Tue, 7 May 2002 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315866AbSEGPND>; Tue, 7 May 2002 11:13:03 -0400
Received: from backtop.namesys.com ([212.16.7.71]:7297 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315865AbSEGPLO>;
	Tue, 7 May 2002 11:11:14 -0400
Date: Tue, 7 May 2002 19:05:44 +0400
From: Hans Reiser <reiser@namesys.com>
Message-Id: <200205071505.g47F5iE04039@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.4] Reiserfs changeset 2 out of 4, please apply.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

 You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

 This changeset are cleaning up reiserfscode, removes stale comments, and
 rewrites some "borrowed" functions so that all of the code in reiserfs subdir
 should now only belong to NAMESYS.
 
Diffstat:
 fs/reiserfs/bitmap.c        |    5 
 fs/reiserfs/dir.c           |    4 
 fs/reiserfs/inode.c         |   37 ----
 fs/reiserfs/namei.c         |  184 ++++++------------------
 fs/reiserfs/super.c         |  326 ++++++++++++++++++++++++++------------------
 include/linux/reiserfs_fs.h |    4 
 6 files changed, 250 insertions(+), 310 deletions(-)

Plain test patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.383.2.38 -> 1.383.2.39
#	   fs/reiserfs/dir.c	1.11    -> 1.12   
#	 fs/reiserfs/namei.c	1.19    -> 1.20   
#	 fs/reiserfs/inode.c	1.32    -> 1.33   
#	include/linux/reiserfs_fs.h	1.16    -> 1.17   
#	 fs/reiserfs/super.c	1.19    -> 1.20   
#	fs/reiserfs/bitmap.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/30	green@angband.namesys.com	1.383.2.39
# reiserfs_fs.h, super.c, namei.c, inode.c, dir.c, bitmap.c:
#   Here is a patch which remakes in original manner last bits in reiserfs
#   code which looked like created by copy-n-paste-ing from other sources.
#   Most of them are removed comments, some are adding intermidiate
#   variables. The only one interesting change is new
#   reiserfs_parse_options.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Tue May  7 17:54:11 2002
+++ b/fs/reiserfs/bitmap.c	Tue May  7 17:54:11 2002
@@ -663,10 +663,7 @@
   return ret;
 }
 
-//
-// a portion of this function, was derived from minix or ext2's
-// analog. You should be able to tell which portion by looking at the
-// ext2 code and comparing. 
+
 static void __discard_prealloc (struct reiserfs_transaction_handle * th,
 				struct inode * inode)
 {
diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Tue May  7 17:54:11 2002
+++ b/fs/reiserfs/dir.c	Tue May  7 17:54:11 2002
@@ -106,7 +106,7 @@
 		if (!d_name[d_reclen - 1])
 		    d_reclen = strlen (d_name);
 	
-		if (d_reclen > REISERFS_MAX_NAME_LEN(inode->i_sb->s_blocksize)){
+		if (d_reclen > REISERFS_MAX_NAME(inode->i_sb->s_blocksize)){
 		    /* too big to send back to VFS */
 		    continue ;
 		}
@@ -177,7 +177,7 @@
 
 
  end:
-    // FIXME: ext2_readdir does not reset f_pos
+
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue May  7 17:54:11 2002
+++ b/fs/reiserfs/inode.c	Tue May  7 17:54:11 2002
@@ -19,10 +19,7 @@
 
 static int reiserfs_get_block (struct inode * inode, long block,
 			       struct buffer_head * bh_result, int create);
-//
-// initially this function was derived from minix or ext2's analog and
-// evolved as the prototype did
-//
+
 void reiserfs_delete_inode (struct inode * inode)
 {
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2; 
@@ -111,8 +108,7 @@
 }
 
 //
-// FIXME: we might cache recently accessed indirect item (or at least
-// first 15 pointers just like ext2 does
+// FIXME: we might cache recently accessed indirect item
 
 // Ugh.  Not too eager for that....
 //  I cut the code until such time as I see a convincing argument (benchmark).
@@ -543,12 +539,7 @@
 #endif
     return reiserfs_new_unf_blocknrs (th, allocated_block_nr, tag);
 }
-//
-// initially this function was derived from ext2's analog and evolved
-// as the prototype did.  You'll need to look at the ext2 version to
-// determine which parts are derivative, if any, understanding that
-// there are only so many ways to code to a given interface.
-//
+
 static int reiserfs_get_block (struct inode * inode, long block,
 			       struct buffer_head * bh_result, int create)
 {
@@ -1142,11 +1133,6 @@
 }
 
 
-//
-// initially this function was derived from minix or ext2's analog and
-// evolved as the prototype did
-//
-
 /* looks for stat data in the tree, and fills up the fields of in-core
    inode stat data fields */
 void reiserfs_read_inode2 (struct inode * inode, void *p)
@@ -1368,10 +1354,6 @@
 }
 
 
-//
-// initially this function was derived from minix or ext2's analog and
-// evolved as the prototype did
-//
 /* looks for stat data, then copies fields to it, marks the buffer
    containing stat data as dirty */
 /* reiserfs inodes are never really dirty, since the dirty inode call
@@ -2042,18 +2024,13 @@
     return error ;
 }
 
-//
-// this is exactly what 2.3.99-pre9's ext2_readpage is
-//
+
 static int reiserfs_readpage (struct file *f, struct page * page)
 {
     return block_read_full_page (page, reiserfs_get_block);
 }
 
 
-//
-// modified from ext2_writepage is
-//
 static int reiserfs_writepage (struct page * page)
 {
     struct inode *inode = page->mapping->host ;
@@ -2062,9 +2039,6 @@
 }
 
 
-//
-// from ext2_prepare_write, but modified
-//
 int reiserfs_prepare_write(struct file *f, struct page *page, 
 			   unsigned from, unsigned to) {
     struct inode *inode = page->mapping->host ;
@@ -2074,9 +2048,6 @@
 }
 
 
-//
-// this is exactly what 2.3.99-pre9's ext2_bmap is
-//
 static int reiserfs_aop_bmap(struct address_space *as, long block) {
   return generic_block_bmap(as, block, reiserfs_bmap) ;
 }
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Tue May  7 17:54:11 2002
+++ b/fs/reiserfs/namei.c	Tue May  7 17:54:11 2002
@@ -195,13 +195,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_match (struct reiserfs_dir_entry * de, 
 			   const char * name, int namelen)
 {
@@ -284,13 +277,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 // may return NAME_FOUND, NAME_FOUND_INVISIBLE, NAME_NOT_FOUND
 // FIXME: should add something like IOERROR
 static int reiserfs_find_entry (struct inode * dir, const char * name, int namelen, 
@@ -300,7 +286,7 @@
     int retval;
 
 
-    if (namelen > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
+    if (namelen > REISERFS_MAX_NAME (dir->i_sb->s_blocksize))
 	return NAME_NOT_FOUND;
 
     /* we will search for this key in the tree */
@@ -330,13 +316,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
 {
     int retval;
@@ -346,7 +325,7 @@
 
     reiserfs_check_lock_depth("lookup") ;
 
-    if (dentry->d_name.len > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
+    if (REISERFS_MAX_NAME (dir->i_sb->s_blocksize) < dentry->d_name.len)
 	return ERR_PTR(-ENAMETOOLONG);
 
     de.de_gen_number_bit_string = 0;
@@ -366,14 +345,6 @@
     return NULL;
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-
 /* add entry to the directory (entry can be hidden). 
 
 insert definition of when hidden directories are used here -Hans
@@ -401,7 +372,7 @@
     if (!namelen)
 	return -EINVAL;
 
-    if (namelen > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
+    if (namelen > REISERFS_MAX_NAME (dir->i_sb->s_blocksize))
 	return -ENAMETOOLONG;
 
     /* each entry has unique key. compose it */
@@ -507,13 +478,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
@@ -523,8 +487,7 @@
     struct reiserfs_transaction_handle th ;
 
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
     journal_begin(&th, dir->i_sb, jbegin_count) ;
@@ -563,13 +526,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
 {
     int retval;
@@ -578,8 +534,7 @@
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
     journal_begin(&th, dir->i_sb, jbegin_count) ;
@@ -618,13 +573,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_mkdir (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
@@ -633,8 +581,7 @@
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
     journal_begin(&th, dir->i_sb, jbegin_count) ;
@@ -697,13 +644,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_rmdir (struct inode * dir, struct dentry *dentry)
 {
     int retval;
@@ -784,13 +724,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_unlink (struct inode * dir, struct dentry *dentry)
 {
     int retval;
@@ -866,14 +799,7 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-static int reiserfs_symlink (struct inode * dir, struct dentry * dentry, const char * symname)
+static int reiserfs_symlink (struct inode * parent_dir, struct dentry * dentry, const char * symname)
 {
     int retval;
     struct inode * inode;
@@ -884,18 +810,17 @@
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
-	return -ENOMEM ;
+    if (!(inode = new_inode(parent_dir->i_sb))) {
+  	return -ENOMEM ;
     }
 
     item_len = ROUND_UP (strlen (symname));
-    if (item_len > MAX_DIRECT_ITEM_LEN (dir->i_sb->s_blocksize)) {
+    if (item_len > MAX_DIRECT_ITEM_LEN (parent_dir->i_sb->s_blocksize)) {
 	iput(inode) ;
 	return -ENAMETOOLONG;
     }
   
-    name = reiserfs_kmalloc (item_len, GFP_NOFS, dir->i_sb);
+    name = reiserfs_kmalloc (item_len, GFP_NOFS, parent_dir->i_sb);
     if (!name) {
 	iput(inode) ;
 	return -ENOMEM;
@@ -903,20 +828,20 @@
     memcpy (name, symname, strlen (symname));
     padd_item (name, item_len, strlen (symname));
 
-    journal_begin(&th, dir->i_sb, jbegin_count) ;
+    journal_begin(&th, parent_dir->i_sb, jbegin_count) ;
     windex = push_journal_writer("reiserfs_symlink") ;
 
-    inode = reiserfs_new_inode (&th, dir, S_IFLNK | S_IRWXUGO, name, strlen (symname), dentry,
+    inode = reiserfs_new_inode (&th, parent_dir, S_IFLNK | S_IRWXUGO, name, strlen (symname), dentry,
 				inode, &retval);
-    reiserfs_kfree (name, item_len, dir->i_sb);
+    reiserfs_kfree (name, item_len, parent_dir->i_sb);
     if (inode == 0) { /* reiserfs_new_inode iputs for us */
 	pop_journal_writer(windex) ;
-	journal_end(&th, dir->i_sb, jbegin_count) ;
+	journal_end(&th, parent_dir->i_sb, jbegin_count) ;
 	return retval;
     }
 
     reiserfs_update_inode_transaction(inode) ;
-    reiserfs_update_inode_transaction(dir) ;
+    reiserfs_update_inode_transaction(parent_dir) ;
 
     inode->i_op = &page_symlink_inode_operations;
     inode->i_mapping->a_ops = &reiserfs_address_space_operations;
@@ -925,31 +850,24 @@
     //
     //reiserfs_update_sd (&th, inode, READ_BLOCKS);
 
-    retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len, 
+    retval = reiserfs_add_entry (&th, parent_dir, dentry->d_name.name, dentry->d_name.len, 
 				 inode, 1/*visible*/);
     if (retval) {
 	inode->i_nlink--;
 	reiserfs_update_sd (&th, inode);
 	pop_journal_writer(windex) ;
-	journal_end(&th, dir->i_sb, jbegin_count) ;
+	journal_end(&th, parent_dir->i_sb, jbegin_count) ;
 	iput (inode);
 	return retval;
     }
 
     d_instantiate(dentry, inode);
     pop_journal_writer(windex) ;
-    journal_end(&th, dir->i_sb, jbegin_count) ;
+    journal_end(&th, parent_dir->i_sb, jbegin_count) ;
     return 0;
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_link (struct dentry * old_dentry, struct inode * dir, struct dentry * dentry)
 {
     int retval;
@@ -957,6 +875,7 @@
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    time_t ctime;
 
 
     if (S_ISDIR(inode->i_mode))
@@ -984,7 +903,8 @@
     }
 
     inode->i_nlink++;
-    inode->i_ctime = CURRENT_TIME;
+    ctime = CURRENT_TIME;
+    inode->i_ctime = ctime;
     reiserfs_update_sd (&th, inode);
 
     atomic_inc(&inode->i_count) ;
@@ -1037,14 +957,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-
 /* 
  * process, that is going to call fix_nodes/do_balance must hold only
  * one path. If it holds 2 or more, it can get into endless waiting in
@@ -1059,10 +971,12 @@
     INITIALIZE_PATH (dot_dot_entry_path);
     struct item_head new_entry_ih, old_entry_ih, dot_dot_ih ;
     struct reiserfs_dir_entry old_de, new_de, dot_dot_de;
-    struct inode * old_inode, * new_inode;
+    struct inode * old_inode, * new_dentry_inode;
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count ; 
+    umode_t old_inode_mode;
+    time_t ctime;
 
 
     /* two balancings: old name removal, new name insertion or "save" link,
@@ -1071,7 +985,7 @@
     jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 3;
 
     old_inode = old_dentry->d_inode;
-    new_inode = new_dentry->d_inode;
+    new_dentry_inode = new_dentry->d_inode;
 
     // make sure, that oldname still exists and points to an object we
     // are going to rename
@@ -1086,13 +1000,14 @@
 	return -ENOENT;
     }
 
-    if (S_ISDIR(old_inode->i_mode)) {
+    old_inode_mode = old_inode->i_mode;
+    if (S_ISDIR(old_inode_mode)) {
 	// make sure, that directory being renamed has correct ".." 
 	// and that its new parent directory has not too many links
 	// already
 
-	if (new_inode) {
-	    if (!reiserfs_empty_dir(new_inode)) {
+	if (new_dentry_inode) {
+	    if (!reiserfs_empty_dir(new_dentry_inode)) {
 		return -ENOTEMPTY;
 	    }
 	}
@@ -1118,9 +1033,7 @@
     retval = reiserfs_add_entry (&th, new_dir, new_dentry->d_name.name, new_dentry->d_name.len, 
 				 old_inode, 0);
     if (retval == -EEXIST) {
-	// FIXME: is it possible, that new_inode == 0 here? If yes, it
-	// is not clear how does ext2 handle that
-	if (!new_inode) {
+	if (!new_dentry_inode) {
 	    reiserfs_panic (old_dir->i_sb,
 			    "vs-7050: new entry is found, new inode == 0\n");
 	}
@@ -1138,8 +1051,8 @@
     */
     reiserfs_update_inode_transaction(old_inode) ;
 
-    if (new_inode) 
-	reiserfs_update_inode_transaction(new_inode) ;
+    if (new_dentry_inode) 
+	reiserfs_update_inode_transaction(new_dentry_inode) ;
 
     while (1) {
 	// look for old name using corresponding entry key (found by reiserfs_find_entry)
@@ -1186,18 +1099,18 @@
 	if (item_moved(&new_entry_ih, &new_entry_path) ||
 	    !entry_points_to_object(new_dentry->d_name.name, 
 	                            new_dentry->d_name.len,
-				    &new_de, new_inode) ||
+				    &new_de, new_dentry_inode) ||
 	    item_moved(&old_entry_ih, &old_entry_path) || 
 	    !entry_points_to_object (old_dentry->d_name.name, 
 	                             old_dentry->d_name.len,
 				     &old_de, old_inode)) {
 	    reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
 	    reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
-	    if (S_ISDIR(old_inode->i_mode))
+	    if (S_ISDIR(old_inode_mode))
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
 	    continue;
 	}
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (S_ISDIR(old_inode_mode)) {
 	    if ( item_moved(&dot_dot_ih, &dot_dot_entry_path) ||
 		 !entry_points_to_object ( "..", 2, &dot_dot_de, old_dir) ) {
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
@@ -1208,7 +1121,7 @@
 	}
 
 
-	RFALSE( S_ISDIR(old_inode->i_mode) && 
+	RFALSE( S_ISDIR(old_inode_mode) && 
 		!reiserfs_buffer_prepared(dot_dot_de.de_bh), "" );
 
 	break;
@@ -1226,22 +1139,23 @@
     old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
     new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
 
-    if (new_inode) {
+    if (new_dentry_inode) {
 	// adjust link number of the victim
-	if (S_ISDIR(new_inode->i_mode)) {
-	    new_inode->i_nlink  = 0;
+	if (S_ISDIR(new_dentry_inode->i_mode)) {
+	    new_dentry_inode->i_nlink  = 0;
 	} else {
-	    new_inode->i_nlink--;
+	    new_dentry_inode->i_nlink--;
 	}
-	new_inode->i_ctime = CURRENT_TIME;
+	ctime = CURRENT_TIME;
+	new_dentry_inode->i_ctime = ctime;
     }
 
-    if (S_ISDIR(old_inode->i_mode)) {
+    if (S_ISDIR(old_inode_mode)) {
 	// adjust ".." of renamed directory 
 	set_ino_in_dir_entry (&dot_dot_de, INODE_PKEY (new_dir));
 	journal_mark_dirty (&th, new_dir->i_sb, dot_dot_de.de_bh);
 	
-        if (!new_inode)
+        if (!new_dentry_inode)
 	    /* there (in new_dir) was no directory, so it got new link
 	       (".."  of renamed directory) */
 	    INC_DIR_INODE_NLINK(new_dir);
@@ -1266,10 +1180,10 @@
     reiserfs_update_sd (&th, old_dir);
     reiserfs_update_sd (&th, new_dir);
 
-    if (new_inode) {
-	if (new_inode->i_nlink == 0)
-	    add_save_link (&th, new_inode, 0/* not truncate */);
-	reiserfs_update_sd (&th, new_inode);
+    if (new_dentry_inode) {
+	if (new_dentry_inode->i_nlink == 0)
+	    add_save_link (&th, new_dentry_inode, 0/* not truncate */);
+	reiserfs_update_sd (&th, new_dentry_inode);
     }
 
     pop_journal_writer(windex) ;
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue May  7 17:54:11 2002
+++ b/fs/reiserfs/super.c	Tue May  7 17:54:11 2002
@@ -29,13 +29,6 @@
 static int reiserfs_remount (struct super_block * s, int * flags, char * data);
 static int reiserfs_statfs (struct super_block * s, struct statfs * buf);
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static void reiserfs_write_super (struct super_block * s)
 {
 
@@ -48,13 +41,6 @@
   unlock_kernel() ;
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static void reiserfs_write_super_lockfs (struct super_block * s)
 {
 
@@ -333,13 +319,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static void reiserfs_put_super (struct super_block * s)
 {
   int i;
@@ -422,81 +401,190 @@
 
 };
 
-/* this was (ext2)parse_options */
-static int parse_options (char * options, unsigned long * mount_options, unsigned long * blocks)
-{
-    char * this_char;
+/* this struct is used in reiserfs_getopt () for containing the value for those
+   mount options that have values rather than being toggles. */
+typedef struct {
     char * value;
-  
+    int bitmask; /* bit which is to be set in mount_options bitmask when this
+                    value is found, 0 is no bits are to be set */
+} arg_desc_t;
+
+
+/* this struct is used in reiserfs_getopt() for describing the set of reiserfs
+   mount options */
+typedef struct {
+    char * option_name;
+    int arg_required; /* 0 is argument is not required, not 0 otherwise */
+    const arg_desc_t * values; /* list of values accepted by an option */
+    int bitmask;  /* bit which is to be set in mount_options bitmask when this
+		     option is selected, 0 is not bits are to be set */
+} opt_desc_t;
+
+
+/* possible values for "-o hash=" and bits which are to be set in s_mount_opt
+   of reiserfs specific part of in-core super block */
+const arg_desc_t hash[] = {
+    {"rupasov", FORCE_RUPASOV_HASH},
+    {"tea", FORCE_TEA_HASH},
+    {"r5", FORCE_R5_HASH},
+    {"detect", FORCE_HASH_DETECT},
+    {NULL, 0}
+};
+
+
+/* possible values for "-o block-allocator=" and bits which are to be set in
+   s_mount_opt of reiserfs specific part of in-core super block */
+const arg_desc_t balloc[] = {
+    {"noborder", REISERFS_NO_BORDER},
+    {"no_unhashed_relocation", REISERFS_NO_UNHASHED_RELOCATION},
+    {"hashed_relocation", REISERFS_HASHED_RELOCATION},
+    {"test4", REISERFS_TEST4},
+    {NULL, 0}
+};
+
+
+/* proceed only one option from a list *cur - string containing of mount options
+   opts - array of options which are accepted
+   opt_arg - if option is found and requires an argument and if it is specifed
+   in the input - pointer to the argument is stored here
+   bit_flags - if option requires to set a certain bit - it is set here
+   return -1 if unknown option is found, opt->arg_required otherwise */
+static int reiserfs_getopt (char ** cur, opt_desc_t * opts, char ** opt_arg,
+			    unsigned long * bit_flags)
+{
+    char * p;
+    /* foo=bar, 
+       ^   ^  ^
+       |   |  +-- option_end
+       |   +-- arg_start
+       +-- option_start
+    */
+    const opt_desc_t * opt;
+    const arg_desc_t * arg;
+    
+    
+    p = *cur;
+    
+    /* assume argument cannot contain commas */
+    *cur = strchr (p, ',');
+    if (*cur) {
+	*(*cur) = '\0';
+	(*cur) ++;
+    }
+    
+    /* for every option in the list */
+    for (opt = opts; opt->option_name; opt ++) {
+	if (!strncmp (p, opt->option_name, strlen (opt->option_name))) {
+	    if (bit_flags && opt->bitmask)
+		set_bit (opt->bitmask, bit_flags);
+	    break;
+	}
+    }
+    if (!opt->option_name) {
+	printk ("reiserfs_getopt: unknown option \"%s\"\n", p);
+	return -1;
+    }
+    
+    p += strlen (opt->option_name);
+    switch (*p) {
+    case '=':
+	if (!opt->arg_required) {
+	    printk ("reiserfs_getopt: the option \"%s\" does not require an argument\n",
+		    opt->option_name);
+	    return -1;
+	}
+	break;
+	
+    case 0:
+	if (opt->arg_required) {
+	    printk ("reiserfs_getopt: the option \"%s\" requires an argument\n", opt->option_name);
+	    return -1;
+	}
+	break;
+    default:
+	printk ("reiserfs_getopt: head of option \"%s\" is only correct\n", opt->option_name);
+	return -1;
+    }
+	
+    /* move to the argument */
+    p ++;
+    
+    if (!strlen (p)) {
+	/* this catches "option=," */
+	printk ("reiserfs_getopt: empty argument for \"%s\"\n", opt->option_name);
+	return -1;
+    }
+    
+    if (!opt->values) {
+	/* *opt_arg contains pointer to argument */
+	*opt_arg = p;
+	return opt->arg_required;
+    }
+    
+    /* values possible for this option are listed in opt->values */
+    for (arg = opt->values; arg->value; arg ++) {
+	if (!strcmp (p, arg->value)) {
+	    if (bit_flags && arg->bitmask)
+		set_bit (arg->bitmask, bit_flags);
+	    return opt->arg_required;
+	}
+    }
+    
+    printk ("reiserfs_getopt: bad value \"%s\" for option \"%s\"\n", p, opt->option_name);
+    return -1;
+}
+
+
+/* returns 0 if something is wrong in option string, 1 - otherwise */
+static int reiserfs_parse_options (char * options, /* string given via mount's -o */
+				   unsigned long * mount_options,
+				   /* after the parsing phase, contains the
+				      collection of bitflags defining what
+				      mount options were selected. */
+				   unsigned long * blocks) /* strtol-ed from NNN of resize=NNN */
+{
+    int c;
+    char * arg = NULL;
+    char * pos;
+    opt_desc_t opts[] = {
+		{"notail", 0, 0, NOTAIL},
+		{"conv", 0, 0, REISERFS_CONVERT}, 
+		{"nolog", 0, 0, 0},
+		{"replayonly", 0, 0, REPLAYONLY},
+		
+		{"block-allocator", 'a', balloc, 0}, 
+		{"hash", 'h', hash, FORCE_HASH_DETECT},
+		
+		{"resize", 'r', 0, 0},
+		{NULL, 0, 0, 0}
+    };
+	
     *blocks = 0;
-    if (!options)
+    if (!options || !*options)
 	/* use default configuration: create tails, journaling on, no
-           conversion to newest format */
+	   conversion to newest format */
 	return 1;
-    for (this_char = strtok (options, ","); this_char != NULL; this_char = strtok (NULL, ",")) {
-	if ((value = strchr (this_char, '=')) != NULL)
-	    *value++ = 0;
-	if (!strcmp (this_char, "notail")) {
-	    set_bit (NOTAIL, mount_options);
-	} else if (!strcmp (this_char, "conv")) {
-	    // if this is set, we update super block such that
-	    // the partition will not be mounable by 3.5.x anymore
-	    set_bit (REISERFS_CONVERT, mount_options);
-	} else if (!strcmp (this_char, "noborder")) {
-				/* this is used for benchmarking
-                                   experimental variations, it is not
-                                   intended for users to use, only for
-                                   developers who want to casually
-                                   hack in something to test */
-	    set_bit (REISERFS_NO_BORDER, mount_options);
-	} else if (!strcmp (this_char, "no_unhashed_relocation")) {
-	    set_bit (REISERFS_NO_UNHASHED_RELOCATION, mount_options);
-	} else if (!strcmp (this_char, "hashed_relocation")) {
-	    set_bit (REISERFS_HASHED_RELOCATION, mount_options);
-	} else if (!strcmp (this_char, "test4")) {
-	    set_bit (REISERFS_TEST4, mount_options);
-	} else if (!strcmp (this_char, "nolog")) {
-	    reiserfs_warning("reiserfs: nolog mount option not supported yet\n");
-	} else if (!strcmp (this_char, "replayonly")) {
-	    set_bit (REPLAYONLY, mount_options);
-	} else if (!strcmp (this_char, "resize")) {
-	    if (value && *value){
-		*blocks = simple_strtoul (value, &value, 0);
-	    } else {
-	  	printk("reiserfs: resize option requires a value\n");
+    
+    for (pos = options; pos; ) {
+	c = reiserfs_getopt (&pos, opts, &arg, mount_options);
+	if (c == -1)
+	    /* wrong option is given */
+	    return 0;
+	
+	if (c == 'r') {
+	    char * p;
+	    
+	    p = 0;
+	    /* "resize=NNN" */
+	    *blocks = simple_strtoul (arg, &p, 0);
+	    if (*p != '\0') {
+		/* NNN does not look like a number */
+		printk ("reiserfs_parse_options: bad value %s\n", arg);
 		return 0;
 	    }
-	} else if (!strcmp (this_char, "hash")) {
-	    if (value && *value) {
-		/* if they specify any hash option, we force detection
-		** to make sure they aren't using the wrong hash
-		*/
-	        if (!strcmp(value, "rupasov")) {
-		    set_bit (FORCE_RUPASOV_HASH, mount_options);
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else if (!strcmp(value, "tea")) {
-		    set_bit (FORCE_TEA_HASH, mount_options);
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else if (!strcmp(value, "r5")) {
-		    set_bit (FORCE_R5_HASH, mount_options);
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else if (!strcmp(value, "detect")) {
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else {
-		    printk("reiserfs: invalid hash function specified\n") ;
-		    return 0 ;
-		}
-	    } else {
-	  	printk("reiserfs: hash option requires a value\n");
-		return 0 ;
-	    }
-	} else if (!strcmp (this_char, "attrs")) {
-	    set_bit (REISERFS_ATTRS, mount_options);
-	} else {
-	    printk ("reiserfs: Unrecognized mount option %s\n", this_char);
-	    return 0;
 	}
     }
+    
     return 1;
 }
 
@@ -524,14 +612,7 @@
 	}
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-static int reiserfs_remount (struct super_block * s, int * flags, char * data)
+static int reiserfs_remount (struct super_block * s, int * mount_flags, char * data)
 {
   struct reiserfs_super_block * rs;
   struct reiserfs_transaction_handle th ;
@@ -540,7 +621,7 @@
 
   rs = SB_DISK_SUPER_BLOCK (s);
 
-  if (!parse_options(data, &mount_options, &blocks))
+  if (!reiserfs_parse_options(data, &mount_options, &blocks))
   	return 0;
 
 #define SET_OPT( opt, bits, super )					\
@@ -564,12 +645,11 @@
 	  return rc;
   }
 
-  if ((unsigned long)(*flags & MS_RDONLY) == (s->s_flags & MS_RDONLY)) {
-    /* there is nothing to do to remount read-only fs as read-only fs */
-    return 0;
-  }
-  
-  if (*flags & MS_RDONLY) {
+  if (*mount_flags & MS_RDONLY) {
+    /* remount rean-only */
+    if (s->s_flags & MS_RDONLY)
+      /* it is read-only already */
+      return 0;
     /* try to remount file system with read-only permissions */
     if (sb_state(rs) == REISERFS_VALID_FS || s->u.reiserfs_sb.s_mount_state != REISERFS_VALID_FS) {
       return 0;
@@ -585,7 +665,7 @@
     s->u.reiserfs_sb.s_mount_state = sb_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;
-
+    
     /* Mount a partition which is read-only, read-write */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
     s->u.reiserfs_sb.s_mount_state = sb_state(rs);
@@ -600,7 +680,7 @@
   SB_JOURNAL(s)->j_must_wait = 1 ;
   journal_end(&th, s, 10) ;
 
-  if (!( *flags & MS_RDONLY ) )
+  if (!( *mount_flags & MS_RDONLY ) )
     finish_unfinished( s );
 
   return 0;
@@ -951,13 +1031,6 @@
     return 0;
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static struct super_block * reiserfs_read_super (struct super_block * s, void * data, int silent)
 {
     int size;
@@ -976,7 +1049,7 @@
 
     memset (&s->u.reiserfs_sb, 0, sizeof (struct reiserfs_sb_info));
 
-    if (parse_options ((char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks) == 0) {
+    if (reiserfs_parse_options ((char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks) == 0) {
 	return NULL;
     }
 
@@ -1138,34 +1211,24 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_statfs (struct super_block * s, struct statfs * buf)
 {
   struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
   
-				/* changed to accomodate gcc folks.*/
-  buf->f_type    =  REISERFS_SUPER_MAGIC;
-  buf->f_bsize   = s->s_blocksize;
-  buf->f_blocks  = sb_block_count(rs) - sb_bmap_nr(rs) - 1;
+  buf->f_namelen = (REISERFS_MAX_NAME (s->s_blocksize));
+  buf->f_ffree   = -1;
+  buf->f_files   = -1;
   buf->f_bfree   = sb_free_blocks(rs);
   buf->f_bavail  = buf->f_bfree;
-  buf->f_files   = -1;
-  buf->f_ffree   = -1;
-  buf->f_namelen = (REISERFS_MAX_NAME_LEN (s->s_blocksize));
+  buf->f_blocks  = sb_block_count(rs) - sb_bmap_nr(rs) - 1;
+  buf->f_bsize   = 8192; /*s->s_blocksize;*/
+  /* changed to accomodate gcc folks.*/
+  buf->f_type    =  REISERFS_SUPER_MAGIC;
   return 0;
 }
 
 static DECLARE_FSTYPE_DEV(reiserfs_fs_type,"reiserfs",reiserfs_read_super);
 
-//
-// this is exactly what 2.3.99-pre9's init_ext2_fs is
-//
 static int __init init_reiserfs_fs (void)
 {
 	reiserfs_proc_info_global_init();
@@ -1179,9 +1242,6 @@
 MODULE_LICENSE("GPL");
 EXPORT_NO_SYMBOLS;
 
-//
-// this is exactly what 2.3.99-pre9's init_ext2_fs is
-//
 static void __exit exit_reiserfs_fs(void)
 {
 	reiserfs_proc_unregister_global( "version" );
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Tue May  7 17:54:11 2002
+++ b/include/linux/reiserfs_fs.h	Tue May  7 17:54:11 2002
@@ -953,9 +953,7 @@
 #define B_I_E_NAME(bh,ih,entry_num) ((char *)(bh->b_data + ih_location(ih) + deh_location(B_I_DEH(bh,ih)+(entry_num))))
 
 // two entries per block (at least)
-//#define REISERFS_MAX_NAME_LEN(block_size) 
-//((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE * 2) / 2)
-#define REISERFS_MAX_NAME_LEN(block_size) 255
+#define REISERFS_MAX_NAME(block_size) 255
 
 
 /* this structure is used for operations on directory entries. It is
