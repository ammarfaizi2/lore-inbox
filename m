Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTFQAoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTFQAoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:44:19 -0400
Received: from holomorphy.com ([66.224.33.161]:59038 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264491AbTFQAoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:44:17 -0400
Date: Mon, 16 Jun 2003 17:58:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.71-bk2-wli-1
Message-ID: <20030617005807.GR20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.71/linux-2.5.71-bk2-wli-1.bz2

applies incrementally atop the bk2 snapshot.

So, where does one get a fanbase, anyway? NFI. Here's at least an
attempt to acquire one, with desktop-oriented goodies to speed up
top(1), apparently to the point where top(1) barely even registers
on its own cpu usage reports even with 1s refreshes (900MHz P-III).
It might also vaguely help people instrument heavy multitasking loads.

For what it's worth, the O(1) proc_pid_statm() patch also restores some
of the old 2.4.x fields whose support was removed from 2.5.x.


Merged:
- flow.c compilefix
	Well, I didn't really do any of the work, but at least I don't
	have to carry it around anymore.


Changes since 2.5.71-wli-1:

+ O(1) proc_pid_readdir()
	originally due to Manfred Spraul; figures out its position from
	a small pid hashtable rearrangement

+ O(1) proc_pid_statm()
	originally due to Ben LaHaise (I think); keeps count of the various
	proc_pid_statm() counters whenever twiddling ptes.

+ non-i386 highpmd fixes
	write stubs for non-i386 pmd twiddling functions

+ highpmd fixes
	a few mm/memory.c functions forgot to pass pmd pointers by reference

+ O(1) buffered_rmqueue() fixes
	correct small typo in CONFIG_SOFTWARE_SUSPEND code touched by it

+ i386 pagetable cache fixes
	Correct failure to reset tlb->freed, which resulted in wildly wrong
	mm->rss counts. Also define FREE_PTE_NR so CONFIG_PREEMPT compiles.


All 12 patches:

O(1) rmqueue_bulk()
	Implement deferred coalescing with list-of-lists -structured order 0
	deferred queues so buffered_rmqueue() in O(1) expected time.

lowmem_page_address() microoptimization
	use page_to_pfn() to inherit its arch-specific microoptimizations

highpmd
	shove pmd's into highmem, by brute force

trivial /proc/ BKL removals
	Kill off some blatantly unnecessary BKL-grabbing in /proc/

i386 pagetable cache
	Resurrect the i386 pagetable cache

pgd_ctor
	Use slab ctors for i386 pgd's, and be safe with AGP and highpmd

O(1) proc_pid_readdir()
	originally due to Manfred Spraul; figures out its position from
	a small pid hashtable rearrangement

O(1) proc_pid_statm()
	originally due to Ben LaHaise (I think); keeps count of the various
	proc_pid_statm() counters whenever twiddling ptes.

non-i386 highpmd fixes
	write stubs for non-i386 pmd twiddling functions

highpmd fixes
	a few mm/memory.c functions forgot to pass pmd pointers by reference

O(1) buffered_rmqueue() fixes
	correct small typo in CONFIG_SOFTWARE_SUSPEND code touched by it

i386 pagetable cache fixes
	Correct failure to reset tlb->freed, which resulted in wildly wrong
	mm->rss counts. Also define FREE_PTE_NR so CONFIG_PREEMPT compiles.


-- wli
