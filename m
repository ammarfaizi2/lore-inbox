Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWIYIjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWIYIjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWIYIjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:39:46 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:28389 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750702AbWIYIjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:39:45 -0400
Message-ID: <45179580.200@infi.nl>
Date: Mon, 25 Sep 2006 10:38:24 +0200
From: Roy de Boer <roy@infi.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 07:27:18 +0000 (GMT) Holger Kiehl 
<Holger.Kiehl@dwd.de> wrote:
 > I get some of the "page allocation failure" errors. My hardware is 4 CPU
 > Opteron with one quad + one dual intel e1000 cards. Kernel is plain 
2.6.18
 > and for two cards MTU is set to 9000.

I'm getting more or less the same error messages (although I'm no 
expert) on a AMD Geode NX 1700+ and a intel e1000 nic. I'm using a stock 
2.6.18 kernel.

I hope this will help diagnose the problem.

Sep 25 07:54:46 gatar kernel: [23623.594000] java: page allocation 
failure. order:1, mode:0x20
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0147963>] 
__alloc_pages+0x213/0x330
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c015da07>] 
cache_alloc_refill+0x307/0x530
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c015dcad>] 
__kmalloc+0x7d/0x80
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04b7523>] 
__alloc_skb+0x63/0x120
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04e4618>] 
tcp_collapse+0x138/0x360
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04e4945>] 
tcp_prune_queue+0x105/0x2c0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<e0e29396>] 
tcp_packet+0x356/0xcc0 [ip_conntrack]
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04e78a1>] 
tcp_data_queue+0x5f1/0xc50
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04e8f3a>] 
tcp_rcv_established+0x26a/0x940
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<e0e11937>] 
ipt_do_table+0x267/0x300 [ip_tables]
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04f0bba>] 
tcp_v4_do_rcv+0xca/0x2d0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04f1bbb>] 
tcp_v4_rcv+0x72b/0x890
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04d46e0>] 
ip_local_deliver_finish+0x0/0x170
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04d46e0>] 
ip_local_deliver_finish+0x0/0x170
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04d497f>] 
ip_local_deliver+0x12f/0x200
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04d46e0>] 
ip_local_deliver_finish+0x0/0x170
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04d4d23>] 
ip_rcv+0x2d3/0x500
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04d4420>] 
ip_rcv_finish+0x0/0x2c0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04bfaa9>] 
netif_receive_skb+0x1f9/0x270
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04bfb8e>] 
process_backlog+0x6e/0xf0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c04bd57c>] 
net_rx_action+0x6c/0x150
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0123e43>] 
__do_softirq+0x43/0x90
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0123eb6>] 
do_softirq+0x26/0x30
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0105776>] do_IRQ+0x36/0x70
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c043739f>] 
ata_scsi_rw_xlat+0x2ff/0x510
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c01038fe>] 
common_interrupt+0x1a/0x20
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0141e7c>] 
remove_suid+0xc/0x70
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c017b236>] 
file_update_time+0x46/0xc0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0144df1>] 
__generic_file_aio_write_nolock+0x201/0x470
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c011b796>] 
__cond_resched+0x16/0x30
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c014532e>] 
generic_file_aio_write+0x6e/0x110
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0105776>] do_IRQ+0x36/0x70
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c01d8994>] 
ext3_file_write+0x44/0xd0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0160a48>] 
do_sync_write+0xd8/0x140
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0132520>] 
autoremove_wake_function+0x0/0x60
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0160fed>] 
vfs_write+0xdd/0x1c0
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0161b0b>] 
sys_write+0x4b/0x80
Sep 25 07:54:46 gatar kernel: [23623.594000]  [<c0102f0d>] 
sysenter_past_esp+0x56/0x79
Sep 25 07:54:46 gatar kernel: [23623.594000] Mem-info:
Sep 25 07:54:46 gatar kernel: [23623.594000] DMA per-cpu:
Sep 25 07:54:46 gatar kernel: [23623.594000] cpu 0 hot: high 0, batch 1 
used:0
Sep 25 07:54:46 gatar kernel: [23623.594000] cpu 0 cold: high 0, batch 1 
used:0
Sep 25 07:54:46 gatar kernel: [23623.594000] DMA32 per-cpu: empty
Sep 25 07:54:46 gatar kernel: [23623.594000] Normal per-cpu:
Sep 25 07:54:46 gatar kernel: [23623.594000] cpu 0 hot: high 186, batch 
31 used:176
Sep 25 07:54:46 gatar kernel: [23623.594000] cpu 0 cold: high 62, batch 
15 used:6
Sep 25 07:54:46 gatar kernel: [23623.594000] HighMem per-cpu: empty
Sep 25 07:54:46 gatar kernel: [23623.594000] Free pages:        5612kB 
(0kB HighMem)
Sep 25 07:54:46 gatar kernel: [23623.594000] Active:92165 inactive:19681 
dirty:1771 writeback:1 unstable:0 free:1403 slab:6352 mapped:14889 
pagetables:424
Sep 25 07:54:46 gatar kernel: [23623.594000] DMA free:2016kB min:88kB 
low:108kB high:132kB active:7404kB inactive:288kB present:16384kB 
pages_scanned:0 all_unreclaimable? no
Sep 25 07:54:46 gatar kernel: [23623.594000] lowmem_reserve[]: 0 0 495 495
Sep 25 07:54:46 gatar kernel: [23623.594000] DMA32 free:0kB min:0kB 
low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Sep 25 07:54:46 gatar kernel: [23623.594000] lowmem_reserve[]: 0 0 495 495
Sep 25 07:54:46 gatar kernel: [23623.594000] Normal free:3596kB 
min:2804kB low:3504kB high:4204kB active:361256kB inactive:78436kB 
present:507840kB pages_scanned:0 all_unreclaimable? no
Sep 25 07:54:46 gatar kernel: [23623.594000] lowmem_reserve[]: 0 0 0 0
Sep 25 07:54:46 gatar kernel: [23623.594000] HighMem free:0kB min:128kB 
low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Sep 25 07:54:46 gatar kernel: [23623.594000] lowmem_reserve[]: 0 0 0 0
Sep 25 07:54:46 gatar kernel: [23623.594000] DMA: 10*4kB 1*8kB 1*16kB 
1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2016kB
Sep 25 07:54:46 gatar kernel: [23623.594000] DMA32: empty
Sep 25 07:54:46 gatar kernel: [23623.594000] Normal: 767*4kB 0*8kB 
1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB 
= 3596kB
Sep 25 07:54:46 gatar kernel: [23623.594000] HighMem: empty
Sep 25 07:54:46 gatar kernel: [23623.594000] Swap cache: add 378, delete 
378, find 16/24, race 0+0
Sep 25 07:54:46 gatar kernel: [23623.594000] Free swap  = 656028kB
Sep 25 07:54:46 gatar kernel: [23623.594000] Total swap = 656496kB
Sep 25 07:54:46 gatar kernel: [23623.594000] Free swap:       656028kB
Sep 25 07:54:46 gatar kernel: [23623.594000] 131056 pages of RAM
Sep 25 07:54:46 gatar kernel: [23623.594000] 0 pages of HIGHMEM
Sep 25 07:54:46 gatar kernel: [23623.594000] 2741 reserved pages
Sep 25 07:54:46 gatar kernel: [23623.594000] 79395 pages shared
Sep 25 07:54:46 gatar kernel: [23623.594000] 0 pages swap cached
Sep 25 07:54:46 gatar kernel: [23623.594000] 1771 pages dirty
Sep 25 07:54:46 gatar kernel: [23623.594000] 1 pages writeback
Sep 25 07:54:46 gatar kernel: [23623.594000] 14889 pages mapped
Sep 25 07:54:46 gatar kernel: [23623.594000] 6352 pages slab
Sep 25 07:54:46 gatar kernel: [23623.594000] 424 pages pagetables

Regards,

Roy de Boer
