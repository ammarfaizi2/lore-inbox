Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbSLREhN>; Tue, 17 Dec 2002 23:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbSLREhN>; Tue, 17 Dec 2002 23:37:13 -0500
Received: from holomorphy.com ([66.224.33.161]:64186 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267122AbSLREhL>;
	Tue, 17 Dec 2002 23:37:11 -0500
Date: Tue, 17 Dec 2002 20:44:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.52-wli-1
Message-ID: <20021218044443.GC12812@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.52-wli-1/

Notable events:

(1) I switched to mainline releases since intermediate -bk snapshots
	vaporize after the following mainline release.
(2) The driverfs oops fix got merged.
(3) A new patch dynamically sizes the pidhash to save memory on tiny boxen.
(4) A new patch has a small experiment with pte_chain pointer block sizes.

01_numaq_io
		My NUMA-Q has PCI-PCI bridges and I've not quite gotten
		them working yet. Here's the workaround. If someone
		would be kind enough to make PCI segments not require
		3 cleanup passes and an accessor that changes semantics
		between each pass and after the last one I'd be much obliged.

02_do_sak
		Update __do_SAK() to use for_each_task_pid(). It was
		looking for all tasks in a given session.

03_proc_super
		Keep count of real processes (not threads) and don't
		walk the tasklist in proc_fill_super().

04_cap_set_pg
		Use for_each_task_pid() in cap_set_pg(). It's trying
		to find all tasks in a given pgrp.

05_vm86		Bugfix for not using release on exit() but instead
		scanning for a matching task pointer, which is oopsable.

06_uml_get_task
		get_task() is attempting to do find_task_by_pid().
		Call find_task_by_pid() and remove tasklist scanning.

07_numaq_mem_map
		Speed up NUMA-Q mem_map initialization by freeing
		higher-order pages during highpage init.

08_numaq_pgdat
		Allocate pgdat's from node-local memory on NUMA-Q.

09_has_stopped_jobs
		Remove the unused has_stopped_jobs() function and
		rename __has_stopped_jobs() to has_stopped_jobs().

10_inode_wait
		Increase the size of the inode wait table.

11_pgd_ctor
		Use slab ctor's to reduce the initialization costs of
		PAE pgd's and pmd's.

12_pidhash_size
		Dynamically size the pidhash hashtable at boot-time,
		proportional to memory. 128KB isn't used until 1GB RAM.
		Kernel BSS reduced by (almost) 128KB.

13_rmap_nrpte
		Try forcibly increasing NRPTE to just slightly above the
		mean pte_chain length for theoretically less allocation
		overhead and/or L2 cache footprint (note: they're already
		>= L1_CACHE_BYTES). If this doesn't work, all you'll get
		is internal fragmentation (measurable by comparing the
		slab info to nr_reverse_maps).
		I'm not 100% sure I want to keep core VM stuff in here...
