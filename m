Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRBAUvu>; Thu, 1 Feb 2001 15:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131619AbRBAUva>; Thu, 1 Feb 2001 15:51:30 -0500
Received: from styx.suse.cz ([195.70.145.226]:22525 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131476AbRBAUvX>;
	Thu, 1 Feb 2001 15:51:23 -0500
Date: Thu, 1 Feb 2001 21:51:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Byron Stanoszek <gandalf@winds.org>
Cc: safemode <safemode@voicenet.com>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010201215116.A3239@suse.cz>
In-Reply-To: <20010201190653.H2341@suse.cz> <Pine.LNX.4.21.0102011316210.27273-100000@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102011316210.27273-100000@winds.org>; from gandalf@winds.org on Thu, Feb 01, 2001 at 01:20:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 01:20:00PM -0500, Byron Stanoszek wrote:

> > On Thu, Feb 01, 2001 at 11:46:08AM -0500, Byron Stanoszek wrote:
> > 
> > > Yeah, by bios does the same thing too on the Abit KT7(a).
> > 
> > Ok, I'll remember this. This is most likely the cause of the problems
> > many people had with the KT7 in the past.
> 
> What cause are you referring to? As far as I know, there are two options to
> increasing the FSB clock.. one increases both FSB+PCICLK, the other just
> increases FSB. If you increase the FSB only, it should keep PCICLK at a solid
> 33. (But I could be wrong, I've never tested that. I can tomorrow though.)

I mean that people can alter the PCI clock on these boards and that 33
doesn't to be always exactly 33 due to rounding errors if used with a
FSB other than 66 or 100 or 133.

Could it be that the PCI bus is not asynchronous, but only
pseudo-synchronous, allowing for divisors of 5, 4.5, 4, 3.5, 3, 2.5, 2?

> > The U33 chips do UDMA timing in PCICLK (T = 30ns @ 33MHz) increments, U66 in
> > PCICLK*2 (T = 15ns @ 33 MHz) increments, and for U100 it's assumed that
> > there is an external 100MHz clock fed to the chip, so that the UDMA timing is
> > in T = 10ns increments independent of the PCICLK. I'm not 100% sure about
> > the last, it might be just PCICLK*3 (T = 10ns @ 33 MHz). An experiment needs
> > to be carried out to verify this.
> 
> I don't have a KT7A personally, I only have a KT7. Can anyone else with a KT7A
> verify this? By verify, I take it you mean to use idebus=33 and overclock
> PCICLK? :) At least that would determine if UDMA100 is based on PCI or an
> external 100MHz source.

Actually he should use the correct idebus= so that the Active/Recover
timings are correct. If KT7A doesn't work with UDMA at high PCI clocks
*even when* idebus= is correct would mean that the UDMA timing is in
1/(PCICLK*3) units instead of units of 10ns.

Anyone help us?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
