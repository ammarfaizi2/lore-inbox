Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQKRQem>; Sat, 18 Nov 2000 11:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbQKRQeX>; Sat, 18 Nov 2000 11:34:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52232 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129234AbQKRQeP>; Sat, 18 Nov 2000 11:34:15 -0500
Date: Sat, 18 Nov 2000 08:03:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Ford <david@linux.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, David Hinds <dhinds@valinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <3A16521A.44B2B628@linux.com>
Message-ID: <Pine.LNX.4.10.10011180750230.8465-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, David Ford wrote:

> Linus Torvalds wrote:
> [...]
> 
> > If somebody still has a problem with the in-kernel stuff, speak up.
> 
> The kernel's irq detection for the card sockets doesn't work for me.  It's the NEC
> Versa LX story.  The DH code also reports no IRQ found but still figures out a
> working IRQ (normally 3) and assigns it for the tulip card.  I use the i82365 module
> w/ the DH code.  The below is the output of the kernel pcmcia code.

> PCI: No IRQ known for interrupt pin B of device 00:03.1. Please try using
> pci=biosirq.
> PCI: No IRQ known for interrupt pin A of device 00:03.0. Please try using
> pci=biosirq.

Strange. Your interrupt router is a bog-standard PIIX4, we know how to
route the thing, AND your device shows up:

> # dump_pirq
> Interrupt routing table found at address 0xf5a80:
>   Version 1.0, size 0x0080
>   Interrupt router is device 00:07.0
>   PCI exclusive interrupt mask: 0x0000
>   Compatible router: vendor 0x8086 device 0x1234
> 
> Device 00:03.0 (slot 0):
>   INTA: link 0x60, irq mask 0x0420
>   INTB: link 0x61, irq mask 0x0420
>
> Interrupt router: Intel 82371AB PIIX4/PIIX4E PCI-to-ISA bridge
>   PIRQ1 (link 0x60): irq 10
>   PIRQ2 (link 0x61): irq 5
>   PIRQ3 (link 0x62): unrouted
>   PIRQ4 (link 0x63): irq 9
>   Serial IRQ: [enabled] [continuous] [frame=21] [pulse=4]

Can you (you've probably done this before, but anyway) enable DEBUG in
arch/i386/kernel/pci-i386.h? I wonder if the kernel for some strange
reason doesn't find your router, even though "dump_pirq" obviously does..
If there's something wrong with the checksumming for example..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
