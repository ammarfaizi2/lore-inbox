Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLLCXq>; Mon, 11 Dec 2000 21:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLLCXf>; Mon, 11 Dec 2000 21:23:35 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:59797 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129228AbQLLCX1>; Mon, 11 Dec 2000 21:23:27 -0500
Date: Tue, 12 Dec 2000 01:52:37 +0000 (GMT)
From: davej@suse.de
To: Linus Torvalds <torvalds@transmeta.com>, Martin Mares <mj@ucw.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
Message-ID: <Pine.LNX.4.21.0012120144490.28939-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The problem seems to be the "pci_get_interrupt_pin()" call. We should not
>do that. The pirq table has the unmodified device information - and when
>we try to swizzle the pins and find the bridge that the device is behind,
>we're trying to be way too clever.

Both with/without the change you mention, I still get routing warnings
on bootup. I've pasted the output from my Athlon box, as that seems
most affected by this. Interrupts 11 & 12 are left free, whilst it
routes multiple devices onto interrupt 5.

PCI: Found IRQ 5 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
emu10k1: EMU10K1 rev 5 model 0x20 found, IO at 0xb800-0xb81f, IRQ 5
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:09.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
PCI: Found IRQ 5 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:09.0
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 5



Interrupt routing table found at address 0xf0e90:
  Version 1.0, size 0x0070
  Interrupt router is device 00:04.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x1106 device 0x0686

Device 00:0c.0 (slot 1): 
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x05, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:0b.0 (slot 2): Ethernet controller
  INTA: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x05, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:09.0 (slot 4): Multimedia audio controller
  INTA: link 0x05, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:04.0 (slot 0): ISA bridge
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x05, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x05, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Interrupt router at 00:04.0: VIA 82C686 PCI-to-ISA bridge
  PIRQA (link 0x01): irq 11
  PIRQB (link 0x02): irq 10
  PIRQC (link 0x03): unrouted
  PIRQD (link 0x05): irq 5


regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
