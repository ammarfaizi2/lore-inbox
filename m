Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTIVLwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbTIVLwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:52:55 -0400
Received: from main.gmane.org ([80.91.224.249]:12756 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263116AbTIVLww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:52:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: various problems with usb2.0 pcmcia adaptor
Date: Mon, 22 Sep 2003 15:37:11 +0200
Message-ID: <slrnbmtuo7.1ab.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 2.6.0-test5-bk8

I've got some problems with the D-Link DUB-C2 2Port USB2.0 PCMCIA
adaptor. If present at boot up time, the kernel hangs after initiating a
second Yenta Socket (log below).

When inserted into a running system ohci-hcd generates multiple error
messages.

Bootup - Log (hand copied):
| Yenta: CardBus Bridge fount at 0000:02:05.0 [103c:001a]
| Yenta: Enabling burst memory read transactions
| Yenta: Using INTVAL to route CSC interrupts to PCI
| Yenta: Routing CardBus interrupts to PCI
| Yenta: ISA IRQ list 0a98, PCI irq 10
| Socket status: 300000006
[..]
| Yenta: CardBus Bridge fount at 0000:02:05.1 [103c:001a]
| Yenta: Enabling burst memory read transactions
| Yenta: Using INTVAL to route CSC interrupts to PCI
| Yenta: Routing CardBus interrupts to PCI
| Yenta: ISA IRQ list 0a98, PCI irq 10
| Socket status: 300000020
[computer hangs]

Tried to disable the onboard usb controller, but the system BIOS won't
allow it (POS in question is a HP Omnibook 6100).

The error messages which could be gained by inserting the PCMCIA card
after booting are:
| cs: IO port probe 0x0c00-0x0cff: clean.
| cs: IO port probe 0x0800-0x08ff: clean.
| cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x3c0-0x3df 0x4d0-0x4d7
| cs: IO port probe 0x0a00-0x0aff: clean.
| ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
| ohci-hcd: block sizes: ed 64 td 64
| PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
| ohci-hcd 0000:07:00.0: OHCI Host Controller
| PCI: Setting latency timer of device 0000:07:00.0 to 64
| ohci-hcd 0000:07:00.0: irq 10, pci mem d2c7d000
| ohci-hcd 0000:07:00.0: new USB bus registered, assigned bus number 2
| ohci-hcd 0000:07:00.0: HC died; cleaning up
| usb usb2: device not accepting address 1, error -22
| ohci-hcd 0000:07:00.0: can't register root hub for usb2, -22
| ohci-hcd 0000:07:00.0: can't start
| ohci-hcd 0000:07:00.0: remove, state 0
| ohci-hcd 0000:07:00.0: USB bus 2 deregistered
| ohci-hcd: probe of 0000:07:00.0 failed with error -16
| ohci-hcd 0000:07:00.1: OHCI Host Controller

and:
| ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
| ohci-hcd: block sizes: ed 64 td 64
| PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
| ohci-hcd 0000:07:00.0: OHCI Host Controller
| PCI: Setting latency timer of device 0000:07:00.0 to 64
| ohci-hcd 0000:07:00.0: irq 10, pci mem d18ae000
| ohci-hcd 0000:07:00.0: new USB bus registered, assigned bus number 2
| hub 2-0:0: USB hub found
| hub 2-0:0: 3 ports detected
| PCI: Enabling device 0000:07:00.1 (0000 -> 0002)
| ohci-hcd 0000:07:00.1: OHCI Host Controller
| PCI: Setting latency timer of device 0000:07:00.1 to 64
| ohci-hcd 0000:07:00.1: irq 10, pci mem d18b8000
| ohci-hcd 0000:07:00.1: new USB bus registered, assigned bus number 3
| hub 3-0:0: USB hub found
| hub 3-0:0: config failed, hub has too many ports! (err -19)
                        [true, it has only 2 ports.]
| ehci_hcd 0000:07:00.2: EHCI Host Controller

	--Andreas

