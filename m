Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQJaXGM>; Tue, 31 Oct 2000 18:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbQJaXFx>; Tue, 31 Oct 2000 18:05:53 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:4317 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129899AbQJaXFq>; Tue, 31 Oct 2000 18:05:46 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 31 Oct 2000 14:52:34 -0800 (PST)
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF4E53.481B5EE2@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010311451340.6447-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't doubt it. a port of netware that can run linux apps would be very
useful to people who want to run netware, but this is not the same thing
as what it has sounded like you were working on.

David Lang

 On Tue, 31 Oct 2000, Jeff
V. Merkey wrote:

> Date: Tue, 31 Oct 2000 15:57:23 -0700
> From: Jeff V. Merkey <jmerkey@timpanogas.org>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.2.18Pre Lan Performance Rocks!
> 
> 
> 
> David Lang wrote:
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > 
> > Jeff, one other thing. Linux is not x86 hand-crafted assembler, it's
> > capable of running on many platforms. are you planning on giving up this
> > capability or hand crafting the kernel for each chip?
> > 
> > Linux on x86 is nice (and I do use it a lot) but one of the things that
> > makes it so useful is that when you do outgrow what youcan do on a x86
> > platform you cna move to a more powerful platform without having to change
> > to a different OS.
> 
> How about a NetWare like NOS with all the application support of Linux? 
> I think a lot of people will love it.  Novell's largest customers have
> told me they want to see it, and would deploy it.  I do believe there's
> a market for such a beast.  A very lucrative one...
> 
> Jeff
> 
> > 
> >  David Lang
> > 
> > On Tue, 31 Oct 2000,
> > Jeff V. Merkey wrote:
> > 
> > > Date: Tue, 31 Oct 2000 15:45:45 -0700
> > > From: Jeff V. Merkey <jmerkey@timpanogas.org>
> > > To: Andi Kleen <ak@suse.de>, mingo@elte.hu, Pavel Machek <pavel@suse.cz>,
> > >      linux-kernel@vger.kernel.org
> > > Subject: Re: 2.2.18Pre Lan Performance Rocks!
> > >
> > >
> > >
> > > One more optimization it has.  NetWare never "calls" functions in the
> > > kernel.  There's a template of register assignments in between kernel
> > > modules that's very strict (esi contains a WTD head, edi has the target
> > > thread, etc.) and all function calls are jumps in a linear space.
> > > layout of all functions are 16 bytes aligned for speed, and all
> > > arguments in kernel are passed via registers.  It's a level of
> > > optimization no C compiler does -- all of it was done by hand, and most
> > > function s in fast paths are layed out in 512 byte chunks to increases
> > > speed.  Stack memory activity in the NetWare kernel is almost
> > > non-existent in almost all of the "fast paths"
> > >
> > > Jeff
> > >
> > > "Jeff V. Merkey" wrote:
> > > >
> > > > A "context" is usually assued to be a "stack".  The simplest of all
> > > > context switches
> > > > is:
> > > >
> > > >    mov    x, esp
> > > >    mov    esp, y
> > > >
> > > > A context switch can be as short as two instructions, or as big as a TSS
> > > > with CR3 hardware switching,
> > > >
> > > > i.e.
> > > >
> > > >    ltr    ax
> > > >    jmp    task_gate
> > > >
> > > > (500 clocks later)
> > > >
> > > >    ts->eip gets exec'd
> > > >
> > > > you can also have a context switch that does an int X where X is a gate
> > > > or TSS.
> > > >
> > > > you can also have a context switch (like linux) that does
> > > >
> > > >     mov    x, esp
> > > >     mov    esp, y
> > > >     mov    z, CR3
> > > >     mov    CR3, w
> > > >
> > > > etc.
> > > >
> > > > In NetWare, a context switch is an in-line assembly language macro that
> > > > is 2 instructions long for a stack switch and 4 instructions for a CR3
> > > > reload -- this is a lot shorter than Linux.
> > > > Only EBX, EBP, ESI, and EDI are saved and this is never done in the
> > > > kernel, but is a natural
> > > > affect of the Watcom C compiler.  There's also strict rules about
> > > > register assignments that re enforced between assembler modules in
> > > > NetWare to reduce the overhead of a context switch.  The code path is
> > > > very complex in NetWare, and priorities and all this stuff exists, but
> > > > these code paths are segragated so these types of checks only happen
> > > > once in a while and check a pre-calc'd "scoreboard" that is read only
> > > > across processors and updated and recal'd by a timer every 18 ticks.
> > > >
> > > > Jeff
> > > >
> > > >
> > > >
> > > > Andi Kleen wrote:
> > > > >
> > > > > On Tue, Oct 31, 2000 at 02:52:11PM -0700, Jeff V. Merkey wrote:
> > > > > > The numbers don't lie.  You know where the code is.  You notice that
> > > > > > there is a version of
> > > > > > the kernel hand coded in assembly language.  You'l also noticed that
> > > > > > it's SMP and takes ZERO LOCKS during context switching, in fact, most of
> > > > > > the design is completely lockless.
> > > > >
> > > > > I suspect most of the confusion in this thread comes because you seem to
> > > > > use a different definition of context switch than Ingo and others. Could
> > > > > you explain what you exactly mean with a context switch ?
> > > > >
> > > > > -Andi
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > Please read the FAQ at http://www.tux.org/lkml/
> > >
> > 
> > -----BEGIN PGP SIGNATURE-----
> > Version: PGP 6.5.2
> > 
> > iQEVAwUBOf9LYj7msCGEppcbAQFdZQgAocWtMwnNmmLnfSS+cGHZd8V0IFfmoVb7
> > fDRoNWMmOzU5g5W8aAudQFqGpGqizBR8/AA9ziqHRfKxwoo5/nuHtEMDpfw0nV5e
> > ghsd7qtzv1kTk0l5zp6bN2qPlGgs7Ke72od10X6pTGDyuUDQK71YNQ9UUcCv8GEO
> > 2PpPOnCHw3atuQ0hetMNcFfIdvvslTB2+pcVzYxWWGhCYIeWreF8w1qf8XDYQil9
> > Ih22vmu69LP03RwXkFioikVSK8F8m+31DUBA67exN+R4qXy8+U5ZtyPQ+onIeguh
> > SnADBNjGjWK2mPyLNSVyAwH6EsIaGzk1QJ5hYULzVFi4zVl3pyRi8w==
> > =91LL
> > -----END PGP SIGNATURE-----
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
