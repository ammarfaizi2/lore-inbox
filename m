Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbQLLU1L>; Tue, 12 Dec 2000 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbQLLU1B>; Tue, 12 Dec 2000 15:27:01 -0500
Received: from front6.grolier.fr ([194.158.96.56]:52727 "EHLO
	front6.grolier.fr") by vger.kernel.org with ESMTP
	id <S131953AbQLLU0z> convert rfc822-to-8bit; Tue, 12 Dec 2000 15:26:55 -0500
Date: Tue, 12 Dec 2000 19:56:07 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Martin Mares <mj@suse.cz>
cc: "David S. Miller" <davem@redhat.com>, lk@tantalophile.demon.co.uk,
        davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <20001212001612.A14150@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10012121925590.1345-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2000, Martin Mares wrote:

> Hello!
> 
> > It is the bar cookies in pci dev structure that are insane, in my opinion.
> > 
> > If a driver needs BARs values, it needs actual BARs values and not some
> > stinking cookies. What a driver can do with BAR cookies other than using
> > them as band-aid for dubiously designed kernel interface.
> 
> If a driver wants to know the BAR values, it can pick them up in the configuration
> space itself. The problem is that these values mean absolutely nothing outside

The return value makes FULL sense on the BUS on which _real_ PCI
transactions will happen for old SYMBIOS devices and will hint recent ones
about using internal cycles instead (that are PCI 2.2 compliants) for
accessing the on chip-RAM.

As seen from the BUS and thus from the PCI device, all the opaque
inventions of O/Ses are just irrelevant sci-fi.

By the way, the hack that used bus_dvma_to_mem() from the BAR cookies is
not from me, but from David S. Miller. This will be fixed as you suggest.

> the bus the device resides on. There exist zillions of translating bridges
> and no driver except for the driver for the particular bridge should ever
> assume anything about them.

You seem to know well PCI but, in my opinion, you still have to learn much
about it and about what reality is.

You should repeat hundred times:

    "It is not Gérard neither the sym driver that wants to know about
     BARs"

But,

    "They are these damned PCI specifications that based everything on 
     actual BUS address comparators and the NCR/SYMBIOS ingenieers 
     that based memory related SCRIPTS instructions on actual adresses
     as seen from the BUS, and btw, as suggested by the specifications."


> The values in pci_dev->resource[] are not some random cookies, they are
> genuine physical addresses as seen by the CPU and as accepted by ioremap().

These cookies are confusing a lot and useless given a correct design of
related kernel interfaces. There is plenty of room in the pcidev structure
for private informations that would have avoided these stupid cookies.

In fact, these cookies are still there for historical reasons when
MMIO-capable PCI device driver(s) had to use vremap() on actual BAR
addresses. This only worked on Intel.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
