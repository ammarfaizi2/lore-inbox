Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWHJRe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWHJRe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWHJRe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:34:26 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:5698 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422644AbWHJReX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:34:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=WReEBj4OBfZ6F0TvcWVWHoT1aYEKi6ybkFUikt5QtfzsxVV+gADXRIPuYR/mai/iV1+srH2MJ96xFuo7dw01VBXY76OZA7ViNZsNHXBYzlYSH1wLlkYlbfjK5GQK3ViBm0oryokNeWaPkiljVX3UWip/ZWPLL6l+ZT2y0T8hktQ=
Message-ID: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com>
Date: Thu, 10 Aug 2006 19:34:22 +0200
From: "Peter M" <peter.mdk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.17.7 running multiple eth bridges
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_117552_31979741.1155231262494"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_117552_31979741.1155231262494
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have built a multi bridge i386 machine with 8 eth devices which
keeps crashing on me.

Kernel 2.6.7.17

I'm using a network card with 4 ports (tulip) and 4 r8169 based cards.

br0: eth0 eth1
br1: eth2 eth3
br2: eth3 eth4
br3: eth5 eth6

Below crash came when I unplugged a cable on a running bridge. Today I
have had two crashes without touching the cables but didn't get any
usable syslog.

I have attached a number of info files which might help.

Regards
Peter M.


