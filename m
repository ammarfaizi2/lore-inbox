Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbUKQLEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbUKQLEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUKQLEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:04:49 -0500
Received: from proxy.quengel.org ([213.146.113.159]:2432 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S262173AbUKQLEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:04:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1 (8139too interrupt) 
References: <20041116014213.2128aca9.akpm@osdl.org>
From: Ralf Gerbig <rge@quengel.org>
Date: Wed, 17 Nov 2004 12:04:21 +0100
In-Reply-To: <20041116014213.2128aca9.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 16 Nov 2004 01:42:13 -0800")
Message-ID: <87lld0rb2i.fsf-news@hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

just found this:

0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:0b.0 Class 0200: 10ec:8139 (rev 10)

19:      12248   IO-APIC-level  ide2, ide3, eth1

 irq 19: nobody cared!
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [<c01388ea>] __report_bad_irq+0x2a/0x90
 [handle_IRQ_event+57/112] handle_IRQ_event+0x39/0x70
 [<c01381a9>] handle_IRQ_event+0x39/0x70
 [note_interrupt+149/192] note_interrupt+0x95/0xc0
 [<c0138a05>] note_interrupt+0x95/0xc0
 [__do_IRQ+357/384] __do_IRQ+0x165/0x180
 [<c0138345>] __do_IRQ+0x165/0x180
 [do_IRQ+71/112] do_IRQ+0x47/0x70
 [<c0105907>] do_IRQ+0x47/0x70
 =======================
 [common_interrupt+26/32] common_interrupt+0x1a/0x20
 [<c0103c52>] common_interrupt+0x1a/0x20
 [default_idle+0/48] default_idle+0x0/0x30
 [<c0101030>] default_idle+0x0/0x30
 [default_idle+35/48] default_idle+0x23/0x30
 [<c0101053>] default_idle+0x23/0x30
 [cpu_idle+54/112] cpu_idle+0x36/0x70
 [<c01010d6>] cpu_idle+0x36/0x70
 [start_kernel+346/384] start_kernel+0x15a/0x180
 [<c042180a>] start_kernel+0x15a/0x180
 [unknown_bootoption+0/480] unknown_bootoption+0x0/0x1e0
 [<c0421380>] unknown_bootoption+0x0/0x1e0
handlers:
[ide_intr+0/496] (ide_intr+0x0/0x1f0)
[<c0269c80>] (ide_intr+0x0/0x1f0)
[ide_intr+0/496] (ide_intr+0x0/0x1f0)
[<c0269c80>] (ide_intr+0x0/0x1f0)
[pg0+541642080/1068946432] (rtl8139_interrupt+0x0/0x1d0 [8139too])
[<e091dd60>] (rtl8139_interrupt+0x0/0x1d0 [8139too])
Disabling IRQ #19

NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timeout, status 0c 0005 c07f media 18.
eth1: Tx queue start entry 63  dirty entry 59.
eth1:  Tx descriptor 0 is 0008a03c.
eth1:  Tx descriptor 1 is 0008a06a.
eth1:  Tx descriptor 2 is 0008a03c.
eth1:  Tx descriptor 3 is 0008a03c. (queue head)
eth1: link up, 10Mbps, full-duplex, lpa 0x4061

and the interface is dead. Rmmod/insmod does not help.

rc1-mm5 works.

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
