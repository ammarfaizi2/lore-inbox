Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbUKJVaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUKJVaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUKJV36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:29:58 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:44265 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262134AbUKJV2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:28:34 -0500
Date: Wed, 10 Nov 2004 22:28:18 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110212818.GC25410@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041109203348.GD8414@logos.cnet>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 06:33:48PM -0200, Marcelo Tosatti wrote:
> So you can be hitting the e1000/TSO issue - care to retest with 
> 2.6.10-rc1-mm3/4 please?
> 
> Thanks a lot for testing!

This is from 2.6.10-rc1-mm3: (i added show_free..)

 swapper: page allocation failure. order:0, mode:0x20
  [<c0137f28>] __alloc_pages+0x242/0x40e
  [<c0138119>] __get_free_pages+0x25/0x3f
  [<c032ed55>] tcp_v4_rcv+0x69a/0x9b5
  [<c013b189>] kmem_getpages+0x21/0xc9
  [<c013be3a>] cache_grow+0xab/0x14d
  [<c013c05e>] cache_alloc_refill+0x182/0x244
  [<c013c3ec>] __kmalloc+0x85/0x8c
  [<c02fac89>] alloc_skb+0x47/0xe0
  [<c02997ca>] e1000_alloc_rx_buffers+0x44/0xe3
  [<c029944b>] e1000_clean_rx_irq+0x17c/0x4b7
  [<c0298fd0>] e1000_clean+0x51/0xe7
  [<c03010dc>] net_rx_action+0x7f/0x11f
  [<c011daa3>] __do_softirq+0xb7/0xc6
  [<c011dadf>] do_softirq+0x2d/0x2f
  [<c010614e>] do_IRQ+0x1e/0x24
  [<c0104756>] common_interrupt+0x1a/0x20
  [<c0101eae>] default_idle+0x0/0x2c
  [<c0101ed7>] default_idle+0x29/0x2c
  [<c0101f40>] cpu_idle+0x33/0x3c
  [<c0448a1f>] start_kernel+0x14c/0x165
  [<c04484bd>] unknown_bootoption+0x0/0x1ab
 DMA per-cpu:
 cpu 0 hot: low 2, high 6, batch 1
 cpu 0 cold: low 0, high 2, batch 1
 cpu 1 hot: low 2, high 6, batch 1
 cpu 1 cold: low 0, high 2, batch 1
 Normal per-cpu:
 cpu 0 hot: low 32, high 96, batch 16
 cpu 0 cold: low 0, high 32, batch 16
 cpu 1 hot: low 32, high 96, batch 16
 cpu 1 cold: low 0, high 32, batch 16
 HighMem per-cpu:
 cpu 0 hot: low 14, high 42, batch 7
 cpu 0 cold: low 0, high 14, batch 7
 cpu 1 hot: low 14, high 42, batch 7
 cpu 1 cold: low 0, high 14, batch 7
 Free pages:         532kB (252kB HighMem)
 Active:39820 inactive:208936 dirty:104508 writeback:672 unstable:0 free:133 slab:7779 mapped:15810 pagetables:410
 DMA free:8kB min:12kB low:24kB high:36kB active:384kB inactive:11400kB present:16384kB pages_scanned:192 all_unreclaimable? no
 protections[]: 0 0 0
 DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
 Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 272kB
 HighMem: 15*4kB 8*8kB 2*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 252kB
 Swap cache: add 1, delete 0, find 0/0, race 0+0
 printk: 696 messages suppressed.
 swapper: page allocation failure. order:0, mode:0x20

-- 
Luká¹ Hejtmánek
