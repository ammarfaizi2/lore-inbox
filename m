Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUK1XtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUK1XtE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUK1XtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:49:04 -0500
Received: from ns.theshore.net ([67.18.92.50]:46219 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S261604AbUK1Xs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:48:58 -0500
Message-ID: <0e0501c4d5a4$e08ebc20$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc2-bk7 - lots of "page allocation failure. order:0, mode:0x20"
Date: Sun, 28 Nov 2004 17:49:17 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Host: 2.6.10-rc2-bk7, SMP, 4GB RAM, about 200M into swap

# cat /proc/sys/vm/min_free_kbytes
10240

I've seen this reported elsewhere, but thought I'd provide a few more examples.  It
seems to happen mostly during scp'ing of large files to the machine. The network
config of this machine is Linux bridge, going through an e1000 card.  Increasing
min_free_kbytes doesn't seem to help.

Some examples:

uml-2.4: page allocation failure. order:0, mode:0x20
 [<c0136fa9>] __alloc_pages+0x1b7/0x35b
 [<c0137172>] __get_free_pages+0x25/0x3f
 [<c031069a>] ip_rcv_finish+0x211/0x28b
 [<c013a224>] kmem_getpages+0x21/0xc9
 [<c013aeb7>] cache_grow+0xab/0x14d
 [<c013b0d5>] cache_alloc_refill+0x17c/0x221
 [<c0310489>] ip_rcv_finish+0x0/0x28b
 [<c013b347>] kmem_cache_alloc+0x4b/0x4d
 [<c037d936>] br_nf_pre_routing+0x191/0x3fc
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c0304025>] nf_iterate+0x71/0xa2
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c0304381>] nf_hook_slow+0x6b/0xf9
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c03797f7>] br_handle_frame+0xe4/0x1c9
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c02fa752>] netif_receive_skb+0x114/0x275
 [<c0113447>] finish_task_switch+0x3a/0x83
 [<c02fa931>] process_backlog+0x7e/0x10b
 [<c02faa35>] net_rx_action+0x77/0xf6
 [<c011cba7>] __do_softirq+0xb7/0xc6
 [<c011cbe3>] do_softirq+0x2d/0x2f
 [<c02fa51d>] netif_rx_ni+0x3b/0x3d
 [<c028230e>] tun_chr_writev+0x11c/0x18a
 [<c028237c>] tun_chr_write+0x0/0x3b
 [<c02823b3>] tun_chr_write+0x37/0x3b
 [<c0151200>] vfs_write+0xb0/0x119
 [<c0152086>] fget_light+0x84/0x86
 [<c015133a>] sys_write+0x51/0x80
 [<c010243b>] syscall_call+0x7/0xb

swapper: page allocation failure. order:0, mode:0x20
 [<c0136fa9>] __alloc_pages+0x1b7/0x35b
 [<c0137172>] __get_free_pages+0x25/0x3f
 [<c013a224>] kmem_getpages+0x21/0xc9
 [<c013aeb7>] cache_grow+0xab/0x14d
 [<c013b0d5>] cache_alloc_refill+0x17c/0x221
 [<c013b347>] kmem_cache_alloc+0x4b/0x4d
 [<c037d936>] br_nf_pre_routing+0x191/0x3fc
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c0304025>] nf_iterate+0x71/0xa2
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c0304381>] nf_hook_slow+0x6b/0xf9
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c03797f7>] br_handle_frame+0xe4/0x1c9
 [<c0379604>] br_handle_frame_finish+0x0/0x10f
 [<c02fa752>] netif_receive_skb+0x114/0x275
 [<c026bb24>] e1000_clean_rx_irq+0x12e/0x447
 [<c026b765>] e1000_clean+0x51/0xca
 [<c02faa35>] net_rx_action+0x77/0xf6
 [<c011cba7>] __do_softirq+0xb7/0xc6
 [<c011cbe3>] do_softirq+0x2d/0x2f
 [<c01046b6>] do_IRQ+0x1e/0x24
 [<c0102db2>] common_interrupt+0x1a/0x20
 [<c01005da>] mwait_idle+0x31/0x48
 [<c01005a0>] cpu_idle+0x33/0x3c

-Chris

