Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTE0Luc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTE0Luc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:50:32 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:64959 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263394AbTE0LuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:50:18 -0400
Date: Tue, 27 May 2003 22:03:46 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: 2.5.70 - IRQs+PCMCIA: Nobody cares! *sniff*
Message-ID: <20030527120346.GB497@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A long while back, botting with a PCMCIA card used to work. Then it
stopped and woe fell accross my world. Essentially the kernel froze.
A bit of time later it oopsed and then froze and woe continued. Now it
oopses but lives and a shred of joy emerged. :) Slowly but surely
sanity is returning to my PCMCIA world.

I think back then someone said that Russel King was working on a fix. I've
been trying to spy out further info on this for a while but have not
been able to spot anything. It could've been in an (to me) esotarically
subjected thread. Anyhow... I'm wondering. What's the status and what,
if anything, can I do to help? :)

dmesg and lspci output below:

--- 8< ---
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
Console: switching to colour frame buffer device 128x48
irq 10: nobody cared!
Call Trace:
 [<c010a2d1>] handle_IRQ_event+0x91/0x100
 [<c010a2d9>] handle_IRQ_event+0x99/0x100
 [<c010a4f5>] do_IRQ+0xb9/0x130
 [<c0108f9c>] common_interrupt+0x18/0x20
 [<c0113236>] delay_tsc+0x12/0x1c
 [<c0201152>] __delay+0x12/0x18
 [<c02011c1>] __const_udelay+0x21/0x30
 [<c02c99da>] yenta_probe_irq+0x11e/0x1b8
 [<c02c9a99>] yenta_get_socket_capabilities+0x25/0x48
 [<c02ca62f>] yenta_open+0x16f/0x1b0
 [<c02c8c4c>] add_pci_socket+0xb0/0xec
 [<c02c8cb2>] cardbus_probe+0x1e/0x38
 [<c0204621>] pci_device_probe_static+0x2d/0x4c
 [<c0204760>] __pci_device_probe+0x20/0x38
 [<c02047ab>] pci_device_probe+0x33/0x4c
 [<c026ed10>] bus_match+0x38/0x64
 [<c026edea>] driver_attach+0x3e/0x58
 [<c026f07d>] bus_add_driver+0x81/0xa0
 [<c026f42a>] driver_register+0x36/0x3c
 [<c0204982>] pci_register_driver+0x6a/0x90
 [<c051286d>] pci_socket_init+0xd/0x20
 [<c0500675>] do_initcalls+0x39/0x94
 [<c05006ec>] do_basic_setup+0x1c/0x20
 [<c0105096>] init+0x2e/0x178
 [<c0105068>] init+0x0/0x178
 [<c0107211>] kernel_thread_helper+0x5/0xc

handlers:
[<c02c9838>] (yenta_interrupt+0x0/0x54)
irq 10: nobody cared!
Call Trace:
 [<c010a2d1>] handle_IRQ_event+0x91/0x100
 [<c010a2d9>] handle_IRQ_event+0x99/0x100
 [<c010a4f5>] do_IRQ+0xb9/0x130
 [<c0108f9c>] common_interrupt+0x18/0x20
 [<c0113234>] delay_tsc+0x10/0x1c
 [<c0201152>] __delay+0x12/0x18
 [<c02011c1>] __const_udelay+0x21/0x30
 [<c02c99da>] yenta_probe_irq+0x11e/0x1b8
 [<c02c9a99>] yenta_get_socket_capabilities+0x25/0x48
 [<c02ca62f>] yenta_open+0x16f/0x1b0
 [<c02c8c4c>] add_pci_socket+0xb0/0xec
 [<c02c8cb2>] cardbus_probe+0x1e/0x38
 [<c0204621>] pci_device_probe_static+0x2d/0x4c
 [<c0204760>] __pci_device_probe+0x20/0x38
 [<c02047ab>] pci_device_probe+0x33/0x4c
 [<c026ed10>] bus_match+0x38/0x64
 [<c026edea>] driver_attach+0x3e/0x58
 [<c026f07d>] bus_add_driver+0x81/0xa0
 [<c026f42a>] driver_register+0x36/0x3c
 [<c0204982>] pci_register_driver+0x6a/0x90
 [<c051286d>] pci_socket_init+0xd/0x20
 [<c0500675>] do_initcalls+0x39/0x94
 [<c05006ec>] do_basic_setup+0x1c/0x20
 [<c0105096>] init+0x2e/0x178
 [<c0105068>] init+0x0/0x178
 [<c0107211>] kernel_thread_helper+0x5/0xc

