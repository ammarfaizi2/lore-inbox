Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272677AbTG0XOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272973AbTG0XCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:02:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272882AbTG0XBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:06 -0400
Date: Sun, 27 Jul 2003 21:18:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272018.h6RKIQWW029756@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: use invalid not illegal in reiserfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/reiserfs/do_balan.c linux-2.6.0-test2-ac1/fs/reiserfs/do_balan.c
--- linux-2.6.0-test2/fs/reiserfs/do_balan.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/fs/reiserfs/do_balan.c	2003-07-15 18:01:30.000000000 +0100
@@ -376,7 +376,7 @@
 		    if ( is_direntry_le_ih (B_N_PITEM_HEAD (tbS0, item_pos))) {
 
 			RFALSE( zeros_num,
-				"PAP-12090: illegal parameter in case of a directory");
+				"PAP-12090: invalid parameter in case of a directory");
 			/* directory item */
 			if ( tb->lbytes > pos_in_item ) {
 			    /* new directory entry falls into L[0] */
@@ -646,7 +646,7 @@
 			int entry_count;
 
 			RFALSE( zeros_num,
-				"PAP-12145: illegal parametr in case of a directory");
+				"PAP-12145: invalid parameter in case of a directory");
 			entry_count = I_ENTRY_COUNT(B_N_PITEM_HEAD(tbS0, item_pos));
 			if ( entry_count - tb->rbytes < pos_in_item )
 			    /* new directory entry falls into R[0] */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/reiserfs/fix_node.c linux-2.6.0-test2-ac1/fs/reiserfs/fix_node.c
--- linux-2.6.0-test2/fs/reiserfs/fix_node.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/fs/reiserfs/fix_node.c	2003-07-15 18:01:30.000000000 +0100
@@ -1847,7 +1847,7 @@
     if ( n_path_offset <= FIRST_PATH_ELEMENT_OFFSET ) {
 	
 	RFALSE( n_path_offset < FIRST_PATH_ELEMENT_OFFSET - 1,
-		"PAP-8260: illegal offset in the path");
+		"PAP-8260: invalid offset in the path");
 
 	if ( PATH_OFFSET_PBUFFER(p_s_path, FIRST_PATH_ELEMENT_OFFSET)->b_blocknr ==
 	     SB_ROOT_BLOCK (p_s_tb->tb_sb) ) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/reiserfs/stree.c linux-2.6.0-test2-ac1/fs/reiserfs/stree.c
--- linux-2.6.0-test2/fs/reiserfs/stree.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/fs/reiserfs/stree.c	2003-07-15 18:01:30.000000000 +0100
@@ -311,7 +311,7 @@
   struct buffer_head  * p_s_parent;
   
   RFALSE( n_path_offset < FIRST_PATH_ELEMENT_OFFSET, 
-	  "PAP-5010: illegal offset in the path");
+	  "PAP-5010: invalid offset in the path");
 
   /* While not higher in path than first element. */
   while ( n_path_offset-- > FIRST_PATH_ELEMENT_OFFSET ) {
@@ -351,7 +351,7 @@
   struct buffer_head  * p_s_parent;
 
   RFALSE( n_path_offset < FIRST_PATH_ELEMENT_OFFSET,
-	  "PAP-5030: illegal offset in the path");
+	  "PAP-5030: invalid offset in the path");
 
   while ( n_path_offset-- > FIRST_PATH_ELEMENT_OFFSET ) {
 
@@ -393,7 +393,7 @@
 
   RFALSE( ! p_s_key || p_s_chk_path->path_length < FIRST_PATH_ELEMENT_OFFSET ||
 	  p_s_chk_path->path_length > MAX_HEIGHT,
-	  "PAP-5050: pointer to the key(%p) is NULL or illegal path length(%d)",
+	  "PAP-5050: pointer to the key(%p) is NULL or invalid path length(%d)",
 	  p_s_key, p_s_chk_path->path_length);
   RFALSE( !PATH_PLAST_BUFFER(p_s_chk_path)->b_bdev,
 	  "PAP-5060: device must not be NODEV");
@@ -430,7 +430,7 @@
 
   RFALSE( n_path_offset < ILLEGAL_PATH_ELEMENT_OFFSET ||
 	  n_path_offset > EXTENDED_MAX_HEIGHT - 1,
-	  "PAP-5080: illegal path offset of %d", n_path_offset);
+	  "PAP-5080: invalid path offset of %d", n_path_offset);
 
   while ( n_path_offset > ILLEGAL_PATH_ELEMENT_OFFSET ) {
     struct buffer_head * bh;
@@ -461,7 +461,7 @@
   int n_path_offset = p_s_search_path->path_length;
 
   RFALSE( n_path_offset < ILLEGAL_PATH_ELEMENT_OFFSET, 
-	  "clm-4000: illegal path offset");
+	  "clm-4000: invalid path offset");
   
   while ( n_path_offset > ILLEGAL_PATH_ELEMENT_OFFSET )  {
     reiserfs_restore_prepared_buffer(s, PATH_OFFSET_PBUFFER(p_s_search_path, 
@@ -478,7 +478,7 @@
   int n_path_offset = p_s_search_path->path_length;
 
   RFALSE( n_path_offset < ILLEGAL_PATH_ELEMENT_OFFSET,
-	  "PAP-5090: illegal path offset");
+	  "PAP-5090: invalid path offset");
   
   while ( n_path_offset > ILLEGAL_PATH_ELEMENT_OFFSET )  
     brelse(PATH_OFFSET_PBUFFER(p_s_search_path, n_path_offset--));
@@ -1044,7 +1044,7 @@
 
 	    RFALSE( ! is_indirect_le_ih(&s_ih) || ! n_unfm_number ||
 		    pos_in_item (p_s_path) + 1 !=  n_unfm_number,
-		    "PAP-5240: illegal item %h "
+		    "PAP-5240: invalid item %h "
 		    "n_unfm_number = %d *p_n_pos_in_item = %d", 
 		    &s_ih, n_unfm_number, pos_in_item (p_s_path));
 
@@ -1065,7 +1065,7 @@
 		    pos_in_item (p_s_path) = (n_new_file_length + n_blk_size - le_ih_k_offset (&s_ih) ) >> p_s_sb->s_blocksize_bits;
 
 		    RFALSE( pos_in_item (p_s_path) > n_unfm_number,
-			    "PAP-5250: illegal position in the item");
+			    "PAP-5250: invalid position in the item");
 
 		    /* Either convert last unformatted node of indirect item to direct item or increase
 		       its free space.  */
@@ -1081,7 +1081,7 @@
 	    }
 
 	    RFALSE( n_unfm_number <= pos_in_item (p_s_path),
-		    "PAP-5260: illegal position in the indirect item");
+		    "PAP-5260: invalid position in the indirect item");
 
 	    /* pointers to be cut */
 	    n_unfm_number -= pos_in_item (p_s_path);
@@ -1573,7 +1573,7 @@
 
     /* go ahead and perform balancing */
     
-    RFALSE( c_mode == M_PASTE || c_mode == M_INSERT, "illegal mode");
+    RFALSE( c_mode == M_PASTE || c_mode == M_INSERT, "invalid mode");
 
     /* Calculate number of bytes that need to be cut from the item. */
     if (retval2 == -1)
