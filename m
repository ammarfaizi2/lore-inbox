Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136636AbRAHDSw>; Sun, 7 Jan 2001 22:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136595AbRAHDSm>; Sun, 7 Jan 2001 22:18:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53257 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136649AbRAHDS3>; Sun, 7 Jan 2001 22:18:29 -0500
Date: Sun, 7 Jan 2001 19:18:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Albert Cranford <ac9410@bellsouth.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
In-Reply-To: <3A58D962.FAEBBAC7@bellsouth.net>
Message-ID: <Pine.LNX.4.10.10101071915400.28661-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Albert Cranford wrote:
> > Could anybody with a VIA chip who has the energy please do something for
> > me:
> >  - enable DEBUG in arch/i386/kernel/pci-i386.h
> >  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
> >    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
> >    numbers for them are 1106:0586 and 1106:0596, I think)
> >  - do a cat /proc/pci
> > 
> 
> Does this help.

Ahh, no.

A SMP kernel (or one with UP IO-APIC) is not going to be helpful for this,
actually. SMP will take the irq data from the MP block, not the pirq table
(that can be considered something of a misfeature right now, but getting
the mixture of PCI irq redirection from the MP tables and the pirq irq
routing information right together is probably not worth it - especially
as I don't think any MS OS has ever done that either, so the BIOS writers
have never experienced that combination - so it's almost guaranteed to
result in strange results).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