handlers:
[<c02c9838>] (yenta_interrupt+0x0/0x54)
irq 10: nobody cared!
Call Trace:
 [<c010a2d1>] handle_IRQ_event+0x91/0x100
 [<c010a2d9>] handle_IRQ_event+0x99/0x100
 [<c010a4f5>] do_IRQ+0xb9/0x130
 [<c0108f9c>] common_interrupt+0x18/0x20
 [<c0113234>] delay_tsc+0x10/0x1c
 [<c0201152>] __delay+0x12/0x18
 [<c02011c1>] __const_udelay+0x21/0x30
 [<c02c99da>] yenta_probe_irq+0x11e/0x1b8
 [<c02c9a99>] yenta_get_socket_capabilities+0x25/0x48
 [<c02ca62f>] yenta_open+0x16f/0x1b0
 [<c02c8c4c>] add_pci_socket+0xb0/0xec
 [<c02c8cb2>] cardbus_probe+0x1e/0x38
 [<c0204621>] pci_device_probe_static+0x2d/0x4c
 [<c0204760>] __pci_device_probe+0x20/0x38
 [<c02047ab>] pci_device_probe+0x33/0x4c
 [<c026ed10>] bus_match+0x38/0x64
 [<c026edea>] driver_attach+0x3e/0x58
 [<c026f07d>] bus_add_driver+0x81/0xa0
 [<c026f42a>] driver_register+0x36/0x3c
 [<c0204982>] pci_register_driver+0x6a/0x90
 [<c051286d>] pci_socket_init+0xd/0x20
 [<c0500675>] do_initcalls+0x39/0x94
 [<c05006ec>] do_basic_setup+0x1c/0x20
 [<c0105096>] init+0x2e/0x178
 [<c0105068>] init+0x0/0x178
 [<c0107211>] kernel_thread_helper+0x5/0xc

handlers:
[<c02c9838>] (yenta_interrupt+0x0/0x54)
irq 10: nobody cared!
Call Trace:
 [<c010a2d1>] handle_IRQ_event+0x91/0x100
 [<c010a2d9>] handle_IRQ_event+0x99/0x100
 [<c010a4f5>] do_IRQ+0xb9/0x130
 [<c0108f9c>] common_interrupt+0x18/0x20
 [<c0113236>] delay_tsc+0x12/0x1c
 [<c0201152>] __delay+0x12/0x18
 [<c02011c1>] __const_udelay+0x21/0x30
 [<c02c99da>] yenta_probe_irq+0x11e/0x1b8
 [<c02c9a99>] yenta_get_socket_capabilities+0x25/0x48
 [<c02ca62f>] yenta_open+0x16f/0x1b0
 [<c02c8c4c>] add_pci_socket+0xb0/0xec
 [<c02c8cb2>] cardbus_probe+0x1e/0x38
 [<c0204621>] pci_device_probe_static+0x2d/0x4c
 [<c0204760>] __pci_device_probe+0x20/0x38
 [<c02047ab>] pci_device_probe+0x33/0x4c
 [<c026ed10>] bus_match+0x38/0x64
 [<c026edea>] driver_attach+0x3e/0x58
 [<c026f07d>] bus_add_driver+0x81/0xa0
 [<c026f42a>] driver_register+0x36/0x3c
 [<c0204982>] pci_register_driver+0x6a/0x90
 [<c051286d>] pci_socket_init+0xd/0x20
 [<c0500675>] do_initcalls+0x39/0x94
 [<c05006ec>] do_basic_setup+0x1c/0x20
 [<c0105096>] init+0x2e/0x178
 [<c0105068>] init+0x0/0x178
 [<c0107211>] kernel_thread_helper+0x5/0xc

