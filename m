Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRFUBLA>; Wed, 20 Jun 2001 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264346AbRFUBKu>; Wed, 20 Jun 2001 21:10:50 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:60550 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264345AbRFUBKn>; Wed, 20 Jun 2001 21:10:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Alexander Viro <viro@math.psu.edu>, Jes Sorensen <jes@sunsite.dk>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Wed, 20 Jun 2001 16:09:38 -0400
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0106201609380G.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 11:33, Alexander Viro wrote:
> On 20 Jun 2001, Jes Sorensen wrote:
> > Not to mention how complex it is to get locking right in an efficient
> > manner. Programming threads is not that much different from kernel SMP
> > programming, except that in userland you get a core dump and retry, in
> > the kernel you get an OOPS and an fsck and retry.
>
> Arrgh. As long as we have that "SMP makes locking harder" myth floating
> around we _will_ get problems. Kernel UP programming is not different
> from SMP one. It is multithreaded. And amount of genuine SMP bugs is
> very small compared to ones that had been there on UP since way back.
> And yes, programming threads is the same thing. No arguments here.

Hopefully in 2.5 we'll get the pre-emptive UP patch in that enables the SMP 
locks on UP and finally clean it all out by exposing the bugs to the main 
user base.

As for multi-threaded programming being hard, people are unfamiliar with it.  
Any programming is hard the first time.  And almost anybody's first attempt 
at it is going to suck.  (Dig out the linux kernel 0.02 sources sometime and 
compare them with what we have today.)

The more experience you get with it, the better you are.  Encouraging people 
to stay away from it rather than learn to do it RIGHT is the wrong attitude.  
People will figure out that using 1000 threads when you need 3 isn't the best 
way to go, that locking is an expense but failing to lock is worse, how to 
spot race conditions (the same old "security" mindset except you don't need a 
malicious third party to get bitten by it.)

And they'll learn it the way I did, and the way everybody does.  Do it wrong 
repeatedly.  Make every mistake there is, hard.  Get burned, rewrite it from 
scratch four times until you figure out how to design it right, spend long 
weekends looking for subtle little EVIL bugs you can't reproduce but which 
bite you the instant you stop looking for them, learn to play "hot potato" 
with volatile data you have to manipulate atomically...

Everybody starts as a bad programmer.  Some of us get it out of our systems 
when we're 12.  Others decide programming is lucrative when they're 35 and 
inflict their "hello world" opus upon their coworkers.  Me, I wrote a disk 
editor and a bunch of bbses in 5th and 6th grade back on the C64 that will 
never see the light of day.  And yes they sucked.  But I'm still proud of 
them.  And I wrote awful multithreaded code back on OS/2, and can now write 
decent threading code because I've learned a large number of things to avoid 
doing.  And I take proper care because I know how hard it is to FIND one of 
these if you do wind up doing it.  I've done it.  Once for two consecutive 
weeks on the same #%*(&#%& bug.  There's no WAY somebody's going to pick that 
sort of thing up in a programming course, or from "advice" from experienced 
people.  We never listen to advice from experienced programmers.  If we did 
we'd still be using Fortran for everything...

Rob
