Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272241AbRH3O3J>; Thu, 30 Aug 2001 10:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272235AbRH3O3B>; Thu, 30 Aug 2001 10:29:01 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:11019 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272241AbRH3O2p>; Thu, 30 Aug 2001 10:28:45 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19815.629732.93415@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:27:51 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: E-pathrelse.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

   This patch adds missing call to pathrelse() to error path in 
   reiserfs_do_truncate(). Without pathrelse(), buffers involved
   into balancing by some process remain locked and can deadlock 
   another process.

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/stree.c linux.patched/fs/reiserfs/stree.c
--- linux/fs/reiserfs/stree.c	Sat Jul 21 21:05:18 2001
+++ linux.patched/fs/reiserfs/stree.c	Tue Aug  7 19:52:32 2001
@@ -1857,6 +1857,7 @@ void reiserfs_do_truncate (struct reiser
 	return;
     }
     if (retval == POSITION_FOUND || retval == FILE_NOT_FOUND) {
+	pathrelse (&s_search_path);
 	reiserfs_warning ("PAP-5660: reiserfs_do_truncate: "
 			  "wrong result %d of search for %K\n", retval, &s_item_key);
 	return;
