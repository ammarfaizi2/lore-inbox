Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSFJNuN>; Mon, 10 Jun 2002 09:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFJNuM>; Mon, 10 Jun 2002 09:50:12 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:24192 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314227AbSFJNuL>;
	Mon, 10 Jun 2002 09:50:11 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADguR1003881@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 14 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 14 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   tidy up super block printing, switch reiserfs proc code to use bdevname
   instead of __bdevname.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 prints.c |    5 +++--
 procfs.c |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.607   -> 1.608  
#	fs/reiserfs/procfs.c	1.10    -> 1.11   
#	fs/reiserfs/prints.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.608
# procfs.c, prints.c:
#   reiserfs: tidy up super block printing, switch reiserfs proc code to use bdevname instead of __bdevname.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
--- a/fs/reiserfs/prints.c	Thu May 30 18:42:29 2002
+++ b/fs/reiserfs/prints.c	Thu May 30 18:42:29 2002
@@ -490,6 +490,7 @@
 
     return "unknown";
 }
+
 /* return 1 if this is not super block */
 static int print_super_block (struct buffer_head * bh)
 {
@@ -509,8 +510,8 @@
 	return 1;
     }
 
-    printk ("%s\'s super block in block %ld\n======================\n",
-            bdevname (bh->b_bdev), bh->b_blocknr);
+    printk ("%s\'s super block is in block %ld\n", bdevname (bh->b_bdev), 
+            bh->b_blocknr);
     printk ("Reiserfs version %s\n", version );
     printk ("Block count %u\n", sb_block_count(rs));
     printk ("Blocksize %d\n", sb_blocksize(rs));
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Thu May 30 18:42:29 2002
+++ b/fs/reiserfs/procfs.c	Thu May 30 18:42:29 2002
@@ -500,7 +500,7 @@
 			"prepare_retry: \t%12lu\n",
 
                         DJP( jp_journal_1st_block ),
-                        DJP( jp_journal_dev ) == 0 ? "none" : __bdevname(to_kdev_t(DJP( jp_journal_dev ))),
+                        bdevname(SB_JOURNAL(sb)->j_dev_bd),
                         DJP( jp_journal_dev ),
                         DJP( jp_journal_size ),
                         DJP( jp_journal_trans_max ),
