Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVIUJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVIUJGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIUJGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:06:40 -0400
Received: from bgs.hu ([195.228.254.245]:35283 "HELO mail.bgs.hu")
	by vger.kernel.org with SMTP id S1750779AbVIUJGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:06:40 -0400
Message-ID: <4331229D.9050302@bgs.hu>
Date: Wed, 21 Sep 2005 11:06:37 +0200
From: Bgs <bgs@bgs.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050731 MultiZilla/1.8.1.0a
X-Accept-Language: en-us, en, hu, it, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: probs with realtek 8110/8169 NIC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Greetings,

I installed a NIC with a 8110/8169 chip in a server to upgrade to 
gigabgit bandwidth. I get a lot of these in dmesg:

Badness in __kfree_skb at net/core/skbuff.c:291
  [<c03e2ff1>] __kfree_skb+0xb1/0x100
  [<c03e658d>] sk_stream_kill_queues+0x4d/0x180
  [<c042e14c>] tcp_v4_destroy_sock+0x1c/0x180
  [<c041d4d7>] tcp_destroy_sock+0x47/0x120
  [<c042561a>] tcp_rcv_state_process+0x51a/0x9c0
  [<c042d1b9>] tcp_v4_do_rcv+0x99/0x120
  [<c042d7d0>] tcp_v4_rcv+0x590/0x770
  [<c0413c7f>] ip_local_deliver+0xbf/0x1c0
  [<c0414260>] ip_local_deliver_finish+0x0/0x130
  [<c04140d6>] ip_rcv+0x356/0x4e0
  [<c0414390>] ip_rcv_finish+0x0/0x270
  [<c01b1165>] pathrelse_and_restore+0x45/0x50
  [<c03e88c7>] netif_receive_skb+0x127/0x190
  [<c036eeac>] rtl8169_rx_vlan_skb+0x15c/0x1a0
  [<c037134a>] rtl8169_rx_interrupt+0x18a/0x400
  [<c0371a50>] pci_dma_sync_single_for_device+0x0/0x1
  [<c03716cb>] rtl8169_interrupt+0x10b/0x150
  [<c01385a0>] handle_IRQ_event+0x30/0x70
  [<c0138682>] __do_IRQ+0xa2/0xe0
  [<c0448056>] tcp_in_window+0x496/0x4a0
  [<c0104d79>] do_IRQ+0x19/0x30
  [<c0103292>] common_interrupt+0x1a/0x20
  [<c0139ad6>] find_get_page+0x26/0x30
  [<c0158373>] __find_get_block_slow+0x53/0x170
  [<c044a1c1>] ipt_do_table+0x251/0x330
  [<c0159190>] __find_get_block+0x80/0xe0
  [<c0159227>] __getblk+0x37/0x70
  [<c01b15f7>] search_by_key+0x97/0xd80
  [<c03edbfc>] neigh_resolve_output+0xec/0x190
  [<c0416c6e>] ip_finish_output+0xfe/0x220
  [<c041730a>] ip_queue_xmit+0x36a/0x510
  [<c0419300>] dst_output+0x0/0x30
  [<c019aab9>] make_cpu_key+0x59/0x70
  [<c019cfad>] inode2sd+0xfd/0x160
  [<c012cc20>] autoremove_wake_function+0x0/0x60
  [<c019aab9>] make_cpu_key+0x59/0x70
  [<c019d326>] reiserfs_update_sd_size+0xa6/0x220
  [<c0139b3f>] find_lock_page+0x1f/0x90
  [<c019aab9>] make_cpu_key+0x59/0x70
  [<c01a8424>] reiserfs_dirty_inode+0x74/0x90
  [<c01a2365>] reiserfs_submit_file_region_for_write+0x215/0x280
  [<c01a3342>] reiserfs_file_write+0x4f2/0x690
  [<c0414260>] ip_local_deliver_finish+0x0/0x130
  [<c04140d6>] ip_rcv+0x356/0x4e0
  [<c0414390>] ip_rcv_finish+0x0/0x270
  [<c03e88c7>] netif_receive_skb+0x127/0x190
  [<c036eeac>] rtl8169_rx_vlan_skb+0x15c/0x1a0
  [<c03713a9>] rtl8169_rx_interrupt+0x1e9/0x400
  [<c03716b5>] rtl8169_interrupt+0xf5/0x150
  [<c0156ad7>] vfs_write+0xa7/0x180
  [<c0156c81>] sys_write+0x51/0x80
  [<c01030d5>] syscall_call+0x7/0xb

The server crashed about twice a day.

I tried the following kernels:

2.6.13.1
2.6.13.2
2.6.12.6
(in this order)


The only other change on the server was the usage of vlans since the new 
NIC. I also get dead loop/fix it  messages, but I think those are the 
consequence of the above error...

Any ideas?

Bye
Bgs

