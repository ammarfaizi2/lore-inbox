Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUHWRPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUHWRPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUHWRPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:15:16 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:48346 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266209AbUHWROa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:14:30 -0400
Message-ID: <412A25C9.8000103@ttnet.net.tr>
Date: Mon, 23 Aug 2004 20:13:45 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10] [1/4]
Content-Type: multipart/mixed;
	boundary="------------090306080109050404010506"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306080109050404010506
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

splitted-up the fs/* gcc3.4-inline-patches.

[1/4] freevxfs, ncpfs, reiserfs


--------------090306080109050404010506
Content-Type: text/plain;
	name="gcc34_inline_09-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_09-1.diff"

--- 28p1/fs/freevxfs/vxfs_extern.h~	2002-02-25 21:38:08.000000000 +0200
+++ 28p1/fs/freevxfs/vxfs_extern.h	2004-08-17 03:32:45.000000000 +0300
@@ -72,7 +72,7 @@
 
 /* vxfs_subr.c */
 extern struct page *		vxfs_get_page(struct address_space *, u_long);
-extern __inline__ void		vxfs_put_page(struct page *);
+extern void			vxfs_put_page(struct page *);
 extern struct buffer_head *	vxfs_bread(struct inode *, int);
 
 #endif /* _VXFS_EXTERN_H_ */
--- 28p1/fs/freevxfs/vxfs_subr.c~	2002-02-25 21:38:08.000000000 +0200
+++ 28p1/fs/freevxfs/vxfs_subr.c	2004-08-17 03:34:31.000000000 +0300
@@ -50,6 +50,12 @@
 	.sync_page =		block_sync_page,
 };
 
+__inline__ void
+vxfs_put_page(struct page *pp)
+{
+	kunmap(pp);
+	page_cache_release(pp);
+}
 
 /**
  * vxfs_get_page - read a page into memory.
@@ -88,13 +94,6 @@
 	return ERR_PTR(-EIO);
 }
 
-__inline__ void
-vxfs_put_page(struct page *pp)
-{
-	kunmap(pp);
-	page_cache_release(pp);
-}
-
 /**
  * vxfs_bread - read buffer for a give inode,block tuple
  * @ip:		inode


--- 28p1/fs/ncpfs/ncplib_kernel.h~	2004-08-16 20:23:00.000000000 +0300
+++ 28p1/fs/ncpfs/ncplib_kernel.h	2004-08-17 12:37:24.000000000 +0300
@@ -131,7 +131,7 @@
 
 #endif /* CONFIG_NCPFS_NLS */
 
-inline int
+int
 ncp_strnicmp(struct nls_table *,
 		const unsigned char *, const unsigned char *, int);
 


--- 28p1/include/linux/reiserfs_fs.h~	2004-08-16 20:23:01.000000000 +0300
+++ 28p1/include/linux/reiserfs_fs.h	2004-08-17 12:49:58.000000000 +0300
@@ -1771,25 +1771,25 @@
 /* stree.c */
 int B_IS_IN_TREE(const struct buffer_head *);
 extern inline void copy_short_key (void * to, const void * from);
-extern inline void copy_item_head(struct item_head * p_v_to, 
+extern void copy_item_head(struct item_head * p_v_to,
 								  const struct item_head * p_v_from);
 
 // first key is in cpu form, second - le
-extern inline int comp_keys (const struct key * le_key, 
+extern int comp_keys (const struct key * le_key,
 			     const struct cpu_key * cpu_key);
-extern inline int  comp_short_keys (const struct key * le_key, 
+extern int  comp_short_keys (const struct key * le_key,
 				    const struct cpu_key * cpu_key);
-extern inline void le_key2cpu_key (struct cpu_key * to, const struct key * from);
+extern void le_key2cpu_key (struct cpu_key * to, const struct key * from);
 
 // both are cpu keys
-extern inline int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
-extern inline int comp_short_cpu_keys (const struct cpu_key *, 
+extern  int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
+extern int comp_short_cpu_keys (const struct cpu_key *,
 				       const struct cpu_key *);
-extern inline void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
+extern void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
 
 // both are in le form
-extern inline int comp_le_keys (const struct key *, const struct key *);
-extern inline int comp_short_le_keys (const struct key *, const struct key *);
+extern int comp_le_keys (const struct key *, const struct key *);
+extern int comp_short_le_keys (const struct key *, const struct key *);
 
 //
 // get key version from on disk key - kludge
@@ -1824,7 +1824,7 @@
 int search_for_position_by_key (struct super_block * p_s_sb, 
 								const struct cpu_key * p_s_cpu_key, 
 								struct path * p_s_search_path);
-extern inline void decrement_bcount (struct buffer_head * p_s_bh);
+extern void decrement_bcount (struct buffer_head * p_s_bh);
 void decrement_counters_in_path (struct path * p_s_search_path);
 void pathrelse (struct path * p_s_search_path);
 int reiserfs_check_path(struct path *p) ;
@@ -1902,7 +1902,7 @@
 void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs );
 
 /* namei.c */
-inline void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
+void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
 int search_by_entry_key (struct super_block * sb, const struct cpu_key * key, 
 			 struct path * path, 
 			 struct reiserfs_dir_entry * de);
@@ -2050,7 +2050,7 @@
                       struct buffer_head **);
 
 /* do_balance.c */
-inline void do_balance_mark_leaf_dirty (struct tree_balance * tb, 
+void do_balance_mark_leaf_dirty (struct tree_balance * tb,
 					struct buffer_head * bh, int flag);
 #define do_balance_mark_internal_dirty do_balance_mark_leaf_dirty
 #define do_balance_mark_sb_dirty do_balance_mark_leaf_dirty


--------------090306080109050404010506--
