Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQKQRSW>; Fri, 17 Nov 2000 12:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQKQRSM>; Fri, 17 Nov 2000 12:18:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18954 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130640AbQKQRR6>; Fri, 17 Nov 2000 12:17:58 -0500
Date: Fri, 17 Nov 2000 08:47:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Woodhouse <dwmw2@infradead.org>, Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, David Hinds <dhinds@valinux.com>,
        tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <3A155F6A.28783D4A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011170843050.2272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Jeff Garzik wrote:
> > 
> > 2. Even when I specify cs_irq=27, it resorts to polling:
> > 
> >         Intel PCIC probe:
> >           Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x00, 2 sockets
> >             host opts [0]: none
> >             host opts [1]: none
> >             ISA irqs (default) = none! polling interval = 1000 ms
> >           Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x80, 2 sockets
> >             host opts [2]: none
> >             host opts [3]: none
> >             ISA irqs (default) = none! polling interval = 1000 ms
> 
> For these two, it sounds to me like you need to be doing a PCI probe,
> and getting the irq and I/O port info from pci_dev.  And calling
> pci_enable_device, which may or may not be a showstopper here...

The i82365 stuff actually used to do much of this, but it was so
intimately intertwined with the cardbus handling that I pruned it out for
my sanity.

It should be possible to do the same thing with a nice simple concentrated
PCI probe, instead of having stuff quite as spread out as it used to be.

As to why it doesn't show any ISA interrupts, who knows... Some of the PCI
PCMCIA bridges need to be initialized.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
