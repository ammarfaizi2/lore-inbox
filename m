Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbRF2Q2v>; Fri, 29 Jun 2001 12:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265328AbRF2Q2l>; Fri, 29 Jun 2001 12:28:41 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:29780 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264669AbRF2Q2Z>; Fri, 29 Jun 2001 12:28:25 -0400
Date: Fri, 29 Jun 2001 11:28:19 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106291628.LAA09466@tomcat.admin.navo.hpc.mil>
To: caszonyi@yahoo.com, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal 11]
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> --- Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
> wrote:
> > > 
> > > 
> > > "This is almost always the result of flakiness in
> > your hardware - either
> > > RAM (most likely), or motherboard (less likely). 
> > "
> > >                          
> > >                               I cannot understand
> > this. There are many other
> > > stuffs that I compiled with gcc without any
> > problem. Again compilation is only
> > > a application. It  only parse and gernerates
> > object files. How can RAM or
> > > motherboard makes different
> > 
> > It's most likely flackey memory.
> > 
> > Remember- a single bit that dropps can cause the
> > signal 11. It doesn't have
> > to happen consistently either. I had the same
> > problem until I slowed down
> > memory access (that seemd to cover the borderline
> > chip).
> > 
> > The compiler uses different amounts of memory
> > depending on the source file,
> > number of symbols defined (via include headers).
> > When the multiple passes
> > occur simultaneously, there is higher memory
> > pressure, and more of the
> > free space used. One of the pages may flake out.
> > Compiling the kernel
> > puts more pressure on memory than compiling most
> > applications.
> > 
> >
> -------------------------------------------------------------------------
> > Jesse I Pollard, II
> > Email: pollard@navo.hpc.mil
> > 
> > Any opinions expressed are solely my own.
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> Almost always ?
> It seems like gcc is THE ONLY program which gets
> signal 11
> Why the X server doesn't get signal 11 ?
> Why others programs don't get signal 11 ?

Load the system down with lots of processes/large
image windows. Unless the bit in question is in
a pointer, or data used in pointer arithmetic or function call
it won't
segfault. Applications (if an instruction page gets hit)
may get an illegal instruction.

> I remember that once Bill Gates was asked about
> crashes in windows and he said: It's a hardware
> problem.
> It was also a joke on that subject:
> Winerr xxx: Hardware problem (it's not our fault, it's
> not, it's not, it's not, it's not...)

Yup - because it crashed VERY frequently when it was obviously a
software bug.

> Seems to me like Micro$oft way of handling problems.
> 
> We must agree that gcc is full of bugs (xanim does not
> 
> run corectly if it is compiled with gcc 2.95.3 
> and other programs which use floating point
> calculations do the same (spice 3f5))

Generating wrong code is different than a segfault.

Currently I'm using egcs-2.91.66 on a 486, without problems.
(I don't do floating point on a 486... too slow).

> Some time ago I installed Linux (Redhat 6.0) on my 
> pc (Cx486 8M RAM) and gcc had a lot of signal 11 (a
> couple every hour) I was upgrading
> the kernel every time there was a new kernel and
> from 2.2.12(or 14) no more signal 11 (very rare)
> Is this still a hardware problem ?
> Was a bug in kernel ?

Not likely - It could just depend on whether all of available
was used. If the physical page with the problem doesn't get used
very often, it won't show up. If the bit in question is not part
of a pointer, or used in pointer arithmetic, again it won't show
up (actually, any operation on addresses). Wrong, or slightly wrong
results MAY show up.

> I think the last answer is more obvious.(or the gcc
> had a bug and the kernel -- a workaround).
> 
> Sorry for bothering you but in every piece of linux
> documentation signal 11 seems to be __identic__ with
> hardware problem.
> Bye

Only when it appears in random location.

GCC is a fairly well debugged program and doesn't segfault
unless you run out of memory, or flakey memory.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
