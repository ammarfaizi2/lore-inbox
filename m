Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSFJNvx>; Mon, 10 Jun 2002 09:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSFJNu7>; Mon, 10 Jun 2002 09:50:59 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:25728 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315198AbSFJNuP>;
	Mon, 10 Jun 2002 09:50:15 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADguKZ003866@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 9 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 9 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   tb_buffer_sanity_check panic message text cleanup. By Josh MacDonald.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 fix_node.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.602   -> 1.603  
#	fs/reiserfs/fix_node.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.603
# fix_node.c:
#   reiserfs: tb_buffer_sanity_check panic message text cleanup.  From Josh MacDonald.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
--- a/fs/reiserfs/fix_node.c	Thu May 30 18:42:23 2002
+++ b/fs/reiserfs/fix_node.c	Thu May 30 18:42:23 2002
@@ -2092,21 +2092,27 @@
   if (p_s_bh) {
     if (atomic_read (&(p_s_bh->b_count)) <= 0) {
 
-      reiserfs_panic (p_s_sb, "tb_buffer_sanity_check(): negative or zero reference counter for buffer %s[%d] (%b)\n", descr, level, p_s_bh);
+      reiserfs_panic (p_s_sb, "jmacd-1: tb_buffer_sanity_check(): negative or zero reference counter for buffer %s[%d] (%b)\n", descr, level, p_s_bh);
     }
 
     if ( ! buffer_uptodate (p_s_bh) ) {
-      reiserfs_panic (p_s_sb, "tb_buffer_sanity_check(): buffer is not up to date %s[%d] (%b)\n", descr, level, p_s_bh);
+      reiserfs_panic (p_s_sb, "jmacd-2: tb_buffer_sanity_check(): buffer is not up to date %s[%d] (%b)\n", descr, level, p_s_bh);
     }
 
     if ( ! B_IS_IN_TREE (p_s_bh) ) {
-      reiserfs_panic (p_s_sb, "tb_buffer_sanity_check(): buffer is not in tree %s[%d] (%b)\n", descr, level, p_s_bh);
+      reiserfs_panic (p_s_sb, "jmacd-3: tb_buffer_sanity_check(): buffer is not in tree %s[%d] (%b)\n", descr, level, p_s_bh);
     }
 
-    if (p_s_bh->b_bdev != p_s_sb->s_bdev || 
-	p_s_bh->b_size != p_s_sb->s_blocksize ||
-	p_s_bh->b_blocknr > SB_BLOCK_COUNT(p_s_sb)) {
-      reiserfs_panic (p_s_sb, "tb_buffer_sanity_check(): check failed for buffer %s[%d] (%b)\n", descr, level, p_s_bh);
+    if (p_s_bh->b_bdev != p_s_sb->s_bdev) {
+	reiserfs_panic (p_s_sb, "jmacd-4: tb_buffer_sanity_check(): buffer has wrong device %s[%d] (%b)\n", descr, level, p_s_bh);
+    }
+
+    if (p_s_bh->b_size != p_s_sb->s_blocksize) {
+	reiserfs_panic (p_s_sb, "jmacd-5: tb_buffer_sanity_check(): buffer has wrong blocksize %s[%d] (%b)\n", descr, level, p_s_bh);
+    }
+
+    if (p_s_bh->b_blocknr > SB_BLOCK_COUNT(p_s_sb)) {
+	reiserfs_panic (p_s_sb, "jmacd-6: tb_buffer_sanity_check(): buffer block number too high %s[%d] (%b)\n", descr, level, p_s_bh);
     }
   }
 }
