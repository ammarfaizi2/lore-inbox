Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRGKAaz>; Tue, 10 Jul 2001 20:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265933AbRGKAaq>; Tue, 10 Jul 2001 20:30:46 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:53960 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265277AbRGKAaf>; Tue, 10 Jul 2001 20:30:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Subject: Hardware testing [was Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))]
Date: Tue, 10 Jul 2001 11:28:25 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01070912485904.00705@localhost.localdomain> <20010710121724.Z1503@niksula.cs.hut.fi>
In-Reply-To: <20010710121724.Z1503@niksula.cs.hut.fi>
MIME-Version: 1.0
Message-Id: <01071011282504.00634@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 July 2001 05:17, Ville Herva wrote:
> On Mon, Jul 09, 2001 at 12:48:59PM -0400, you [Rob Landley] claimed:
> > (P.S. What kind of CPU load is most likely to send a processor into
> > overheat? (Other than "a tight loop", thanks.  I mean what kind of
> > instructions?) This is going to be CPU specific, isn't it?  Our would a
> > general instruction mix that doesn't call halt be enough?  It would need
> > to keep the FPU busy too, wouldn't it?  And maybe handle interrupts. 
> > Hmmm...)
>
> See Robert Redelmeier's cpuburn:
>
> http://users.ev1.net/~redelm/

Cool.  If nothing else, this is a much better starting point for further work 
than starting from scratch...

> It is coded is assembly specificly to heat the CPU as much as possible. See
> the README for details, but it seems that floating point operations are
> tougher than integers and MMX can be even harder (depending on CPU model,
> of course). Not sure what kind of role SSE, SSE2, 3dNow! play these days.
> Perhaps Alan knows?

There's at least three seperate things that need testing here.  memtest86 
tests whether your memory is OK.  CPUburn seems to do a good job testing 
processor heat (not that I'm running it on my laptop, which doesn't seem to 
have a thermal readout thingy anyway...)

The third thing (which started this thread) was memory bus.  The new 3DNow 
optimizations drove a memory bus into failure, and that IS processor 
specific...

> The gcc compile is a good test for many other tests - it uses a lot of
> memory with complex pointers references (tests memory, and bit errors in
> pointers are likely to sig11 rather than produce subtle errors in output),
> stresses chipset somewhat (memory throughput), and cpu somewhat. But to
> test CPU overheating and nothing else, cpuburn should be a lot better.
> (Even seti@home is better as it uses FPU). Just run them an observe the
> sensors readings. Cpuburn gets several degrees higher.

The downside of a test like gcc is that it does test many things, meaning 
when it fails you still don't know why.

memtest86 is great becuase it ONLY tests memory.  CPUburn is similarly 
specific.  A memory bus buster would be a good tool to add to the mix.  (DMA 
is another common problem, but the more I look into it, the more it seems to 
be dependent on whatever peripheral you're talking to, which is more 
complication than I'm looking to bite off...)

The downside of memtest86 is that your system can pass it and still have an 
obvious problem (for example, overclocking stresses both memory bus AND 
heat...)

It might be possible to put all three testers into a menu where you could 
switch on and off what you wanted to test, and run them overnight.  That way, 
if you are testing for three things (perhaps alternating tests every few 
minutes?), and you get it to fail, you can switch some off to get more 
specific tests to narrow down the problem...

> > the compile in a loop, add in a processor temperature detector daemon to
> > kill the test and HLT the system if the temperature went too high...
>
> Cpuburn exists when CPU miscalculates something (sign of overheat).
>
> I'm not sure if cpuburn is included in cerberus these days (istr it is),
> but a nice test set for memory, cpu, disk etc to run over night or over
> weekend to catch most of the hw faults would definetely be nice.

I've heard of ceberus but thought it was just a disk test suite...  One more 
thing to download and look into...  (If the tests in it can be switched 
on/off, maybe this is what I'm looking for...) 

Rob
