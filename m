Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269813AbRHIO3B>; Thu, 9 Aug 2001 10:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269817AbRHIO2m>; Thu, 9 Aug 2001 10:28:42 -0400
Received: from ffmdi5-212-144-149-114.arcor-ip.net ([212.144.149.114]:21748
	"EHLO merv") by vger.kernel.org with ESMTP id <S269813AbRHIO2h>;
	Thu, 9 Aug 2001 10:28:37 -0400
Date: Thu, 9 Aug 2001 16:27:29 +0200
To: Per Jessen <per@computer.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mark H. Wood" <mwood@IUPUI.Edu>
Subject: Re: how to tell Linux *not* to share IRQs ?
Message-ID: <20010809162728.A2854@bombe.modem.informatik.tu-muenchen.de>
Reply-To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Mail-Followup-To: Per Jessen <per@computer.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Mark H. Wood" <mwood@IUPUI.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6E44EE000F26DC@mta1n.bluewin.ch>
User-Agent: Mutt/1.3.18i
From: Andreas Bombe <andreas@bombe.modem.informatik.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 09:03:14PM +0200, Per Jessen wrote:
> On Wed, 8 Aug 2001 12:13:40 -0500 (EST), Mark H. Wood wrote:
> 
> >On Wed, 8 Aug 2001, Andrew McNamara wrote:
> >[snippage]
> >> The problem is largely historical - each interrupt traditionally had a
> >> physically line associated with it, and lines on your backplane were a
> >> limited resource.
> >>
> >> If you were to do it again these days, you might have some sort of
> >> shared serial bus, so devices could give detailed data to the cpu
> >> (not only to uniquely identify the interrupting device, but also
> >> identify sub-devices - say a USB peripheral).
> >
> >See for example "vectored interrupts" on the PDP10.  The device driver
> >tells the device where the driver's ISR is, and when the device
> >interrupts, it puts that address on the bus.  The interrupt logic jumps
> >directly to the ISR, which "knows" it is the only driver that would be
> >interested in this interrupt.  (You could set up a jump table if you
> >wanted to, so that each device of the same type could identify itself
> >uniquely, but that typically wasn't a big problem in '10 installations
> >where multiples were most likely in a PDP11 on the other side of a DTE20,
> >or Massbus devices on a single RH20.)
> >
> >Apparently this idea is now so old that it is new. :-)
> 
> Yeah - I believe the same was possible on the Z80 - though I'd have to 
> go read the manual to be certain.

And with the m68k, too.  In fact, that's what it always tries to do.  It
runs an interrupt acknowledge cycle when an interrupt is raised so that
the interrupting device can respond with an 8 bit vector number which is
used to load the address of the handler from the vector table.

When the /AVEC (autovector) input is true it generates a vector number
automatically depending on the interrupt level.  So it supports both
modes of operation.

So it's not like the PDP-10 was the only to do that.  If only a better
design would have become standard instead of the ugly IBM PC
architecture...

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
