Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTECLix (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 07:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTECLix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 07:38:53 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:31735
	"EHLO flat") by vger.kernel.org with ESMTP id S263293AbTECLiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 07:38:51 -0400
Date: Sat, 3 May 2003 12:52:04 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm4
Message-ID: <20030503115204.GA822@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

2.5.68-mm4 fixes APM suspend on my Vaio (problem reported with 2.5.68-mm2) but
my PCMCIA ethernet is still broken after suspend and requires ifconfig eth0
down; cardctl eject; cardctl insert before it will come to life (it took two
goes at that the first time, only one the second)

As before, I get thousands of "eth0: command 0x5800 did not complete!" after
resume, and I got the following backtrace after resume (possibly triggered by
the cardctl commands).

As before, Sony Vaio, pre-empt, APM, combined ethernet/modem PCMCIA using
3c574_cs.

Any more info required?

Charlie

irq 11: nobody cared!
Call Trace:
 [<c010b640>] handle_IRQ_event+0x90/0x100
 [<c010b897>] do_IRQ+0x97/0x120
 [<c0109c68>] common_interrupt+0x18/0x20
 [<c01ab1e3>] pci_bus_write_config_word+0x73/0x90
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c88a7890>] dead_socket+0x0/0xc [pcmcia_core]
 [<c882984a>] yenta_set_socket+0xba/0x1b0 [yenta_socket]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c882a027>] yenta_clear_maps+0x57/0x90 [yenta_socket]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c88a7890>] dead_socket+0x0/0xc [pcmcia_core]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c882a20b>] yenta_init+0x1b/0x30 [yenta_socket]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c882aa70>] ricoh_init+0x10/0xe0 [yenta_socket]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c8829036>] +0x36/0x40 [yenta_socket]
 [<c882c180>] +0x0/0x840 [yenta_socket]
 [<c889dada>] init_socket+0x2a/0x30 [pcmcia_core]
 [<c889df25>] shutdown_socket+0x15/0x100 [pcmcia_core]
 [<c889e16a>] socket_shutdown+0x4a/0x60 [pcmcia_core]
 [<c889e47a>] socket_insert+0x7a/0x80 [pcmcia_core]
 [<c889da1a>] get_socket_status+0x1a/0x20 [pcmcia_core]
 [<c889e6ad>] pccardd+0x13d/0x1f0 [pcmcia_core]
 [<c0119df0>] default_wake_function+0x0/0x20
 [<c01091d2>] ret_from_fork+0x6/0x14
 [<c0119df0>] default_wake_function+0x0/0x20
 [<c889e570>] pccardd+0x0/0x1f0 [pcmcia_core]
 [<c010722d>] kernel_thread_helper+0x5/0x18

handlers:
[<c8862410>] (el3_interrupt+0x0/0x260 [3c574_cs])

