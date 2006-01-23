Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWAWUzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWAWUzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAWUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:55:36 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:40299 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932477AbWAWUze convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:55:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mg7QzwuOosapgjmJYNv6S1SqhOsWq5P0cGBFBUmKdF3gqKuuXBrRUQ0uKWPciMhMHV1kNuK/7jAkeNjCyc1zWa+EbgWPTOUVYTR6rg/LG7bPHvz3vaxQ5lik72G6MdkvZpuqi04Sm4x/btLWt8KqhaALXxj343fAPBxxHJ2iIjs=
Message-ID: <32e47b670601231255l16fa0fa5i20823aab0c213971@mail.gmail.com>
Date: Mon, 23 Jan 2006 15:55:34 -0500
From: Sai Bathina <sai.bathina@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14.3 and page allocation failures..
In-Reply-To: <1138048153.136509.119540@f14g2000cwb.googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138048153.136509.119540@f14g2000cwb.googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I am seeing page allocation errors and I have a snapshot of the
/var/log/messages.

My Hardware configs are
Dell 750, using e1000 driver(e1000-6.2.15)

model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz cache size      :
1024 KB

             total       used       free     shared    buffers
cached
Mem:       1035396     573568     461828          0      24812
40400
-/+ buffers/cache:     508356     527040
Swap:      2097136          0    2097136

Observed the failures after about 9-10 hrs of running network traffic.
I am assuming that it has something to do with the e1000 driver page
allocations here....I would appreciate if anyone can help me in
figuring out what is going wrong with this.



