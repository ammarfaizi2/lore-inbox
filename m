Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSB0AaL>; Tue, 26 Feb 2002 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSB0AaC>; Tue, 26 Feb 2002 19:30:02 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:14840 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S290277AbSB0A3v> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 19:29:51 -0500
Date: Wed, 27 Feb 2002 01:29:35 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 3c59x and cardbus
In-Reply-To: <20020226230010.GI803@ufies.org>
Message-ID: <Pine.GSO.4.30.0202270126570.28095-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get very similar error if I remove the module and then reload it (rmmod
followed by a modprobe). So once I rmmod it, It will never be usable again
until i reboot.

I have to pci 3com 905's, I can send the pci id's if those matters
tomorrow.


On Tue, 26 Feb 2002, christophe [iso-8859-15] barbé wrote:

> Now that the forget_option bug is solved I have the following :
>
> Each time I suspend, the card resume in a bad state but return in a good
> state after that :
>
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e000.
>   diagnostics: net 0ee0 media 8800 dma 000000a0.
>   Flags; bus-master 1, dirty 20(4) current 36(4)
>   Transmit list 00af8300 vs. c0af8300.
>   0: @c0af8200  length 80000062 status 00000062
>   1: @c0af8240  length 80000062 status 00000062
>   2: @c0af8280  length 80000062 status 80000062
>   3: @c0af82c0  length 80000062 status 80000062
>   4: @c0af8300  length 80000062 status 00000062
>   5: @c0af8340  length 8000003c status 0000003c
>   6: @c0af8380  length 80000062 status 00000062
>   7: @c0af83c0  length 80000062 status 00000062
>   8: @c0af8400  length 8000003c status 0000003c
>   9: @c0af8440  length 80000062 status 00000062
>   10: @c0af8480  length 80000062 status 00000062
>   11: @c0af84c0  length 80000036 status 00000036
>   12: @c0af8500  length 80000062 status 00000062
>   13: @c0af8540  length 80000062 status 00000062
>   14: @c0af8580  length 80000062 status 00000062
>   15: @c0af85c0  length 80000062 status 00000062
> eth0: Resetting the Tx ring pointer.
>
> The tx ring seems to be in a good state, no ?
>
> Christophe
>
> On Tue, Feb 26, 2002 at 01:59:07PM -0500, christophe barbé wrote:
> > Thank you, I have done something similar and that solve it in my case at
> > least. This driver was clearly not designed for cardbus.
> >
> > I am still looking for my resume/suspend problem.
> > Hope to find the solution soon.
> >
> > Christophe
> >
> > On Tue, Feb 26, 2002 at 10:51:08AM -0800, Andrew Morton wrote:
> > > christophe barbé wrote:
> > > >
> > > > Ok I have found why.
> > > > When I resinsert the card, the driver give it a new id (this driver
> > > > supports multiple cards) and the option as I set it is only defined for
> > > > the card #0. I would expect that the driver give the same id back.
> > > >
> > >
> > > hrm.  OK, hotplugging and slot-positional module parameters weren't
> > > designed to live together.
> > >
> > > This should fix it for single cards.   For multiple cards, you'll
> > > have to make sure you eject them in reverse scan order :)
> > >
> > > Index: drivers/net/3c59x.c
> > > ===================================================================
> > > RCS file: /opt/cvs/lk/drivers/net/3c59x.c,v
> > > retrieving revision 1.74.2.7
> > > diff -u -r1.74.2.7 3c59x.c
> > > --- drivers/net/3c59x.c	2002/02/13 21:03:03	1.74.2.7
> > > +++ drivers/net/3c59x.c	2002/02/26 18:49:24
> > > @@ -2898,6 +2898,9 @@
> > >  		BUG();
> > >  	}
> > >
> > > +	if (vp->card_idx == vortex_cards_found)
> > > +		vortex_cards_found--;
> > > +
> > >  	vp = dev->priv;
> > >
> > >  	/* AKPM: FIXME: we should have
> > >
> > >
> > > -
> >
> > --
> > Christophe Barbé <christophe.barbe@ufies.org>
> > GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
> >
> > Imagination is more important than knowledge.
> >    Albert Einstein, On Science
>
>
>
> --
> Christophe Barbé <christophe.barbe@ufies.org>
> GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
>
> Imagination is more important than knowledge.
>    Albert Einstein, On Science
>

-- 
pozsy

