Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTJ0Uwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTJ0Uwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:52:39 -0500
Received: from platane.lps.ens.fr ([129.199.121.28]:41869 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S263578AbTJ0Uwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:52:36 -0500
Date: Mon, 27 Oct 2003 21:52:35 +0100
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: test9, complete lockup, ipchains related
Message-ID: <20031027205235.GA18206@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following setup on my PIV computer, shuttle motherboard,
2.6.0-test9 kernel:

eth1 is a RTL-8029 and connects me to the outside world
eth0 is a RT8139 and is where I plug my laptop.

Using ipchains, I masqerade the laptop, so that it can also access the
outside world.

The problem is that my computer locks up when I try to do a big backup
with rsync over ssh from the laptop to a computer in the outside world.
No mouse, no keyboard, nothing in the logs.

I couldn't reproduce it with some scp from the laptop to a computer over
the outside world. I don't know what is so special with rsync.

I couldn't reproduce it with a rsync from the laptop to my computer. That
is why I think it is ipchains related.

Everything is working fine with kernels -test1 and -test4. The lockup is
already present in -test8 and, I think, -test7 (need to check that).

Once I constated the problem with a complete boot (X11, kde, many
services), I have reproduced them in booting in single user mode, with no
more operations than ifup'ing eth0, eth1, loading ipchains and setting
the one single rule (masqerading) I need.

ONCE, I got some kernel trace spit out on the console before the computer
locked. Unfortunately, I only got the 24 last lines. I tried to obtain
another trace in a 80x60 vga mode, but failed. Here is the trace, hand
copied:

	ip_rcv_finish +0x1c5/0x22c
	ip_rcv_finish +0x0/0x22c
	nf_hook_slow +0xd4/0x122
	ip_rcv_finish +0x0/0x22c
	ip_rcv +0x3c5/0x480
	ip_rcv_finish +0x0/0x22c
	netif_receive_skb +0x12b/0x164
	process_backlog +0x6e/0xfd
	net_rx_action +0x6a/0xe4
	do_softirq +0x95/0x97
	do_IRQ +0xca/0xe5
	default_idle +0x0/0x27
	rest_init +0x0/0x27
	common_interrupt +0x18/0x20
	default_idle +0x0/0x27
	rest_init +0x0/0x27
	default_idle +0x24/0x27
	cpu_idle +0x2e/0x37
	start_kernel +0x163/0x191
	unknown_bootoption +0x0/0xff
Code 8b 53 08 0f b7 47 0e 31 f6 66 39 42 1e 74 1f 85 f6 75 07 a1
	Kernel panic: Fatal exception in interrupt
	In interrupt handler - not syncing

.config, dmesg, lspci, etc. available on
http://perso.nerim.net/~tudia/bug-reports


Regards,

	Éric Brunet
