Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbQLKXCE>; Mon, 11 Dec 2000 18:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbQLKXBq>; Mon, 11 Dec 2000 18:01:46 -0500
Received: from front4m.grolier.fr ([195.36.216.54]:7311 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129464AbQLKXBh> convert rfc822-to-8bit; Mon, 11 Dec 2000 18:01:37 -0500
Date: Mon, 11 Dec 2000 22:30:59 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "David S. Miller" <davem@redhat.com>
cc: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <200012112148.NAA24830@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10012112207400.2144-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, David S. Miller wrote:

>    Date: 	Mon, 11 Dec 2000 21:49:52 +0100 (CET)
>    From: Gérard Roudier <groudier@club-internet.fr>
> 
>    If now, the PCI stuff is claimed to be cleaned up, then _all_ the
>    hacks have to be removed definitely.  As a result, the driver will
>    not work anymore on Sparc64, neither on PPC and I am not sure it
>    will still work on Alpha, in my opinion.
> 
> Actually Gerard, in your current 2.4.x NCR53c8xx and SYM53c8XX drivers
> only real ifdefs for sparc64 are printf format strings for PCI interrupt
> numbers :-)
> 
> Really, in 2.4.x sparc64 requires PCI config space hackery no longer.

Really?

I was thinking about the pcivtophys() alias bus_dvma_to_mem() hackery used
to retrieve the actual BAR address from the so-called pcidev bar cookies.

As you know the driver needs to know the actual values of MEM BARs, since
SCRIPTS may access either the IO registers and/or the on-chip RAM using
non sci-fi but actual BUS adresses (those that are actually used by PCI
transactions and that devices compare against their BARs in order to
claim access they are targetted).

Even for chips that donnot actually master themselves (896 for example),
due to LOAD/STORE and using internal cycles to access the on-chip RAM, 
the actual on-chip RAM BAR address we need.

Note that if reading the BARs using pci_read_config_*() interface is
allowed, then the pcivtophys() is and was an useless thing.

About the PPC, it is the memcpy_toio() for the on-chip RAM that does not
work using iomapped bar cookie. The driver has to use SCRIPT that does
self-mastering, but self-mastering is no more compliant with PCI-2.2 as we
know.

About the Alpha. The pcivtobus/bus_dvma_to_mem thing in the driver, is not
defined as just nilpotent, but in fact it is so (d & 0xffffffff) at least
for 32 bit scsi-fi cookies.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
