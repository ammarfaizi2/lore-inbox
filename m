Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWTDq>; Thu, 23 Nov 2000 14:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129097AbQKWTDh>; Thu, 23 Nov 2000 14:03:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15113 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129091AbQKWTDX>; Thu, 23 Nov 2000 14:03:23 -0500
Date: Thu, 23 Nov 2000 10:32:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <Pine.LNX.4.21.0011231859140.32678-100000@svea.tellus>
Message-ID: <Pine.LNX.4.10.10011231027440.928-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Tobias Ringstrom wrote:
> > 
> >  - enable DEBUG in arch/i386/kernel/pci-i386.h. This should make the code
> >    print out what the pirq table entries are etc.
> 
> Done. When adding the call to eisa_set_level_irq, the line
> 
> IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 ... OK
> 
> was changed into
> 
> IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 -> edge ... OK

Ok.

The thing was marked as edge-triggered, which is basically always wrong
for a PCI interrupt. The above printout just means that it now noticed
that it was edge, and fixed it up in the ELCR.

> >  - add the line "eisa_set_level_irq(irq);" to pirq_via_set() just before
> >    the "return 1;"
> 
> You certainly know your kernel very well... :-)

That's why they pay me the big bucks. Good.

I'll make it do the eisa_set_level_irq() in the generic code: it should
always be right (we don't do it now in the PIIX4 case, for example, but
the PIIX documentation actually says that we _should_), and there is no
need to do it separately for each interrupt router.

One down.

Now just tell me if the problem with the machine that needs warm-booting
from Windows is fixed by the other PCI change, and I'll be a happy camper.

(Or rather, I'd be a happy camper if I knew what the cause of the disk
corruption reports is. That one bugs me).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
