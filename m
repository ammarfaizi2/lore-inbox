Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUAIQ6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUAIQ6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:58:09 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:43477 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262129AbUAIQ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:58:01 -0500
Date: Fri, 09 Jan 2004 08:57:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: altugoz2003@libero.it
Subject: [Bug 1821] New: Debug: sleeping function called from	invalid context at mm/slab.c:1856 
Message-ID: <13730000.1073667476@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1821

           Summary: Debug: sleeping function called from invalid context at
                    mm/slab.c:1856
    Kernel Version: 2.6.1
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: altugoz2003@libero.it


Distribution: Slackware-9.1
Hardware Environment: Compaq Presario 908EA
Software Environment:
Problem Description:

I'm using cdc_acm module to connect my Motorola cellular phone for a GPRS
connection. after the connection is established and i try to exchange data,
i keep getting the following call trace it dmesg:


Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01220f1>] __might_sleep+0x91/0xa0
 [<c01455af>] __kmalloc+0x8f/0xa0
 [<d0898991>] ohci_urb_enqueue+0xc1/0x290 [ohci_hcd]
 [<c02e2237>] hcd_submit_urb+0xe7/0x150
 [<c02e2bc6>] usb_submit_urb+0x1c6/0x250
 [<d08e15c0>] acm_tty_write+0xb0/0x150 [cdc_acm]
 [<d08e8c29>] ppp_async_push+0xe9/0x160 [ppp_async]
 [<d08e8b2f>] ppp_async_send+0x3f/0x50 [ppp_async]
 [<d08f2952>] ppp_push+0x82/0xd0 [ppp_generic]
 [<d08f25f9>] ppp_send_frame+0x269/0x540 [ppp_generic]
 [<d08f1f07>] ppp_start_xmit+0xf7/0x270 [ppp_generic]
 [<d08f232f>] ppp_xmit_process+0x7f/0xe0 [ppp_generic]
 [<d08f1f07>] ppp_start_xmit+0xf7/0x270 [ppp_generic]
 [<c035b6d3>] qdisc_restart+0x53/0xe0
 [<c034f9e5>] dev_queue_xmit+0x165/0x200
 [<c036a79f>] ip_finish_output2+0xff/0x1e0
 [<c035a085>] nf_hook_slow+0xf5/0x170
 [<c036a6a0>] ip_finish_output2+0x0/0x1e0
 [<c03684fc>] ip_finish_output+0x4c/0x50
 [<c036a6a0>] ip_finish_output2+0x0/0x1e0
 [<c036a685>] dst_output+0x15/0x30
 [<c035a085>] nf_hook_slow+0xf5/0x170
 [<c036a670>] dst_output+0x0/0x30
 [<c0368afc>] ip_queue_xmit+0x40c/0x520
 [<c036a670>] dst_output+0x0/0x30
 [<c012b86d>] update_wall_time+0xd/0x40
 [<c012bc7e>] do_timer+0xde/0xf0
 [<c01110fb>] timer_interrupt+0x3b/0xf0
 [<c010d2db>] handle_IRQ_event+0x3b/0x70
 [<c010d60a>] do_IRQ+0x9a/0xf0
 [<c010bb98>] common_interrupt+0x18/0x20
 [<c037e51d>] tcp_v4_send_check+0x4d/0xd0
 [<c037857e>] tcp_transmit_skb+0x39e/0x590
 [<c037b042>] tcp_send_ack+0x82/0xd0
 [<c03770f7>] tcp_rcv_established+0x5c7/0x710
 [<c037f750>] tcp_v4_do_rcv+0x110/0x120
 [<c037fd80>] tcp_v4_rcv+0x620/0x840
 [<c0365b65>] ip_local_deliver_finish+0xd5/0x1d0
 [<c0365a90>] ip_local_deliver_finish+0x0/0x1d0
 [<c035a085>] nf_hook_slow+0xf5/0x170
 [<c0365a90>] ip_local_deliver_finish+0x0/0x1d0
 [<c036586b>] ip_local_deliver+0x5b/0x60
 [<c0365a90>] ip_local_deliver_finish+0x0/0x1d0
 [<c0365e4c>] ip_rcv_finish+0x1ec/0x260
 [<c035a085>] nf_hook_slow+0xf5/0x170
 [<c0365c60>] ip_rcv_finish+0x0/0x260
 [<c03659d6>] ip_rcv+0x166/0x220
 [<c0365c60>] ip_rcv_finish+0x0/0x260
 [<c034fe97>] netif_receive_skb+0x187/0x1f0
 [<c034ff75>] process_backlog+0x75/0x100
 [<c035006a>] net_rx_action+0x6a/0xf0
 [<c0127996>] do_softirq+0x96/0xa0
 [<c010d645>] do_IRQ+0xd5/0xf0
 [<c0105000>] _stext+0x0/0x30
 [<c010bb98>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x30
 [<c0109066>] default_idle+0x26/0x30
 [<c01090e4>] cpu_idle+0x34/0x40
 [<c04d473f>] start_kernel+0x15f/0x190
 [<c04d44a0>] unknown_bootoption+0x0/0x100

which fill up my logs. Everything else, including my connection seems to work fine.

Steps to reproduce:

connect the phone, load the cdc_acm module and establish a ppp connection. the
messages appear as soon as there is some data exchange


