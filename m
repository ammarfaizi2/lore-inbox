Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUBPTon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUBPTon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:44:43 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:64211 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S265573AbUBPToj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:44:39 -0500
Message-ID: <40311DA3.70308@jburgess.uklinux.net>
Date: Mon, 16 Feb 2004 19:44:36 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2: page allocation failure error from networking code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got 10 copies of the following message about a memory allocation 
failure in what appears to be the networking code. The vdradmind.pl task 
connects to a server running on localhost every 5 minutes. The task 
appeared to freeze after the 10th allocation error (but this could just 
be the userspace not handling the error properly).

This was on a machine running 2.6.2 for several days.

Feb 15 05:10:16 giga vdr[2225]: connect from 127.0.0.1, port 33116 - 
accepted
Feb 15 05:10:16 giga vdr[2225]: closing SVDRP connection
Feb 15 05:15:21 giga vdr[2225]: connect from 127.0.0.1, port 33117 - 
accepted
Feb 15 05:15:21 giga vdr[2225]: closing SVDRP connection
Feb 15 05:20:22 giga kernel: vdradmind.pl: page allocation failure. 
order:1, mode:0x20
Feb 15 05:20:22 giga kernel: Call Trace:
Feb 15 05:20:22 giga kernel:  [<c014a10d>] __alloc_pages+0x2ed/0x34b
Feb 15 05:20:22 giga kernel:  [<c014a18a>] __get_free_pages+0x1f/0x41
Feb 15 05:20:22 giga kernel:  [<c014e6c2>] cache_grow+0x12b/0x496
Feb 15 05:20:22 giga kernel:  [<c014edaa>] cache_alloc_refill+0x37d/0x4f3
Feb 15 05:20:22 giga kernel:  [<c014f623>] kmem_cache_alloc+0x1a7/0x1c7
Feb 15 05:20:22 giga kernel:  [<c03ecca7>] sk_alloc+0x28/0x10d
Feb 15 05:20:22 giga kernel:  [<c042b94d>] 
tcp_create_openreq_child+0x31/0x6c9
Feb 15 05:20:22 giga kernel:  [<c04274c7>] tcp_v4_syn_recv_sock+0x47/0x3a2
Feb 15 05:20:22 giga kernel:  [<c03ee02a>] kfree_skbmem+0x24/0x2c
Feb 15 05:20:22 giga kernel:  [<c042c1a3>] tcp_check_req+0x1be/0x45e
Feb 15 05:20:22 giga kernel:  [<c0427c59>] tcp_v4_do_rcv+0x94/0x11c
Feb 15 05:20:22 giga kernel:  [<c04283bb>] tcp_v4_rcv+0x6da/0x916
Feb 15 05:20:22 giga kernel:  [<c040bb56>] ip_local_deliver+0xda/0x220
Feb 15 05:20:22 giga kernel:  [<c040bf94>] ip_rcv+0x2f8/0x44a
Feb 15 05:20:22 giga kernel:  [<c03f3123>] netif_receive_skb+0x12b/0x161
Feb 15 05:20:22 giga kernel:  [<c03f31ce>] process_backlog+0x75/0xf6
Feb 15 05:20:22 giga kernel:  [<c0112d10>] do_gettimeofday+0x18/0xae
Feb 15 05:20:22 giga kernel:  [<c03f28d5>] dev_queue_xmit+0x324/0x666
Feb 15 05:20:22 giga kernel:  [<c040f63c>] ip_queue_xmit+0x456/0x5a7
Feb 15 05:20:22 giga kernel:  [<c040f63c>] ip_queue_xmit+0x456/0x5a7
Feb 15 05:20:22 giga kernel:  [<c0427884>] tcp_v4_hnd_req+0x62/0x24a
Feb 15 05:20:22 giga kernel:  [<c03ee02a>] kfree_skbmem+0x24/0x2c
Feb 15 05:20:22 giga kernel:  [<c0427c9b>] tcp_v4_do_rcv+0xd6/0x11c
Feb 15 05:20:22 giga kernel:  [<c04283bb>] tcp_v4_rcv+0x6da/0x916
Feb 15 05:20:22 giga kernel:  [<c040bb56>] ip_local_deliver+0xda/0x220
Feb 15 05:20:22 giga kernel:  [<c03ee02a>] kfree_skbmem+0x24/0x2c
Feb 15 05:20:22 giga kernel:  [<c03ee0b4>] __kfree_skb+0x82/0xfa
Feb 15 05:20:22 giga kernel:  [<c040bf94>] ip_rcv+0x2f8/0x44a
Feb 15 05:20:22 giga kernel:  [<c03f3123>] netif_receive_skb+0x12b/0x161
Feb 15 05:20:22 giga kernel:  [<c03f31ce>] process_backlog+0x75/0xf6
Feb 15 05:20:22 giga kernel:  [<c03f32b9>] net_rx_action+0x6a/0xe2
Feb 15 05:20:22 giga kernel:  [<c012a81a>] do_softirq+0x92/0x94
Feb 15 05:20:22 giga kernel:  [<c04378cf>] inet_wait_for_connect+0x84/0xd7
Feb 15 05:20:22 giga kernel:  [<c01221bf>] autoremove_wake_function+0x0/0x4f
Feb 15 05:20:22 giga kernel:  [<c01221bf>] autoremove_wake_function+0x0/0x4f
Feb 15 05:20:22 giga kernel:  [<c04379f7>] inet_stream_connect+0xd5/0x1a1
Feb 15 05:20:22 giga kernel:  [<c03eb202>] sys_connect+0x85/0xb1
Feb 15 05:20:22 giga kernel:  [<c03e9f94>] sock_map_fd+0x113/0x141
Feb 15 05:20:22 giga kernel:  [<c03f3fc6>] dev_ioctl+0x7e/0x338
Feb 15 05:20:22 giga kernel:  [<c0437f96>] inet_ioctl+0xfa/0x10a
Feb 15 05:20:22 giga kernel:  [<c03ebd97>] sys_socketcall+0xe2/0x2ac
Feb 15 05:20:22 giga kernel:  [<c018369e>] sys_fcntl64+0x57/0x95
Feb 15 05:20:22 giga kernel:  [<c010b3f1>] sysenter_past_esp+0x52/0x71
Feb 15 05:20:22 giga kernel:

