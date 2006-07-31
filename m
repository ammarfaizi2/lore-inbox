Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWGaMBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGaMBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGaMBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:01:44 -0400
Received: from pc1.pod.cz ([213.155.227.146]:6378 "EHLO pc11.op.pod.cz")
	by vger.kernel.org with ESMTP id S1750786AbWGaMBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:01:43 -0400
Date: Mon, 31 Jul 2006 14:01:42 +0200
From: Vitezslav Samel <samel@mail.cz>
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at net/core/dev.c
Message-ID: <20060731120142.GB3292@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  After booting 2.6.18-rc3 these messages appeared in kernel log:

Jul 31 10:57:17 fw kernel: BUG: warning at net/core/dev.c:1171/skb_checksum_help()
Jul 31 10:57:17 fw kernel:  [<c025ec4c>] skb_checksum_help+0x159/0x15b
Jul 31 10:57:17 fw kernel:  [<c02afb93>] ip_nat_fn+0x1a7/0x23e
Jul 31 10:57:17 fw kernel:  [<c02af56b>] ipt_local_hook+0xac/0x115
Jul 31 10:57:17 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:17 fw kernel:  [<c02afd9a>] ip_nat_local_fn+0x65/0xd5
Jul 31 10:57:17 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:17 fw kernel:  [<c026e8fe>] nf_iterate+0x58/0x84
Jul 31 10:57:17 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:17 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:17 fw kernel:  [<c026e995>] nf_hook_slow+0x6b/0x102
Jul 31 10:57:17 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:17 fw kernel:  [<c0279290>] ip_queue_xmit+0x408/0x4f3
Jul 31 10:57:17 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:17 fw kernel:  [<c01b781f>] as_dispatch_request+0x196/0x37d
Jul 31 10:57:17 fw kernel:  [<c01aedd2>] elv_next_request+0x10e/0x184
Jul 31 10:57:17 fw kernel:  [<c02139c3>] start_io+0x9f/0x124
Jul 31 10:57:17 fw kernel:  [<c0213cb3>] do_cciss_request+0x26b/0x2f5
Jul 31 10:57:17 fw kernel:  [<c02ac2d5>] tcp_manip_pkt+0x109/0x128
Jul 31 10:57:17 fw kernel:  [<c028a02b>] tcp_transmit_skb+0x282/0x47f
Jul 31 10:57:17 fw kernel:  [<c028af5a>] tso_fragment+0x13f/0x1f4
Jul 31 10:57:17 fw kernel:  [<c028b7dc>] tcp_write_xmit+0x1a2/0x2aa
Jul 31 10:57:17 fw kernel:  [<c028b919>] __tcp_push_pending_frames+0x35/0xa2
Jul 31 10:57:17 fw kernel:  [<c0288725>] tcp_rcv_established+0x3fc/0x73b
Jul 31 10:57:17 fw kernel:  [<c02905b3>] tcp_v4_do_rcv+0xd7/0xd9
Jul 31 10:57:17 fw kernel:  [<c0290bd6>] tcp_v4_rcv+0x621/0x77e
Jul 31 10:57:17 fw kernel:  [<c02755c5>] ip_local_deliver+0x8f/0x1da
Jul 31 10:57:17 fw kernel:  [<c0275710>] ip_local_deliver_finish+0x0/0x124
Jul 31 10:57:18 fw kernel:  [<c0275a62>] ip_rcv+0x22e/0x481
Jul 31 10:57:18 fw kernel:  [<c0275cb5>] ip_rcv_finish+0x0/0x227
Jul 31 10:57:18 fw kernel:  [<c025e8a0>] __net_timestamp+0x14/0x27
Jul 31 10:57:18 fw kernel:  [<c025f50d>] netif_receive_skb+0x1a1/0x1a9
Jul 31 10:57:18 fw kernel:  [<c021a72a>] e1000_clean_rx_irq+0x1bd/0x569
Jul 31 10:57:18 fw kernel:  [<c021a1d1>] e1000_clean+0x70/0x10a
Jul 31 10:57:18 fw kernel:  [<c025f675>] net_rx_action+0x6a/0xe0
Jul 31 10:57:18 fw kernel:  [<c011af07>] __do_softirq+0x40/0x8e
Jul 31 10:57:18 fw kernel:  [<c011af7c>] do_softirq+0x27/0x29
Jul 31 10:57:18 fw kernel:  [<c0105026>] do_IRQ+0x36/0x69
Jul 31 10:57:18 fw kernel:  [<c0103492>] common_interrupt+0x1a/0x20

