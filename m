Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280856AbRKBW3V>; Fri, 2 Nov 2001 17:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280860AbRKBW3N>; Fri, 2 Nov 2001 17:29:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:42036 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S280856AbRKBW27>; Fri, 2 Nov 2001 17:28:59 -0500
Date: Fri, 2 Nov 2001 22:29:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vm_swap_full bogus
Message-ID: <Pine.LNX.4.21.0111022224220.2575-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed bogus vm_swap_full() macro since 2.4.10:
swapper_space.nrpages counts _cached_ swap, not used swap.
Either I'm confused again, or... please apply!

Hugh

--- 2.4.14-pre7/mm/memory.c	Fri Nov  2 06:22:15 2001
+++ linux/mm/memory.c	Fri Nov  2 22:13:19 2001
@@ -1068,7 +1068,7 @@
 
 /* Swap 80% full? Release the pages as they are paged in.. */
 #define vm_swap_full() \
-	(swapper_space.nrpages*5 > total_swap_pages*4)
+	(nr_swap_pages*5 < total_swap_pages)
 
 /*
  * We hold the mm semaphore and the page_table_lock on entry and