Feb 15 05:20:26 giga kernel: vdradmind.pl: page allocation failure. 
order:1, mode:0x20
Feb 15 05:20:26 giga kernel: Call Trace:
Feb 15 05:20:26 giga kernel:  [<c014a10d>] __alloc_pages+0x2ed/0x34b
Feb 15 05:20:26 giga kernel:  [<c014a18a>] __get_free_pages+0x1f/0x41
Feb 15 05:20:26 giga kernel:  [<c014e6c2>] cache_grow+0x12b/0x496
Feb 15 05:20:26 giga kernel:  [<c012fbf0>] do_timer+0xdf/0xe4
Feb 15 05:20:26 giga kernel:  [<c014edaa>] cache_alloc_refill+0x37d/0x4f3
Feb 15 05:20:26 giga kernel:  [<c014f623>] kmem_cache_alloc+0x1a7/0x1c7
Feb 15 05:20:26 giga kernel:  [<c03ecca7>] sk_alloc+0x28/0x10d
Feb 15 05:20:26 giga kernel:  [<c042b94d>] 
tcp_create_openreq_child+0x31/0x6c9
Feb 15 05:20:26 giga kernel:  [<c04274c7>] tcp_v4_syn_recv_sock+0x47/0x3a2
Feb 15 05:20:26 giga kernel:  [<c042b94d>] 
tcp_create_openreq_child+0x31/0x6c9
Feb 15 05:20:26 giga kernel:  [<c042c1a3>] tcp_check_req+0x1be/0x45e
Feb 15 05:20:26 giga kernel:  [<c04274c7>] tcp_v4_syn_recv_sock+0x47/0x3a2
Feb 15 05:20:26 giga kernel:  [<c03ee02a>] kfree_skbmem+0x24/0x2c
Feb 15 05:20:26 giga kernel:  [<c042c1a3>] tcp_check_req+0x1be/0x45e
Feb 15 05:20:26 giga kernel:  [<c0427c59>] tcp_v4_do_rcv+0x94/0x11c
Feb 15 05:20:26 giga kernel:  [<c04283bb>] tcp_v4_rcv+0x6da/0x916
Feb 15 05:20:26 giga kernel:  [<c040bb56>] ip_local_deliver+0xda/0x220
Feb 15 05:20:26 giga kernel:  [<c040bf94>] ip_rcv+0x2f8/0x44a
Feb 15 05:20:26 giga kernel:  [<c03f3123>] netif_receive_skb+0x12b/0x161
Feb 15 05:20:26 giga kernel:  [<c03f31ce>] process_backlog+0x75/0xf6
Feb 15 05:20:26 giga kernel:  [<c0112d10>] do_gettimeofday+0x18/0xae
Feb 15 05:20:26 giga kernel:  [<c03f28d5>] dev_queue_xmit+0x324/0x666
Feb 15 05:20:26 giga kernel:  [<c040eea8>] ip_finish_output+0xb9/0x1e2
Feb 15 05:20:26 giga kernel:  [<c0427884>] tcp_v4_hnd_req+0x62/0x24a
Feb 15 05:20:26 giga kernel:  [<c0427c9b>] tcp_v4_do_rcv+0xd6/0x11c
Feb 15 05:20:26 giga kernel:  [<c04283bb>] tcp_v4_rcv+0x6da/0x916
Feb 15 05:20:26 giga kernel:  [<c011e18a>] recalc_task_prio+0x90/0x1aa
Feb 15 05:20:26 giga kernel:  [<c040bb56>] ip_local_deliver+0xda/0x220
Feb 15 05:20:26 giga kernel:  [<c042695d>] tcp_v4_send_check+0x54/0xf4
Feb 15 05:20:26 giga kernel:  [<c040bf94>] ip_rcv+0x2f8/0x44a
Feb 15 05:20:26 giga kernel:  [<c03f3123>] netif_receive_skb+0x12b/0x161
Feb 15 05:20:26 giga kernel:  [<c03f31ce>] process_backlog+0x75/0xf6
Feb 15 05:20:26 giga kernel:  [<c03f32b9>] net_rx_action+0x6a/0xe2
Feb 15 05:20:26 giga kernel:  [<c012a81a>] do_softirq+0x92/0x94
Feb 15 05:20:26 giga kernel:  [<c0416c08>] tcp_prequeue_process+0x78/0x86
Feb 15 05:20:26 giga kernel:  [<c041713c>] tcp_recvmsg+0x373/0x741
Feb 15 05:20:26 giga kernel:  [<c0437c6d>] inet_recvmsg+0x5a/0x75
Feb 15 05:20:26 giga kernel:  [<c03ea35b>] sock_aio_read+0xb8/0xd0
Feb 15 05:20:26 giga kernel:  [<c016c35b>] do_sync_read+0x8b/0xb7
Feb 15 05:20:26 giga kernel:  [<c03eb20e>] sys_connect+0x91/0xb1
Feb 15 05:20:26 giga kernel:  [<c0437f96>] inet_ioctl+0xfa/0x10a
Feb 15 05:20:26 giga kernel:  [<c016c46f>] vfs_read+0xe8/0x119
Feb 15 05:20:26 giga kernel:  [<c016c6b2>] sys_read+0x42/0x63
Feb 15 05:20:26 giga kernel:  [<c010b3f1>] sysenter_past_esp+0x52/0x71
Feb 15 05:20:26 giga kernel:

