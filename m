Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLLUs0>; Tue, 12 Dec 2000 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQLLUsR>; Tue, 12 Dec 2000 15:48:17 -0500
Received: from front2m.grolier.fr ([195.36.216.52]:26102 "EHLO
	front2m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129525AbQLLUsI> convert rfc822-to-8bit; Tue, 12 Dec 2000 15:48:08 -0500
Date: Tue, 12 Dec 2000 20:17:21 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "David S. Miller" <davem@redhat.com>
cc: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <200012112303.PAA01350@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10012121958390.1389-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, David S. Miller wrote:

>    Date: Mon, 11 Dec 2000 23:07:01 +0100 (CET)
>    From: Gérard Roudier <groudier@club-internet.fr>
> 
>    So, if you want to fix this insane PCI interface:
> 
>    1) Provide the _actual_ BARs values in the pci dev structure, otherwise 
>       drivers that need them will have to deal with ugly hackery or access 
>       explicitely the PCI configuration space.
> 
> Tell me one valid use of this information first :-)

SCRIPTS. Have a look into my kind :-) response to Martin.

By the way, the genuine physical addresses, alias pcidev cookies, as seen
from the CPU have exactly NO USE at all, except as input for ioremap().
Drivers can throw them away after that. So, given correct design they
should not even have to deal with them.

> a) If you want to use it to arrive at addresses MEM I/O operations
>    you need to go through something akin to ioremap() first anyways.

ioremap() is the historical successor of vremap(). Without vremap(), it
may well never have existed.

> b) If you wish to interpret the BAR values and use them from a BUS
>    perspective somehow, you still need to go through some interface
>    because you cannot assume what even the hw BAR values mean.
>    This is precisely the kind of interface I am suggesting.

The BAR values make FULL sense on the BUS.

>    Consider even just that top few bits of BAR values on some system
>    have some special meaning, and must be masked out before used from
>    PCI device side transactions.  Perhaps these bits are interpreted
>    somehow at the host bridge when CPU accesses to device MEM or I/O
>    space are made.  I argue not that this is compliant behavior, I
>    argue only that it is something idiots designing hardware will in
>    fact do.  We have seen worse things occur.  Now, subsequently, if
>    we start using raw BARs in drivers these systems (however important
>    or not important) will become difficult to impossible to support.
>    Here the blacklists will end up in your driver, which is where I
>    think both of us will agree they should not be :-)

Read my reply to Martin on that point. 

>    2) Provide an interface that accepts the PCI dev and the BAR offset as
>       input and that return somes cookie for read*/write* interface.
> 	  GiveMeSomeCookieForMmIo(pcidev, bar_offset).
> 
> I do not understand why ioremap() is such a bletcherous interface
> for you :-)  You take resource in PDEV, add desired offset, and pass
> it to ioremap().  What about this sequence requires you to take pain
> killers? :-)  It seems quite straightforward to me.

I can live perfectly with ioremap(). :-))

> We do not want to expose physical BARs because you as a driver have
> no way to portably interpret this information.  On the other hand
> if you tell us "Given PDEV resource X, plus offset Y, give me this
> address in BUS space" we can do that and that is the interface that
> makes sense and is implementable on all architectures.  This is what
> I am proposing for adding asm/pci.h
> 
> Having people read and intepret BARs is not implementable on all
> architecures (see discussion in (b) above).
> 
> I guess there is some fundamental reason you do not like the kernel
> trying to discourage access to physical BARs.  This makes things so
> much easier and cleaner, at least to me.
> 
> I bet we end up in standstill here and ifdef hacks remain in symbios
> drivers :-)))  We will see...

I will wait for your .txt file that describes your idea. Your
documentation about the new DMA mapping had been extremally useful.
Let me thank you again for it.

Bye,
  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
