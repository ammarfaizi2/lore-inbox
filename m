Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLLWAS>; Tue, 12 Dec 2000 17:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbQLLWAJ>; Tue, 12 Dec 2000 17:00:09 -0500
Received: from front1.grolier.fr ([194.158.96.51]:12416 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S129906AbQLLV7x> convert rfc822-to-8bit; Tue, 12 Dec 2000 16:59:53 -0500
Date: Tue, 12 Dec 2000 21:28:18 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "David S. Miller" <davem@redhat.com>
cc: mj@suse.cz, lk@tantalophile.demon.co.uk, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <200012122014.MAA05129@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10012122106020.1501-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2000, David S. Miller wrote:

>    Date: Tue, 12 Dec 2000 20:17:21 +0100 (CET)
>    From: Gérard Roudier <groudier@club-internet.fr>
> 
>    On Mon, 11 Dec 2000, David S. Miller wrote:
> 
>    > Tell me one valid use of this information first :-)
> 
>    SCRIPTS. Have a look into my kind :-) response to Martin.
> 
> Ok, this I understand.
> 
>    > b) If you wish to interpret the BAR values and use them from a BUS
>    >    perspective somehow, you still need to go through some interface
>    >    because you cannot assume what even the hw BAR values mean.
>    >    This is precisely the kind of interface I am suggesting.
> 
>    The BAR values make FULL sense on the BUS.
> 
> I am saying there may be systems where it does not make any sense,
> f.e. actually used bits of BAR depend upon whether CPU, or DEVICE on
> that bus, or DEVICE on some other bus make the access.
>
> Forget all the PCI specifications, it is irrelevant here.  All your
> PCI expertiece means nothing, nor mine.  People build dumb machines
> with "PCI implementations" and we need to handle them.

Even the dumbest PCI implementation will keep with BAR relevance. Reason
is that PCI devices are using BAR values and corresponding size to make
decision about claiming or not a transaction as target.
You can be as dump as you want with PCI, but not that much. :-)

>    I will wait for your .txt file that describes your idea. Your
>    documentation about the new DMA mapping had been extremally useful.
>    Let me thank you again for it.
> 
> It requires no .txt file :-), 

No problems, a ".text" file would also fit just fine. :-)

> it will just be formalization of
> existing bus_to_dvma_whatever hack :-) Specify PDEV (device) and
> RESNUM (which I/O or MEM resource for that device), returns either
> error or address as seen by BUS that PDEV is on.  You may offset
> this return value as desired, up to the size of that resource.
> 
> I could make a more elaborate interface (add new parameter,
> PDEV_MASTER which is device which wishes to access area described by
> PDEV+RESNUM), allowing full PCI peer-to-peer setup, as described by
> someone else in another email of this thread.  This version would have
> an error return, since there will be peer2peer situations on some
> systems which cannot be made.  But I feel this is inappropriate until
> 2.5.x, others can disagree.

I saw the proposal.

Btw, unlike the person, that proposed it, that will be able to test
peer-to-peer unability only, my current machine will allow to test
peer-to-peer ability only between 2 different PCI BUSes. :-)

For now, my intention is to encapsulate the right interface as seen from
my brain device in macros and forget about it until a new interface will
be provided. I will first implement it on SYM-2 and backport changes to
sym53c8xx later. And since I need the new major driver version to be
tested on non-Intel platforms, this will make full synergy for the
testings. :-)

Bye,
  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
