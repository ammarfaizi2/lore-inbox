Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbRGKJOH>; Wed, 11 Jul 2001 05:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267258AbRGKJN5>; Wed, 11 Jul 2001 05:13:57 -0400
Received: from a93-143.dialup.iol.cz ([194.228.143.93]:57288 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S267257AbRGKJNn>;
	Wed, 11 Jul 2001 05:13:43 -0400
Date: Wed, 11 Jul 2001 11:11:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rob Landley <landley@webofficenow.com>
Cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Hardware testing [was Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))]
Message-ID: <20010711111159.A2026@suse.cz>
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01070912485904.00705@localhost.localdomain> <20010710121724.Z1503@niksula.cs.hut.fi> <01071011282504.00634@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01071011282504.00634@localhost.localdomain>; from landley@webofficenow.com on Tue, Jul 10, 2001 at 11:28:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 11:28:25AM -0400, Rob Landley wrote:
> On Tuesday 10 July 2001 05:17, Ville Herva wrote:
> > On Mon, Jul 09, 2001 at 12:48:59PM -0400, you [Rob Landley] claimed:
> > > (P.S. What kind of CPU load is most likely to send a processor into
> > > overheat? (Other than "a tight loop", thanks.  I mean what kind of
> > > instructions?) This is going to be CPU specific, isn't it?  Our would a
> > > general instruction mix that doesn't call halt be enough?  It would need
> > > to keep the FPU busy too, wouldn't it?  And maybe handle interrupts. 
> > > Hmmm...)
> >
> > See Robert Redelmeier's cpuburn:
> >
> > http://users.ev1.net/~redelm/
> 
> Cool.  If nothing else, this is a much better starting point for further work 
> than starting from scratch...
> 
> > It is coded is assembly specificly to heat the CPU as much as possible. See
> > the README for details, but it seems that floating point operations are
> > tougher than integers and MMX can be even harder (depending on CPU model,
> > of course). Not sure what kind of role SSE, SSE2, 3dNow! play these days.
> > Perhaps Alan knows?
> 
> There's at least three seperate things that need testing here.  memtest86 
> tests whether your memory is OK.  CPUburn seems to do a good job testing 
> processor heat (not that I'm running it on my laptop, which doesn't seem to 
> have a thermal readout thingy anyway...)
> 
> The third thing (which started this thread) was memory bus.  The new 3DNow 
> optimizations drove a memory bus into failure, and that IS processor 
> specific...

Don't forget the L1/L2/L3 caches. I had once a mainboard with a faulty
L2 cache chip ('twas a K6-3 CPU, plus a FIC VA-503+ mainboard). No memory
or CPU test found the failure, yet kernel compliation was still crashing
after 6-8 hours.

I modified the 'memtest.c' little proggy (not the big memtest86, just a
little utility that runs under Linux), to use patterns and test size
that tests the L1 and then L2, and the error has shown after ten seconds
of running the test.

-- 
Vojtech Pavlik
SuSE Labs
