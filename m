Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264535AbTCYVFu>; Tue, 25 Mar 2003 16:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264537AbTCYVFu>; Tue, 25 Mar 2003 16:05:50 -0500
Received: from fionet.com ([217.172.181.68]:44160 "EHLO service")
	by vger.kernel.org with ESMTP id <S264535AbTCYVFp>;
	Tue, 25 Mar 2003 16:05:45 -0500
Subject: Re: System time warping around real time problem - please help
From: Fionn Behrens <fionn@unix-ag.org>
To: linux-kernel@vger.kernel.org
Cc: root@chaos.analogic.com, tim@physik3.uni-rostock.de
In-Reply-To: <Pine.LNX.4.53.0303251152080.29361@chaos>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: United Fools of Bugaloo
Message-Id: <1048627013.2348.39.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 22:16:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Tue, 25 Mar 2003, Fionn Behrens wrote: 
> > On Die, 2003-03-25 at 18:07, Richard B. Johnson wrote:
> > > On Tue, 25 Mar 2003, Fionn Behrens wrote:
> >
> > > > I have got an increasingly annoying problem with our fairly new
> > > > (fall '02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 
> > > > 2.4.20.
> >
> > > I am using the exact same kernel (a lot of folks are). There
> > > is no such jumping on my system.
> > > Try this program:
> >
> > [... prg1.c ...]
> >
> > > If this shows time jumping around you have one of either:
> > >
> > > (1) Bad timer channel 0 chip (PIT).
> > > (2) Some daemon trying to sync time with another system.
> > > (3) You are traveling too close to the speed of light.
> >
> > It just exits immediately with exit code 1. (*shrug*)

> Hmmm. Note that the for(;;) { } provides no exit path.

I noticed that well and investigated the issue using ddd. Funnily enough
the program runs well in ddd until X crashes. But in the shell it still
behaves like it would be nothing but exit(1);
 
> So, you probably have some bad RAM or your CPU is too 
> hot (broken fan??), or something like that. 

None of the above. The system is liquid cooled and subject to contiuous
thermal monitoring. The RAM is 1GB Infineon ECC. Before the weekend I
had the machine running overnight with memtest86 - 14 hours, all tests
activated. Not a single error.
I also tried an endless kernel compile loop the other day and the
machine compiled about 100 kernels in approx two hours without a hitch.

> > [... prg2.c ...]
> >
> > When I run this code it begins to put out Prev N New M lines.

> > Prev 1048615862810879.000000 New 1048615862759879.000000

> > After a few seconds of run time random processes on my machine begin
> > to crash, or I get kernel oopses and kernel freezes. Looks very 
> > much like heavy use of gettimeofday() causes random writes in system
> > memory.

> Looks very much like you have a real bad hardware problem. 

Just what, that is the question. After having activated the notsc
feature the system has not yet exposed the warp symptons but as I noted
in the beginning it may well take a day or two for that to happen.

Yet still, running the first (in ddd) or second test programs - despite
the current absence of any error message - causes random processes to
crash until the program is being stopped (by a crashed terminal, X or
kernel, that is).

Oddly enough, the system runs pretty stable for at least days of normal
use as long as the clock symptoms dont show up (and you dont run those
test programs). Which means it has not crashed a lot recently, just
being rebooted by me because of the jumping clock annoyance which -
among others - results in sluggishly behaving UI components and frequent
short connection freezes in ssh connections.

> > E.g. which type of hardware problem?
> Since the machine used to work last fall, It's probably just a
> FAN or RAM  problems.

I'll swap the RAM sticks around for now but I suspect its something
else. I just still fail to grasp  how calls to gettimeofday() are able
to cause random writes to memory...

Summary:
       - No apparent hardware issue.
       - System runs stable as long as you dont for (;;) gettimeofday();
       - notsc being evaluated. I will get back to you later.
         Does not resolve the odd test software crash, though. 

Kind regards,
		Fionn

P.S.: Please keep sending me a Cc:, I grabbed this one from the archive
