Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbQKRWqk>; Sat, 18 Nov 2000 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131927AbQKRWqa>; Sat, 18 Nov 2000 17:46:30 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:4108 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131883AbQKRWqR>;
	Sat, 18 Nov 2000 17:46:17 -0500
Date: Sat, 18 Nov 2000 14:16:09 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Ford <david@linux.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
Message-ID: <20001118141609.A21152@valinux.com>
In-Reply-To: <3A16521A.44B2B628@linux.com> <Pine.LNX.4.10.10011180750230.8465-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011180750230.8465-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 18, 2000 at 08:03:51AM -0800
From: David Hinds <dhinds@valinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 08:03:51AM -0800, Linus Torvalds wrote:
> 
> Strange. Your interrupt router is a bog-standard PIIX4, we know how to
> route the thing, AND your device shows up:
> 
> > # dump_pirq
> > Interrupt routing table found at address 0xf5a80:
> >   Version 1.0, size 0x0080
> >   Interrupt router is device 00:07.0
> >   PCI exclusive interrupt mask: 0x0000
> >   Compatible router: vendor 0x8086 device 0x1234

Oh... the kernel pci-irq code looks for the "compatible router" if it
is set; if unset, then it looks up the ID's of the router device.

0x8086, 0x1234 is not a known router type, so the kernel decides it
can't interpret the routing table.

0x8086, 0x1234 is listed in pci_ids.h as an 82371MX.  I'm suspicious 
of that: the MX chipset has an 82443MX, not an 82371.  In any case, I
think pci-irq.c should check both sets of ID's for a match.

-- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
