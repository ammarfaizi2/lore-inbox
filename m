Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276702AbRJHIk6>; Mon, 8 Oct 2001 04:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276763AbRJHIkt>; Mon, 8 Oct 2001 04:40:49 -0400
Received: from [204.177.156.37] ([204.177.156.37]:48541 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S276702AbRJHIko>; Mon, 8 Oct 2001 04:40:44 -0400
Date: Mon, 8 Oct 2001 09:42:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] spurious swap_list_unlock
In-Reply-To: <20011008002426.I726@athlon.random>
Message-ID: <Pine.LNX.4.21.0110080932380.1379-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Andrea Arcangeli wrote:
> On Sun, Oct 07, 2001 at 01:35:58AM +0200, Andrea Arcangeli wrote:
> > On Thu, Oct 04, 2001 at 10:57:09PM +0200, Andrea Arcangeli wrote:
> > > 2) Hugh's locking cleanups
> > 
> > checked now (of course it's just in pre4), very nice.
> 
> btw, while playing with the code I now noticed a swap_list_unlock
> leftover in vmscan.c.

Eek, that's not at all nice!  Many thanks for spotting it,
and for your review, Andrea.  I'll check it all over again.
For others' sake, patch for 2.4.11-pre5 or 2.4.11-pre4 below.

Hugh

--- 2.4.11-pre5/mm/vmscan.c	Sun Oct  7 20:54:29 2001
+++ linux/mm/vmscan.c	Mon Oct  8 09:32:13 2001
@@ -139,7 +139,6 @@
 	}
 
 	/* No swap space left */
-	swap_list_unlock();
 	set_pte(page_table, pte);
 	UnlockPage(page);
 	return 0;

