Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129248AbQKWRkS>; Thu, 23 Nov 2000 12:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129210AbQKWRkI>; Thu, 23 Nov 2000 12:40:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38663 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129767AbQKWRhF>; Thu, 23 Nov 2000 12:37:05 -0500
Date: Thu, 23 Nov 2000 09:06:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <Pine.LNX.4.21.0011212252300.30223-300000@svea.tellus>
Message-ID: <Pine.LNX.4.10.10011230901580.7992-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2000, Tobias Ringstrom wrote:
> > 
> > Tobias, can you confirm that calling pci_enable_device before reading
> > dev->irq fixes the 3c59x.c problem for you?
> 
> Nope. The interrupts do not seem to get through. Packets are transmitted,
> but that's it. I've copied the interesting parts from dmesg:
> 
> 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
> See Documentation/networking/vortex.txt
> PCI: Enabling device 00:0a.0 (0014 -> 0017)
> PCI: Assigned IRQ 9 for device 00:0a.0
> eth0: 3Com PCI 3c905C Tornado at 0xa400,  00:01:02:b4:18:e4, IRQ 9

Ok, the VIA stuff is happy, and enables the irq routing. The fact that the
irq's don't actually seem to ever actually appear means that the enable
sequence is probably slightly buggy.

Can you do two things?

 - enable DEBUG in arch/i386/kernel/pci-i386.h. This should make the code
   print out what the pirq table entries are etc.

 - add the line "eisa_set_level_irq(irq);" to pirq_via_set() just before
   the "return 1;"

Jeff, you had complete VIA docs, right? Can you check that whatever 
Tobias' ends up having output from the debug stuff looks sane?

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
