Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286688AbRL1CIE>; Thu, 27 Dec 2001 21:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286693AbRL1CH4>; Thu, 27 Dec 2001 21:07:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11015
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S286691AbRL1CHn>; Thu, 27 Dec 2001 21:07:43 -0500
Date: Thu, 27 Dec 2001 18:05:51 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Stodden <stodden@in.tum.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <20011227155403.A1730@suse.de>
Message-ID: <Pine.LNX.4.10.10112271046070.24491-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would provide patches if you had not goat screwed the block layer and
had taken a little more thought in design, but GAWD forbid we have design.
You have made it clear that you do not believe in testing the data
transport layers in storage.

Translation: You do not care if data gets to disk correctly or not.

You have stated you do not believe in standards, thus you believe less in
me because I "Co-Author" one for NCITS.

You have stated the tools of the trade are worthless but you have an ATA
and SCSI analyzer but you refuse to use them.  I know you have them
because I know who provided them to you.

Maybe when you get off your high horse and begin to listen, I will quit
being the ASS pointing out your faulty implimentation of BIO.  Maybe when
you decide it is important we can try to work togather again.

One thing you need to remember, BLOCK is everybodies "BITCH".
FileSystems dictate to BLOCK there requirements.
Low_Level Drivers dictate to BLOCK there rulesets.
BLOCK is there to bend over backwards to make the transition work.
BLOCK is not a RULE-SETTER, it is nothing but a SLAVE, and it has to be
damn clever.  One of you assests is you are "clever", but that will not
cover your knowledge defecits in pure storage transport.

Now I am tired of this game you are playing, so lets spell it out.

Congratulations of your copying of the rq->special for the CDB transport
out of the ACB driver that myself and two other people authored.

Congratulations on you first attempts to create the "pre-builder" model
that myself and one other has described to you, to bad you did not listen
9 months ago or you would have the bigger picture.

BUZZIT on mixing two issues that are volitale on there own rights to sort
out.  The high memory bounce and block are two different changes, and one
is dependent on the other, regardless if you see it or not.

BUZZIT on your short sightedness on the immediate intercept of command
mode

BUZZIT on you himem operations that is not able to perform the vaddr
windowing for the entire request, but choose to suffer the latency of
single sector transaction repetion.

BUZZIT on your total lack of documention the the changes to the
request_struct, otherwise I could follow your mindset and it would not be
a pissing contest.

BUZZIT on your moving CDROM operations to create a bogus BLOCK_IOCTL, for
what?  Who know it may have some valid usage, but CDROM is not it.

BUZZIT on your cut and past in block to make an effective rabbit warren or
chaotic maze to make it total opaque in what is really going on.

Cheers, and Happy New Year.

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Thu, 27 Dec 2001, Jens Axboe wrote:

> On Sun, Dec 23 2001, Andre Hedrick wrote:
> > the content is primarily the FS.  Should an APP close a file but it is
> > still in buffer_cache, there is no way to notify the app or the user or
> > anything associated with the creation/closing of that file, if a write
> > error occurs.
> > 
> > So we have user-space believing it is success.
> 
> We have a buggy user-space app believing it is a success -- do you
> really believe programs like eg mta's ignorantly closes a file and just
> hopes for the best? fsync.
> 
> > FS doing an initial ACK of success.
> > BLOCK generating the request to the low_level.
> > LOW_LEVEL goes OH CRAP, I am having a problem and can not complete.
> > 
> > LOW_LEVEL goes, HEY BLOCK we have a problem.
> > BLOCK, that is nice whatever ....
> 
> What does this _mean_?
> 
> > This is a bad model, an worse is
> > 
> > LOW_LEVEL goes, HEY BLOCK we have a problem.
> > BLOCK goes, HEY FS we have an annoying LOW_LEVEL asking for reissue.
> > FS, duh which way did the rabbit go ...
> 
> retries belong at the low level, once you pass up info of failure to the
> upper layers it's fatal. time for FS to shut down.
> 
> > > Incidentally the EVMS IBM volume manager code does support bad block
> > > remapping in some situations.
> > 
> > Well managing badblock can be a major pain, but it is the right thing to
> > do.  Now what is the cost, since there is surge in journaling FS's that
> > have logs.  The cost is coming up w/ a sane way to manage the mess.
> > Even before we get to managing the mess, we have to be able to reissue the
> > request to a reallocated location, and make all kinds of noise that we are
> > doing heroic attempts to save the data.  These may include --
> 
> Irk, software managed bad block remapping is horrible.
> 
> > The issue is we are doing nothing to address the point, and it is arrogant
> > for the maintainers of the various storage classes and the supported upper
> > layers not willing to address this issue.
> 
> How about showing solutions in form of patches instead bitching about
> this again and again? Frankly, I'm pretty sick of just seeing pointless
> talk about the issue.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

