Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUDECHC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 22:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbUDECHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 22:07:02 -0400
Received: from [202.28.93.1] ([202.28.93.1]:60942 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S262941AbUDECG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 22:06:56 -0400
Date: Mon, 5 Apr 2004 09:06:59 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040405090659.2c084243.kitt@gear.kku.ac.th>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use 2.6.5 on Acer TravelMate 361 Evi. It has built-in orinoco card hardwired to a cardbus controller.  lspci reports three cardbus controller on my notebook:
 
01:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
        Subsystem: Lucent Technologies: Unknown device ab01
        Flags: medium devsel, IRQ 10
        Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        16-bit legacy interface ports at 0001
 
01:09.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 02)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1022
        Flags: stepping, slow devsel, IRQ 11
        Memory at 10002000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001
 
01:09.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 02)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1022
        Flags: stepping, slow devsel, IRQ 11
        Memory at 10003000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=0a, subordinate=0d, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

When I start pcmcia service I got this messages:

Apr  5 06:23:24 peorth kernel: Linux Kernel Card Services
Apr  5 06:23:24 peorth kernel:   options:  [pci] [cardbus] [pm]
Apr  5 06:23:24 peorth kernel: PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
Apr  5 06:23:24 peorth kernel: Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
Apr  5 06:23:24 peorth kernel: Yenta: Enabling burst memory read transactions
Apr  5 06:23:24 peorth kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Apr  5 06:23:24 peorth kernel: Yenta: Routing CardBus interrupts to PCI
Apr  5 06:23:25 peorth kernel: Yenta: ISA IRQ mask 0x0000, PCI irq 10
Apr  5 06:23:25 peorth kernel: Socket status: 30000011
Apr  5 06:23:25 peorth kernel: Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
Apr  5 06:23:27 peorth kernel: irq 10: nobody cared!
Apr  5 06:23:27 peorth kernel: Call Trace:
Apr  5 06:23:27 peorth kernel:  [<c0108eca>] __report_bad_irq+0x2a/0x90
Apr  5 06:23:27 peorth kernel:  [<c0108fc0>] note_interrupt+0x70/0xb0
Apr  5 06:23:27 peorth kernel:  [<c0109270>] do_IRQ+0x120/0x130
Apr  5 06:23:27 peorth kernel:  [<c0107618>] common_interrupt+0x18/0x20
Apr  5 06:23:27 peorth kernel:  [<c01217ee>] do_softirq+0x3e/0xa0
Apr  5 06:23:27 peorth kernel:  [<c010924a>] do_IRQ+0xfa/0x130
Apr  5 06:23:27 peorth kernel:  [<c0107618>] common_interrupt+0x18/0x20
Apr  5 06:23:27 peorth kernel:  [<c0113286>] delay_pmtmr+0x16/0x20
Apr  5 06:23:27 peorth kernel:  [<c01cf512>] __delay+0x12/0x20
Apr  5 06:23:27 peorth kernel:  [<d0da29fe>] yenta_probe_irq+0xfe/0x140 [yenta_socket]
Apr  5 06:23:27 peorth kernel:  [<d0da2a7a>] yenta_get_socket_capabilities+0x3a/0x70 [yenta_socket]
Apr  5 06:23:27 peorth kernel:  [<d0da2dc7>] yenta_probe+0x1a7/0x240 [yenta_socket]
Apr  5 06:23:27 peorth kernel:  [<c01d3712>] pci_device_probe_static+0x52/0x70
Apr  5 06:23:27 peorth kernel:  [<c01d376c>] __pci_device_probe+0x3c/0x50
Apr  5 06:23:27 peorth kernel:  [<c01d37ac>] pci_device_probe+0x2c/0x50
Apr  5 06:23:27 peorth kernel:  [<c0232b1f>] bus_match+0x3f/0x70
Apr  5 06:23:27 peorth kernel:  [<c0232c4c>] driver_attach+0x5c/0xa0
Apr  5 06:23:27 peorth kernel:  [<c0232f78>] bus_add_driver+0xa8/0xc0
Apr  5 06:23:27 peorth kernel:  [<c02333cf>] driver_register+0x2f/0x40
Apr  5 06:23:27 peorth kernel:  [<c01d399c>] pci_register_driver+0x5c/0x90
Apr  5 06:23:27 peorth kernel:  [<d0d9400f>] yenta_socket_init+0xf/0x11 [yenta_socket]
Apr  5 06:23:27 peorth kernel:  [<c0134722>] sys_init_module+0x142/0x280
Apr  5 06:23:27 peorth kernel:  [<c0107459>] sysenter_past_esp+0x52/0x71
Apr  5 06:23:27 peorth kernel:
Apr  5 06:23:27 peorth kernel: handlers:
Apr  5 06:23:27 peorth kernel: [<d0d55890>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
Apr  5 06:23:27 peorth kernel: [<d0d4da10>] (ohci_irq_handler+0x0/0x860 [ohci1394])
Apr  5 06:23:27 peorth kernel: [<d0da18a0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Apr  5 06:23:27 peorth kernel: Disabling IRQ #10
Apr  5 06:23:27 peorth kernel: Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Apr  5 06:23:27 peorth kernel: Socket status: 30000006
Apr  5 06:23:27 peorth kernel: Yenta: CardBus bridge found at 0000:01:09.1 [1025:1022]
Apr  5 06:23:27 peorth kernel: Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Apr  5 06:23:27 peorth kernel: Socket status: 30000410
Apr  5 06:23:30 peorth cardmgr[3347]: watching 3 sockets
Apr  5 06:23:30 peorth kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Apr  5 06:23:30 peorth kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x240-0x247 0x370-0x38f 0x4d0-0x4d7
Apr  5 06:23:30 peorth kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Apr  5 06:23:30 peorth kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Apr  5 06:23:30 peorth cardmgr[3349]: socket 0: Lucent Technologies WaveLAN/IEEE Adapter
Apr  5 06:23:31 peorth cardmgr[3349]: unsupported card in socket 2
Apr  5 06:23:31 peorth cardmgr[3349]:   product info: "O2Micro", "SmartCardBus Reader", "V1.0"
Apr  5 06:23:31 peorth cardmgr[3349]:   manfid: 0xffff, 0x0001

I can use iwconfig to control the orinoco card located in socket 0 but it seems that the card cannot send any packet and ifconfig shows TX errors on the interface.

This also happened in 2.6.2, 2.6.3 and 2.6.4. Currently, I have to use 2.4 + pcmcia-cs to use pcmcia. (2.4 kernel-pcmcia cause system freeze if I modprobe yenta-socket).

How can I make my orinoco card works on 2.6 ? 

TIA
kitt
