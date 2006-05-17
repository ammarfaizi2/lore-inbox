Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWEQXkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWEQXkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWEQXkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:40:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750737AbWEQXkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:40:35 -0400
Date: Wed, 17 May 2006 16:40:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Avuton Olrich <avuton@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFT] major libata update
In-Reply-To: <87ves44qrs.fsf@duaron.myhome.or.jp>
Message-ID: <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
References: <20060515170006.GA29555@havoc.gtf.org>
 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
 <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
 <44694C4F.3000008@garzik.org> <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
 <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org> <87ves44qrs.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 May 2006, OGAWA Hirofumi wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Mon, 15 May 2006, Avuton Olrich wrote:
> >
> > diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
> > index 06dab00..49b9fea 100644
> > --- a/arch/i386/pci/irq.c
> > +++ b/arch/i386/pci/irq.c
> > @@ -880,6 +880,7 @@ static int pcibios_lookup_irq(struct pci
> >  	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask)) ) {
> >  		DBG(" -> got IRQ %d\n", irq);
> >  		msg = "Found";
> > +		eisa_set_level_irq(irq);
> >  	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
> >  		DBG(" -> assigning IRQ %d", newirq);
> >  		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
> 
> I like it. I'd like to put this type stuff (fixes setting of 8259,
> APIC, chipset, etc.) into pci...

Andrew, can you put the one-liner into -mm and see if it gathers any 
reports? 

I think Neil already reported that it fixed a lost interrupt problem for 
him, but I'm worried that it might result in interrupt storms for others. 

In particular, I have this pretty strong memory that we tried to do 
something like this a long time ago, and it caused problems at least 
with the legacy ISA/ATA interrupts (irq 14/15).

On the other hand, my memory is pretty damn bad at times, and besides, I 
hope that that "hardcoded" case just above it is the one that takes care 
of the old ATA interrupts. This is one of those times when the only 
guaranteed right thing to do would be to be bug-for-bug compatible with 
whatever crud MS-Win does..

		Linus
