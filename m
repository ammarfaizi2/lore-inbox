Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311578AbSCNKOp>; Thu, 14 Mar 2002 05:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311580AbSCNKOg>; Thu, 14 Mar 2002 05:14:36 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9221 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S311578AbSCNKOS>;
	Thu, 14 Mar 2002 05:14:18 -0500
Date: Thu, 14 Mar 2002 11:14:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Daniela Engert <dani@ngrt.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <martin@dalecki.de>, Shawn Starr <spstarr@sh0n.net>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314111416.A5613@ucw.cz>
In-Reply-To: <20020314091808.B31998@ucw.cz> <20020314084211.2611E5246@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314084211.2611E5246@mail.medav.de>; from dani@ngrt.de on Thu, Mar 14, 2002 at 10:48:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:48:10AM +0100, Daniela Engert wrote:

> >00..1f 586
> >20..2f 586a
> >30..3f 586b
> >40..46 586b 3040 silicon
> >Has a bug where the preq# til ddack# bit must be cleared or can cause
> >spontaneous reboots.
> >47..4f 586b 3041 silicon
> 
> True. I leave this particular setup to the BIOS which is supposed to
> take care of such idiosyncrasies...

Unfortunately not all BIOSes do. I have at least two reported buggy
BIOSES which set the bit even on the 3040 silicon.

> >>        0x3109	 VT8233c	      x    x	x    x	   x   x   x   -    -
> >>        0x3147	 VT8233a	      x    x	x    x	   x   x   x   x    -
> >> 
> >>  known bugs:
> >>    - all:  no host side cable type detection.
> >
> >Not true, for the UDMA100 and UDMA133 capable ones, there are defined
> >bits in the UDMA_TIMING register. Not all BIOSes use those, though.
> 
> Interesting. None of the user reports ever indicated that.

It's possible the BIOSes don't set the bits. My driver also checks if
the BIOS enabled UDMA >= 44MB/s on these chips, assuming 80 cable as
well.

Anyway, the docs state the bits should reflect the cable presence.

> >> --------------------------------------------------------------------------------
> >>  0x10DE Nvidia
> >>    0x01BC     nForce		      x    x	x    x	   x   x   x   -    -
> >> 
> >>  known bugs:
> >>    - nForce: no host side cable type detection.
> >
> >Do you have any info on this one? I'd really like to have a Linux driver
> >for it ...
> 
> I have no docs, but my father's machine has this chip built in :-) My
> driver is running it just fine. In fact, this is a clone of the ATA/100
> capable AMD IDE chip cell with all config register addresses shifted up
> by 0x10.

Thanks for this info. :) I think I'll add the support to my AMD driver.
Could you by any chance send me a PCI config space dump of the IDE
controller there?

> I'm looking forward to the new ATI chipset, let's bet where their IDE
> cell is licenced from :-)

I don't think it'll be Intel. I bet on VIA ...

-- 
Vojtech Pavlik
SuSE Labs
