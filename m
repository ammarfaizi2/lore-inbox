Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTIIQMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTIIQMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:12:03 -0400
Received: from halon.barra.com ([144.203.11.1]:44527 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S264218AbTIIQL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:11:56 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test5]oops inserting PCMCIA card
Date: Mon, 8 Sep 2003 16:30:19 -0700
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081630.19263.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I insert a PCMCIA card I get the oops cited below. There is no driver for the card so it is not to blame.
when I eject the card afterwards I get an oops in interrupt so it reboots I could not capture the trace.

here is the bridge info:

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 1: 10000000-103ff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

here is the oops: (I get same oops in test4-mm6)

Sep  8 16:05:49 bologoe kernel: Unable to handle kernel paging request at virtual address d08721c0
Sep  8 16:05:49 bologoe kernel:  printing eip:
Sep  8 16:05:49 bologoe kernel: c020b80a
Sep  8 16:05:49 bologoe kernel: *pde = 013ae067
Sep  8 16:05:49 bologoe kernel: *pte = 00000000
Sep  8 16:05:49 bologoe kernel: Oops: 0000 [#1]
Sep  8 16:05:49 bologoe kernel: CPU:    0
Sep  8 16:05:49 bologoe kernel: EIP:    0060:[pci_match_device+10/160]    Not tainted
Sep  8 16:05:49 bologoe kernel: EFLAGS: 00010286
Sep  8 16:05:49 bologoe kernel: EIP is at pci_match_device+0xa/0xa0
Sep  8 16:05:49 bologoe kernel: eax: d08721c0   ebx: cdbf9334   ecx: 00000002   edx: d08721c0
Sep  8 16:05:49 bologoe kernel: esi: d08afe88   edi: cdbf9334   ebp: cdef3e14   esp: cdef3e10
Sep  8 16:05:49 bologoe kernel: ds: 007b   es: 007b   ss: 0068
Sep  8 16:05:49 bologoe kernel: Process pccardd (pid: 765, threadinfo=cdef2000 task=cdd7db40)
Sep  8 16:05:49 bologoe kernel: Stack: d08afe60 cdef3e54 c020c14a d08721c0 cdbf9334 0000006b 000005ed 00000088 
Sep  8 16:05:49 bologoe kernel:        c0202fdf c3cd8d54 d0827b80 00000282 0000002e 0248a870 d08afe88 cdbf9388 
Sep  8 16:05:49 bologoe kernel:        ffffffed cdef3e70 c025a95a cdbf9388 d08afe88 d08afed4 cdbf9388 c037e7f8 
Sep  8 16:05:49 bologoe kernel: Call Trace:
Sep  8 16:05:49 bologoe kernel:  [pci_bus_match+42/816] pci_bus_match+0x2a/0x330
Sep  8 16:05:49 bologoe kernel:  [kset_hotplug+751/960] kset_hotplug+0x2ef/0x3c0
Sep  8 16:05:49 bologoe kernel:  [bus_match+42/112] bus_match+0x2a/0x70
Sep  8 16:05:49 bologoe kernel:  [device_attach+82/176] device_attach+0x52/0xb0
Sep  8 16:05:49 bologoe kernel:  [bus_add_device+117/192] bus_add_device+0x75/0xc0
Sep  8 16:05:49 bologoe kernel:  [device_add+209/272] device_add+0xd1/0x110
Sep  8 16:05:49 bologoe kernel:  [pci_bus_add_devices+583/976] pci_bus_add_devices+0x247/0x3d0
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2481555/2542871] cardbus_assign_irqs+0xc1/0xd0 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2481762/2542871] cb_alloc+0xc0/0x100 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2467213/2542871] socket_setup+0x11b/0x170 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2467471/2542871] socket_insert+0xad/0x150 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2468209/2542871] socket_detect_change+0x4f/0x80 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2468851/2542871] pccardd+0x251/0x320 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Sep  8 16:05:49 bologoe kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Sep  8 16:05:49 bologoe kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Sep  8 16:05:49 bologoe kernel:  [__crc___wait_on_buffer+2468258/2542871] pccardd+0x0/0x320 [pcmcia_core]
Sep  8 16:05:49 bologoe kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Sep  8 16:05:49 bologoe kernel: 
Sep  8 16:05:49 bologoe kernel: Code: 8b 0a 85 c9 74 74 83 f9 ff 74 2e 0f b7 43 24 39 c1 74 26 31 
Sep  8 16:05:49 bologoe pci.agent[1865]: ... no modules for PCI slot 0000:02:00.0