Aug  8 09:52:16 analyzeTHIS kernel: r8169: eth5: link down
Aug  8 09:52:16 analyzeTHIS kernel: br2: port 2(eth5) entering disabled state
Aug  8 09:52:28 analyzeTHIS kernel: r8169: eth5: link up
Aug  8 09:52:28 analyzeTHIS kernel: br2: port 2(eth5) entering learning state
Aug  8 09:52:30 analyzeTHIS kernel: r8169: eth5: link down
Aug  8 09:52:30 analyzeTHIS kernel: br2: port 2(eth5) entering disabled state
Aug  8 09:52:33 analyzeTHIS kernel: r8169: eth5: link up
Aug  8 09:52:33 analyzeTHIS kernel: br2: port 2(eth5) entering learning state
Aug  8 09:52:48 analyzeTHIS kernel: br2: topology change detected, propagating
Aug  8 09:52:48 analyzeTHIS kernel: br2: port 2(eth5) entering forwarding state
Aug  8 09:54:04 analyzeTHIS kernel: do_IRQ+0x19/0x24  <c0103976>
common_interrupt+0x1a/0x20
Aug  8 09:54:11 analyzeTHIS kernel:  <c014358a> __kmalloc+0x5a/0x61
<c020992c> __alloc_skb+0x4c/0xf2
Aug  8 09:54:54 analyzeTHIS kernel:  <c88dc759>
rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
rtl8169_rx_fill+0x45/0x5a [r8169]
Aug  8 09:55:26 analyzeTHIS kernel:  <c88dd38b>
rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
pci_unmap_single+0x0/0x10 [r8169]
Aug  8 09:56:07 analyzeTHIS kernel:  <c88dd486>
rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
handle_IRQ_event+0x20/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c010b146> get_offset_pmtmr+0x44/0xefe
Aug  8 09:56:22 analyzeTHIS kernel:  <c0105a89>
do_gettimeofday+0x16/0x9d  <c020defa> __net_timestamp+0xf/0x22
Aug  8 09:56:22 analyzeTHIS kernel:  <c020df28>
dev_queue_xmit_nit+0x1b/0xec  <c02195bb> qdisc_restart+0x7b/0xee
Aug  8 09:56:22 analyzeTHIS kernel:  <c020e3f2>
dev_queue_xmit+0xbe/0x186  <c8a73cb2> br_dev_queue_push_xmit+0xc2/0xc9
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a7890f>
br_nf_post_routing+0x14b/0x158 [bridge]  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
<c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
 <c8a73bf0> br_dekB 0*4096kB = 476kB
Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
Aug  8 09:56:22 analyzeTHIS kernel: 17487 pages shared
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages dirty
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
Aug  8 09:56:22 analyzeTHIS kernel: 11826 pages slab
Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
Aug  8 09:56:22 analyzeTHIS kernel: kswapd0: page allocation failure.
order:0, mode:0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
__alloc_pages+0x254/0x266  <c010f04a>
smp_local_timer_interrupt+0xb/0x11
Aug  8 09:56:22 analyzeTHIS kernel:  <c0142688>
kmem_getpages+0x39/0x91  <c0143127> cache_grow+0x93/0x122
Aug  8 09:56:22 analyzeTHIS kernel:  <c01432db>
cache_alloc_refill+0x125/0x15e  <c0143586> __kmalloc+0x56/0x61
Aug  8 09:56:22 analyzeTHIS kernel:  <c020992c> __alloc_skb+0x4c/0xf2
<c88dc759> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc878>
rtl8169_rx_fill+0x45/0x5a [r8169]  <c88dd38b>
rtl8169_rx_interrupt+0x2af/0x304 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd81c>
pci_unmap_single+0x0/0x10 [r8169]  <c88dd486>
rtl8169_interrupt+0xa6/0x103 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d943>
handle_IRQ_event+0x20/0x4c  <c012d9c2> __do_IRQ+0x53/0x91
Aug  8 09:56:22 analyzeTHIS kernel:  <c0104e59> do_IRQ+0x19/0x24
<c0103976> common_interrupt+0x1a/0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c014358a> __kmalloc+0x5a/0x61
<c020992c> __alloc_skb+0x4c/0xf2
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc759>
rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
rtl8169_rx_fill+0x45/0x5a [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd38b>
rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
pci_unmap_single+0x0/0x10 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd486>
rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
handle_IRQ_event+0x20/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c010b146> get_offset_pmtmr+0x44/0xefe
Aug  8 09:56:22 analyzeTHIS kernel:  <c0105a89>
do_gettimeofday+0x16/0x9d  <c020defa> __net_timestamp+0xf/0x22
Aug  8 09:56:22 analyzeTHIS kernel:  <c020df28>
dev_queue_xmit_nit+0x1b/0xec  <c02195bb> qdisc_restart+0x7b/0xee
Aug  8 09:56:22 analyzeTHIS kernel:  <c020e3f2>
dev_queue_xmit+0xbe/0x186  <c8a73cb2> br_dev_queue_push_xmit+0xc2/0xc9
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a7890f>
br_nf_post_routing+0x14b/0x158 [bridge]  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
<c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
 <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c8a73ce7>
br_forward_finish+0x2e/0x41 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c8a782bd>
br_nf_forward_finish+0xc6/0xcb [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a783e2>
br_nf_forward_ip+0x120/0x12b [bridge]  <c021f894> nf_iterate+0x3f/0x6d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c021f909> nf_hook_slow+0x47/0x9d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c8a73d8d> __br_forward+0x46/0x57
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c8a73e84> br_flood+0x8e/0xa6
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
[bridge]  <c8a73ecc> br_flood_forward+0x16/0x1a [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
[bridge]  <c8a747db> br_handle_frame_finish+0x89/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77bae>
br_nf_pre_routing_finish+0x29b/0x2a9 [bridge]  <c8a8165f>
ip_conntrack_in+0x192/0x21c [ip_conntrer-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:30
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:11
Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         976kB (0kB HighMem)
Aug  8 09:56:22 analyzeTHIS kernel: Active:12345 inactive:6399 dirty:1
writeback:0 unstable:0 free:244 slab:11918 mapped:1477 pagetables:54
Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
high:268kB active:3500kB inactive:2724kB present:16384kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: Normal free:460kB min:1260kB
low:1572kB high:1888kB active:45880kB inactive:22872kB
present:114624kB pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
low:128kB high:128kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal: 3*4kB 0*8kB 0*16kB 0*32kB
1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 460kB
Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
Aug  8 09:56:22 analyzeTHIS kernel: 17391 pages shared
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
Aug  8 09:56:22 analyzeTHIS kernel: 11918 pages slab
Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
Aug  8 09:56:22 analyzeTHIS kernel: printk: 1908 messages suppressed.
Aug  8 09:56:22 analyzeTHIS kernel: events/0: page allocation failure.
order:0, mode:0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
__alloc_pages+0x254/0x266  <c0142688> kmem_getpages+0x39/0x91
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
<c01432db> cache_alloc_refill+0x125/0x15e
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143586> __kmalloc+0x56/0x61
<c020992c> __alloc_skb+0x4c/0xf2
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc759>
rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
rtl8169_rx_fill+0x45/0x5a [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd38b>
rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
pci_unmap_single+0x0/0x10 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd486>
rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
handle_IRQ_event+0x20/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c012d93d> handle_IRQ_event+0x1a/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c8a788b4> br_nf_post_routing+0xf0/0x158
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c021f894>
nf_iterate+0x3f/0x6d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c021f909>
nf_hook_slow+0x47/0x9d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73ce7>
br_forward_finish+0x2e/0x41 [bridge]  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a782bd>
br_nf_forward_finish+0xc6/0xcb [bridge]  <c8a783e2>
br_nf_forward_ip+0x120/0x12b [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
<c8a73cb9> br_forward_finish+0x0/0x41 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
 <c8a73cb9> br_forward_finish+0x0/0x41 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d8d> __br_forward+0x46/0x57
[bridge]  <c8a73cb9> br_forward_finish+0x0/0x41 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73e84> br_flood+0x8e/0xa6
[bridge]  <c8a73d47> __br_forward+0x0/0x57 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73ecc>
br_flood_forward+0x16/0x1a [bridge]  <c8a73d47> __br_forward+0x0/0x57
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a747db>
br_handle_frame_finish+0x89/0xe0 [bridge]  <c8a77bae>
br_nf_pre_routing_finish+0x29b/0x2a9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a8165f>
ip_conntrack_in+0x192/0x21c [ip_conntrack]  <c8a77913>
br_nf_pre_routing_finish+0x0/0x2a9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
<c8a77913> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
 <c8a77913> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]  <c8a78186>
br_nf_pre_routing+0x2e7/0x305 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]  <c8a78194>
br_nf_pre_routing+0x2f5/0x305 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
<c8a74752> br_handle_frame_finish+0x0/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
 <c8a74752> br_handle_frame_finish+0x0/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a749a4>
br_handle_frame+0x146/0x172 [bridge]  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c020e815>
netif_receive_skb+0x1b3/0x25d  <c020e92d> process_backlog+0x6e/0xd7
Aug  8 09:56:22 analyzeTHIS kernel:  <c020ea0b>
net_rx_action+0x75/0x105  <c011a42c> __do_softirq+0x34/0x7d
Aug  8 09:56:22 analyzeTHIS kernel:  <c011a497> do_softirq+0x22/0x26
<c0104e5e> do_IRQ+0x1e/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c01438f6> drain_array+0x12/0x7f
Aug  8 09:56:22 analyzeTHIS kernel:  <c01439a6> cache_reap+0x43/0x11b
<c01228c9> run_workqueue+0x6e/0xa2
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143963> cache_reap+0x0/0x11b
<c01229f5> worker_thread+0xf8/0x12a
Aug  8 09:56:22 analyzeTHIS kernel:  <c01136aa>
default_wake_function+0x0/0x12  <c025da4e> schedule+0x460/0x4c5
Aug  8 09:56:22 analyzeTHIS kernel:  <c01136aa>
default_wake_function+0x0/0x12  <c01228fd> worker_thread+0x0/0x12a
Aug  8 09:56:22 analyzeTHIS kernel:  <c0124f42> kthread+0x79/0xa3
<c0124ec9> kthread+0x0/0xa3
Aug  8 09:56:22 analyzeTHIS kernel:  <c01012d5> kernel_thread_helper+0x5/0xb
Aug  8 09:56:22 analyzeTHIS kernel: Mem-info:
Aug  8 09:56:22 analyzeTHIS kernel: DMA per-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 0, batch 1 used:0
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 0, batch 1 used:0
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal per-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:32
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:11
Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         976kB (0kB HighMem)
Aug  8 09:56:22 analyzeTHIS kernel: Active:12345 inactive:6399 dirty:1
writeback:0 unstable:0 free:244 slab:11916 mapped:1477 pagetables:54
Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
high:268kB active:3500kB inactive:2724kB present:16384kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: Normal free:460kB min:1260kB
low:1572kB high:1888kB active:45880kB inactive:22872kB
present:114624kB pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
low:128kB high:128kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal: 3*4kB 0*8kB 0*16kB 0*32kB
1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 460kB
Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
Aug  8 09:56:22 analyzeTHIS kernel: 17391 pages shared
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
Aug  8 09:56:22 analyzeTHIS kernel: 11916 pages slab
Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
Aug  8 09:56:22 analyzeTHIS kernel: printk: 1684 messages suppressed.
Aug  8 09:56:22 analyzeTHIS kernel: cron: page allocation failure.
order:0, mode:0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
__alloc_pages+0x254/0x266  <c01323bb> __alloc_pages+0xbd/0x266
Aug  8 09:56:22 analyzeTHIS kernel:  <c0142688>
kmem_getpages+0x39/0x91  <c0143127> cache_grow+0x93/0x122
Aug  8 09:56:22 analyzeTHIS kernel:  <c01432db>
cache_alloc_refill+0x125/0x15e  <c0143586> __kmalloc+0x56/0x61
Aug  8 09:56:22 analyzeTHIS kernel:  <c020992c> __alloc_skb+0x4c/0xf2
<c88dc759> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc878>
rtl8169_rx_fill+0x45/0x5a [r8169]  <c88dd38b>
rtl8169_rx_interrupt+0x2af/0x304 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd81c>
pci_unmap_single+0x0/0x10 [r8169]  <c88dd486>
rtl8169_interrupt+0xa6/0x103 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d943>
handle_IRQ_event+0x20/0x4c  <c012d9c2> __do_IRQ+0x53/0x91
Aug  8 09:56:22 analyzeTHIS kernel:  <c0104e59> do_IRQ+0x19/0x24
<c0103976> common_interrupt+0x1a/0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd409>
rtl8169_interrupt+0x29/0x103 [r8169]  <c012d943>
handle_IRQ_event+0x20/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c010b146> get_offset_pmtmr+0x44/0xefe
Aug  8 09:56:22 analyzeTHIS kernel:  <c0105a89>
do_gettimeofday+0x16/0x9d  <c020defa> __net_timestamp+0xf/0x22
Aug  8 09:56:22 analyzeTHIS kernel:  <c020df28>
dev_queue_xmit_nit+0x1b/0xec  <c02195bb> qdisc_restart+0x7b/0xee
Aug  8 09:56:22 analyzeTHIS kernel:  <c020e3f2>
dev_queue_xmit+0xbe/0x186  <c8a73cb2> br_dev_queue_push_xmit+0xc2/0xc9
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a7890f>
br_nf_post_routing+0x14b/0x158 [bridge]  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
<c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
 <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c8a73ce7>
br_forward_finish+0x2e/0x41 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c8a782bd>
br_nf_forward_finish+0xc6/0xcb [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a783e2>
br_nf_forward_ip+0x120/0x12b [bridge]  <c021f894> nf_iterate+0x3f/0x6d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c021f909> nf_hook_slow+0x47/0x9d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c8a73d8d> __br_forward+0x46/0x57
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
br_forward_finish+0x0/0x41 [bridge]  <c8a73e84> br_flood+0x8e/0xa6
[bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
[bridge]  <c8a73ecc> br_flood_forward+0x16/0x1a [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
[bridge]  <c8a747db> br_handle_frame_finish+0x89/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77bae>
br_nf_pre_routing_finish+0x29b/0x2a9 [bridge]  <c8a8165f>
ip_conntrack_in+0x192/0x21c [ip_conntrack]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77913>
br_nf_pre_routing_finish+0x0/0x2a9 [bridge]  <c021f894>
nf_iterate+0x3f/0x6d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77913>
br_nf_pre_routing_finish+0x0/0x2a9 [bridge]  <c021f909>
nf_hook_slow+0x47/0x9d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77913>
br_nf_pre_routing_finish+0x0/0x2a9 [bridge]  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a78186>
br_nf_pre_routing+0x2e7/0x305 [bridge]  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a78194>
br_nf_pre_routing+0x2f5/0x305 [bridge]  <c021f894>
nf_iterate+0x3f/0x6d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]  <c021f909>
nf_hook_slow+0x47/0x9d
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]  <c8a749a4>
br_handle_frame+0x146/0x172 [bridge]
Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
br_handle_frame_finish+0x0/0xe0 [bridge]  <c020e815>
netif_receive_skb+0x1b3/0x25d
Aug  8 09:56:22 analyzeTHIS kernel:  <c020e92d>
process_backlog+0x6e/0xd7  <c020ea0b> net_rx_action+0x75/0x105
Aug  8 09:56:22 analyzeTHIS kernel:  <c011a42c> __do_softirq+0x34/0x7d
 <c011a497> do_softirq+0x22/0x26
Aug  8 09:56:22 analyzeTHIS kernel:  <c0104e5e> do_IRQ+0x1e/0x24
<c0103976> common_interrupt+0x1a/0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c015872c> prune_dcache+0x2e/0xf1
 <c0158a85> shrink_dcache_memory+0x18/0x30
Aug  8 09:56:22 analyzeTHIS kernel:  <c01350b8>
shrink_slab+0x12a/0x190  <c0135eed> try_to_free_pages+0xee/0x19a
Aug  8 09:56:22 analyzeTHIS kernel:  <c0132464>
__alloc_pages+0x166/0x266  <c0142688> kmem_getpages+0x39/0x91
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
<c01432db> cache_alloc_refill+0x125/0x15e
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143475>
kmem_cache_alloc+0x2a/0x34  <c014ff89> getname+0x13/0x4a
Aug  8 09:56:22 analyzeTHIS kernel:  <c0151624>
__user_walk_fd+0xe/0x42  <c014ceb7> vfs_stat_fd+0x1a/0x45
Aug  8 09:56:22 analyzeTHIS kernel:  <c01275b5>
hrtimer_try_to_cancel+0xb/0x32  <c01275e7> hrtimer_cancel+0xb/0x16
Aug  8 09:56:22 analyzeTHIS kernel:  <c025e972> do_nanosleep+0x43/0x66
 <c01277b0> hrtimer_nanosleep+0x4c/0x103
Aug  8 09:56:22 analyzeTHIS kernel:  <c014cef1> vfs_stat+0xf/0x13
<c014d4af> sys_stat64+0x10/0x27
Aug  8 09:56:22 analyzeTHIS kernel:  <c025da4e> schedule+0x460/0x4c5
<c0105a89> do_gettimeofday+0x16/0x9d
Aug  8 09:56:22 analyzeTHIS kernel:  <c0119bcb> sys_time+0x13/0x40
<c0102f33> syscall_call+0x7/0xb
Aug  8 09:56:22 analyzeTHIS kernel: Mem-info:
Aug  8 09:56:22 analyzeTHIS kernel: DMA per-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 0, batch 1 used:0
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 0, batch 1 used:0
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal per-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:31
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:11
Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         976kB (0kB HighMem)
Aug  8 09:56:22 analyzeTHIS kernel: Active:12277 inactive:6435 dirty:1
writeback:0 unstable:0 free:244 slab:11917 mapped:1477 pagetables:54
Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
high:268kB active:3500kB inactive:2724kB present:16384kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: Normal free:460kB min:1260kB
low:1572kB high:1888kB active:45608kB inactive:23016kB
present:114624kB pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
low:128kB high:128kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal: 3*4kB 0*8kB 0*16kB 0*32kB
1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 460kB
Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
Aug  8 09:56:22 analyzeTHIS kernel: 17423 pages shared
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
Aug  8 09:56:22 analyzeTHIS kernel: 11917 pages slab
Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
Aug  8 09:56:22 analyzeTHIS kernel: printk: 1262 messages suppressed.
Aug  8 09:56:22 analyzeTHIS kernel: init: page allocation failure.
order:0, mode:0x20
Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
__alloc_pages+0x254/0x266  <c0142688> kmem_getpages+0x39/0x91
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
<c01432db> cache_alloc_refill+0x125/0x15e
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143586> __kmalloc+0x56/0x61
<c020992c> __alloc_skb+0x4c/0xf2
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc759>
rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
rtl8169_rx_fill+0x45/0x5a [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd38b>
rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
pci_unmap_single+0x0/0x10 [r8169]
Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd486>
rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
handle_IRQ_event+0x20/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c01a0693> ioread32+0x22/0x26
Aug  8 09:56:22 analyzeTHIS kernel:  <c8906a37>
tulip_interrupt+0x47/0x798 [tulip]  <c012d943>
handle_IRQ_event+0x20/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c012d93d> handle_IRQ_event+0x1a/0x4c
Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
<c0104e59> do_IRQ+0x19/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c0143616> kfree+0x56/0x5b
Aug  8 09:56:22 analyzeTHIS kernel:  <c0209ba2> kfree_skbmem+0xb/0x6d
<c022468b> ip_rcv+0x3a7/0x3b1
Aug  8 09:56:22 analyzeTHIS kernel:  <c020e8a1>
netif_receive_skb+0x23f/0x25d  <c020e92d> process_backlog+0x6e/0xd7
Aug  8 09:56:22 analyzeTHIS kernel:  <c020ea0b>
net_rx_action+0x75/0x105  <c011a42c> __do_softirq+0x34/0x7d
Aug  8 09:56:22 analyzeTHIS kernel:  <c011a497> do_softirq+0x22/0x26
<c0104e5e> do_IRQ+0x1e/0x24
Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
common_interrupt+0x1a/0x20  <c8951090> reiserfs_clear_inode+0x0/0x56
[reiserfs]
Aug  8 09:56:22 analyzeTHIS kernel:  <c0159b48> clear_inode+0xb6/0xe4
<c0159bc6> dispose_list+0x50/0xaa
Aug  8 09:56:22 analyzeTHIS kernel:  <c0159e87>
prune_icache+0x11d/0x152  <c0159ed4> shrink_icache_memory+0x18/0x30
Aug  8 09:56:22 analyzeTHIS kernel:  <c01350b8>
shrink_slab+0x12a/0x190  <c0135eed> try_to_free_pages+0xee/0x19a
Aug  8 09:56:22 analyzeTHIS kernel:  <c0132464>
__alloc_pages+0x166/0x266  <c0142688> kmem_getpages+0x39/0x91
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
<c01432db> cache_alloc_refill+0x125/0x15e
Aug  8 09:56:22 analyzeTHIS kernel:  <c0143475>
kmem_cache_alloc+0x2a/0x34  <c014ff89> getname+0x13/0x4a
Aug  8 09:56:22 analyzeTHIS kernel:  <c0151624>
__user_walk_fd+0xe/0x42  <c014ceb7> vfs_stat_fd+0x1a/0x45
Aug  8 09:56:22 analyzeTHIS kernel:  <c01435f7> kfree+0x37/0x5b
<c0209c00> kfree_skbmem+0x69/0x6d
Aug  8 09:56:22 analyzeTHIS kernel:  <c022468b> ip_rcv+0x3a7/0x3b1
<c020e8a1> netif_receive_skb+0x23f/0x25d
Aug  8 09:56:22 analyzeTHIS kernel:  <c014cef1> vfs_stat+0xf/0x13
<c014d4af> sys_stat64+0x10/0x27
Aug  8 09:56:22 analyzeTHIS kernel:  <c025da4e> schedule+0x460/0x4c5
<c0102f33> syscall_call+0x7/0xb
Aug  8 09:56:22 analyzeTHIS kernel: Mem-info:
Aug  8 09:56:22 analyzeTHIS kernel: DMA per-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 0, batch 1 used:0
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 0, batch 1 used:0
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal per-cpu:
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:34
Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:13
Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         968kB (0kB HighMem)
Aug  8 09:56:22 analyzeTHIS kernel: Active:12277 inactive:6435 dirty:1
writeback:0 unstable:0 free:242 slab:11928 mapped:1477 pagetables:54
Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
high:268kB active:3500kB inactive:2724kB present:16384kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
Aug  8 09:56:22 analyzeTHIS kernel: Normal free:452kB min:1260kB
low:1572kB high:1888kB active:45608kB inactive:23016kB
present:114624kB pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
low:128kB high:128kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
Aug  8 09:56:22 analyzeTHIS kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB
1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 452kB
Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
Aug  8 09:56:22 analyzeTHIS kernel: 17395 pages shared
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
Aug  8 09:56:22 analyzeTHIS kernel: 11928 pages slab
Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables

------=_Part_117552_31979741.1155231262494
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqpeqyb5
Content-Disposition: attachment; filename="config.gz"

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
BbYQlMgzmET/BwpMTqiW5QAA
------=_Part_117552_31979741.1155231262494
Content-Type: application/x-gzip; name=lshw.txt.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqpercrb
Content-Disposition: attachment; filename="lshw.txt.gz"

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
EOmfA9GgCiJ9p20a/zUh0qsh+h9FnjWzO0cAAA==
------=_Part_117552_31979741.1155231262494
Content-Type: application/x-gzip; name=lspci-vvv.txt.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqperm01
Content-Disposition: attachment; filename="lspci-vvv.txt.gz"

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
ECH9ZQhZWxH6H095XpuULgAA
------=_Part_117552_31979741.1155231262494
Content-Type: application/x-gzip; name=proc_modules.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqpery6o
Content-Disposition: attachment; filename="proc_modules.gz"

H4sICN9s20QCA3Byb2NfbW9kdWxlcwCFVVuO2zAM/N9T8AAqoPfjDr1BUQSOrGTVJI5he7NpT19K
she2i6h/QTwakcPhaJxAaEopUPgG3+MjAH16e1QC/3s7DrE9B5DWOL4FNCYDrlcPRhkODAqWrCE0
QcK7j4d33wK3TujdNSIkyMd49PchAGOGcYpcy5kV21GzBH2cmglxjsotk+MqfU5fpdXaIkmCrsux
+a7YH/y966ah8ZfDaerB/NObDWKPBOkkT6T745sLcr/dqQvTNXYX0Jbuj6zgRZ+32IbD6McITGlO
901lxvEMghu3067ROn8cDrd7i6cdXrZto80A3w73GwjsMilb4GR9R5tp2kLjrNrd41iTAVhjgQiZ
FFMwTmQpnoxnMjMXorUsUqbzg2XaATdMyn2Zx/R9+rjGHmfH7a4NR3Mbw+QBzWH3pxufv4Y4huE0
AiKM4sA3DLIY8TkJpEiy7eedb/h1bEFRZbMBEbue1ZEvs2rjeEG1DbYhNyTOL5Bz6MIQsVyV/f6j
D8Ot6UI3/VxTGptljfHWnJP1RbbhC3B2wlsTvObPJxjuKsT2lPUcbtxRkDIr9gqaa26u8cbUE8Vh
ktbQuYj3fhLyCYpLW2nutEC1Bpa995q22PTWaqRljOlKCSZ7pY8RkRShr5Fl5sOflBrAnayRZoOO
V+9owHKV0ZVqTY6hZcRSs8rUdE4cPypMU1DCVMrVxwWKUmGCVcrVxTget4H+xwpaFSvE0zU8QThd
GRktFptQ2x6UqxlBZ2jfek7Rjof7FVOBylohTG1OdOETrKiZQmRn3vspas7+42Lhcu6OOEimEMsr
WJ55/W/8oZ0AibOvgDNxc2uNxK3D4KvpJ4qLIo6Q4SpJVyuZ5/14xAbreCI3Hq+oV942DLhHGD7v
w2WE5O+K2m6JovlZ1clV+H595fWSZGSVV2TOIjLHDCkRQpZ4IGXzSdlqUhaWpF0kZc3IskJkYSzW
J8XWpFiWzHYkxWpkbSOydgiZp0/myZJlamSeCJnFJl86kpVGmzDIs/noMDa4TO8D2zwQluU38C+9
O4sxCwkAAA==
------=_Part_117552_31979741.1155231262494
Content-Type: application/x-gzip; name=proc.interrupts.txt.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqpesgqu
Content-Disposition: attachment; filename="proc.interrupts.txt.gz"

H4sICPJj20QCA3Byb2MuaW50ZXJydXB0cy50eHQAbZDPCsIwDMbvfYo+gEKT9d92HR4GTsdU8Dpq
wR4EmXt/jHW6jbWHjzT5Nf0Szv+nbC5iDBnnooiRAW3RTND1vG2qkvMhPHxPGBRjQeY2gQUrJBKG
xVQTa8x1L9fdPIEqgplGzFGtQT/cs81HNbF21jRbs/3gGIfvHFLbHCDxc+eeITYUUSGqjGro9Tie
lVqntkAURlYRK392FJiEnXDzgig1mUZIUsAOdbXYF9sfy2Vi17bzBKur0+L+BrAnKdbXAQAA
------=_Part_117552_31979741.1155231262494--
