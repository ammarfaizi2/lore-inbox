Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQLKXiD>; Mon, 11 Dec 2000 18:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLKXhx>; Mon, 11 Dec 2000 18:37:53 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:46517 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129983AbQLKXhj> convert rfc822-to-8bit; Mon, 11 Dec 2000 18:37:39 -0500
Date: Mon, 11 Dec 2000 23:07:01 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "David S. Miller" <davem@redhat.com>
cc: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <200012112221.OAA01081@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10012112250330.2255-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, David S. Miller wrote:

>    Date: Mon, 11 Dec 2000 22:30:59 +0100 (CET)
>    From: Gérard Roudier <groudier@club-internet.fr>
> 
>    On Mon, 11 Dec 2000, David S. Miller wrote:
> 
>    > Really, in 2.4.x sparc64 requires PCI config space hackery no longer.
> 
>    Really?
> 
>    I was thinking about the pcivtophys() alias bus_dvma_to_mem() hackery used
>    to retrieve the actual BAR address from the so-called pcidev bar cookies.
> 
> Really :-)  This conversation was about drivers making modifications
> to PCI config space areas which are being argued to be only modified
> by arch-specific PCI support layers.  That is the context in which
> I made my statements.

Was more general in my opinion. :-)

> Interpreting physical BAR values is another issue altogether.  Kernel
> wide interfaces for this may be easily added to include/asm/pci.h
> infrastructure, please just choose some sane name for it and I will
> compose a patch ok? :-)

Really? :-)

It is the bar cookies in pci dev structure that are insane, in my opinion.

If a driver needs BARs values, it needs actual BARs values and not some
stinking cookies. What a driver can do with BAR cookies other than using
them as band-aid for dubiously designed kernel interface.

BUT, a driver does not care about handles passed to read*/write* and
friends and should not have to care. Using cookies, handle or tag or
whatever means 'user should not worry about but just pass them when
needed' is good here.

So, if you want to fix this insane PCI interface:

1) Provide the _actual_ BARs values in the pci dev structure, otherwise 
   drivers that need them will have to deal with ugly hackery or access 
   explicitely the PCI configuration space.

2) Provide an interface that accepts the PCI dev and the BAR offset as
   input and that return somes cookie for read*/write* interface.
       GiveMeSomeCookieForMmIo(pcidev, bar_offset).

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
