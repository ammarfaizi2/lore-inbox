Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTHZSma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTHZSma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:42:30 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:2955 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262255AbTHZSmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:42:11 -0400
Date: Tue, 26 Aug 2003 22:38:50 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4: blkdev_requests "memory before object was overwritten" and oops in __iget
Message-ID: <20030826183850.GA4781@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Found one of my test boxes freezed today (or may be even yesterday).
   That's what was in logs:

Aug 25 00:50:37 dwarf kernel: [drm] DMA Cleanup
Aug 25 21:46:31 dwarf kernel: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
Aug 25 21:46:31 dwarf kernel: [drm] Using POST v1.2 init.
Aug 25 21:46:31 dwarf kernel: PCI: Found IRQ 11 for device 0000:00:02.0
Aug 25 21:46:39 dwarf kernel: slab error in cache_alloc_debugcheck_after(): cache `blkdev_requests': memory before object was overwritten
Aug 25 21:46:39 dwarf kernel: Call Trace:
Aug 25 21:46:39 dwarf kernel:  [<c0153b4b>] kmem_cache_alloc+0xdb/0x1c0
Aug 25 21:46:39 dwarf kernel:  [<c014c615>] mempool_alloc+0x65/0x290
Aug 25 21:46:39 dwarf kernel:  [<c014c615>] mempool_alloc+0x65/0x290
Aug 25 21:46:39 dwarf kernel:  [<c0123af0>] autoremove_wake_function+0x0/0x50
Aug 25 21:46:39 dwarf last message repeated 2 times
Aug 25 21:46:39 dwarf kernel:  [<c039d60f>] get_request+0x19f/0x550
Aug 25 21:46:39 dwarf kernel:  [<c039aa79>] elv_merge+0x29/0x30
Aug 25 21:46:39 dwarf kernel:  [<c039e51c>] __make_request+0x1ac/0x690
Aug 25 21:46:39 dwarf kernel:  [<c039eb43>] generic_make_request+0x143/0x1e0
Aug 25 21:46:39 dwarf kernel:  [<c017813a>] bio_alloc+0xda/0x1c0
Aug 25 21:46:40 dwarf kernel:  [<c039ec1d>] submit_bio+0x3d/0x80
Aug 25 21:46:40 dwarf kernel:  [<c01d7eda>] submit_logged_buffer+0x3a/0x60
Aug 25 21:46:41 dwarf kernel:  [<c01d8583>] kupdate_one_transaction+0x233/0x240
Aug 25 21:46:41 dwarf kernel:  [<c01d8619>] reiserfs_journal_kupdate+0x89/0xd0
Aug 25 21:46:41 dwarf kernel:  [<c01db471>] flush_old_commits+0x141/0x1d0
Aug 25 21:46:41 dwarf kernel:  [<c01c90d0>] reiserfs_write_super+0x30/0x40
Aug 25 21:46:41 dwarf kernel:  [<c017a3aa>] sync_supers+0x1ea/0x280
Aug 25 21:46:41 dwarf kernel:  [<c014fa85>] wb_kupdate+0x45/0x140
Aug 25 21:46:41 dwarf kernel:  [<c0120aba>] schedule+0x1fa/0x530
Aug 25 21:46:41 dwarf kernel:  [<c0150424>] __pdflush+0x214/0x600
Aug 25 21:46:41 dwarf kernel:  [<c0150810>] pdflush+0x0/0x20
Aug 25 21:46:41 dwarf kernel:  [<c0150821>] pdflush+0x11/0x20
Aug 25 21:46:41 dwarf kernel:  [<c014fa40>] wb_kupdate+0x0/0x140
Aug 25 21:46:41 dwarf kernel:  [<c0108269>] kernel_thread_helper+0x5/0xc
Aug 25 21:46:41 dwarf kernel: 
Aug 25 21:46:41 dwarf kernel: slab error in cache_alloc_debugcheck_after(): cache `blkdev_requests': memory after object was overwritten
Aug 25 21:46:41 dwarf kernel: Call Trace:
Aug 25 21:46:41 dwarf kernel:  [<c0153b73>] kmem_cache_alloc+0x103/0x1c0
Aug 25 21:46:41 dwarf kernel:  [<c014c615>] mempool_alloc+0x65/0x290
Aug 25 21:46:41 dwarf kernel:  [<c014c615>] mempool_alloc+0x65/0x290
Aug 25 21:46:41 dwarf kernel:  [<c0123af0>] autoremove_wake_function+0x0/0x50
Aug 25 21:46:41 dwarf last message repeated 2 times
Aug 25 21:46:41 dwarf kernel:  [<c039d60f>] get_request+0x19f/0x550
Aug 25 21:46:41 dwarf kernel:  [<c039aa79>] elv_merge+0x29/0x30
Aug 25 21:46:41 dwarf kernel:  [<c039e51c>] __make_request+0x1ac/0x690
Aug 25 21:46:41 dwarf kernel:  [<c039eb43>] generic_make_request+0x143/0x1e0
Aug 25 21:46:41 dwarf kernel:  [<c017813a>] bio_alloc+0xda/0x1c0
Aug 25 21:46:41 dwarf kernel:  [<c039ec1d>] submit_bio+0x3d/0x80
Aug 25 21:46:42 dwarf kernel:  [<c01d7eda>] submit_logged_buffer+0x3a/0x60
Aug 25 21:46:42 dwarf kernel:  [<c01d8583>] kupdate_one_transaction+0x233/0x240
Aug 25 21:46:42 dwarf kernel:  [<c01d8619>] reiserfs_journal_kupdate+0x89/0xd0
Aug 25 21:46:42 dwarf kernel:  [<c01db471>] flush_old_commits+0x141/0x1d0
Aug 25 21:46:42 dwarf kernel:  [<c01c90d0>] reiserfs_write_super+0x30/0x40
Aug 25 21:46:42 dwarf kernel:  [<c017a3aa>] sync_supers+0x1ea/0x280
Aug 25 21:46:42 dwarf kernel:  [<c014fa85>] wb_kupdate+0x45/0x140
Aug 25 21:46:42 dwarf kernel:  [<c0120aba>] schedule+0x1fa/0x530
Aug 25 21:46:42 dwarf kernel:  [<c0150424>] __pdflush+0x214/0x600
Aug 25 21:46:42 dwarf kernel:  [<c0150810>] pdflush+0x0/0x20
Aug 25 21:46:42 dwarf kernel:  [<c0150821>] pdflush+0x11/0x20
Aug 25 21:46:42 dwarf kernel:  [<c014fa40>] wb_kupdate+0x0/0x140
Aug 25 21:46:42 dwarf kernel:  [<c0108269>] kernel_thread_helper+0x5/0xc
Aug 25 21:46:42 dwarf kernel: 
Aug 25 21:46:44 dwarf kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 25 21:46:44 dwarf kernel:  printing eip:
Aug 25 21:46:44 dwarf kernel: c0193139
Aug 25 21:46:44 dwarf kernel: *pde = 00000000
Aug 25 21:46:44 dwarf kernel: Oops: 0002 [#1]
Aug 25 21:46:44 dwarf kernel: CPU:    0
Aug 25 21:46:44 dwarf kernel: EIP:    0060:[<c0193139>]    Not tainted
Aug 25 21:46:44 dwarf kernel: EFLAGS: 00010246
Aug 25 21:46:44 dwarf kernel: EIP is at __iget+0x29/0x60
Aug 25 21:46:44 dwarf kernel: eax: c04fb328   ebx: cd46c03c   ecx: 00000000   edx: cd46c044
Aug 25 21:46:44 dwarf kernel: esi: 00000071   edi: c04fb360   ebp: df8f5e44   esp: df8f5e40
Aug 25 21:46:44 dwarf kernel: ds: 007b   es: 007b   ss: 0068
Aug 25 21:46:44 dwarf kernel: Process kswapd0 (pid: 8, threadinfo=df8f4000 task=df926000)
Aug 25 21:46:44 dwarf kernel: Stack: cd46c03c df8f5e84 c019398e cd46c03c 00000077 000000ff 000001ef 000000ff 
Aug 25 21:46:45 dwarf kernel:        df8f5e60 df8f5e60 00000000 00000071 c9984044 d57d5044 00000080 df8f4000 
Aug 25 21:46:45 dwarf kernel:        00000053 df8f5e90 c0193be8 00000080 df8f5ec4 c0157cff 00000080 000000d0 
Aug 25 21:46:45 dwarf kernel: Call Trace:
Aug 25 21:46:45 dwarf kernel:  [<c019398e>] prune_icache+0x20e/0x440
Aug 25 21:46:45 dwarf kernel:  [<c0193be8>] shrink_icache_memory+0x28/0x30
Aug 25 21:46:45 dwarf kernel:  [<c0157cff>] shrink_slab+0x11f/0x170
Aug 25 21:46:45 dwarf kernel:  [<c0159b70>] balance_pgdat+0x1e0/0x220
Aug 25 21:46:45 dwarf kernel:  [<c0159c95>] kswapd+0xe5/0x100
Aug 25 21:46:45 dwarf kernel:  [<c0123af0>] autoremove_wake_function+0x0/0x50
Aug 25 21:46:45 dwarf kernel:  [<c0123af0>] autoremove_wake_function+0x0/0x50
Aug 25 21:46:45 dwarf kernel:  [<c0159bb0>] kswapd+0x0/0x100
Aug 25 21:46:45 dwarf kernel:  [<c0108269>] kernel_thread_helper+0x5/0xc
Aug 25 21:46:45 dwarf kernel: 
Aug 25 21:46:45 dwarf kernel: Code: 89 01 c7 43 08 00 01 10 00 89 48 04 a1 20 b3 4f c0 89 50 04 
Aug 25 21:46:45 dwarf kernel:  fs/fs-writeback.c:71: spin_lock(fs/inode.c:c04fb330) already locked by fs/inode.c/409
Aug 25 22:54:59 dwarf kernel: [drm] DMA Cleanup

   This is usual pentium3-650, 512M RAM, i815-based motherboard, uniprocessor
   kernel. X server was not started at the time.
   Ask me if you need more info.

Bye,
    Oleg
