Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbQKUTkY>; Tue, 21 Nov 2000 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbQKUTkQ>; Tue, 21 Nov 2000 14:40:16 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:6149 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131101AbQKUTkC>;
	Tue, 21 Nov 2000 14:40:02 -0500
Date: Tue, 21 Nov 2000 20:09:59 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: andrewm@uow.edu.au
Subject: 3c59x: Using bad IRQ 0
Message-ID: <Pine.LNX.4.21.0011211959550.29915-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.4.0-test11:

When saying yes to "Plug-and-play OS" in the BIOS, my 3Com 905C adapter
stops working, since the driver tries to use IRQ 0, since the BIOS does
not assign an IRQ to it. The driver seems to read the IRQ from the card
before it calls pci_enable_device (and pci_set_master).

Quoting dmesg (from test10, but it looks the same in test11):

PCI: PCI BIOS revision 2.10 entry at 0xf10f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:11.0
[...]
3c59x.c:LK1.1.9  2 Sep 2000  Donald Becker and
others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.38 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0xa400, PCI: Enabling device 00:0a.0 (0014 -> 0017)
PCI: Assigned IRQ 9 for device 00:0a.0
 00:01:02:b4:18:e4, IRQ 0
 *** Warning: IRQ 0 is unlikely to work! ***
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.

As you can see, the PCI driver does assign an IRQ, but the driver ignores
it. I hope this is enough info to fix the problem.

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
