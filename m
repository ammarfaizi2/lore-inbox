Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311445AbSCSQzH>; Tue, 19 Mar 2002 11:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311437AbSCSQy5>; Tue, 19 Mar 2002 11:54:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11276 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311436AbSCSQyi>; Tue, 19 Mar 2002 11:54:38 -0500
Date: Tue, 19 Mar 2002 11:49:37 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: lse-tech@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] 7.52 second kernel compile
In-Reply-To: <730219199.1016271418@[10.10.2.3]>
Message-ID: <Pine.LNX.3.96.1020319114117.1772E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Martin J. Bligh wrote:

> > I think Im addicted. I need help!
> 
> Well, you're not going to get much competition, so maybe help
> would be more in order ;-) ;-)
> 
> Are you still doing something like this?
> # MAKE="make -j14" /usr/bin/time make -j14 bzImage
> 
> I tried setting the MAKE variable as well as doing the -j,
> but it actually made kernel compile time slower - what difference
> does it make on your machine? Can somebody clarify what this
> actually does, as opposed to the -j on the command line?

  Passing the -j option to make either (a) starts N processes at the
initial level and implies -j1 for submakes, (b) starts N processes at base
level each of which get the -jN and use it, or (c) -jN means run a total
of N processes shared between everything running. The [abc] depends on the
make you run, BSD, xmake, old GNU, new GNU, etc.

  No that doesn't clarify things, the correct answer is "it depends." I
have always used the environment variable with older GNU make, havent
rethought it on very recent systems. I suggest that N be Nproc+1 for best
results, but I've never had more than four CPUs with a build large enough
to measure.
 
> BTW - the other tip that was in the big book of whizzy kernel
> compiles was to set gcc to use -pipe ... you might want to try
> that.

  I general -pipe is a bad thing for uni, non-win for SMP (for any -j)
although I have often thought that making the pipe buffer larger might
change that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

