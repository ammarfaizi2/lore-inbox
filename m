Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSFBVPE>; Sun, 2 Jun 2002 17:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSFBVPD>; Sun, 2 Jun 2002 17:15:03 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54023
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314278AbSFBVPB>; Sun, 2 Jun 2002 17:15:01 -0400
Date: Sun, 2 Jun 2002 14:14:15 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: FUD or FACTS ?? but a new FLAME!
In-Reply-To: <Pine.SOL.4.30.0206021405070.1886-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10206021330120.5846-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Bartlomiej Zolnierkiewicz wrote:

> > So any BIOS/BH's traversed are at risk of there is a media error or any
> > other error event.
> 
> Yes, broken multi-PIO.

Worse than broken, there is not an acceptable interface to honor the
hardware and protect the data, and meet the requirement of the development
kernel.

So I can make it technically correct and operate clean.
I can not promise driver level protection of the data above.
This very issue breaks the requirement of the state diagram for data
transfers.

Offline I will walk you throught the process and requirements.
I am tired of explaining it to people who can not and will not understand
the issue.  Even though I have spent time on may occassions with several
people to explain, they all claim to understand yet none prove it.

For some reason, I trust you get the points and see the magnitude of the
problem.  The issue can you explain it to the rest who you will have to
deal with, because I am done.

So you now it is up to you to fix it, I will answer your questions.

> So what should we do in case of overclocked PCI bus?

Same as in the past, do not support overclocking.

> Get overclocked ATA or try to mess with timings?

Forest Gump, "Stupid is as Stupid does" best answer.

> It is legal according to ATA spec.

For the HOST hardware not for the HOST drivers.
One of the issues in the spec, is the lack of separation of layers.
The spec is two layers not three, and described but the effects on each
end of the cable/ribbon.  Additionally the spec is a one sided set of
rules of how to talk to a device (disk,atapi,etc).  Much like how one has
to address Torvalds.  Talk to a device the wrong way, the operation is
aborted with an error.  Talk to Torvalds the wrong way, you get aborted.

But the SPEC and Torvalds are mutual dictators and react the same way.

> So all hosts are broken in this respect?

This one does not parse well, so I will ask you to clarify it.
However let me define HOST first.

HOST == Interface + Driver.

On the hardware side of the HOST, those values describe are for the
manufactures to make the hardware.  They intern provide tables and rules
for setting the hardware to match discretely to the capablitites of the
devices attached.

Additionally any sane driver would pre-determine the values to be
programmed to insure the communications are proper.  I have a preference
to obtain these values from the vender and then compare on paper before
publishing.  If there is a problem, one would go back the vender of the
hardware and verify the differences.

> > Instead of using the fixed and bounded PIO timing values as set forward by
> > the OEM Chip makers, who know best how their product works.  2.5 now has
> > this charming piece of crap which admits to dorking up the command block
> > transfer timing execution.  OUCH.
> 
> So they are generally broken? If so why there are even registers for
> setting timings, they could have done tables in hardware?

Upon completion of POST it is observed and reported all drives default
their fast io mode.  The origin of the host tuning code happened when most
interfaces were ATA-2 and the drives were ATA-3.  Few people recall the
issues, but they happened like this.

PIIX3 limited to Mult-Word DMA 2 and an Ultra-33 drive attached.
Instant deadlock upon writing to the interface.  The host would wait for
data which was already sent but missed.  The system never booted.

> > Now recall me being called a LIAR by PINHEAD.

I realized a mistake was made here, and should not have stepped into the
sandbox to throw sand.  This was wrong of me to drop to name calling.
I just wish other people were big enough to admit when they are wrong.
I hold little hope of ever seeing an apology from the otherside.

> > I wish somebody would inform Maxtor so it can be made public.
> > On monday I will call one of my contacts there who writes the
> > diskware/firmware, I am sure he will need a good laugh at the beginning of
> > the week.
> 
> Why, I cant get it.

Would you please re-ask the question because I missed it.

> > The latter will not provide usable reports to fix it, while the former
> > will allow one to make it elegant.
> 
> I will try to make the best of the two worlds.

You are my hope in it working, and if I had a choice you would be
Maintainer in 2.5!

> Anyway, thanks for input Andre...

Hey, I own you the thanks for trying to understand and your ablitity to
follow the points.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

