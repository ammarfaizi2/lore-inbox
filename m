Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSB0CY1>; Tue, 26 Feb 2002 21:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291532AbSB0CYR>; Tue, 26 Feb 2002 21:24:17 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:13280 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S291477AbSB0CYH>;
	Tue, 26 Feb 2002 21:24:07 -0500
Date: Tue, 26 Feb 2002 18:24:05 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, Jaroslav Kysela <perex@suse.cz>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] Conversion of hp100 to new PCI interface
Message-ID: <20020226182405.A18274@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020226174657.A18197@bougret.hpl.hp.com> <20020226175353.B18197@bougret.hpl.hp.com> <3C7C4043.893429A9@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7C4043.893429A9@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Feb 26, 2002 at 09:11:15PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 09:11:15PM -0500, Jeff Garzik wrote:
> > 
> > +       /* Conversion to new PCI API :
> > +        * The memory block we use, lp->page_vaddr, was DMA allocated via
> > +        * pci_alloc_consistent(), so we just need to "retreive" the
> > +        * original mapping to bus/phys address - Jean II */
> >         ringptr->pdl = pdlptr + 1;
> > -       ringptr->pdl_paddr = virt_to_bus(pdlptr + 1);
> > +       ringptr->pdl_paddr = virt_to_phys(pdlptr + 1);
> 
> Nope..  You need to use the mapping value obtained from
> pci_alloc_consistent...

	I don't understand the objection. The memory has been declared
as DMA and the system already manages it as such. What's the catch ?
	If I can't use virt_to_phys(), can I have a function that does
exactly the same ? The new API is heavy enough, and if drivers can't
have something like this it's just messy...
	Just define something like :
------------------------------------------
static inline dma_addr_t pci_map_alloc(struct pci_dev *hwdev, void *ptr)
{
	ret virt_to_phys(ptr);
}
------------------------------------------

> Note for ISA (and EISA and VLB) devices, you also call
> pci_alloc_consistent.  You pass NULL for the pci device.

	That's what I do. But I don't claim it's tested.
	By the way, it seems weird to prefix all those functions with
"pci_" where in fact they are only loosely related to PCI stuff.
	Also, on the inconsistent side, most functions handle pci_dev
== NULL, but not all, and it's not well documented. For example, if
you pass NULL to pci_set_dma_mask(), it will kaboom !

> 	Jeff

	Jean
