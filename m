Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQKIU1d>; Thu, 9 Nov 2000 15:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130894AbQKIU1X>; Thu, 9 Nov 2000 15:27:23 -0500
Received: from front5m.grolier.fr ([195.36.216.55]:31669 "EHLO
	front5m.grolier.fr") by vger.kernel.org with ESMTP
	id <S131154AbQKIU1M> convert rfc822-to-8bit; Thu, 9 Nov 2000 15:27:12 -0500
Date: Thu, 9 Nov 2000 20:27:24 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: hiren_mehta@agilent.com
cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: RE: accessing on-card ram/rom
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718808E5@xsj02.sjs.agilent.com>
Message-ID: <Pine.LNX.4.10.10011092011010.1341-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2000 hiren_mehta@agilent.com wrote:

> I looked at the IO-mapping.txt file. It says that
> on x86 architecture it should not make any difference.
> It also says that "on x86 it _is_ the same memory space. So
> on x86 it actually works to just dereference a pointer".

For bus_to_virt() to give a usable virtual address, such a virtual 
mapping must exist and additionnally be part of the linear kernel 
mapping. A PCI MMIO address is generally _not_ even mapped by default 
by the kernel.

On the other hand, bus_to_virt() hasn't the proper semantic for your
problem, since it applies to main memory addresses as seen from the PCI
BUS, and you want an MMIO address usable by the CPU (=virtual).

Hmmm... ioremap() just create a virtual mapping for the CPU to access 
the MMIO window of your PCI chip just fine.

  Gérard.

> Any inputs on this ?
> 
> Thanks and regards,
> -hiren
> 
> > -----Original Message-----
> > From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> > Sent: Wednesday, November 08, 2000 2:53 PM
> > To: MEHTA,HIREN (A-SanJose,ex1)
> > Cc: 'linux-kernel@vger.kernel.org'
> > Subject: Re: accessing on-card ram/rom
> > 
> > 
> > "MEHTA,HIREN (A-SanJose,ex1)" wrote:
> > > I have a PCI card which has on-card ram/rom which gets mapped
> > > into pci address space and there is a separate base register
> > > for this memory. Now the question is : can I access this on-card
> > > memory by converting the pci base address into the virtual address
> > > using bus_to_virt and adding the required offset ? Or do I need
> > > to use ioremap function to map the physical address space starting
> > > from the pci base address into the kernel virtual address space ?
> > > Or is there any other interface to access the on-card memory ?
> > > Is it that bus_to_virt can be used only for the normal RAM ?
> > 
> > Use ioremap.
> > 
> > For more details, read linux/Documentation/IO-mapping.txt.
> > 
> > 	Jeff
> > 
> > 
> > -- 
> > Jeff Garzik             | "When I do this, my computer freezes."
> > Building 1024           |          -user
> > MandrakeSoft            | "Don't do that."
> >                         |          -level 1
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
