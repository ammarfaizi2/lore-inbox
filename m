Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbTDRWqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTDRWqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:46:20 -0400
Received: from host217-44-221-128.range217-44.btcentralplus.com ([217.44.221.128]:51460
	"EHLO flat") by vger.kernel.org with ESMTP id S263216AbTDRWqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:46:12 -0400
Date: Fri, 18 Apr 2003 23:58:35 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [2.5.67-mm4] Badness in local_bh_enable at kernel/softirq.c:105
Message-ID: <20030418225835.GA687@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seems to be triggered by network traffic on 3c574 PCMCIA ethernet card.
Several different traces appear.

Config: Sony Vaio. Celeron 333, 128MB, 3c574 PCMCIA ethernet.

These are a few of the traces.

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022bd10>] udp_sendmsg+0x1b0/0x880
 [<c01195d5>] scheduler_tick+0x3a5/0x3b0
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c0109bb8>] common_interrupt+0x18/0x20
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c020cada>] ip_output+0x13a/0x290
 [<c020d8fd>] ip_generic_getfrag+0x4d/0xc0
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c020df59>] ip_append_data+0x599/0x760
 [<c022ba19>] udp_push_pending_frames+0x109/0x210
 [<c022bdab>] udp_sendmsg+0x24b/0x880
 [<c01f6d93>] __kfree_skb+0x83/0x110
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022bd10>] udp_sendmsg+0x1b0/0x880
 [<c01f6d93>] __kfree_skb+0x83/0x110
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c020cada>] ip_output+0x13a/0x290
 [<c020d8fd>] ip_generic_getfrag+0x4d/0xc0
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c020df59>] ip_append_data+0x599/0x760
 [<c022ba19>] udp_push_pending_frames+0x109/0x210
 [<c022bdab>] udp_sendmsg+0x24b/0x880
 [<c01f6d93>] __kfree_skb+0x83/0x110
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022bd10>] udp_sendmsg+0x1b0/0x880
 [<c01f6d93>] __kfree_skb+0x83/0x110
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c020cada>] ip_output+0x13a/0x290
 [<c020d8fd>] ip_generic_getfrag+0x4d/0xc0
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c020df59>] ip_append_data+0x599/0x760
 [<c022ba19>] udp_push_pending_frames+0x109/0x210
 [<c022bdab>] udp_sendmsg+0x24b/0x880
 [<c01f6d93>] __kfree_skb+0x83/0x110
 [<c022c98a>] udp_recvmsg+0x21a/0x2d0
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022bd10>] udp_sendmsg+0x1b0/0x880
 [<c01f6d93>] __kfree_skb+0x83/0x110
 [<c022c98a>] udp_recvmsg+0x21a/0x2d0
 [<c022c9be>] udp_recvmsg+0x24e/0x2d0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c020822f>] __ip_route_output_key+0x2f/0xf0
 [<c020837f>] ip_route_output_flow+0x2f/0x80
 [<c022cbd3>] udp_connect+0x193/0x300
 [<c01f2f7c>] sockfd_lookup+0x1c/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c01f42a1>] sys_connect+0x91/0xc0
 [<c01f2f42>] sock_map_fd+0x122/0x140
 [<c01f005d>] serport_serio_write+0x2d/0x40
 [<c01f2d6b>] sock_destroy_inode+0x1b/0x20
 [<c01f4567>] sys_send+0x37/0x40
 [<c01f4ece>] sys_socketcall+0x15e/0x2a0
 [<c014df72>] sys_close+0x62/0xa0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c022e9ff>] arp_send+0x1ef/0x2a0
 [<c022f00e>] arp_process+0x52e/0x570
 [<c01faee3>] netif_receive_skb+0xc3/0x190
 [<c01fb01d>] process_backlog+0x6d/0x100
 [<c01fb124>] net_rx_action+0x74/0x120
 [<c0120d3a>] do_softirq+0x9a/0xa0
 [<c010b7bd>] do_IRQ+0xfd/0x120
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0109bb8>] common_interrupt+0x18/0x20
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0107004>] default_idle+0x24/0x40
 [<c010709a>] cpu_idle+0x3a/0x50
 [<c0105000>] _stext+0x0/0x60
 [<c02d8768>] start_kernel+0x148/0x150
 [<c02d84b0>] unknown_bootoption+0x0/0x120

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c022e9ff>] arp_send+0x1ef/0x2a0
 [<c022e3e4>] arp_solicit+0xa4/0x120
 [<c01fe4a5>] __neigh_event_send+0xd5/0x1c0
 [<c01fedac>] neigh_resolve_output+0x1ac/0x1d0
 [<c020cb0d>] ip_output+0x16d/0x290
 [<c020df59>] ip_append_data+0x599/0x760
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c022a920>] raw_sendmsg+0x450/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c013375c>] find_get_page+0x2c/0x60
 [<c013483a>] filemap_nopage+0x1da/0x2d0
 [<c01402ea>] do_no_page+0x1aa/0x370
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c011806c>] do_page_fault+0x23c/0x45e
 [<c01b1d9f>] tty_write+0x1cf/0x2f0
 [<c0128d13>] sys_rt_sigaction+0xe3/0x110
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fe4d5>] __neigh_event_send+0x105/0x1c0
 [<c01fedac>] neigh_resolve_output+0x1ac/0x1d0
 [<c020cb0d>] ip_output+0x16d/0x290
 [<c020df59>] ip_append_data+0x599/0x760
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c022a920>] raw_sendmsg+0x450/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c013375c>] find_get_page+0x2c/0x60
 [<c013483a>] filemap_nopage+0x1da/0x2d0
 [<c01402ea>] do_no_page+0x1aa/0x370
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c011806c>] do_page_fault+0x23c/0x45e
 [<c01b1d9f>] tty_write+0x1cf/0x2f0
 [<c0128d13>] sys_rt_sigaction+0xe3/0x110
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022a870>] raw_sendmsg+0x3a0/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c013375c>] find_get_page+0x2c/0x60
 [<c013483a>] filemap_nopage+0x1da/0x2d0
 [<c01402ea>] do_no_page+0x1aa/0x370
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c011806c>] do_page_fault+0x23c/0x45e
 [<c01b1d9f>] tty_write+0x1cf/0x2f0
 [<c0128d13>] sys_rt_sigaction+0xe3/0x110
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c01fecf7>] neigh_resolve_output+0xf7/0x1d0
 [<c01fe7ec>] neigh_update+0x25c/0x3e0
 [<c022ed2e>] arp_process+0x24e/0x570
 [<c0124571>] add_timer+0x91/0xa0
 [<c0124571>] add_timer+0x91/0xa0
 [<c01faee3>] netif_receive_skb+0xc3/0x190
 [<c01fb01d>] process_backlog+0x6d/0x100
 [<c01fb124>] net_rx_action+0x74/0x120
 [<c0120d3a>] do_softirq+0x9a/0xa0
 [<c010b7bd>] do_IRQ+0xfd/0x120
 [<c0109bb8>] common_interrupt+0x18/0x20
 [<c01197af>] schedule+0x1bf/0x3d0
 [<c011d0bf>] do_syslog+0x19f/0x3a0
 [<c0119a10>] default_wake_function+0x0/0x20
 [<c014e74e>] vfs_read+0xbe/0x130
 [<c014e9ee>] sys_read+0x3e/0x60
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fe767>] neigh_update+0x1d7/0x3e0
 [<c022ed2e>] arp_process+0x24e/0x570
 [<c0124571>] add_timer+0x91/0xa0
 [<c0124571>] add_timer+0x91/0xa0
 [<c01faee3>] netif_receive_skb+0xc3/0x190
 [<c01fb01d>] process_backlog+0x6d/0x100
 [<c01fb124>] net_rx_action+0x74/0x120
 [<c0120d3a>] do_softirq+0x9a/0xa0
 [<c010b7bd>] do_IRQ+0xfd/0x120
 [<c0109bb8>] common_interrupt+0x18/0x20
 [<c01197af>] schedule+0x1bf/0x3d0
 [<c011d0bf>] do_syslog+0x19f/0x3a0
 [<c0119a10>] default_wake_function+0x0/0x20
 [<c014e74e>] vfs_read+0xbe/0x130
 [<c014e9ee>] sys_read+0x3e/0x60
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c020cada>] ip_output+0x13a/0x290
 [<c020df59>] ip_append_data+0x599/0x760
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c022a920>] raw_sendmsg+0x450/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c013375c>] find_get_page+0x2c/0x60
 [<c013483a>] filemap_nopage+0x1da/0x2d0
 [<c01402ea>] do_no_page+0x1aa/0x370
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c011806c>] do_page_fault+0x23c/0x45e
 [<c01b6ee0>] write_chan+0x0/0x270
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022a870>] raw_sendmsg+0x3a0/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c013375c>] find_get_page+0x2c/0x60
 [<c013483a>] filemap_nopage+0x1da/0x2d0
 [<c01402ea>] do_no_page+0x1aa/0x370
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c011806c>] do_page_fault+0x23c/0x45e
 [<c01b6ee0>] write_chan+0x0/0x270
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c020cada>] ip_output+0x13a/0x290
 [<c020df59>] ip_append_data+0x599/0x760
 [<c020e7cc>] ip_push_pending_frames+0x2ac/0x400
 [<c022a920>] raw_sendmsg+0x450/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c01c10a2>] hide_cursor+0x62/0xa0
 [<c01b4c10>] opost_block+0xf0/0x1b0
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c0109052>] do_signal+0x102/0x110
 [<c01b6ee0>] write_chan+0x0/0x270
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c022a870>] raw_sendmsg+0x3a0/0x5a0
 [<c020d8b0>] ip_generic_getfrag+0x0/0xc0
 [<c02349ad>] inet_sendmsg+0x4d/0x60
 [<c01f319e>] sock_sendmsg+0x9e/0xd0
 [<c01c3cb4>] do_con_trol+0xd44/0xf00
 [<c01c10a2>] hide_cursor+0x62/0xa0
 [<c01b4c10>] opost_block+0xf0/0x1b0
 [<c01f2c4f>] move_addr_to_kernel+0x6f/0x80
 [<c01f4513>] sys_sendto+0xe3/0x100
 [<c0109052>] do_signal+0x102/0x110
 [<c01b6ee0>] write_chan+0x0/0x270
 [<c01f4f20>] sys_socketcall+0x1b0/0x2a0
 [<c010924b>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:105
Call Trace:
 [<c0120dcd>] local_bh_enable+0x8d/0x90
 [<c01fa9eb>] dev_queue_xmit+0x21b/0x2b0
 [<c022e9ff>] arp_send+0x1ef/0x2a0
 [<c022f00e>] arp_process+0x52e/0x570
 [<c01faee3>] netif_receive_skb+0xc3/0x190
 [<c01fb01d>] process_backlog+0x6d/0x100
 [<c01fb124>] net_rx_action+0x74/0x120
 [<c0120d3a>] do_softirq+0x9a/0xa0
 [<c010b7bd>] do_IRQ+0xfd/0x120
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0109bb8>] common_interrupt+0x18/0x20
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0106fe0>] default_idle+0x0/0x40
 [<c0107004>] default_idle+0x24/0x40
 [<c010709a>] cpu_idle+0x3a/0x50
 [<c0105000>] _stext+0x0/0x60
 [<c02d8768>] start_kernel+0x148/0x150
 [<c02d84b0>] unknown_bootoption+0x0/0x120


