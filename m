Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUATWec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUATWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:34:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29831 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262674AbUATWe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:34:28 -0500
Date: Tue, 20 Jan 2004 17:31:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Adrian Bunk <bunk@fs.tum.de>
cc: Robert Schwebel <robert@schwebel.de>,
       Juergen Beisert <jbeisert@eurodsn.de>, cliff white <cliffw@osdl.org>,
       piggin@cyberone.com.au, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
In-Reply-To: <20040120221025.GI12027@fs.tum.de>
Message-ID: <Pine.LNX.4.53.0401201718520.12967@chaos>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au>
 <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au>
 <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de>
 <20040116111501.70200cf3.cliffw@osdl.org> <Pine.LNX.4.53.0401161425110.31018@chaos>
 <20040117021532.GH12027@fs.tum.de> <20040117091337.GZ5139@pengutronix.de>
 <20040120221025.GI12027@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Adrian Bunk wrote:

> On Sat, Jan 17, 2004 at 10:13:37AM +0100, Robert Schwebel wrote:
>
> > Hi,
>
> Hi Robert,
>
> > On Sat, Jan 17, 2004 at 03:15:32AM +0100, Adrian Bunk wrote:
> > > Besides the AMD Elan cpufreq driver I see nothing where CONFIG_MELAN
> > > gave you any real difference (except your highest goal is to avoid a
> > > recompilation when switching from the Pentium 4 to the AMD Elan - but I
> > > doubt the really "prevents development").
> > >
> > > But I'm not religious about this issue. Let Robert decide, the Elan
> > > support is his child.
> > >
> > > > > > - added optimizing CFLAGS for the AMD Elan
> > > >
> > > > There are no such different "optimizations" for ELAN.
> > >
> > > What's wrong wih the -march=i486 Robert suggested?
> >
> > I've not followed the 2.6 development regarding the arch selection that
> > closely; let's collect arguments:
> >
> > - Is it still possible to run a -march=i486 built kernel on a pentium?
> >   IMHO It would be good to optimize the code for i486, but I'm not that
> >   familiar with how good gcc optimizes for 486 that I can comment this.
>
> yes, since a Pentium supports a superset of the 486 gcc can't optimize
> for a 486 in a way that the code won't run on a Pentium.
>
> > - I personally work with lots of cross architectures like ARM, so cross
> >   compiling for an embedded system is no problem for me. But if people
> >   want to test stuff on their pentiums I also have no problem with that.
> >
> > Other arguments?
>
> The only reason why I sent the patch to make the AMD Elan a separate
> subarch was the CLOCK_TICK_RATE #ifdef in include/asm-i386/timex.h .
>
> It should be possible to change it to a variable (as with
> CONFIG_X86_PC9800) if both the Elan and a different cpu are supported if
> this is really a required use.
>
> If this is the solution you prefer, how would you do runtime detection
> for the AMD Elan?
>
> > Robert
>
> cu
> Adrian
>

I don't think you need a runtime detection. All that's needed is
the ability to set the clock divisor to a slightly different value
than the default. It doesn't need some special architecture because
that will prevent setting other things like SMP. And yes, the embedded
AMDs we use here have the SMP spin-locks because it is necessary to
completely test the operating system independently of the target
system. This is done by running my development workstation, a Pentium
with two CPUs with the exact same OS. The modules are, of course,
different, actually mostly missing on the target system because
only Analogic-specific hardware interface modules are used plus
the RAM disk.

I just set my workstation time when I log in in the morning.
In a whole day it's only off by:

Script started on Tue Jan 20 17:25:37 2004
$ nettime time-a.timefreq.bldrdoc.gov
Reference time = Tue Jan 20 17:22:26 2004
       My time = Tue Jan 20 17:25:54 2004
    Difference = 208 seconds
   Time set by   time-a.timefreq.bldrdoc.gov (132.163.4.101)
$ exit
exit
Script done on Tue Jan 20 17:22:36 2004

208 seconds. As long as I don't change it during a compile,
everything is fine.

So, again, please don't change anything that prevents me and
others from using the AMD operating system on an ordinary workstation.
Otherwise, I'll have to make some stupid embedded test software
that exercises the OS on the AMD to get by the FDA requirements
for independent testing of the OS. I would also have to re-certify
our testing procedure.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


