Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVCZTji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVCZTji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVCZTji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:39:38 -0500
Received: from zork.zork.net ([64.81.246.102]:18639 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261234AbVCZTjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:39:35 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: PCMCIA Oops (was Re: 2.6.12-rc1-mm3)
References: <20050325002154.335c6b0b.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 26 Mar 2005 19:39:29 +0000
In-Reply-To: <20050325002154.335c6b0b.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 25 Mar 2005 00:21:54 -0800")
Message-ID: <6uu0myyz66.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a PowerBook5.4 I get the below when I insert the PCMCIA card or
boot with it inserted; however, if I boot with no card inserted,
sleep-resume and insert the card it works fine.  Similar with
2.6.12-rc1-mm1; not sure why I didn't notice until now, since I
happily used it for six days or so, PCMCIA and all, although there was
*some* PCMCIA-related issue I failed to note and cannot now recall.


Yenta: CardBus bridge found at 0001:10:13.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0001:10:13.0, mfunc 0x00001002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 53
Socket status: 30000010
pcmcia: I/O behind socket: 0x0 - 0x7fffff
pcmcia: Memory behind socket: 0xf3000000 - 0xf3ffffff
pcmcia: Memory behind socket: 0x80000000 - 0xafffffff
cs: memory probe 0x80000000-0xafffffff:Machine check in kernel mode.
Caused by (from SRR1=149030): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
NIP: F20CEC90 LR: F20CEC64 SP: EF8F3BE0 REGS: ef8f3b30 TRAP: 0200    Not tainted
MSR: 00149030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c12966a0[805] 'modprobe' THREAD: ef8f2000
Last syscall: 128 
GPR00: 00000060 EF8F3BE0 C12966A0 F103C000 00000000 EF8F9880 00000002 EF8F3C5A 
GPR08: C04B6370 F103D000 00000000 00001000 22002488 1001E284 10017070 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 C1225D40 30000000 00000000 
GPR24: EF8F3C5A 00000021 00000002 C12D282C 00000000 00000000 00000002 EF8F3C5A 
NIP [f20cec90] pcmcia_read_cis_mem+0x184/0x1c0 [pcmcia_core]
LR [f20cec64] pcmcia_read_cis_mem+0x158/0x1c0 [pcmcia_core]
Call trace:
 [f20cefa0] read_cis_cache+0x144/0x168 [pcmcia_core]
 [f20cf668] pccard_get_next_tuple+0x7c/0x2a8 [pcmcia_core]
 [f20cf378] pccard_get_first_tuple+0x94/0x144 [pcmcia_core]
 [f20d0fb8] pccard_validate_cis+0x94/0x27c [pcmcia_core]
 [f106e3c8] readable+0x88/0xa8 [rsrc_nonstatic]
 [f106e5a0] cis_readable+0xc8/0xe4 [rsrc_nonstatic]
 [f106e860] do_mem_probe+0x1d0/0x1e8 [rsrc_nonstatic]
 [f106e8b8] validate_mem+0x40/0x68 [rsrc_nonstatic]
 [f106e99c] pcmcia_nonstatic_validate_mem+0xbc/0xc8 [rsrc_nonstatic]
 [f20d134c] pcmcia_validate_mem+0x34/0x38 [pcmcia_core]
 [f20e39b4] pcmcia_card_add+0x28/0xc0 [pcmcia]
 [f20e441c] ds_event+0x8c/0xe4 [pcmcia]
 [f20cda3c] send_event+0x70/0xc8 [pcmcia_core]
 [f20ce52c] pccard_register_pcmcia+0xac/0xcc [pcmcia_core]
 [f20e49b4] pcmcia_bus_add_socket+0xa8/0x104 [pcmcia]


-- 
Dag vijandelijk luchtschip de huismeester is dood
