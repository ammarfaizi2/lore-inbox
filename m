Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275024AbTHLFgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275044AbTHLFgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:36:46 -0400
Received: from pop.gmx.net ([213.165.64.20]:3310 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275024AbTHLFgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:36:44 -0400
Message-Id: <5.2.1.1.2.20030812062357.01a102f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 12 Aug 2003 07:40:53 +0200
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: What is interactivity? Re: [PATCH]O14int [SCHED_SOFTRR
  please]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308120226.35580.roger.larsson@skelleftea.mail.telia.com
 >
References: <5.2.1.1.2.20030811212837.01975fa0@pop.gmx.net>
 <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net>
 <5.2.1.1.2.20030811212837.01975fa0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:26 AM 8/12/2003 +0200, Roger Larsson wrote:
>On Monday 11 August 2003 21.46, Mike Galbraith wrote:
> > At 08:19 PM 8/11/2003 +0200, Roger Larsson wrote:
> > >On Sunday 10 August 2003 13.17, Mike Galbraith wrote:
> > > > At 01:48 AM 8/10/2003 -0700, Simon Kirby wrote:
> > > > >I am seeing similar starvation problems that others are seeing in
> > > > > these threads.  At first it was whenever I clicked a link in Mozilla
> > > > > -- xmms would stop, sometimes for a second or so, on a Celeron 466
> > > > > MHz machine.
> > > >
> > > > Do you see this with test-X and Ingo's latest changes too?  I can only
> > > > imagine one scenario off the top of my head where this could happen; if
> > > > xmms exhausted a slice while STARVATION_LIMIT is exceeded, it could
> > > > land in the expired array and remain unserviced for the period of time
> > > > it takes for all tasks remaining in the active array to exhaust their
> > > > slices.  Seems like that should be pretty rare though.
> > >
> > >xmms is a RT process - it does not really have interactivity problems...
> > >It will be extremely hard to fix this in a generic scheduler, instead
> > >let xmms be the RT process it is with SCHED_SOFTRR (or whatever
> > >it will be named).
> > >Do this for arts, and other audio/video path applications.
> >
> > (For the scenario described, it doesn't matter what scheduler policy is
> > used)
>
>It matters if the SOFTRR processes are well behaved, they will get their share
>as long as _they_ do not overuse CPU.
>
>Suppose you have xmms running SOFTRR. Whatever you do that is not SOFTRR
>(or higher SCHED_FIFO, SCHED_RR) can't touch is scheduler wice.
>It will remain SOFTRR and will not run out of its timeslice unless it uses 
>too
>much CPU - its timeslice is refilled immediately whenever it gets empty (it
>is put last on the SOFTRR run queue - not in the expired array...)

Yup, brainfart on my part.  Realtime tasks are immune.

>But if it SOFTRR processes has used too much CPU there are no guarantees.
>
> >
> > >Then start the race for interactivity tuning
> > >  (X, X applications, console, login, etc)
> > >
> > >interactivity = two-way
> > >         http://www.m-w.com/cgi-bin/dictionary?va=interactive
> > >
> > >Listening to music is not interactive.
> >
> > ?!?  <tilt> What makes you say that?  What in the world am I doing when I
> > fire up xmms?
> > --- snip ---
>
>You expect sound to start soon - that is the interactive behaviour.
>
>Suppose xmms starts after four seconds and then won't miss a beat.
>Compare with if it starts after ten seconds and then won't miss a beat.
>If you relate each frame to the start action then you will see that _every_
>frame in the first case is one second late, and in the second case ten
>seconds late. (Best possible interactivity would be an immediate start - 
>don't
>you agree?)
>
>xmms is interactive if you see the audioboard as the second part.
>But I think that if we could concentrate on human users the problem will
>become easier. If I leave home while compiling KDE and playing audio with 
>xmms
>- is xmms still interactive? (this will be hard to fix but it is not
>impossible, someone (on a MAC I think) have done a application that logged in
>when you arrived with your bluetooth device and logged off when you left)

If I leave the room, or even become distracted enough, xmms ceases to be 
interactive.

>"make all" - interactive? It depends on my expectations, my expectations
>depends on how big the _total task_ is.

If you're watching it, I'd call it interactive.  I see no difference 
between watching a movie and watching compiler output scroll by.

>* If it is run from a shell script - like the kde-build I have in the
>   background right now. No way!

Agreed.  If you're not watching the output scroll by, it's not interactive.

>* If it is my kdeveloper test project ("Hello world" for remote debugging).
>   Yes it is! I waiting for it and expect it to be ready NOW.
>
>make bzImage - total rebuild, Not interactive - I expect to be able to get a
>cup of coffe while waiting.
>make bzImage - one .c file changed, interactive

Well, interactivity can certainly be viewed like one of those tricky 
philosophy questions (bears farting in the woods, trees falling over etc;), 
but I consider any task which is connected to a human via any of our senses 
to be interactive.  Perhaps it's not a 100% accurate use of the term, but 
for lack of a better term...

>I think that the work done this far is great. It is great that the scheduler
>almost can handle xmms under all kinds of loads - but enough is enough.

I don't care if xmms skips or my mouse pointer stalls while I'm testing at 
the heavy end of the load scale, you flat can't have low latency and max 
throughput at the same time.  If xmms skips and the mouse becomes sticks at 
less than "heavy" though, something is wrong (defining heavy is one of 
those tricky judgement calls).  It's the mozilla loading a webpage type of 
reports that I worry about.

         -Mike 

