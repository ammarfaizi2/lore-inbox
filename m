Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291809AbSB0DD3>; Tue, 26 Feb 2002 22:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSB0DDT>; Tue, 26 Feb 2002 22:03:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291776AbSB0DDH>;
	Tue, 26 Feb 2002 22:03:07 -0500
Message-ID: <3C7C4C6C.6921F967@mandrakesoft.com>
Date: Tue, 26 Feb 2002 22:03:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Jaroslav Kysela <perex@suse.cz>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] Conversion of hp100 to new PCI interface
In-Reply-To: <20020226174657.A18197@bougret.hpl.hp.com> <20020226175353.B18197@bougret.hpl.hp.com> <3C7C4043.893429A9@mandrakesoft.com> <20020226182405.A18274@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 
> On Tue, Feb 26, 2002 at 09:11:15PM -0500, Jeff Garzik wrote:
> > >
> > > +       /* Conversion to new PCI API :
> > > +        * The memory block we use, lp->page_vaddr, was DMA allocated via
> > > +        * pci_alloc_consistent(), so we just need to "retreive" the
> > > +        * original mapping to bus/phys address - Jean II */
> > >         ringptr->pdl = pdlptr + 1;
> > > -       ringptr->pdl_paddr = virt_to_bus(pdlptr + 1);
> > > +       ringptr->pdl_paddr = virt_to_phys(pdlptr + 1);
> >
> > Nope..  You need to use the mapping value obtained from
> > pci_alloc_consistent...
> 
>         I don't understand the objection. The memory has been declared
> as DMA and the system already manages it as such. What's the catch ?
>         If I can't use virt_to_phys(), can I have a function that does
> exactly the same ? The new API is heavy enough, and if drivers can't
> have something like this it's just messy...

It's not portable, and there's no reason to keep recalculating the value
on those platforms where it does work.  You need to store the mapping
value for later use.

Read the section "Optimizing Unmap State Space Consumption" in
Documentation/DMA-mapping.txt for some examples and information WRT
pci_map_xxx/pci_unmap_xxx too.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