handlers:
[<c02c9838>] (yenta_interrupt+0x0/0x54)
irq 10: nobody cared!
Call Trace:
 [<c010a2d1>] handle_IRQ_event+0x91/0x100
 [<c010a2d9>] handle_IRQ_event+0x99/0x100
 [<c010a4f5>] do_IRQ+0xb9/0x130
 [<c0108f9c>] common_interrupt+0x18/0x20
 [<c0113234>] delay_tsc+0x10/0x1c
 [<c0201152>] __delay+0x12/0x18
 [<c02011c1>] __const_udelay+0x21/0x30
 [<c02c99da>] yenta_probe_irq+0x11e/0x1b8
 [<c02c9a99>] yenta_get_socket_capabilities+0x25/0x48
 [<c02ca62f>] yenta_open+0x16f/0x1b0
 [<c02c8c4c>] add_pci_socket+0xb0/0xec
 [<c02c8cb2>] cardbus_probe+0x1e/0x38
 [<c0204621>] pci_device_probe_static+0x2d/0x4c
 [<c0204760>] __pci_device_probe+0x20/0x38
 [<c02047ab>] pci_device_probe+0x33/0x4c
 [<c026ed10>] bus_match+0x38/0x64
 [<c026edea>] driver_attach+0x3e/0x58
 [<c026f07d>] bus_add_driver+0x81/0xa0
 [<c026f42a>] driver_register+0x36/0x3c
 [<c0204982>] pci_register_driver+0x6a/0x90
 [<c051286d>] pci_socket_init+0xd/0x20
 [<c0500675>] do_initcalls+0x39/0x94
 [<c05006ec>] do_basic_setup+0x1c/0x20
 [<c0105096>] init+0x2e/0x178
 [<c0105068>] init+0x0/0x178
 [<c0107211>] kernel_thread_helper+0x5/0xc

handlers:
[<c02c9838>] (yenta_interrupt+0x0/0x54)
irq 10: nobody cared!
Call Trace:
 [<c010a2d1>] handle_IRQ_event+0x91/0x100
 [<c010a2d9>] handle_IRQ_event+0x99/0x100
 [<c010a4f5>] do_IRQ+0xb9/0x130
 [<c0108f9c>] common_interrupt+0x18/0x20
 [<c0113234>] delay_tsc+0x10/0x1c
 [<c0201152>] __delay+0x12/0x18
 [<c02011c1>] __const_udelay+0x21/0x30
 [<c02c99da>] yenta_probe_irq+0x11e/0x1b8
 [<c02c9a99>] yenta_get_socket_capabilities+0x25/0x48
 [<c02ca62f>] yenta_open+0x16f/0x1b0
 [<c02c8c4c>] add_pci_socket+0xb0/0xec
 [<c02c8cb2>] cardbus_probe+0x1e/0x38
 [<c0204621>] pci_device_probe_static+0x2d/0x4c
 [<c0204760>] __pci_device_probe+0x20/0x38
 [<c02047ab>] pci_device_probe+0x33/0x4c
 [<c026ed10>] bus_match+0x38/0x64
 [<c026edea>] driver_attach+0x3e/0x58
 [<c026f07d>] bus_add_driver+0x81/0xa0
 [<c026f42a>] driver_register+0x36/0x3c
 [<c0204982>] pci_register_driver+0x6a/0x90
 [<c051286d>] pci_socket_init+0xd/0x20
 [<c0500675>] do_initcalls+0x39/0x94
 [<c05006ec>] do_basic_setup+0x1c/0x20
 [<c0105096>] init+0x2e/0x178
 [<c0105068>] init+0x0/0x178
 [<c0107211>] kernel_thread_helper+0x5/0xc

handlers:
[<c02c9838>] (yenta_interrupt+0x0/0x54)
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000820
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
uhci-hcd 00:07.2: irq 9, io base 00001440
--- 8< ---

...
02:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
02:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
