Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRBCUVP>; Sat, 3 Feb 2001 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129454AbRBCUVG>; Sat, 3 Feb 2001 15:21:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13068 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129268AbRBCUUr>; Sat, 3 Feb 2001 15:20:47 -0500
Date: Sat, 3 Feb 2001 12:20:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Martin Diehl <mdiehlcs@compuserve.de>, davej@suse.de, becker@scyld.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ne2k-pci irq fix
In-Reply-To: <Pine.LNX.3.96.1010201090450.26802C-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10102031213540.8867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Feb 2001, Jeff Garzik wrote:
> 
> > Probably I've missed this because the last time I hit such a thing was
> > when my ob800 bios mapped the cardbus memory BAR's into bogus legacy
> > 0xe0000 area. Hence there was good reason to read and correct this before
> > trying to enable the device.
> 
> This is a PCI fixup, the driver shouldn't have to worry about this..

Actually, I'd rather see the _drivers_ do most of the fixups for their own
chips, and leave the global PCI fixups for things like

 - PCI/ISA/whatever bridges that affect drivers for _other_ chips. I hate
   having some random PCI driver having to know about the fact that it
   might be behind a bridge that needs special initialization. That kind
   of "non-local" knowledge is that the PCI fixups are there for.

 - stuff that needs to be fixed up early in order to have a working system
   and make sure that we don't have any resource clashes we can't fix up
   later on.

But if there is a BIOS/chip bug that affects only one driver, and that bug
is local to that driver only and can't affect anything else, then I'd
rather see the driver keep track of it. It's easy enough for a driver to
do any required fixup before it actually calls "pci_enable_device()". 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
