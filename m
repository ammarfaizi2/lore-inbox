Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbTC1JGI>; Fri, 28 Mar 2003 04:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbTC1JGI>; Fri, 28 Mar 2003 04:06:08 -0500
Received: from angband.namesys.com ([212.16.7.85]:23445 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262837AbTC1JGF>; Fri, 28 Mar 2003 04:06:05 -0500
Date: Fri, 28 Mar 2003 12:17:20 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [2.4] [PATCH] reiserfs: fixup transaction size check for old filesystems
Message-ID: <20030328121720.G7315@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   It turned out that recently introduced additional journal check
   breaks journal replays on filesystems created with old reiserfs
   tools that do not write journal parameters into superblock.
   Please apply following patch that fixes the problem.

   Thank you.

Bye,
    Oleg
===== fs/reiserfs/journal.c 1.26 vs edited =====
--- 1.26/fs/reiserfs/journal.c	Thu Mar 13 14:52:15 2003
+++ edited/fs/reiserfs/journal.c	Tue Mar 25 16:38:55 2003
@@ -1401,7 +1401,7 @@
 		     *newest_mount_id) ;
       return -1 ;
     }
-    if ( le32_to_cpu(desc->j_len) > sb_journal_trans_max(SB_DISK_SUPER_BLOCK(p_s_sb)) ) {
+    if ( le32_to_cpu(desc->j_len) > JOURNAL_TRANS_MAX ) {
       reiserfs_warning("journal-2018: Bad transaction length %d encountered, ignoring transaction\n", le32_to_cpu(desc->j_len));
       return -1 ;
     }
