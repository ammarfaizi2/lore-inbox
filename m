Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274929AbTHLAYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274931AbTHLAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:24:12 -0400
Received: from mailb.telia.com ([194.22.194.6]:40141 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S274929AbTHLAYH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:24:07 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Mike Galbraith <efault@gmx.de>
Subject: What is interactivity? Re: [PATCH]O14int [SCHED_SOFTRR please]
Date: Tue, 12 Aug 2003 02:26:34 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net> <5.2.1.1.2.20030811212837.01975fa0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030811212837.01975fa0@pop.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308120226.35580.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 August 2003 21.46, Mike Galbraith wrote:
> At 08:19 PM 8/11/2003 +0200, Roger Larsson wrote:
> >On Sunday 10 August 2003 13.17, Mike Galbraith wrote:
> > > At 01:48 AM 8/10/2003 -0700, Simon Kirby wrote:
> > > >I am seeing similar starvation problems that others are seeing in
> > > > these threads.  At first it was whenever I clicked a link in Mozilla
> > > > -- xmms would stop, sometimes for a second or so, on a Celeron 466
> > > > MHz machine.
> > >
> > > Do you see this with test-X and Ingo's latest changes too?  I can only
> > > imagine one scenario off the top of my head where this could happen; if
> > > xmms exhausted a slice while STARVATION_LIMIT is exceeded, it could
> > > land in the expired array and remain unserviced for the period of time
> > > it takes for all tasks remaining in the active array to exhaust their
> > > slices.  Seems like that should be pretty rare though.
> >
> >xmms is a RT process - it does not really have interactivity problems...
> >It will be extremely hard to fix this in a generic scheduler, instead
> >let xmms be the RT process it is with SCHED_SOFTRR (or whatever
> >it will be named).
> >Do this for arts, and other audio/video path applications.
>
> (For the scenario described, it doesn't matter what scheduler policy is
> used)

It matters if the SOFTRR processes are well behaved, they will get their share
as long as _they_ do not overuse CPU.

Suppose you have xmms running SOFTRR. Whatever you do that is not SOFTRR
(or higher SCHED_FIFO, SCHED_RR) can't touch is scheduler wice.
It will remain SOFTRR and will not run out of its timeslice unless it uses too 
much CPU - its timeslice is refilled immediately whenever it gets empty (it 
is put last on the SOFTRR run queue - not in the expired array...)
But if it SOFTRR processes has used too much CPU there are no guarantees.

>
> >Then start the race for interactivity tuning
> >  (X, X applications, console, login, etc)
> >
> >interactivity = two-way
> >         http://www.m-w.com/cgi-bin/dictionary?va=interactive
> >
> >Listening to music is not interactive.
>
> ?!?  <tilt> What makes you say that?  What in the world am I doing when I
> fire up xmms?
> --- snip ---

You expect sound to start soon - that is the interactive behaviour.

Suppose xmms starts after four seconds and then won't miss a beat.
Compare with if it starts after ten seconds and then won't miss a beat.
If you relate each frame to the start action then you will see that _every_
frame in the first case is one second late, and in the second case ten
seconds late. (Best possible interactivity would be an immediate start - don't 
you agree?)

xmms is interactive if you see the audioboard as the second part.
But I think that if we could concentrate on human users the problem will
become easier. If I leave home while compiling KDE and playing audio with xmms 
- is xmms still interactive? (this will be hard to fix but it is not 
impossible, someone (on a MAC I think) have done a application that logged in 
when you arrived with your bluetooth device and logged off when you left)


"make all" - interactive? It depends on my expectations, my expectations
depends on how big the _total task_ is.
* If it is run from a shell script - like the kde-build I have in the
  background right now. No way!
* If it is my kdeveloper test project ("Hello world" for remote debugging).
  Yes it is! I waiting for it and expect it to be ready NOW.

make bzImage - total rebuild, Not interactive - I expect to be able to get a 
cup of coffe while waiting.
make bzImage - one .c file changed, interactive

I think that the work done this far is great. It is great that the scheduler
almost can handle xmms under all kinds of loads - but enough is enough.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