Jan 20 09:00:02  snort2: page allocation failure. order:0, mode:0x20
Jan 20 09:00:02   [__alloc_pages+936/976] __alloc_pages+0x3a8/0x3d0
Jan 20 09:00:02   [kmem_getpages+44/132] kmem_getpages+0x2c/0x84
Jan 20 09:00:02   [cache_grow+163/316] cache_grow+0xa3/0x13c
Jan 20 09:00:02   [cache_alloc_refill+415/488]
cache_alloc_refill+0x19f/0x1e8
Jan 20 09:00:02   [__kmalloc+115/136] __kmalloc+0x73/0x88
Jan 20 09:00:03   [__alloc_skb+88/292] __alloc_skb+0x58/0x124
Jan 20 09:00:03   [pg0+944968351/1069114368]
e1000_alloc_rx_buffers+0x6f/0x3b0 [e1000]
Jan 20 09:00:03   [netif_receive_skb+322/576]
netif_receive_skb+0x142/0x240
Jan 20 09:00:03   [pg0+944966571/1069114368]
e1000_clean_rx_irq+0x6db/0x6ec [e1000]
Jan 20 09:00:03   [__kfree_skb+15/204] __kfree_skb+0xf/0xcc
Jan 20 09:00:03   [pg0+944963983/1069114368] e1000_clean+0x9f/0x150
[e1000]
Jan 20 09:00:03   [net_rx_action+128/296] net_rx_action+0x80/0x128
Jan 20 09:00:03   [gcc2_compiled.+141/256] __do_softirq+0x8d/0x100
Jan 20 09:00:03   [do_softirq+47/52] do_softirq+0x2f/0x34
Jan 20 09:00:03   [irq_exit+52/64] irq_exit+0x34/0x40
Jan 20 09:00:03   [gcc2_compiled.+32/40] do_IRQ+0x20/0x28
Jan 20 09:00:03   [common_interrupt+26/32] common_interrupt+0x1a/0x20
Jan 20 09:00:03  Mem-info:
Jan 20 09:00:03  DMA per-cpu:
Jan 20 09:00:03  cpu 0 hot: low 2, high 6, batch 1 used:2
Jan 20 09:00:03  cpu 0 cold: low 0, high 2, batch 1 used:1
Jan 20 09:00:03  Normal per-cpu:
Jan 20 09:00:03  cpu 0 hot: low 62, high 186, batch 31 used:98
Jan 20 09:00:03  cpu 0 cold: low 0, high 62, batch 31 used:44
Jan 20 09:00:03  HighMem per-cpu:
Jan 20 09:00:03  cpu 0 hot: low 30, high 90, batch 15 used:33
Jan 20 09:00:03  cpu 0 cold: low 0, high 30, batch 15 used:18
Jan 20 09:00:03  Free pages:        5176kB (300kB HighMem)
Jan 20 09:00:03  Active:129626 inactive:112034 dirty:39 writeback:773
unstable:0 free:1294 slab:12014 mapped:235222 pagetables:684
Jan 20 09:00:03  DMA free:3548kB min:68kB low:84kB high:100kB
active:3252kB inactive:3068kB present:16384kB pages_scanned:33
all_unreclaimable? no
Jan 20 09:00:03  lowmem_reserve[]: 0 880 1007
Jan 20 09:00:03  Normal free:1328kB min:3756kB low:4692kB high:5632kB
active:438048kB inactive:393860kB present:901120kB pages_scanned:1620
all_unreclaimable? no
Jan 20 09:00:03  lowmem_reserve[]: 0 0 1022
Jan 20 09:00:03  HighMem free:300kB min:128kB low:160kB high:192kB
active:77204kB inactive:51208kB present:130816kB pages_scanned:0
all_unreclaimable? no
Jan 20 09:00:03  lowmem_reserve[]: 0 0 0
Jan 20 09:00:03  DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
Jan 20 09:00:03  Normal: 0*4kB 0*8kB 1*16kB 1*32kB 0*64kB 0*128kB
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1328kB
Jan 20 09:00:03  HighMem: 23*4kB 12*8kB 1*16kB 1*32kB 1*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 300kB
Jan 20 09:00:03  Swap cache: add 320859, delete 319219, find
236898/236988, race 0+0
Jan 20 09:00:03  Free swap  = 817272kB
Jan 20 09:00:03  Total swap = 2097136kB
Jan 20 09:00:03  Free swap:       817272kB
Jan 20 09:00:03  262080 pages of RAM
Jan 20 09:00:03  32704 pages of HIGHMEM
Jan 20 09:00:03  4255 reserved pages
Jan 20 09:00:03  9309 pages shared
Jan 20 09:00:03  1640 pages swap cached
Jan 20 09:00:03  39 pages dirty
Jan 20 09:00:03  773 pages writeback
Jan 20 09:00:03  235222 pages mapped
Jan 20 09:00:03  12014 pages slab
Jan 20 09:00:03  684 pages pagetables
Jan 20 09:05:02  ips-send: page allocation failure. order:0, mode:0x20
Jan 20 09:05:02   [__alloc_pages+936/976] __alloc_pages+0x3a8/0x3d0
Jan 20 09:05:02   [kmem_getpages+44/132] kmem_getpages+0x2c/0x84
Jan 20 09:05:02   [cache_grow+163/316] cache_grow+0xa3/0x13c
Jan 20 09:05:02   [cache_alloc_refill+415/488]
cache_alloc_refill+0x19f/0x1e8
Jan 20 09:05:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:05:02   [kmem_cache_alloc+63/76] kmem_cache_alloc+0x3f/0x4c
Jan 20 09:05:02   [br_nf_pre_routing+768/948]
br_nf_pre_routing+0x300/0x3b4
Jan 20 09:05:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:05:02   [nf_iterate+69/112] nf_iterate+0x45/0x70
Jan 20 09:05:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:05:02   [nf_hook_slow+100/260] nf_hook_slow+0x64/0x104
Jan 20 09:05:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:05:02   [br_handle_frame+385/476] br_handle_frame+0x181/0x1dc
Jan 20 09:05:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:05:02   [netif_receive_skb+322/576]
netif_receive_skb+0x142/0x240
Jan 20 09:05:02   [pg0+944966390/1069114368]
e1000_clean_rx_irq+0x626/0x6ec [e1000]
Jan 20 09:05:02   [do_no_page+85/852] do_no_page+0x55/0x354
Jan 20 09:05:02   [pg0+944963983/1069114368] e1000_clean+0x9f/0x150
[e1000]
Jan 20 09:05:02   [net_rx_action+128/296] net_rx_action+0x80/0x128
Jan 20 09:05:02   [gcc2_compiled.+141/256] __do_softirq+0x8d/0x100
Jan 20 09:05:02   [do_softirq+47/52] do_softirq+0x2f/0x34
Jan 20 09:05:02   [irq_exit+52/64] irq_exit+0x34/0x40
Jan 20 09:05:02   [gcc2_compiled.+32/40] do_IRQ+0x20/0x28
Jan 20 09:05:02   [common_interrupt+26/32] common_interrupt+0x1a/0x20
Jan 20 09:05:02  Mem-info:
Jan 20 09:05:02  DMA per-cpu:
Jan 20 09:05:02  cpu 0 hot: low 2, high 6, batch 1 used:2
Jan 20 09:05:02  cpu 0 cold: low 0, high 2, batch 1 used:1
Jan 20 09:05:02  Normal per-cpu:
Jan 20 09:05:02  cpu 0 hot: low 62, high 186, batch 31 used:92
Jan 20 09:05:02  cpu 0 cold: low 0, high 62, batch 31 used:45
Jan 20 09:05:02  HighMem per-cpu:
Jan 20 09:05:02  cpu 0 hot: low 30, high 90, batch 15 used:39
Jan 20 09:05:02  cpu 0 cold: low 0, high 30, batch 15 used:23
Jan 20 09:05:02  Free pages:        5040kB (180kB HighMem)
Jan 20 09:05:02  Active:128181 inactive:112056 dirty:0 writeback:1077
unstable:0 free:1260 slab:13455 mapped:233993 pagetables:687
Jan 20 09:05:02  DMA free:3548kB min:68kB low:84kB high:100kB
active:2848kB inactive:3384kB present:16384kB pages_scanned:35
all_unreclaimable? no
Jan 20 09:05:02  lowmem_reserve[]: 0 880 1007
Jan 20 09:05:02  Normal free:1312kB min:3756kB low:4692kB high:5632kB
active:432024kB inactive:394232kB present:901120kB pages_scanned:2009
all_unreclaimable? no
Jan 20 09:05:02  lowmem_reserve[]: 0 0 1022
Jan 20 09:05:02  HighMem free:180kB min:128kB low:160kB high:192kB
active:77852kB inactive:50608kB present:130816kB pages_scanned:0
all_unreclaimable? no
Jan 20 09:05:02  lowmem_reserve[]: 0 0 0
Jan 20 09:05:02  DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
Jan 20 09:05:02  Normal: 0*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1312kB
Jan 20 09:05:02  HighMem: 13*4kB 2*8kB 1*16kB 1*32kB 1*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 180kB
Jan 20 09:05:02  Swap cache: add 324768, delete 323174, find
238815/238918, race 0+0
Jan 20 09:05:02  Free swap  = 802288kB
Jan 20 09:05:02  Total swap = 2097136kB
Jan 20 09:05:02  Free swap:       802288kB
Jan 20 09:05:02  262080 pages of RAM
Jan 20 09:05:02  32704 pages of HIGHMEM
Jan 20 09:05:02  4255 reserved pages
Jan 20 09:05:02  9282 pages shared
Jan 20 09:05:02  1594 pages swap cached
Jan 20 09:05:02  0 pages dirty
Jan 20 09:05:02  1077 pages writeback
Jan 20 09:05:02  233993 pages mapped
Jan 20 09:05:02  13455 pages slab
Jan 20 09:05:02  687 pages pagetables
Jan 20 09:15:02  sw-config: page allocation failure. order:0, mode:0x20
Jan 20 09:15:02   [__alloc_pages+936/976] __alloc_pages+0x3a8/0x3d0
Jan 20 09:15:02   [kmem_getpages+44/132] kmem_getpages+0x2c/0x84
Jan 20 09:15:02   [cache_grow+163/316] cache_grow+0xa3/0x13c
Jan 20 09:15:02   [cache_alloc_refill+415/488]
cache_alloc_refill+0x19f/0x1e8
Jan 20 09:15:02   [__kmalloc+115/136] __kmalloc+0x73/0x88
Jan 20 09:15:02   [nf_queue+122/752] nf_queue+0x7a/0x2f0
Jan 20 09:15:02   [nf_hook_slow+218/260] nf_hook_slow+0xda/0x104
Jan 20 09:15:02   [br_nf_forward_finish+0/224]
br_nf_forward_finish+0x0/0xe0
Jan 20 09:15:02   [br_forward_finish+0/76] br_forward_finish+0x0/0x4c
Jan 20 09:15:02   [br_nf_forward_ip+264/296]
br_nf_forward_ip+0x108/0x128
Jan 20 09:15:02   [br_nf_forward_finish+0/224]
br_nf_forward_finish+0x0/0xe0
Jan 20 09:15:02   [nf_iterate+69/112] nf_iterate+0x45/0x70
Jan 20 09:15:02   [br_forward_finish+0/76] br_forward_finish+0x0/0x4c
Jan 20 09:15:02   [nf_hook_slow+100/260] nf_hook_slow+0x64/0x104
Jan 20 09:15:02   [br_forward_finish+0/76] br_forward_finish+0x0/0x4c
Jan 20 09:15:02   [__br_forward+66/88] __br_forward+0x42/0x58
Jan 20 09:15:02   [br_forward_finish+0/76] br_forward_finish+0x0/0x4c
Jan 20 09:15:02   [br_forward+29/76] br_forward+0x1d/0x4c
Jan 20 09:15:02   [br_handle_frame_finish+195/220]
br_handle_frame_finish+0xc3/0xdc
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [br_nf_pre_routing_finish+684/704]
br_nf_pre_routing_finish+0x2ac/0x2c0
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [br_nf_pre_routing_finish+0/704]
br_nf_pre_routing_finish+0x0/0x2c0
Jan 20 09:15:02   [br_nf_pre_routing_finish+0/704]
br_nf_pre_routing_finish+0x0/0x2c0
Jan 20 09:15:02   [nf_iterate+69/112] nf_iterate+0x45/0x70
Jan 20 09:15:02   [br_nf_pre_routing_finish+0/704]
br_nf_pre_routing_finish+0x0/0x2c0
Jan 20 09:15:02   [nf_hook_slow+100/260] nf_hook_slow+0x64/0x104
Jan 20 09:15:02   [nf_hook_slow+251/260] nf_hook_slow+0xfb/0x104
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [br_nf_pre_routing+907/948]
br_nf_pre_routing+0x38b/0x3b4
Jan 20 09:15:02   [br_nf_pre_routing+925/948]
br_nf_pre_routing+0x39d/0x3b4
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [nf_iterate+69/112] nf_iterate+0x45/0x70
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [nf_hook_slow+100/260] nf_hook_slow+0x64/0x104
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [br_handle_frame+385/476] br_handle_frame+0x181/0x1dc
Jan 20 09:15:02   [br_handle_frame_finish+0/220]
br_handle_frame_finish+0x0/0xdc
Jan 20 09:15:02   [netif_receive_skb+322/576]
netif_receive_skb+0x142/0x240
Jan 20 09:15:02   [pg0+944966390/1069114368]
e1000_clean_rx_irq+0x626/0x6ec [e1000]
Jan 20 09:15:02   [do_no_page+85/852] do_no_page+0x55/0x354
Jan 20 09:15:02   [pg0+944963983/1069114368] e1000_clean+0x9f/0x150
[e1000]
Jan 20 09:15:02   [net_rx_action+128/296] net_rx_action+0x80/0x128
Jan 20 09:15:02   [gcc2_compiled.+141/256] __do_softirq+0x8d/0x100
Jan 20 09:15:02   [do_softirq+47/52] do_softirq+0x2f/0x34
Jan 20 09:15:02   [irq_exit+52/64] irq_exit+0x34/0x40
Jan 20 09:15:02   [gcc2_compiled.+32/40] do_IRQ+0x20/0x28
Jan 20 09:15:02   [common_interrupt+26/32] common_interrupt+0x1a/0x20
Jan 20 09:15:02  Mem-info:
Jan 20 09:15:02  DMA per-cpu:
Jan 20 09:15:02  cpu 0 hot: low 2, high 6, batch 1 used:2
Jan 20 09:15:02  cpu 0 cold: low 0, high 2, batch 1 used:1
Jan 20 09:15:02  Normal per-cpu:
Jan 20 09:15:02  cpu 0 hot: low 62, high 186, batch 31 used:92
Jan 20 09:15:02  cpu 0 cold: low 0, high 62, batch 31 used:50
Jan 20 09:15:02  HighMem per-cpu:
Jan 20 09:15:02  cpu 0 hot: low 30, high 90, batch 15 used:42
Jan 20 09:15:02  cpu 0 cold: low 0, high 30, batch 15 used:21
Jan 20 09:15:02  Free pages:        5084kB (240kB HighMem)
Jan 20 09:15:02  Active:127760 inactive:111885 dirty:35 writeback:425
unstable:0 free:1271 slab:14006 mapped:233280 pagetables:712
Jan 20 09:15:02  DMA free:3548kB min:68kB low:84kB high:100kB
active:1384kB inactive:3720kB present:16384kB pages_scanned:33
all_unreclaimable? no
Jan 20 09:15:02  lowmem_reserve[]: 0 880 1007
Jan 20 09:15:02  Normal free:1296kB min:3756kB low:4692kB high:5632kB
active:432568kB inactive:392496kB present:901120kB pages_scanned:0
all_unreclaimable? no
Jan 20 09:15:02  lowmem_reserve[]: 0 0 1022
Jan 20 09:15:02  HighMem free:240kB min:128kB low:160kB high:192kB
active:77088kB inactive:51324kB present:130816kB pages_scanned:0
all_unreclaimable? no
Jan 20 09:15:02  lowmem_reserve[]: 0 0 0
Jan 20 09:15:02  DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
Jan 20 09:15:02  Normal: 0*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1296kB
Jan 20 09:15:02  HighMem: 12*4kB 8*8kB 2*16kB 1*32kB 1*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 240kB
Jan 20 09:15:02  Swap cache: add 330626, delete 328837, find
242588/242691, race 0+0
Jan 20 09:15:02  Free swap  = 778864kB
Jan 20 09:15:02  Total swap = 2097136kB
Jan 20 09:15:02  Free swap:       778864kB
Jan 20 09:15:02  262080 pages of RAM
Jan 20 09:15:02  32704 pages of HIGHMEM
Jan 20 09:15:02  4255 reserved pages
Jan 20 09:15:02  10595 pages shared
Jan 20 09:15:02  1789 pages swap cached
Jan 20 09:15:02  35 pages dirty
Jan 20 09:15:02  425 pages writeback
Jan 20 09:15:02  233280 pages mapped
Jan 20 09:15:02  14006 pages slab
Jan 20 09:15:02  712 pages pagetables
