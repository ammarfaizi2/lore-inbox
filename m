Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSJZFN6>; Sat, 26 Oct 2002 01:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbSJZFN6>; Sat, 26 Oct 2002 01:13:58 -0400
Received: from gate.gau.hu ([192.188.242.65]:41369 "EHLO gate.gau.hu")
	by vger.kernel.org with ESMTP id <S261859AbSJZFN4>;
	Sat, 26 Oct 2002 01:13:56 -0400
Date: Sat, 26 Oct 2002 07:12:36 +0200 (CEST)
From: Cajoline <cajoline@andaxin.gau.hu>
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: ASUS TUSL2-C and Promise Ultra100 TX2
In-Reply-To: <008701c27c93$50d9c140$020da8c0@nitemare>
Message-ID: <Pine.LNX.4.44.0210260632370.13879-100000@andaxin.gau.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Oct 2002, Robbert Kouprie wrote:

> Cajoline writes:
>
> > I recently setup a box with the following components:
> > Intel Celeron 1300 MHz
> > ASUS TUSL2-C motherboard
> > 2 x Promise Ultra100 TX2 controllers
>
> I have a CUSL2-C board, P3-800 Coppermine and a Ultra133TX2 controller.

This board should be rather similar to mine, with the main difference
being suport for Coppermine/Tualatin processors. Does your motherboard
also use the PIIX4 onboard IDE chipset?

>
> > Any 2.4 kernel I have tried on this machine displays this strange
> > a
> > behavior: any drives attached to the PDC controllers only work at udma
> > mode 2 (UDMA33).
>
> I have the same problem. This is a known problem in the vanilla kernels
> (still in 2.4.20-pre11). You can force the right UDMA setting by giving
> a "ideX=ata66" kernel boot parameter, where the "X" is your interface

Indeed, that could be a workaround, but I'm afraid it's not that good
after all, because not all the drives have the same capabilities, it's
still slower than udma 5 (UDMA100) and from my tests, with such a
forced setting, the performance is still poor even for this udma mode.

> number. This is fixed in recent -ac kernels (I tested with
> 2.4.20-pre10-ac2).

This is interesting. Excuse my ignorance, but do you know what has
actually changed exactly regarding PDC20268 and PDC20269? Especially
considering these controllers have been already supported in standard
kernels for some time now, and they do actually work, except for unusual
cases like this, obviously.
I looked through the patch, but I can't say I did quite understand.

>
> > What's even funnier is that if I try to copy files from a
> > filesystem on
> > a
> >
> > drive attached to a PDC20268 and a drive attached to the motherboard
> > controller (PIIX4 chipset), the system eventually locks up
> > (after about
> > 3
> > GB).
> > What I mean by this is that there are no errors whatsoever, from the
> > kernel ide driver, from the filesystem, nothing at all. It just stops
> > responding to anything: login at the console, shell commands, network
> > daemons, everything stops working. You can't even reboot it - a hard
> > reset
> > is required.
>
> This is nasty, I experience this too. This is different from the problem
> you describe earlier. I already checked different recent kernels, BIOS
> versions, NICs, memory, processors, and still it hangs. I suspect it's a
> unknown bug in the driver or a hardware bug in the controller. The
> problem is that it hangs completely dead, giving no information to start
> debugging. :(

OK fine, I agree, but how do you explain this only happens when running on
this motherboard? For some reason I can not explain, I still think it is
related to the specific setup. Otherwise it should eventually occur
under different configurations, yet it never has, at least not for me,
even though I have done quite a number of such tests.

>
> > So I have come to the conclusion there must be some rather bizarre
> >
> > incompatibility between the PDCs and this motherboard.
> > Let me note that the PDC controllers do work just fine with
> > other older
> > motherboards.
>
> Like you, I also have other boxes with Promise Ultra66/100/133
> controllers, with _different_ motherboards, which indeed don't have such
> problem, so the combination of motherboard <-> controller looks
> important here.

Indeed. The same controllers work just fine on a P3 600 + QDI Advance 10F
motherboard (with onboard VIA vt82c686a IDE UDMA66 controller).

>
> > And another thing, during boot-up, the PDCs do show the
> > drives attached to it, detected at the right udma mode.
>
> Ditto.
>
> > I was wondering if anyone has come across this specific problem. I
> > browsed
> >
> > thoroughly through the list archives, but I didn't find any mention of
> > the
> > specific motherboard, or even the PIIX4 chipset and these controllers.
> > I know there is probably no way I can get this hardware to work
> > together,
> > yet I'm curious to know if this has occurred to someone else as well.
>
> Well, it has. And I'm still hoping to solve this one. I an open to any
> suggestions, patches or tests.

Same here.

>
> Regards,
> - Robbert Kouprie
>

Thanks for writing. Now at least I know I'm not the only one experiencing
such bizarre behavior from this hardware :)

Regards,
Cajoline Leblanc

