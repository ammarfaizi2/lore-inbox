Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUCSOIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUCSOIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:08:43 -0500
Received: from ind-iport-1-sec.cisco.com ([64.104.129.9]:15752 "EHLO
	ind-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262999AbUCSOIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:08:24 -0500
From: Naveen Burmi <naveenb@cisco.com>
Reply-To: naveenb@cisco.com
To: linux-kernel@vger.kernel.org
Subject: page allocation failure. order:0, mode:0x20
Date: Fri, 19 Mar 2004 19:38:08 +0530
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403191938.09026.naveenb@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While testing  linux-iscsi-4.0.1.1 driver on linux kernel version 2.6.3, my 
system's  console was floded with follwoing message:

"page allocation failure. order:0, mode:0x20"

Is this a known problem in linux kernel version 2.6.x ? 
Is there any patch available for this problem ?

My setup :-

Four processor machine : 
====================
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 698.159
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1392.64


NIC :
====
Intel Corp. 82557/8/9 [Ethernet Pro 100]
MTU: 1500

Used two iscsi disks of 17GB, having filesystem ext3.

Memory status before starting I/O:
===========================
             total       used       free     shared    buffers     cached
Mem:       2070376     432996    1637380          0      45524     162980
-/+ buffers/cache:     224492    1845884
Swap:      2040212        388    2039824

Memory status after starting I/O:
=========================
            total       used       free     shared    buffers     cached
Mem:       2070376    2063604       6772          0      32124    1804716
-/+ buffers/cache:     226764    1843612
Swap:      2040212        380    2039832

Following are excerpts from messages appears on my system console:
============================================================

iscsi-tx: page allocation failure. order:0, mode:0x20
Call Trace:
 [<c014ab6b>] __alloc_pages+0x33b/0x3d0
 [<c014ac27>] __get_free_pages+0x27/0x40
 [<c010dbab>] handle_IRQ_event+0x3b/0x70
 [<c014ec0c>] cache_grow+0xdc/0x3b0
 [<c014effd>] cache_alloc_refill+0x11d/0x530
 [<c011f953>] kernel_map_pages+0x33/0x68
 [<c014fe84>] __kmalloc+0x244/0x280
 [<c035c278>] alloc_skb+0x48/0xf0
 [<c02785a4>] e100_rx_srv+0x1f4/0x5e0
 [<c0278182>] e100intr+0x2b2/0x360
 [<c010dbab>] handle_IRQ_event+0x3b/0x70
 [<c010e022>] do_IRQ+0xe2/0x230
 [<c010c000>] common_interrupt+0x18/0x20
 [<c011007b>] handle_vm86_fault+0x57b/0xa70
 [<c015012f>] kmem_cache_free+0x1af/0x3c0
 [<c035c475>] kfree_skbmem+0x25/0x30
 [<c035c475>] kfree_skbmem+0x25/0x30
 [<c035c51e>] __kfree_skb+0x9e/0x130
 [<c038d107>] tcp_clean_rtx_queue+0x147/0x3d0
 [<c038da67>] tcp_ack+0xe7/0x3f0
 [<c035c51e>] __kfree_skb+0x9e/0x130
 [<c0390676>] tcp_rcv_established+0x436/0x7f0
 [<c039a3ba>] tcp_v4_do_rcv+0x13a/0x140
 [<c035b905>] __release_sock+0x65/0xd0
 [<c035c0ed>] release_sock+0xad/0xd0
 [<c0386b0b>] tcp_sendmsg+0x4db/0x13f0
 [<c0392f2a>] tcp_write_xmit+0x1ba/0x310
 [<c035c0b1>] release_sock+0x71/0xd0
 [<c035c278>] alloc_skb+0x48/0xf0
 [<c03ab37b>] inet_sendmsg+0x4b/0x60
 [<c035801b>] sock_sendmsg+0xcb/0xd0
 [<c03ab37b>] inet_sendmsg+0x4b/0x60
 [<c0155b7a>] kmap_high+0x23a/0x280
 [<c014d90b>] check_poison_obj+0x2b/0x1a0
 [<c0155bee>] kunmap_high+0x2e/0xf0
 [<c011fa0e>] kmap+0x3e/0x40
 [<c035bad8>] sock_no_sendpage+0x78/0xa0
 [<c03865eb>] tcp_sendpage+0x4b/0x90
 [<f89a0ea8>] iscsi_xmit_data+0x668/0xb00 [iscsi]
 [<c03865a0>] tcp_sendpage+0x0/0x90
 [<c038013e>] ip_output+0x5e/0x80
 [<c039ab86>] tcp_v4_rcv+0x7c6/0xaa0
 [<c0278160>] e100intr+0x290/0x360
 [<c011f576>] __change_page_attr+0x26/0x1e0
 [<c0130ef6>] update_wall_time+0x16/0x40
 [<c01313b0>] do_timer+0xc0/0xd0
 [<c0112e76>] timer_interrupt+0x96/0x1e0
 [<c010dbab>] handle_IRQ_event+0x3b/0x70
 [<c010e060>] do_IRQ+0x120/0x230
 [<c010dbab>] handle_IRQ_event+0x3b/0x70
 [<c010c000>] common_interrupt+0x18/0x20
 [<c014d90b>] check_poison_obj+0x2b/0x1a0
 [<f89a1487>] iscsi_xmit_r2t_data+0x147/0x310 [iscsi]
 [<f89a14db>] iscsi_xmit_r2t_data+0x19b/0x310 [iscsi]
 [<f89823ea>] iscsi_tx_thread+0x83a/0xbc0 [iscsi]
 [<c0121860>] schedule+0x60/0x780
 [<c0121f80>] default_wake_function+0x0/0x30
 [<c0121f80>] default_wake_function+0x0/0x30
 [<f8981bb0>] iscsi_tx_thread+0x0/0xbc0 [iscsi]
 [<c01091bd>] kernel_thread_helper+0x5/0x18

iscsi-tx: page allocation failure. order:0, mode:0x20
iscsi-tx: page allocation failure. order:0, mode:0x20
Call Trace:
 [<c014ab6b>] __alloc_pages+0x33b/0x3d0
 [<c014ea02>] cache_init_objs+0xe2/0x1e0
 [<c014ac27>] __get_free_pages+0x27/0x40
 [<c014ec0c>] cache_grow+0xdc/0x3b0
 [<c014effd>] cache_alloc_refill+0x11d/0x530
 [<c011f953>] kernel_map_pages+0x33/0x68
 [<c014fbb5>] kmem_cache_alloc+0x205/0x230
 [<c035c253>] alloc_skb+0x23/0xf0
 [<c0387779>] tcp_sendmsg+0x1149/0x13f0
 [<c0392f2a>] tcp_write_xmit+0x1ba/0x310
 [<c035c0b1>] release_sock+0x71/0xd0
 [<c035bff0>] lock_sock+0x70/0xc0
 [<c03ab37b>] inet_sendmsg+0x4b/0x60
 [<c035801b>] sock_sendmsg+0xcb/0xd0
 [<c03ab37b>] inet_sendmsg+0x4b/0x60
 [<c035801b>] sock_sendmsg+0xcb/0xd0
 [<c014d90b>] check_poison_obj+0x2b/0x1a0
 [<c011fa00>] kmap+0x30/0x40
 [<c035bad8>] sock_no_sendpage+0x78/0xa0
 [<c03865eb>] tcp_sendpage+0x4b/0x90
 [<f89a11a8>] iscsi_xmit_data+0x668/0xb00 [iscsi]
 [<c03865a0>] tcp_sendpage+0x0/0x90
 [<c011f953>] kernel_map_pages+0x33/0x68
 [<c010c000>] common_interrupt+0x18/0x20
 [<c039a9af>] tcp_v4_rcv+0x5ef/0xaa0
 [<c011f953>] kernel_map_pages+0x33/0x68
 [<c0121275>] scheduler_tick+0x105/0x680
 [<c011b93d>] smp_apic_timer_interrupt+0xcd/0x140
 [<c010c082>] apic_timer_interrupt+0x1a/0x20
 [<c014d90b>] check_poison_obj+0x2b/0x1a0
 [<f89a1787>] iscsi_xmit_r2t_data+0x147/0x310 [iscsi]
 [<f8982470>] iscsi_tx_thread+0x890/0xc10 [iscsi]
 [<c0121860>] schedule+0x60/0x780
 [<c0121f80>] default_wake_function+0x0/0x30
 [<c0121f80>] default_wake_function+0x0/0x30
 [<f8981be0>] iscsi_tx_thread+0x0/0xc10 [iscsi]
 [<c01091bd>] kernel_thread_helper+0x5/0x18

Call Trace:
 [<c014ab6b>] __alloc_pages+0x33b/0x3d0
 [<c014ac27>] __get_free_pages+0x27/0x40
 [<c014ec0c>] cache_grow+0xdc/0x3b0
 [<c014effd>] cache_alloc_refill+0x11d/0x530
 [<c011f953>] kernel_map_pages+0x33/0x68
 [<c014fe84>] __kmalloc+0x244/0x280
 [<c035c278>] alloc_skb+0x48/0xf0
 [<c035c278>] alloc_skb+0x48/0xf0
 [<c0278505>] e100_rx_srv+0x155/0x5e0
 [<c02785a4>] e100_rx_srv+0x1f4/0x5e0
 [<c0533f4c>] isapnp_read_tag+0x2c/0xa0
 [<c0278182>] e100intr+0x2b2/0x360
 [<c010dbab>] handle_IRQ_event+0x3b/0x70
 [<c010e022>] do_IRQ+0xe2/0x230
 [<c010c000>] common_interrupt+0x18/0x20
 [<c011007b>] handle_vm86_fault+0x57b/0xa70
 [<c015012f>] kmem_cache_free+0x1af/0x3c0
 [<c035c475>] kfree_skbmem+0x25/0x30
 [<c035c475>] kfree_skbmem+0x25/0x30
 [<c035c51e>] __kfree_skb+0x9e/0x130
 [<c038d107>] tcp_clean_rtx_queue+0x147/0x3d0
 [<c0392f2a>] tcp_write_xmit+0x1ba/0x310
 [<c038da67>] tcp_ack+0xe7/0x3f0
 [<c0390676>] tcp_rcv_established+0x436/0x7f0
 [<c039a3ba>] tcp_v4_do_rcv+0x13a/0x140
 [<c035b905>] __release_sock+0x65/0xd0
 [<c035c0ed>] release_sock+0xad/0xd0
 [<c0385851>] wait_for_tcp_memory+0x141/0x210
 [<c0124bc0>] autoremove_wake_function+0x0/0x50
 [<c0124bc0>] autoremove_wake_function+0x0/0x50
 [<c0387542>] tcp_sendmsg+0xf12/0x13f0
 [<c035c0b1>] release_sock+0x71/0xd0
 [<c035bff0>] lock_sock+0x70/0xc0
 [<c03ab37b>] inet_sendmsg+0x4b/0x60
 [<c035801b>] sock_sendmsg+0xcb/0xd0
 [<c03ab37b>] inet_sendmsg+0x4b/0x60
 [<c0155b7a>] kmap_high+0x23a/0x280
 [<c014d90b>] check_poison_obj+0x2b/0x1a0
 [<c0155bee>] kunmap_high+0x2e/0xf0
 [<c011fa0e>] kmap+0x3e/0x40
 [<c035bad8>] sock_no_sendpage+0x78/0xa0
 [<c03865eb>] tcp_sendpage+0x4b/0x90
 [<f89a11a8>] iscsi_xmit_data+0x668/0xb00 [iscsi]
 [<c03865a0>] tcp_sendpage+0x0/0x90
 [<c011007b>] handle_vm86_fault+0x57b/0xa70
 [<c0361bb7>] netif_receive_skb+0x1b7/0x230
 [<c0130ef6>] update_wall_time+0x16/0x40
 [<c01313b0>] do_timer+0xc0/0xd0
 [<c0112e76>] timer_interrupt+0x96/0x1e0
 [<c0121275>] scheduler_tick+0x105/0x680
 [<c0130ef6>] update_wall_time+0x16/0x40
 [<c0112e76>] timer_interrupt+0x96/0x1e0
 [<c014d90b>] check_poison_obj+0x2b/0x1a0
 [<f89a1787>] iscsi_xmit_r2t_data+0x147/0x310 [iscsi]
 [<f8982470>] iscsi_tx_thread+0x890/0xc10 [iscsi]
 [<c0121860>] schedule+0x60/0x780
 [<c0121f80>] default_wake_function+0x0/0x30
 [<c0121f80>] default_wake_function+0x0/0x30
 [<f8981be0>] iscsi_tx_thread+0x0/0xc10 [iscsi]
 [<c01091bd>] kernel_thread_helper+0x5/0x18




Thanks,
Naveen.




