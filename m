Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277546AbRJETYv>; Fri, 5 Oct 2001 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277558AbRJETYm>; Fri, 5 Oct 2001 15:24:42 -0400
Received: from [204.177.156.37] ([204.177.156.37]:54157 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S277546AbRJETYa>; Fri, 5 Oct 2001 15:24:30 -0400
Date: Fri, 5 Oct 2001 20:26:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: pre4 oom too soon
Message-ID: <Pine.LNX.4.21.0110051945080.1199-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.11-pre4 gives me oom_kill I never got before.
All numbers decimal in 4kB pages:

num_physpages         65520
free or freeable      56000	(from MemFree after swapoff afterwards)
total_swap_pages     132526
prog tries to hog    153600

At oom_kill time:

all_zones_low           yes    (DMA & Normal well above min, no Highmem)
nr_swap_pages             0
page_cache_size       59013
swapper_space.nrpages 58202

I'm not sure exactly what to blame in out_of_memory(), but it does
look wrong to depend so much on whether nr_swap_pages happens to be
0 at that instant or not, and a lot of that full swap is duplicated
in the swap cache.  Probably that should be taken into consideration?

(I wonder whether, before my 2.4.10 fix to lowest_bit and highest_bit
in scan_swap_map, it was rarer to find nr_swap_pages 0 - swap pages
could be free, but invisible to scan_swap_map.)

Hugh

