Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSFVDAk>; Fri, 21 Jun 2002 23:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSFVDAj>; Fri, 21 Jun 2002 23:00:39 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:10119 "EHLO
	pimout4-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316831AbSFVDAi>; Fri, 21 Jun 2002 23:00:38 -0400
Message-Id: <200206220300.g5M30VO354182@pimout4-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: latest linus-2.5 BK broken
Date: Fri, 21 Jun 2002 17:02:09 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201428481.8225-100000@home.transmeta.com> <3D125032.3040809@evision-ventures.com>
In-Reply-To: <3D125032.3040809@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 05:59 pm, Martin Dalecki wrote:

> Well but this simply still doesn't make SMP magically scale
> better. HT gives you about 12% increase in throughput on average.
> This will hardly increase your MP3 ripping expierence :-).

HT is currently sopping up the idle time on the second and third execution 
core in the processor, and the fact that the processor before HT only had as 
many cores as it could at least sometimes use means that these execution 
cores aren't always idle.

That said, there's nothing to stop them from adding a fourth or even fifth 
execution core to the die and getting a 25% boost, and then a fifth core and 
getting a little boost form that too.  (And when you add the sixth core, 
teach the processor about the concept of a third thread, at which point you 
just write in instruction dispatcher feeding an arbitrary number of thread 
instruction streams into an arbitrary number of execution cores, and then add 
cores to your heart's content until you start having numa problems in your L1 
cache... :)

By the way, your mp3 ripping experience is largely about latency, which HT 
does help.  (Realtime is all about getting a tiny amount of work done NOW, 
rather than a lot of work done after a significant fraction of a second 
scheduling delay.)  As long as ripping and playback don't skip, processes 
that can be batched aren't really the problem.  (Suck this CD dry, crunch it 
to files in this directory, I'm going to answer email in the meantime.)

> > When you integrate multiple CPU's on one standard die (either HT or real
> > CPU's), the same thing happens.
>
> Again HT is still only one CPU. You are too software centric :-).

It's a CPU that literally can advance two processes at once.  Not "time 
slice, time slice, time slice" with evil context switches in between trashing 
your cache, but actual parallel processing.

My understanding is that with HT turned on, one of your three execution cores 
is devoted to each thread, and they get to fight over who gets to use the 
third each clock cycle.  So you get to queue up DMA for that screaming scsi 
card without waiting for your other system call to exit its critical region.  
Hence the latency picture is REALLY NICE...

> However corssbar switches are indeed allowing for maximally
> 64 CPUs and more importantly it's the first step since a long time
> to provide better overall system throughput. However they will still
> not be near any commodity - too much heat for the foreseeable future.

If you can do 8-way SMP/SMT on a chip (does SMT with twice as many execution 
cores as threads count as "real" SMP to you?), and then you fit that in an 
8-way motherboard, boom: you have 64 way.  Without really needing crossbar 
switches if you don't want to go that way...

Sooner or later they'll just have an arbitrary execution core scheduler, and 
they won't have a fixed ratio of threads to cores, you'll just feed the 
chip what you've got and it'll power down any cores that aren't in use this 
clock cycle.  I can easily see transmeta scaling code morphing up to dozens 
or even hundreds of execution in that case...

That's a few years in the future, though.

> > A 3D tech person might say that the technology is still the same.
> >
> > But a real human will notice that it's radically different.
>
> Yes but you can drive the technology only up to the perceptual limits
> of a human. For example since about 6 years all those advancements
> in the graphics area are largely uninterresting to me. I don't
> play computer games. Never - they are too boring. Jet another
> fan in my computer - no thank's.

"It doesn't interst me so it's not interesting" is not a good argument, but 
the fact that the human visual perception threshold has long been reported to 
be 80 million triangles per second and we're approaching the ability to do 
that in real time with commodity off the shelf video cards.  (Another two or 
three generations of moore's law and we WON'T be able to see the 
difference...)  That is a point.

> Well the last real technological jump comparable to the invention
> of television was actually due to this kind of CPUs which you
> compare to microbes - mobiles :-). And well I'm awaiting the
> day where there will be some WinWLAN card as shoddy as those Win
> modems are... Fortunately they made 802.11b complicated enough :-)
> But with a corssbar switch in place they could well make up for
> the latency on the main CPU... oh fear... oh scare...

The latency in the cat 5 dwarfs any latency you're going to have on the 
motherboard, and that's something they deal with by just making gigabit and 
higher synchronous.  No reason you can't have a win-ethernet card except that 
100baseT is now $4.50 on a card (and a lot less on a chip on the motherboard, 
and that's just a licensing cost, the IC is pennies), and your "last mile" 
cable modem or DSL still isn't maxing out the ten magabit ethernet connection 
you're really hooking up to the internet through...

There's no excess cost to squeeze out of here by going to a DSP...

Rob
