Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSFJNv5>; Mon, 10 Jun 2002 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSFJNvQ>; Mon, 10 Jun 2002 09:51:16 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:26752 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315287AbSFJNuU>;
	Mon, 10 Jun 2002 09:50:20 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADguKE003872@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 11 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 11 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

    variable name cleanup in read_bitmaps.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 super.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.604   -> 1.605  
#	 fs/reiserfs/super.c	1.46    -> 1.47   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.605
# super.c:
#   reiserfs: variable name cleanup in read_bitmaps.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu May 30 18:42:26 2002
+++ b/fs/reiserfs/super.c	Thu May 30 18:42:26 2002
@@ -734,14 +734,14 @@
 
 static int read_bitmaps (struct super_block * s)
 {
-    int i, bmp;
+    int i, bmap_nr;
 
     SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * SB_BMAP_NR(s), GFP_NOFS, s);
     if (SB_AP_BITMAP (s) == 0)
 	return 1;
-    for (i = 0, bmp = REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
-	 i < SB_BMAP_NR(s); i++, bmp = s->s_blocksize * 8 * i) {
-	SB_AP_BITMAP (s)[i] = sb_getblk(s, bmp);
+    for (i = 0, bmap_nr = REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
+	 i < SB_BMAP_NR(s); i++, bmap_nr = s->s_blocksize * 8 * i) {
+	SB_AP_BITMAP (s)[i] = sb_getblk(s, bmap_nr);
 	if (!buffer_uptodate(SB_AP_BITMAP(s)[i]))
 	    ll_rw_block(READ, 1, SB_AP_BITMAP(s) + i);
     }
