Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSFJNvz>; Mon, 10 Jun 2002 09:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSFJNvK>; Mon, 10 Jun 2002 09:51:10 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:26240 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315245AbSFJNuS>;
	Mon, 10 Jun 2002 09:50:18 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADguXu003863@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 8 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 8 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   fix unused variable gcc warning in reiserfs_free_prealloc_block when
   CONFIG_REISERFS_CHECK is off.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 bitmap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Plainetxt patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.601   -> 1.602  
#	fs/reiserfs/bitmap.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.602
# bitmap.c:
#   fix unused variable gcc warning in reiserfs_free_prealloc_block when CONFIG_REISERFS_CHECK is off.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Thu May 30 18:42:22 2002
+++ b/fs/reiserfs/bitmap.c	Thu May 30 18:42:22 2002
@@ -139,10 +139,8 @@
 /* preallocated blocks don't need to be run through journal_mark_freed */
 void reiserfs_free_prealloc_block (struct reiserfs_transaction_handle *th, 
                           unsigned long block) {
-    struct super_block * s = th->t_super;
-
-    RFALSE(!s, "vs-4060: trying to free block on nonexistent device");
-    RFALSE(is_reusable (s, block, 1) == 0, "vs-4070: can not free such block");
+    RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
+    RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");
     _reiserfs_free_block(th, block) ;
 }
 
