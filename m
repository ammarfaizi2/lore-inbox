Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266564AbUF3G1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUF3G1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUF3G1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:27:47 -0400
Received: from ns.theshore.net ([216.156.129.65]:32007 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S266564AbUF3G1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:27:41 -0400
Message-ID: <003c01c45e6b$a2323ed0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.4 and 2.6.7 page allocation failure / e1000 related ?
Date: Wed, 30 Jun 2004 01:29:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've had this appear in dmesg a few times on a number of different systems, all
identical hardware: SuperMicro 6013P-i dual Xeon, with 4GB of RAM, built-in e1000
NICs connected via 100Mbit switch.

It doesn't appear to cause any ill effects.  I haven't provided all the variations
of the messages, but the consistent thing between them are the e1000_* calls.
This isn't an OOM situation, the machines are only a handful of MB into swap (if
that).


Host: 2.6.7+skas+sysemu
Process: 2.4.26-linode29-1um

2.4.26-linode29: page allocation failure. order:0, mode:0x20
 [<c0138526>] __alloc_pages+0x2e0/0x32d
 [<c0138598>] __get_free_pages+0x25/0x3f
 [<c013b832>] kmem_getpages+0x21/0xcd
 [<c013c411>] cache_grow+0x9f/0x1fc
 [<c013c63d>] cache_alloc_refill+0xcf/0x21a
 [<c013cc28>] __kmalloc+0x73/0x7a
 [<c02bf265>] alloc_skb+0x47/0xe0
 [<c026653a>] e1000_alloc_rx_buffers+0x57/0xf2
 [<c02661b6>] e1000_clean_rx_irq+0x109/0x436
 [<c0125457>] __group_send_sig_info+0xb3/0xcf
 [<c0265e1a>] e1000_clean+0x43/0xb9
 [<c02c4500>] net_rx_action+0x7a/0x103
 [<c011fc8f>] __do_softirq+0xab/0xad
 [<c011fcbe>] do_softirq+0x2d/0x2f
 [<c0108155>] do_IRQ+0xf6/0x114
 [<c0106478>] common_interrupt+0x18/0x20
 [<c013007b>] sys_delete_module+0x130/0x193
 [<c013fdc8>] refill_inactive_zone+0x472/0x5a9
 [<c013ffa4>] shrink_zone+0xa5/0xe4
 [<c0140044>] shrink_caches+0x61/0x63
 [<c01400f4>] try_to_free_pages+0xae/0x185
 [<c0138410>] __alloc_pages+0x1ca/0x32d
 [<c0138598>] __get_free_pages+0x25/0x3f
 [<c013b832>] kmem_getpages+0x21/0xcd
 [<c013c411>] cache_grow+0x9f/0x1fc
 [<c013c63d>] cache_alloc_refill+0xcf/0x21a
 [<c013cc28>] __kmalloc+0x73/0x7a
 [<c01a0cfa>] __jbd_kmalloc+0x28/0x2c
 [<c01998fa>] do_get_write_access+0x21d/0x65a
 [<c0155802>] __getblk+0x37/0x65
 [<c018eda1>] ext3_get_inode_loc+0x7a/0x27c
 [<c0199d70>] journal_get_write_access+0x39/0x51
 [<c018f9d1>] ext3_reserve_inode_write+0x8d/0xd3
 [<c018fa42>] ext3_mark_inode_dirty+0x2b/0x51
 [<c018faed>] ext3_dirty_inode+0x85/0x87
 [<c0171d9d>] __mark_inode_dirty+0x1b9/0x1be
 [<c016c23f>] inode_update_time+0xac/0xd6
 [<c013605e>] generic_file_aio_write_nolock+0x299/0xb65
 [<c0107daa>] handle_IRQ_event+0x3a/0x64
 [<c0317b1f>] unix_stream_data_wait+0x119/0x12a
 [<c0317d7a>] unix_stream_recvmsg+0x24a/0x49e
 [<c02bec8e>] sock_def_readable+0x6a/0x86
 [<c0136a3e>] generic_file_aio_write+0x78/0xa2
 [<c018a71b>] ext3_file_write+0x44/0xd5
 [<c0152dca>] do_sync_write+0x8b/0xb7
 [<c010579d>] handle_signal+0xd5/0x130
 [<c01058ec>] do_signal+0xf4/0xfe
 [<c011f249>] do_setitimer+0x1b7/0x1e1
 [<c0152eb2>] vfs_write+0xbc/0x127
 [<c0152fc2>] sys_write+0x42/0x63
 [<c0105af9>] syscall_call+0x7/0xb


