Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUH3NtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUH3NtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUH3NtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:49:22 -0400
Received: from gepard.lm.pl ([212.244.46.42]:25764 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S268090AbUH3NpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:45:25 -0400
Subject: Re: 2.6.9-rc1-mm1 kjournald: page allocation failure. order:1,
	mode:0x20
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040829160257.3b881fef.akpm@osdl.org>
References: <1093794970.1751.10.camel@rakieeta>
	 <20040829160257.3b881fef.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-TTIrFusoJekk5hb1t1It"
Organization: o2.pl Sp z o.o.
Message-Id: <1093873432.1786.16.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Aug 2004 15:43:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TTIrFusoJekk5hb1t1It
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

W li¶cie z pon, 30-08-2004, godz. 01:02, Andrew Morton pisze: 
> Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
> >
> > after creating several GB of data in small files on the SMP highmem box
> >  the
> > 
> >  kjournald: page allocation failure. order:1, mode:0x20
> > 
> > 
> >  start flooding the logs, load goes to sth around 1k, writing processes
> >  get stuck in D state and the system needs hard reset.
> > 
> >  Anyone else is experiencing that kind of problems?
> > 
> >  Im running sw raid1 on that box, not preemtible kernel.
> 
> There should have been a stack trace as well.  Please send it.
> 

this time there is an attachement.
Sadly I don't have the stack for kjournald process however I have
similiar traces, please see the attached file. 2.6.9-rc1-mm1 SMP,
highmem.

Hope that can give you some more information.

Krzysztof

--=-TTIrFusoJekk5hb1t1It
Content-Disposition: attachment; filename=2.6.9-rc1-mm1bug
Content-Type: text/plain; name=2.6.9-rc1-mm1bug; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

swapper: page allocation failure. order:2, mode:0x20
 [<c0133b1f>] __alloc_pages+0x21a/0x3d3
 [<c0133cfd>] __get_free_pages+0x25/0x3f
 [<c01370be>] kmem_getpages+0x21/0xcd
 [<c0137c2c>] alloc_slabmgmt+0x55/0x60
 [<c0137dab>] cache_grow+0xa7/0x148
 [<c0137f1b>] cache_alloc_refill+0xcf/0x219
 [<c013842f>] __kmalloc+0x73/0x7a
 [<c0244a75>] pskb_expand_head+0x51/0x123
 [<c02910e1>] tcp_in_window+0x46d/0x472
 [<c0249536>] skb_checksum_help+0x103/0x114
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c0294f90>] ip_nat_fn+0x224/0x235
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c0294c7f>] ipt_route_hook+0x37/0x3b
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c0252dfd>] nf_iterate+0x71/0xa5
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c02530c6>] nf_hook_slow+0x6b/0xf9
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c0260782>] dst_output+0x0/0x29
 [<c025e30d>] ip_finish_output+0x1f8/0x1fd
 [<c02607ab>] ip_finish_output2+0x0/0x1a4
 [<c0260782>] dst_output+0x0/0x29
 [<c0260796>] dst_output+0x14/0x29
 [<c025311f>] nf_hook_slow+0xc4/0xf9
 [<c0260782>] dst_output+0x0/0x29
 [<c025ea18>] ip_queue_xmit+0x4e5/0x5e4
 [<c0260782>] dst_output+0x0/0x29
 [<c0137c2c>] alloc_slabmgmt+0x55/0x60
 [<c0137df7>] cache_grow+0xf3/0x148
 [<c0137f1b>] cache_alloc_refill+0xcf/0x219
 [<c026ef42>] tcp_transmit_skb+0x423/0x6ce
 [<c026faa1>] tcp_write_xmit+0x189/0x2d5
 [<c026cdd5>] __tcp_data_snd_check+0xdd/0xec
 [<c026d672>] tcp_rcv_established+0x49f/0x906
 [<c02761d3>] tcp_v4_do_rcv+0x139/0x13e
 [<c0276787>] tcp_v4_rcv+0x5af/0x80a
 [<c025008f>] .text.lock.neighbour+0xca/0x16b
 [<c0294bcf>] ipt_hook+0x37/0x3b
 [<c025b566>] ip_local_deliver_finish+0x0/0x161
 [<c025b608>] ip_local_deliver_finish+0xa2/0x161
 [<c025b566>] ip_local_deliver_finish+0x0/0x161
 [<c025311f>] nf_hook_slow+0xc4/0xf9
 [<c025b566>] ip_local_deliver_finish+0x0/0x161
 [<c025b6c7>] ip_rcv_finish+0x0/0x251
 [<c025b081>] ip_local_deliver+0x1b7/0x1d5
 [<c025b566>] ip_local_deliver_finish+0x0/0x161
 [<c025b8a4>] ip_rcv_finish+0x1dd/0x251
 [<c025b6c7>] ip_rcv_finish+0x0/0x251
 [<c025311f>] nf_hook_slow+0xc4/0xf9
 [<c025b6c7>] ip_rcv_finish+0x0/0x251
 [<c025b49a>] ip_rcv+0x3fb/0x4c7
 [<c025b6c7>] ip_rcv_finish+0x0/0x251
 [<c0249d7f>] netif_receive_skb+0x12d/0x190
 [<c01f200f>] e1000_clean_rx_irq+0x13f/0x470
 [<c02444d4>] __kfree_skb+0x6f/0xe4
 [<c01f1c19>] e1000_clean+0x51/0xe9
 [<c0249f9d>] net_rx_action+0x7a/0x120
 [<c011dfde>] __do_softirq+0xba/0xc9
 [<c0107649>] do_softirq+0x4c/0x5b
 =======================
 [<c0106dd9>] do_IRQ+0x158/0x193
 [<c010207e>] default_idle+0x0/0x2d
 [<c0104a2c>] common_interrupt+0x18/0x20
 [<c010207e>] default_idle+0x0/0x2d
 [<c01020a8>] default_idle+0x2a/0x2d
 [<c010211c>] cpu_idle+0x37/0x40
 [<c031f9d7>] start_kernel+0x16a/0x183
 [<c031f4a0>] unknown_bootoption+0x0/0x16f
RAID1 conf printout:
 --- wd:2 rd:2
 disk 0, wo:0, o:1, dev:sdn1
 disk 1, wo:0, o:1, dev:sdv1
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
printk: 41 messages suppressed.
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
printk: 98 messages suppressed.
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
printk: 170 messages suppressed.
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
printk: 273 messages suppressed.
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace
printk: 161 messages suppressed.
mazakd: page allocation failure. order:1, mode:0x20
Stack pointer is garbage, not printing trace

--=-TTIrFusoJekk5hb1t1It--

