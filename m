Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTGVKpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbTGVKpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:45:11 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:35739 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S270709AbTGVKo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:44:59 -0400
From: Erik Hensema <erik@hensema.net>
Subject: [2.6.0-test1] Destroying alive neighbour dea4ce00
Date: Tue, 22 Jul 2003 11:00:00 +0000 (UTC)
Message-ID: <slrnbhq69f.1pp.erik@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following oopses/bugs/whatever on a 2.6.0-test1 box running
native ipv6 over ethernet:

Jul 22 11:10:14 bender kernel: Destroying alive neighbour dea4ce00
Jul 22 11:10:14 bender kernel: Call Trace:
Jul 22 11:10:14 bender kernel:  [<c02f8588>] dst_destroy+0xa8/0xc0
Jul 22 11:10:14 bender kernel:  [<c0350eff>] ndisc_dst_gc+0x5f/0x70
Jul 22 11:10:14 bender kernel:  [<c0354720>] fib6_run_gc+0x0/0x120
Jul 22 11:10:14 bender kernel:  [<c0354771>] fib6_run_gc+0x51/0x120
Jul 22 11:10:14 bender kernel:  [<c01254b4>] run_timer_softirq+0xc4/0x1c0
Jul 22 11:10:14 bender kernel:  [<c0121272>] do_softirq+0x62/0xc0
Jul 22 11:10:14 bender kernel:  [<c010b8cd>] do_IRQ+0x11d/0x150
Jul 22 11:10:14 bender kernel:  [<c01070f0>] default_idle+0x0/0x30
Jul 22 11:10:14 bender kernel:  [<c0109cc8>] common_interrupt+0x18/0x20
Jul 22 11:10:14 bender kernel:  [<c01070f0>] default_idle+0x0/0x30
Jul 22 11:10:14 bender kernel:  [<c0107116>] default_idle+0x26/0x30
Jul 22 11:10:14 bender kernel:  [<c0107192>] cpu_idle+0x32/0x50
Jul 22 11:10:14 bender kernel:  [<c0105000>] _stext+0x0/0x60
Jul 22 11:10:14 bender kernel:  [<c04707b9>] start_kernel+0x179/0x1a0
Jul 22 11:10:14 bender kernel:  [<c04704f0>] unknown_bootoption+0x0/0x110

Jul 22 11:11:05 bender kernel: Destroying alive neighbour dea4ce00
Jul 22 11:11:05 bender kernel: Call Trace:
Jul 22 11:11:05 bender kernel:  [<c0358009>] ndisc_recv_na+0x209/0x250
Jul 22 11:11:05 bender kernel:  [<c0358e34>] ndisc_rcv+0x104/0x110
Jul 22 11:11:05 bender kernel:  [<c035ef59>] icmpv6_rcv+0x339/0x500
Jul 22 11:11:05 bender kernel:  [<c0357084>] ndisc_send_ns+0x284/0x440
Jul 22 11:11:05 bender kernel:  [<c0353d46>] fib6_lookup+0x26/0x40
Jul 22 11:11:05 bender kernel:  [<c034a73f>] ip6_input+0xff/0x310
Jul 22 11:11:05 bender kernel:  [<c034a57a>] ipv6_rcv+0x17a/0x240
Jul 22 11:11:05 bender kernel:  [<c036eae2>] packet_rcv_spkt+0x1e2/0x270
Jul 22 11:11:05 bender kernel:  [<c02f5590>] netif_receive_skb+0x1e0/0x200
Jul 22 11:11:05 bender kernel:  [<c02f5625>] process_backlog+0x75/0x100
Jul 22 11:11:05 bender kernel:  [<c02f5767>] net_rx_action+0xb7/0x110
Jul 22 11:11:05 bender kernel:  [<c0121272>] do_softirq+0x62/0xc0
Jul 22 11:11:05 bender kernel:  [<c010b8cd>] do_IRQ+0x11d/0x150
Jul 22 11:11:05 bender kernel:  [<c01070f0>] default_idle+0x0/0x30
Jul 22 11:11:05 bender kernel:  [<c0109cc8>] common_interrupt+0x18/0x20
Jul 22 11:11:05 bender kernel:  [<c01070f0>] default_idle+0x0/0x30
Jul 22 11:11:05 bender kernel:  [<c0107116>] default_idle+0x26/0x30
Jul 22 11:11:05 bender kernel:  [<c0107192>] cpu_idle+0x32/0x50
Jul 22 11:11:05 bender kernel:  [<c0105000>] _stext+0x0/0x60
Jul 22 11:11:05 bender kernel:  [<c04707b9>] start_kernel+0x179/0x1a0
Jul 22 11:11:05 bender kernel:  [<c04704f0>] unknown_bootoption+0x0/0x110

Local IPv6 seems to work, but when I'm trying to get outside my local
segment I get these errors.
-- 
Erik Hensema <erik@hensema.net>
