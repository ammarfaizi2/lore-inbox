Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBAVwe>; Thu, 1 Feb 2001 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbRBAVwO>; Thu, 1 Feb 2001 16:52:14 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:38026 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S129116AbRBAVwK>; Thu, 1 Feb 2001 16:52:10 -0500
Message-ID: <3A79DA7F.4B8AA239@voicenet.com>
Date: Thu, 01 Feb 2001 16:51:59 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <20010201190653.H2341@suse.cz> <Pine.LNX.4.21.0102011316210.27273-100000@winds.org> <20010201215116.A3239@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> On Thu, Feb 01, 2001 at 01:20:00PM -0500, Byron Stanoszek wrote:
>
> > > On Thu, Feb 01, 2001 at 11:46:08AM -0500, Byron Stanoszek wrote:
> > >
> > > > Yeah, by bios does the same thing too on the Abit KT7(a).
> > >
> > > Ok, I'll remember this. This is most likely the cause of the problems
> > > many people had with the KT7 in the past.
> >
> > What cause are you referring to? As far as I know, there are two options to
> > increasing the FSB clock.. one increases both FSB+PCICLK, the other just
> > increases FSB. If you increase the FSB only, it should keep PCICLK at a solid
> > 33. (But I could be wrong, I've never tested that. I can tomorrow though.)
>
> I mean that people can alter the PCI clock on these boards and that 33
> doesn't to be always exactly 33 due to rounding errors if used with a
> FSB other than 66 or 100 or 133.
>
> Could it be that the PCI bus is not asynchronous, but only
> pseudo-synchronous, allowing for divisors of 5, 4.5, 4, 3.5, 3, 2.5, 2?
>
> > > The U33 chips do UDMA timing in PCICLK (T = 30ns @ 33MHz) increments, U66 in
> > > PCICLK*2 (T = 15ns @ 33 MHz) increments, and for U100 it's assumed that
> > > there is an external 100MHz clock fed to the chip, so that the UDMA timing is
> > > in T = 10ns increments independent of the PCICLK. I'm not 100% sure about
> > > the last, it might be just PCICLK*3 (T = 10ns @ 33 MHz). An experiment needs
> > > to be carried out to verify this.
> >
> > I don't have a KT7A personally, I only have a KT7. Can anyone else with a KT7A
> > verify this? By verify, I take it you mean to use idebus=33 and overclock
> > PCICLK? :) At least that would determine if UDMA100 is based on PCI or an
> > external 100MHz source.
>
> Actually he should use the correct idebus= so that the Active/Recover
> timings are correct. If KT7A doesn't work with UDMA at high PCI clocks
> *even when* idebus= is correct would mean that the UDMA timing is in
> 1/(PCICLK*3) units instead of units of 10ns.
>
> Anyone help us?
>
> --
> Vojtech Pavlik
> SuSE Labs

I for one dont use the KT7 motherboards    but i know from experience that
increasing the FSB only effects ram speed ( at least negatively anyway)  i have
100Mhz ram and 133Mhz ram so once i'm at 114Mhz the 100Mhz ram cant handle too much
more ..   so 114Mhz is what i stay at.   My PCI clock is not changed at all and so
far (for the last couple days) the hdd's on my idebus have not had any problems what
so ever.   Sorry but i've only got UDMA66 drives and idebus is whatever the 2.2.x
kernel defaults to.    I'm guessing any sort of corruption caused by 2.4.x had
something to do with that dirty page writes mail that was sent to the list a while
ago and was probably fixed but never made it to the changelog.     I'll stick to 2.2
until 2.5 though just in case.    What would be interesting is figuring out why the
kernel can't recover somehow from infinite ide irq reset loops which are usually
brought on by dma timeouts.   That would at least somewhat usefull for when they
actually happen (I saw them numerous times in 2.4.x but not since going back to
2.2.x).


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