and

Jul 31 10:57:18 fw kernel: BUG: warning at net/core/dev.c:1225/skb_gso_segment()
Jul 31 10:57:18 fw kernel:  [<c025ee15>] skb_gso_segment+0x1c7/0x1cc
Jul 31 10:57:18 fw kernel:  [<c025eea7>] dev_gso_segment+0x1a/0x41
Jul 31 10:57:18 fw kernel:  [<c025ef47>] dev_hard_start_xmit+0x79/0xf7
Jul 31 10:57:18 fw kernel:  [<c026a34c>] __qdisc_run+0x84/0x156
Jul 31 10:57:18 fw kernel:  [<c025f1b9>] dev_queue_xmit+0x1f4/0x20d
Jul 31 10:57:18 fw kernel:  [<c0278d5d>] ip_output+0x120/0x24b
Jul 31 10:57:18 fw kernel:  [<c0278a81>] ip_finish_output+0x0/0x1bc
Jul 31 10:57:18 fw kernel:  [<c02792a9>] ip_queue_xmit+0x421/0x4f3
Jul 31 10:57:18 fw kernel:  [<c0278535>] dst_output+0x0/0xc
Jul 31 10:57:18 fw kernel:  [<c01b781f>] as_dispatch_request+0x196/0x37d
Jul 31 10:57:18 fw kernel:  [<c01aedd2>] elv_next_request+0x10e/0x184
Jul 31 10:57:18 fw kernel:  [<c02139c3>] start_io+0x9f/0x124
Jul 31 10:57:18 fw kernel:  [<c0213cb3>] do_cciss_request+0x26b/0x2f5
Jul 31 10:57:18 fw kernel:  [<c02ac2d5>] tcp_manip_pkt+0x109/0x128
Jul 31 10:57:18 fw kernel:  [<c028a02b>] tcp_transmit_skb+0x282/0x47f
Jul 31 10:57:18 fw kernel:  [<c028af5a>] tso_fragment+0x13f/0x1f4
Jul 31 10:57:18 fw kernel:  [<c028b7dc>] tcp_write_xmit+0x1a2/0x2aa
Jul 31 10:57:18 fw kernel:  [<c028b919>] __tcp_push_pending_frames+0x35/0xa2
Jul 31 10:57:18 fw kernel:  [<c0288725>] tcp_rcv_established+0x3fc/0x73b
Jul 31 10:57:18 fw kernel:  [<c02905b3>] tcp_v4_do_rcv+0xd7/0xd9
Jul 31 10:57:18 fw kernel:  [<c0290bd6>] tcp_v4_rcv+0x621/0x77e
Jul 31 10:57:18 fw kernel:  [<c02755c5>] ip_local_deliver+0x8f/0x1da
Jul 31 10:57:18 fw kernel:  [<c0275710>] ip_local_deliver_finish+0x0/0x124
Jul 31 10:57:18 fw kernel:  [<c0275a62>] ip_rcv+0x22e/0x481
Jul 31 10:57:18 fw kernel:  [<c0275cb5>] ip_rcv_finish+0x0/0x227
Jul 31 10:57:18 fw kernel:  [<c025e8a0>] __net_timestamp+0x14/0x27
Jul 31 10:57:18 fw kernel:  [<c025f50d>] netif_receive_skb+0x1a1/0x1a9
Jul 31 10:57:18 fw kernel:  [<c021a72a>] e1000_clean_rx_irq+0x1bd/0x569
Jul 31 10:57:18 fw kernel:  [<c021a1d1>] e1000_clean+0x70/0x10a
Jul 31 10:57:18 fw kernel:  [<c025f675>] net_rx_action+0x6a/0xe0
Jul 31 10:57:18 fw kernel:  [<c011af07>] __do_softirq+0x40/0x8e
Jul 31 10:57:19 fw kernel:  [<c011af7c>] do_softirq+0x27/0x29
Jul 31 10:57:19 fw kernel:  [<c0105026>] do_IRQ+0x36/0x69
Jul 31 10:57:19 fw kernel:  [<c0103492>] common_interrupt+0x1a/0x20


The machine seems to work fine, but messages are somewhat odd.
System is HP DL380g4 with two 2port e1000 NICs and SCSI discs
on cciss controller.

  Are these messages OK ?


	Thanks,
		Vita
