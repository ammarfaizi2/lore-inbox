Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbUKIWg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUKIWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUKIWg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:36:27 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:29143 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261732AbUKIWgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:36:15 -0500
Date: Tue, 9 Nov 2004 23:35:58 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Stefan Schmidt <zaphodb@zaphods.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041109223558.GR1309@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041109164113.GD7632@logos.cnet>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Nov 09, 2004 at 02:41:13PM -0200, Marcelo Tosatti wrote:
> Stefan, Lukas, 
> 
> Can you please run your workload which cause 0-order page allocation 
> failures with the following patch, pretty please? 
> 
> We will have more information on the free areas state when the allocation 
> fails.
> 
> Andrew, please apply it to the next -mm, will you?

here is the trace:
 klogd: page allocation failure. order:0, mode: 0x20
  [__alloc_pages+441/862] __alloc_pages+0x1b9/0x363
  [__get_free_pages+42/63] __get_free_pages+0x25/0x3f
  [kmem_getpages+37/201] kmem_getpages+0x21/0xc9
  [cache_grow+175/333] cache_grow+0xab/0x14d
  [cache_alloc_refill+376/537] cache_alloc_refill+0x174/0x219
  [__kmalloc+137/140] __kmalloc+0x85/0x8c
  [alloc_skb+75/224] alloc_skb+0x47/0xe0
  [e1000_alloc_rx_buffers+72/227] e1000_alloc_rx_buffers+0x44/0xe3
  [e1000_clean_rx_irq+402/1095] e1000_clean_rx_irq+0x18e/0x447
  [e1000_clean+85/202] e1000_clean+0x51/0xca
  [net_rx_action+123/246] net_rx_action+0x77/0xf6
  [__do_softirq+183/198] __do_softirq+0xb7/0xc6
  [do_softirq+45/47] do_softirq+0x2d/0x2f
  [do_IRQ+274/304] do_IRQ+0x112/0x130
  [common_interrupt+24/32] common_interrupt+0x18/0x20
  [_spin_unlock_irq+13/28] _spin_unlock_irq+0x9/0x1c
  [do_syslog+295/990] do_syslog+0x127/0x3de
  [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
  [autoremove_wake_function+0/87] autoremove_wake_function+0x0/0x57
  [dnotify_parent+62/166] dnotify_parent+0x3a/0xa6
  [vfs_read+180/281] vfs_read+0xb0/0x119
  [sys_read+85/128] sys_read+0x51/0x80
  [syscall_call+7/11] syscall_call+0x7/0xb
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

 Free pages:         348kB (112kB HighMem)
 Active:38175 inactive:210615 dirty:95618 writeback:2461 unstable:0 free:87 slab:7706 mapped:14968 pagetables:404
 DMA free:4kB min:12kB low:24kB high:36kB active:456kB inactive:11152kB present:16384kB
 protections[]: 0 0 0
 Normal free:232kB min:708kB low:1416kB high:384kB active:40264kB inactive:88296kB present:131008kB
 protections[]: 0 0 0
 HighMem free:112kB min:128kB low:256kB high:384kB active:40264kB inactive:88296kB present:131008kB
 protections[]: 0 0 0
 DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4kB
 Normal: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 232kB
 HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 112kB
 Swap cache: add 1, delete 1, find 0/0, race 0+0

-- 
Luká¹ Hejtmánek
