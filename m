Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUEVCOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUEVCOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUEUWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:40:11 -0400
Received: from science.horizon.com ([192.35.100.1]:61742 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S266049AbUEUWdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:08 -0400
Date: 20 May 2004 04:05:05 -0000
Message-ID: <20040520040505.14642.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, kerndev@sc-software.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already reported (I thought) this message:

May 19 02:23:47: Unable to handle kernel paging request at virtual address efd78000
May 19 02:23:47:  printing eip:
May 19 02:23:47: c01a999b
May 19 02:23:47: *pde = 004a7067
May 19 02:23:47: *pte = 2fd78000
May 19 02:23:47: Oops: 0002 [#1]
May 19 02:23:47: DEBUG_PAGEALLOC
May 19 02:23:47: CPU:    0
May 19 02:23:47: EIP:    0060:[<c01a999b>]    Not tainted
May 19 02:23:47: EFLAGS: 00010246   (2.6.6) 
May 19 02:23:47: EIP is at encode_entry+0x4b/0x530
May 19 02:23:47: eax: 00000000   ebx: 00000000   ecx: 00000644   edx: f3532df8
May 19 02:23:47: esi: efd78000   edi: e4a19644   ebp: 00000654   esp: f14b7b98
May 19 02:23:47: ds: 007b   es: 007b   ss: 0068
May 19 02:23:47: Process nfsd (pid: 1029, threadinfo=f14b6000 task=f1532a80)
May 19 02:23:47: Stack: 00000008 0000002f f5217080 00000027 00000000 f5217084 f3532df8 00000006 
May 19 02:23:47:        e4a1964c 0000001c 02000001 04000900 0019a291 0022e7a8 14343bfc 0022e76b 
May 19 02:23:47:        14343b61 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
May 19 02:23:47: Call Trace:
May 19 02:23:47:  [<c016af1f>] ext3_bread+0x1f/0x90
May 19 02:23:47:  [<c0168505>] ext3_readdir+0x305/0x490
May 19 02:23:47:  [<c011dd18>] in_group_p+0x38/0x70
May 19 02:23:47:  [<c01a9ed0>] nfs3svc_encode_entry_plus+0x0/0x50
May 19 02:23:47:  [<c019d930>] fh_verify+0x280/0x550
May 19 02:23:47:  [<c019d5d0>] nfsd_acceptable+0x0/0xe0
May 19 02:23:47:  [<c013da8c>] open_private_file+0x1c/0x90
May 19 02:23:47:  [<c014ba2d>] vfs_readdir+0x7d/0x90
May 19 02:23:47:  [<c01a11f9>] nfsd_readdir+0x79/0xc0
May 19 02:23:47:  [<c01a6b8a>] nfsd3_proc_readdirplus+0xda/0x1d0
May 19 02:23:47:  [<c01a9ed0>] nfs3svc_encode_entry_plus+0x0/0x50
May 19 02:23:47:  [<c01a8e90>] nfs3svc_decode_readdirplusargs+0x0/0x180
May 19 02:23:47:  [<c019bce6>] nfsd_dispatch+0xb6/0x1a0
May 19 02:23:47:  [<c03139fd>] svc_authenticate+0x4d/0x80
May 19 02:23:47:  [<c03112d7>] svc_process+0x487/0x5f0
May 19 02:23:47:  [<c0103b6c>] common_interrupt+0x18/0x20
May 19 02:23:47:  [<c019bad9>] nfsd+0x179/0x2d0
May 19 02:23:47:  [<c019b960>] nfsd+0x0/0x2d0
May 19 02:23:47:  [<c0101fbd>] kernel_thread_helper+0x5/0x18
May 19 02:23:47: 
May 19 02:23:47: Code: 89 06 89 c8 0f c8 89 46 04 81 7c 24 1c 00 01 00 00 b8 ff 00 

Which later turned into a reboot-requiring cascade of these:

May 19 06:29:57:  <4>qmail-rspawn: page allocation failure. order:0, mode:0x20
May 19 06:29:57: Call Trace:
May 19 06:29:57:  [<c0127395>] __alloc_pages+0x2d5/0x330
May 19 06:29:57:  [<c012740f>] __get_free_pages+0x1f/0x40
May 19 06:29:57:  [<c012a961>] cache_grow+0x91/0x270
May 19 06:29:57:  [<c012ae3e>] cache_alloc_refill+0x2fe/0x400
May 19 06:29:57:  [<c01261a7>] mempool_alloc+0x67/0x110
May 19 06:29:57:  [<c012b520>] kmem_cache_alloc+0x1a0/0x1b0
May 19 06:29:57:  [<c020dad8>] submit_bio+0x58/0xf0
May 19 06:29:57:  [<c01d1490>] radix_tree_node_alloc+0x10/0x50
May 19 06:29:57:  [<c01d16f9>] radix_tree_insert+0xe9/0x110
May 19 06:29:57:  [<c0138a25>] __add_to_swap_cache+0x55/0xc0
May 19 06:29:57:  [<c0138bbe>] add_to_swap+0x4e/0xb0
May 19 06:29:57:  [<c012deef>] shrink_list+0x3af/0x3e0
May 19 06:29:57:  [<c012e065>] shrink_cache+0x145/0x300
May 19 06:29:57:  [<c012e7a9>] shrink_caches+0x79/0x80
May 19 06:29:57:  [<c012e851>] try_to_free_pages+0xa1/0x180
May 19 06:29:57:  [<c012728c>] __alloc_pages+0x1cc/0x330
May 19 06:29:57:  [<c014515e>] <4>qmail-rspawn: page allocation failure. order:0, mode:0x20
May 19 06:29:57: Call Trace:
May 19 06:29:57:  [<c0127395>] __alloc_pages+0x2d5/0x330
May 19 06:29:57:  [<c012740f>] __get_free_pages+0x1f/0x40
May 19 06:29:57:  [<c012a961>] cache_grow+0x91/0x270
May 19 06:29:57:  [<c012ae3e>] cache_alloc_refill+0x2fe/0x400
May 19 06:29:57:  [<c012b520>] kmem_cache_alloc+0x1a0/0x1b0
May 19 06:29:57:  [<c029dce2>] dst_alloc+0x22/0x90
May 19 06:29:57:  [<c02b7cee>] ip_route_input_slow+0x47e/0x800
May 19 06:29:57:  [<c0253a38>] lba_28_rw_disk+0x88/0x90
May 19 06:29:57:  [<c02dc0e8>] arp_process+0x1e8/0x4c0
May 19 06:29:57:  [<c0303c79>] packet_rcv+0x189/0x2f0
May 19 06:29:57:  [<c029a2b0>] netif_receive_skb+0x150/0x180
May 19 06:29:57:  [<c023f3ac>] tulip_poll+0x44c/0x660
May 19 06:29:57:  [<c029a44c>] net_rx_action+0x6c/0xf0
May 19 06:29:57:  [<c0115b09>] __do_softirq+0x79/0x80
May 19 06:29:57:  [<c0115b37>] do_softirq+0x27/0x30
May 19 06:29:57:  [<c0105525>] do_IRQ+0xd5/0x110
May 19 06:29:57:  [<c0103b6c>] common_interrupt+0x18/0x20
May 19 06:29:57:  [<c012007b>] param_get_long+0x1b/0x30
May 19 06:29:57:  [<c0122ebc>] kallsyms_lookup+0xdc/0x180
May 19 06:29:57:  [<c014515e>] copy_strings+0x1be/0x1f0
May 19 06:29:57:  [<c014515e>] copy_strings+0x1be/0x1f0
May 19 06:29:57:  [<c0122f9a>] __print_symbol+0x3a/0x170
May 19 06:29:57:  [<c01ef150>] complement_pos+0x10/0x160
May 19 06:29:57:  [<c01ef150>] complement_pos+0x10/0x160
May 19 06:29:57:  [<c014515e>] copy_strings+0x1be/0x1f0
May 19 06:29:57:  [<c0103e81>] show_trace+0xb1/0xc0
May 19 06:29:57:  [<c014515e>] copy_strings+0x1be/0x1f0
May 19 06:29:57:  [<c0103f33>] dump_stack+0x13/0x20
May 19 06:29:57:  [<c0127395>] __alloc_pages+0x2d5/0x330
May 19 06:29:57:  [<c012740f>] __get_free_pages+0x1f/0x40
May 19 06:29:57:  [<c012a961>] cache_grow+0x91/0x270
May 19 06:29:57:  [<c012ae3e>] cache_alloc_refill+0x2fe/0x400
May 19 06:29:57:  [<c01261a7>] mempool_alloc+0x67/0x110
May 19 06:29:57:  [<c012b520>] kmem_cache_alloc+0x1a0/0x1b0
May 19 06:29:57:  [<c020dad8>] submit_bio+0x58/0xf0
May 19 06:29:57:  [<c01d1490>] radix_tree_node_alloc+0x10/0x50
May 19 06:29:57:  [<c01d16f9>] radix_tree_insert+0xe9/0x110
May 19 06:29:57:  [<c0138a25>] __add_to_swap_cache+0x55/0xc0
May 19 06:29:57:  [<c0138bbe>] add_to_swap+0x4e/0xb0
May 19 06:29:57:  [<c012deef>] shrink_list+0x3af/0x3e0
May 19 06:29:57:  [<c012e065>] shrink_cache+0x145/0x300
May 19 06:29:57:  [<c012e7a9>] shrink_caches+0x79/0x80
May 19 06:29:57:  [<c012e851>] try_to_free_pages+0xa1/0x180
May 19 06:29:57:  [<c012728c>] __alloc_pages+0x1cc/0x330
May 19 06:29:57:  [<c014515e>] copy_strings+0x1be/0x1f0
May 19 06:29:57:  [<c01451b0>] copy_strings_kernel+0x20/0x30
May 19 06:29:57:  [<c0146125>] do_execve+0x125/0x200
May 19 06:29:57:  [<c0102775>] sys_execve+0x35/0x70
May 19 06:29:57:  [<c01039ff>] syscall_call+0x7/0xb
May 19 06:29:57: 

(Similar repetitions ad nauseam; write if you want them all.)


The memory map is pretty full, as it's a 1GB machine run with a regular
3+1 split.  /proc/iomem is as follows:

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cb3ff : Video ROM
000cc000-000cc7ff : Adapter ROM
000d0000-000d1fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-0031b833 : Kernel code
  0031b834-003f5ebf : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
40000000-40000fff : 0000:00:09.0
  40000000-40000fff : yenta_socket
40001000-40001fff : 0000:00:09.1
  40001000-40001fff : yenta_socket
40400000-407fffff : PCI CardBus #03
40800000-40bfffff : PCI CardBus #03
40c00000-40ffffff : PCI CardBus #07
41000000-413fffff : PCI CardBus #07
de800000-e07fffff : PCI Bus #02
  de800000-de8003ff : 0000:02:07.0
    de800000-de8003ff : tulip
  df000000-df0003ff : 0000:02:06.0
    df000000-df0003ff : tulip
  df800000-df8003ff : 0000:02:05.0
    df800000-df8003ff : tulip
  e0000000-e00003ff : 0000:02:04.0
    e0000000-e00003ff : tulip
e0800000-e0803fff : 0000:00:0c.0
e1000000-e1003fff : 0000:00:0b.0
e1800000-e1800fff : 0000:00:0a.0
e2000000-e3cfffff : PCI Bus #01
  e2000000-e2ffffff : 0000:01:00.0
e3d00000-e3dfffff : PCI Bus #02
e3f00000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : 0000:01:00.0
e6000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved
