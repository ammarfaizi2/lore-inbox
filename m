Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTFVAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 20:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFVAMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 20:12:16 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:39570 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264647AbTFVAMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 20:12:13 -0400
Date: Sat, 21 Jun 2003 17:26:14 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net is down
Message-ID: <20030622002614.GA16225@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030621135812.GE14404@work.bitmover.com> <20030621190944.GA13396@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621190944.GA13396@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 12:09:44PM -0700, Larry McVoy wrote:
> On Sat, Jun 21, 2003 at 06:58:12AM -0700, Larry McVoy wrote:
> > I'm tracking down the problem, it's been off the air for most of the night it 
> > appears.  I may upgrade the processor and motherboard.  If I do that, it 
> > will be off the air for a bit longer.
> 
> I'm still at the office working on this.  Both the main and the backup drives
> are not checking cleanly.  It's going to be several more hours before it is
> back up at this rate.

Still working on it but I'm starting to get somewhere.  There is something
very strange or flakey about Samsung 80GB IDE drives.  The symptoms are that
on some controllers the drive gets all sorts of errors.  Running under
the most recent (on bkbits.net at least) linux-2.5 tree, if I put the drive
on a Serverworks IDE interface (Tyan dual PIII, I think a 2150?) then the
drive looks like it is just trashed, lots of fsck errors.  I pulled it and
tried on an ECS el cheopo motherboard and that failed too.  I then thought
that maybe the deal was that I had partitioned it under a 3ware and I was
trying to fsck it on a normal IDE (hey, I was grabbing for an answer) so
I stuck a 3ware into the el cheapo box.  Still didnt work.   OK, I tried
another ECS el cheapo and this one works.  

By the way, "didn't work" meant that it would get through the fsck enough
to restart the fsck from the beginning and then somewhere along the way
the fsck would cause the system to reboot.  Nice.  It took several tries
to figure that out, I eventually resorted to video taping the screen to
find out what happened (it takes an hour to fsck this drive so I'd be
reading mail and looking over my shoulder about every minute trying to
catch it and of course I always missed it) and all I got was stuff that
looked like the kernel was hosed, sendmail started crapping out and I
know it wasn't doing anything.  I have the video if someone wants it,
this was Red Hat 8.0 generic, so 2.4.19 I think.

OK, finally clean fsck on the second el cheapo, move it over to the Tyan
and try again.  Disk drive go kaboom.  I'm starting to get pissed, this
is my bloody Saturday, I promised my kids we'd play together, I'm grumpy,
my wife keeps calling to ask when we are going to the beach, shit this
just sucks, I need an sys admin that I trust to do this stuff.  It's
beyond lame that I don't have one.  Any good sys admins out there in
the Bay Area?  Call me, now is a good time to negotiate a good package.
Deep breath, don't get pissed, that's how you make things worse.  OK,
back at it.  Pull the drive, plug in a Promise card, stick the drive on
that and pray that it works.  Whoops, didn't compile that in, recompile,
reboot, man I hate American Megatrends, it takes forever to do a warm
reboot.  Linux BIOS, where are you?  OK, it sees it, do the fsck, wait
an hour, whoohoo!  We're clean.

Time to think about what to do.  I don't trust the Samsung even though it
says it is OK, too many problems.  Another deep breath, call the local
suppliers, yeah, they got some 80GB drives, we're at 40GB so that seems
cool, head off to the store to buy some new drives.  Shit.  The store
lied and they were out of stock.  Buy some 120GB?  Nah, if we get to
that much data on bkbits.net I want it spread over multiple machines
so I'm not stuck in the machine room for 40 hours the next time this
crap happens.  It sucks to be me some days, it really does.  Go back,
steal a 80GB Western Digital drive from one of the desktops, stick it in.
By the way, Western Digital, if you ever want an endorsement I'm your man,
every other drive company has screwed me at least once and you never have.
Your drives rock, they behave well under benchmarks and they behave well
in the real world and I have the data to prove it.  And, best of all,
your drives fail nicely, blocks start going bad but you can get 99.9%
of the data off, very nice.  Good job.

Plug in the WD 80GB, write a script to start cloning the repositories,
that's easy, it's running, and I'm typing in this mail as something to
do while it runs.  Hence the verboseness.  And in spite of that we are
only up to linux-ajc (who's ajc?).  But we're getting there.  My guess
is that this is going to run for a few more hours.  I've been here since
7am this morning, I'm going out to get plastered and I'll put the rest
of this back together tomorrow.

I wasn't kidding about that sys admin job, I'd love for this to be
someone else's problem.  In theory I'm supposed to be a CEO who plays
golf games and cuts multi-million dollar deals for development tools.
I still need to learn how to play golf so I could use some help, right?
The problem is that I want things fixed right so that problems don't come
back and I don't trust lame people to do that so I end up doing a lot of
stuff myself.  If you have an ego that won't quit because you could kick
my pathetic sys admin ass all over the place, you're who I want to hire.
Of course you need to be able to take a lot of shit because BK isn't
politically correct in the open source world :-(  

I'm outta here to drink some beer, ETA on bkbits being back online is
some time tomorrow.  Sorry about the delay.  For what it is worth, we are
in the process of setting up an India based development effort which is
going to take this over and make it work better.  We really want to be
in a place where when something goes wrong we change some DNS entries
and we're back on line.  We're not there yet but we are working on it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