Host: 2.6.4+skas
Process: 2.4.26-linode29-1um

2.4.26-linode26: page allocation failure. order:0, mode:0x20
Call Trace:
 [<c013d696>] __alloc_pages+0x300/0x345
 [<c013d700>] __get_free_pages+0x25/0x3f
 [<c0140142>] cache_grow+0x98/0x299
 [<c0344d1c>] br_forward_finish+0x0/0x5a
 [<c0140412>] cache_alloc_refill+0xcf/0x215
 [<c0140760>] kmem_cache_alloc+0x4b/0x4d
 [<c02be9ce>] skb_clone+0x1e/0x1a8
 [<c0344f50>] br_flood+0x6f/0x10d
 [<c0344dd7>] __br_forward+0x0/0x64
 [<c0345040>] br_flood_forward+0x27/0x2b
 [<c0344dd7>] __br_forward+0x0/0x64
 [<c0345845>] br_handle_frame_finish+0x12d/0x161
 [<c02cd3d6>] nf_hook_slow+0xd4/0x123
 [<c0345718>] br_handle_frame_finish+0x0/0x161
 [<c034858e>] br_nf_pre_routing_finish+0x10c/0x3b6
 [<c0345718>] br_handle_frame_finish+0x0/0x161
 [<c023e0ad>] poke_blanked_console+0x36/0xd8
 [<c0239a99>] set_cursor+0x75/0x8e
 [<c023d25f>] vt_console_print+0x215/0x303
 [<c011cee0>] __wake_up_common+0x38/0x57
 [<c02ccfbc>] nf_iterate+0x71/0xa5
 [<c0348482>] br_nf_pre_routing_finish+0x0/0x3b6
 [<c02cd3d6>] nf_hook_slow+0xd4/0x123
 [<c0348482>] br_nf_pre_routing_finish+0x0/0x3b6
 [<c0345718>] br_handle_frame_finish+0x0/0x161
 [<c0348a97>] br_nf_pre_routing+0x25f/0x377
 [<c0348482>] br_nf_pre_routing_finish+0x0/0x3b6
 [<c02ccfbc>] nf_iterate+0x71/0xa5
 [<c0345718>] br_handle_frame_finish+0x0/0x161
 [<c02cd37b>] nf_hook_slow+0x79/0x123
 [<c0345718>] br_handle_frame_finish+0x0/0x161
 [<c0345970>] br_handle_frame+0xf7/0x1e7
 [<c0345718>] br_handle_frame_finish+0x0/0x161
 [<c02c34f6>] netif_receive_skb+0xc6/0x1f4
 [<c02675dc>] e1000_alloc_rx_buffers+0x57/0xf2
 [<c02674fd>] e1000_clean_rx_irq+0x3ae/0x436
 [<c0266eba>] e1000_clean+0x43/0xbb
 [<c02c37af>] net_rx_action+0x7a/0x103
 [<c012488b>] do_softirq+0xc3/0xc5
 [<c0117332>] smp_apic_timer_interrupt+0xd2/0x13a
 [<c010b4da>] apic_timer_interrupt+0x1a/0x20
 [<c0203165>] __copy_user_intel+0x73/0xac
 [<c02032be>] __copy_to_user_ll+0x74/0x78
 [<c01124a6>] get_fpxregs+0x3b/0x4c
 [<c010fa69>] sys_ptrace+0x5ad/0x82c
 [<c011ce96>] default_wake_function+0x0/0x12
 [<c010aaeb>] syscall_call+0x7/0xb

lspci:
00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)
00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting
(rev 01)
00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0) (rev
01)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:03.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper) (rev 01)
02:03.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper) (rev 01)
04:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

Any insight would be appreciated.

Thanks,
-Chris

