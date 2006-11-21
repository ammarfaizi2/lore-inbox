Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWKUVqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWKUVqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161401AbWKUVqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:46:40 -0500
Received: from iabervon.org ([66.92.72.58]:51981 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1161390AbWKUVqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:46:38 -0500
Date: Tue, 21 Nov 2006 16:46:37 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18.2: Nobody cared about the millionth sata_nv interrupt
Message-ID: <Pine.LNX.4.64.0611211603270.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
Nobody cared about the millionth sata_nv interrupt

[2.]
Long after boot, I get "irq 209: nobody cared", and my hard drive 
stops working (209 is libata for the hard drive). The third time this 
happened, /proc/interrupts gave exactly 1000000 for the number of 
interrupts; the second time it was also an even value in base 10 (but I 
didn't remember what value) and I missed the first time it happened.

[3.] 
libata, sata_nv, kernel

[4.]
Linux version 2.6.18-gentoo-r2 (root@livecd) (gcc version 4.1.1 (Gentoo 
4.1.1)) #1 Mon Nov 20 19:16:59 EST 2006

(Based on 2.6.18.2)

None of the gentoo patches look at all related, and current -stable 
doesn't look like it would fix anything related.

[5.]
2.6.17 either didn't have this issue or I didn't run it long enough. I'm 
building it now to try more extensively.

[6.]
Call Trace:
 [<ffffffff8020a9ce>] dump_stack+0x12/0x17
 [<ffffffff80240078>] __report_bad_irq+0x30/0x7d
 [<ffffffff8024028b>] note_interrupt+0x1c6/0x207
 [<ffffffff8023f8e7>] __do_IRQ+0x91/0xc5
 [<ffffffff8020bd87>] do_IRQ+0xe7/0xf5
 [<ffffffff80209b31>] ret_from_intr+0x0/0xa
DWARF2 unwinder stuck at ret_from_intr+0x0/0xa
Leftover inexact backtrace:
 <IRQ> [<ffffffff8805ee05>] :forcedeth:nv_nic_irq+0x5d/0x168
 [<ffffffff8805ee23>] :forcedeth:nv_nic_irq+0x7b/0x168
 [<ffffffff8023f827>] handle_IRQ_event+0x29/0x58
 [<ffffffff8023f8ce>] __do_IRQ+0x78/0xc5
 [<ffffffff8020bd87>] do_IRQ+0xe7/0xf5
 [<ffffffff80208884>] default_idle+0x0/0x50
 [<ffffffff80209b31>] ret_from_intr+0x0/0xa
 <EOI> [<ffffffff802088ad>] default_idle+0x29/0x50
 [<ffffffff80208910>] cpu_idle+0x3c/0x5b
 [<ffffffff8058f756>] start_kernel+0x1bd/0x1c2
 [<ffffffff8058f24b>] _sinittext+0x24b/0x24f

handlers:
[<ffffffff803480f1>] (nv_generic_interrupt+0x0/0x97)
Disabling IRQ #209

[7.]
It's crashed three times in a day; the third time I was intentionally 
driving up the hard drive interrupt count, and it crashed before too long. 
Takes too long to bisect too effectively, but I think it'll be 
reproduceable.

[8.]
00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at e400 [size=8]
        Region 1: I/O ports at e080 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at dc00 [size=4]
        Region 4: I/O ports at d880 [size=16]
        Region 5: Memory at dff7c000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>

	-Daniel
*This .sig left intentionally blank*
