Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRAONHG>; Mon, 15 Jan 2001 08:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbRAONGz>; Mon, 15 Jan 2001 08:06:55 -0500
Received: from smtppop2pub.gte.net ([206.46.170.21]:17222 "EHLO
	smtppop2pub.verizon.net") by vger.kernel.org with ESMTP
	id <S129805AbRAONGt>; Mon, 15 Jan 2001 08:06:49 -0500
Message-ID: <3A62F5BD.24C8C687@gte.net>
Date: Mon, 15 Jan 2001 08:06:05 -0500
From: Stephen Clark <sclark46@gte.net>
Reply-To: sclark46@gte.net
Organization: Paradigm 4
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <20010112212427.A2829@suse.cz> <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com> <20010113150046.E1155@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sucks! I have had several systems with VIA chipsets and have never had any
problems. Currently I am running a SOYO K6-2 system with UDMA 33 and a SOYO K-7
system with both UDMA-33 and UDMA-66 with not problems. How do we know that
there is not some related hardware problem, (cable, power supply, etc ) with the
systems that reported problems? What percentage of people are running OK VS
those that are not?

Now everybody with a VIA chipset is going to be punished!

My $.02
Steve

Vojtech Pavlik wrote:

> On Fri, Jan 12, 2001 at 04:09:22PM -0800, Linus Torvalds wrote:
>
> > On Fri, 12 Jan 2001, Vojtech Pavlik wrote:
> > >
> > > However - Alan's IDE patch for 2.2 kills autodma on ALL VIA chipsets.
> > > That's because all VIA chipsets starting from vt82c586 to vt82c686b
> > > (UDMA100), share the same PCI ID.
> > >
> > > Would you prefer to filter just vt82c586 and vt82c586a as the comment in
> > > Alan's code says or simply unconditionally kill autodma on all of VIA
> > > chipsets, as Alan's code does?
> >
> > Right now, for 2.4.1, I'd rather have the patch to just do the same as
> > 2.2.x. We can figure it out better when we get a better idea of exactly
> > what the bug is, and whether there is some other work-around, and whether
> > it is 100% certain that it is just those two controllers (maybe the other
> > ones are buggy too, but the 2.2.x tests basically cured their symptoms too
> > and peopl ehaven't reported them because they are "fixed").
> >
> >               Linus
>
> Ok, here goes the patch.
>
> Note that with this patch, all VIA users will get IDE transferrates
> about 3 MB/sec as opposed to about 20 MB/sec without it (and with
> UDMA66).
>
> This patch disables automatic DMA on all VIA chipsets, including the
> ancient 82c561 for 486's, and up to the 686a UDMA66 chipset.
>
> Also note that enabling the DMA later with hdparm -X66 -d1 or similar
> command is not safe, and usually works by pure luck on VIA chipsets.
> This however, would need some non-minor changes to the generic code to
> fix.
>
> But perhaps it's still worth ...
>
> --
> Vojtech Pavlik
> SuSE Labs
>
>   ------------------------------------------------------------------------
>
>    via-no-autodma.diffName: via-no-autodma.diff
>                       Type: Plain Text (text/plain)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
