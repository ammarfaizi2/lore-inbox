Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUELQxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUELQxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUELQxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:53:33 -0400
Received: from linuxhacker.ru ([217.76.32.60]:12756 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265128AbUELQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:53:25 -0400
Date: Wed, 12 May 2004 19:50:38 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, mason@suse.com,
       reiserfs-dev@namesys.com
Subject: [PATCH] [2.6] Make reiserfs not to crash on oom
Message-ID: <20040512165038.GA72981@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  Thanks to Standford guys, a case where reiserfs can dereference NULL pointer
  if memory allocation fail during mount was identified.

  Here's 2.6 version of patch.

Bye,
    Oleg

===== fs/reiserfs/journal.c 1.91 vs edited =====
--- 1.91/fs/reiserfs/journal.c	Mon May 10 14:25:42 2004
+++ edited/fs/reiserfs/journal.c	Wed May 12 19:28:18 2004
@@ -2260,8 +2260,10 @@
     INIT_LIST_HEAD (&SB_JOURNAL(p_s_sb)->j_prealloc_list);
     INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_working_list);
     INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_journal_list);
-    reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
- 				   SB_BMAP_NR(p_s_sb)) ;
+    if (reiserfs_allocate_list_bitmaps(p_s_sb,
+				       SB_JOURNAL(p_s_sb)->j_list_bitmap, 
+ 				       SB_BMAP_NR(p_s_sb)))
+	goto free_and_return ;
     allocate_bitmap_nodes(p_s_sb) ;
 
     /* reserved for journal area support */
