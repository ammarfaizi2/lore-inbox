Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbUCYXkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUCYXkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:40:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4225
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263660AbUCYXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:40:13 -0500
Date: Fri, 26 Mar 2004 00:41:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.5-rc2-aa3
Message-ID: <20040325234106.GA1972@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this seems feature complete. Both nonlinear swapping and prio_tree
are available now. I believe objrmap-core+anon-vma+prio_tree can be
merged into mainline after a bit more of testing, certainly they looks
good enough for -mm.

As usual this work wouldn't been possible without the efforts of Hugh
Dickins, Dave McCracken, and last but not the least Rajesh
Venkatasubramanian.

As usual I'm writing this on my desktop while running this kernel and it
swaps fine (uptime still 10 minutes though ;).

after some misc swapping (desktop like load) this is the profiling:

724627 total                                      0.2810
613729 default_idle                             9589.5156
 47565 mmx_clear_page                           424.6875
  9710 do_page_fault                              7.2898
  5965 buffered_rmqueue                           9.8109
  4589 delay_tsc                                143.4062
  3986 do_no_page                                 2.1853
  2679 unmap_page_range                           3.4171
  2487 free_hot_cold_page                         9.1434
  2363 page_add_rmap                              6.4212
  1897 page_address                              10.7784
  1600 handle_mm_fault                            0.6993
  1594 release_pages                              4.5284
  1289 page_remove_rmap                           5.7545
  1229 lru_cache_add_active                      15.3625
  1041 __alloc_pages                              1.3555
  1002 find_pte                                   5.2188
   952 __copy_to_user_ll                          3.9667
   858 __pagevec_lru_add_active                   4.4688
   720 probe_irq_on                               2.2500

the prio_tree funcs are at the end, this is expected since I have normal
load:

    14 prio_tree_insert                           0.0203
     8 prio_tree_first                            0.0185
     6 prio_tree_remove                           0.0179
     4 __vma_prio_tree_insert                     0.0139
     4 prio_tree_next                             0.0081
     2 __vma_prio_tree_remove                     0.0054

the db simulator is running fine on the test box too.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa3.gz

Changelog diff between 2.6.5-rc2-aa2 and 2.6.5-rc2-aa3:

Only in 2.6.5-rc2-aa2: anon_vma.gz
Only in 2.6.5-rc2-aa3: anon-vma.gz

	Rediffed to fixup a reject after objrmap-core update.

Files 2.6.5-rc2-aa2/extraversion and 2.6.5-rc2-aa3/extraversion differ
Files 2.6.5-rc2-aa2/objrmap-core.gz and 2.6.5-rc2-aa3/objrmap-core.gz differ

	Fixup locking in swapoff, and microscalability optimization
	in do_munmap. Both from the original objrmap patch from Dave McCracken.

Only in 2.6.5-rc2-aa3: prio-tree.gz

	Drop computational complexity of swapping using objrmap, using
	a prio tree for efficient search of the vma-ranges mapping
	any given page in an inode. From Rajesh Venkatasubramanian.

	More details can be found at his URL:
	http://www-personal.engin.umich.edu/~vrajesh/linux/prio_tree/
