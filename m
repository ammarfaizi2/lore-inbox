Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTLDUBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTLDUBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:01:25 -0500
Received: from holomorphy.com ([199.26.172.102]:30929 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261719AbTLDUBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:01:23 -0500
Date: Thu, 4 Dec 2003 12:01:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11-wli-1
Message-ID: <20031204200120.GL19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Successfully tested on a Thinkpad T21. Any feedback regarding
performance would be very helpful. Desktop users should notice top(1)
is faster, kernel hackers that kernel compiles are faster, and highmem
users should see much less per-process lowmem overhead.

This release is vastly cleaned up compared to the test8 release, and
features the wchan and major/minor fault accounting fixes. I still
need to fold the anobjrmap fixes into the original patches and find
some alternative way for smbfs and ncpfs to do whatever d_validate()
was doing for them. I also need to find a coherent way to incorporate
the cleanups for pte caching suggested by akpm without bloating the
pte cache on lowmem boxen (but nothing radical like 4/4 or pgcl).

It's also worth noting that the patches "originally due" to someone
were just plucked off of the list by me (in some cases, they just first
implemented of the idea), so be sure to ascribe all the credit to
them, and all the bugs to me. I wasn't sure of a complete (or even
partial) list of those to credit for top-down vma allocation, hence
"various", though it was jejb who described the glibc workaround.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.6.0-test11/


-- wli

 1:	highpmd
		-- originally due to aa as part of pte-highmem
		-- from scratch implementation based on 2.6 highpte
 2:	O(1) buffered_rmqueue()
 3:	i386 pte caching
 4:	O(lg(n)) proc_pid_readdir()/proc_task_readdir()
 5:	O(1) proc_pid_statm()
		-- originally due to bcrl
 6:	kmap_atomic() microoptimizations
 7:	compile-time mapping->page_lock type selection
 8:	4KB i386 stacks
		-- originally due to bcrl
 9:	objrmap
		-- originally due to dmc/mbligh
10:	RCU mapping->i_shared_lock
11:	anobjrmap, phase 1
		-- originally due to hugh
12:	anobjrmap, phase 2
		-- originally due to hugh
13:	anobjrmap, phase 3
		-- originally due to hugh
14:	anobjrmap, phase 4
		-- originally due to hugh
15:	anobjrmap, phase 5
		-- originally due to hugh
16:	RCU anon->lock
17:	convert copy_strings() to use kmap_atomic() instead of kmap()
18:	increase page allocator batch counts
19:	node-local i386 per_cpu areas
20:	CONFIG_MMAP_TOPDOWN, top-down vma allocation
		-- various prior implementations
21:	anobjrmap fixes
22:	increase static vfs hashtable and VM array sizes
23:	intermezzo 4KB stack fixes
		-- due to muli
24:	/proc/ BKL gunk plus page wait hashtable sizing adjustment
25:	invalidate_inodes() speedup
		-- originally due to Kirill Korotaev
26:	fix the anobjrmap fix and adjust page_alloc.c inlining
27:	remove ->valid_addr_bitmap, kern_addr_valid(), and d_validate()
28:	fix wchan accounting
29:	fix major/minor fault accounting
30:	remove mm->swap_address
