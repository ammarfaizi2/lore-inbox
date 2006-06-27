Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932953AbWF0J0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbWF0J0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933391AbWF0J0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:26:05 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:33988 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932953AbWF0J0B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:26:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 11:26:28 +0200
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <20060627075906.GK22071@suse.de> <200606271907.27831.nigel@suspend2.net>
In-Reply-To: <200606271907.27831.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606271126.28898.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 27 June 2006 11:07, Nigel Cunningham wrote:
> On Tuesday 27 June 2006 17:59, Jens Axboe wrote:
> > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > On Tuesday 27 June 2006 17:05, Jens Axboe wrote:
> > > > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > > > On Tuesday 27 June 2006 15:36, Jens Axboe wrote:
> > > > > > On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > > > > > > On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> > > > > > > > On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > > > > > > > > Add Suspend2 extent support. Extents are used for storing the
> > > > > > > > > lists of blocks to which the image will be written, and are
> > > > > > > > > stored in the image header for use at resume time.
> > > > > > > >
> > > > > > > > Could you please put all of the changes in
> > > > > > > > kernel/power/extents.c into one patch?  It's quite difficult to
> > > > > > > > review them now, at least for me.
> > > > > > >
> > > > > > > I spent a long time splitting them up because I was asked in
> > > > > > > previous iterations to break them into manageable chunks. How
> > > > > > > about if I were to email you the individual files off line, so as
> > > > > > > to not send the same amount again?
> > > > > >
> > > > > > Managable chunks means logical changes go together, one function
> > > > > > per diff is really extreme and unreviewable. Support for extents is
> > > > > > one logical change, so it's one patch. Unless of course you have to
> > > > > > do some preparatory patches, then you'd do those separately.
> > > > > >
> > > > > > I must admit I thought you were kidding when I read through this
> > > > > > extents patch series, having a single patch just adding includes!
> > > > >
> > > > > Sorry for fluffing it up. I'm pretty inexperienced, but I'm trying to
> > > > > follow CodingStyle and all the other advice. If I'd known I'd
> > > > > misunderstood what was wanted, I probably could have submitted this
> > > > > months ago. Oh well. Live and learn. What would you have me do at
> > > > > this point?
> > > >
> > > > Split up your patches differently, and not in so many steps. Ideally
> > > > each step should work and compile, with each introducing some sort of
> > > > functionality. Each patch should be reviewable on its own.
> > >
> > > The difficulty I have there is that suspending to disk doesn't seem to
> > > me to be something where you can add a bit at a time like that. I do
> > > have proc entries that allow you to say "Just freeze the processes and
> > > prepare the metadata, then free it and exit" (freezer_test) and "Do
> > > everything but actually writing the image and doing the atomic copy,
> > > then exit (test_filter_speed), for diagnosing problems and tuning the
> > > configuration, but if I start were to start again with nothing, I'd
> > > only write the dynamic pageflags code to start with and submit it
> > > (giving you lib/dyn_pageflags.c and kernel/power/pageflags.c), then
> > > the refrigerator changes and the extent code and so on. I guess what
> > > I'm trying to say is that I'm not mutating swsusp into suspend2 here,
> > > and I don't think I can. Suspend2 is a reimplementation of swsusp, not
> > > a series of incremental modifications. It uses completely different
> > > methods for writing the image, storing the metadata and so on. Until
> > > recently, the only thing it shared with swsusp was the refrigerator
> > > and driver model calls, and even now the sharing of lowlevel code is
> > > only a tiny fraction of all that is done.
> >
> > You can't split up what isn't composed of multiple things, of course. I
> > didn't review your patches (sorry), but if you have changes outside of
> > suspend2 itself, then you need to split these out. You could submit
> > those patches seperately.
> 
> Ok. That I can certainly do, and I can post one patch per file in a logical 
> order.
> 
> > Now I haven't followed the suspend2 vs swsusp debate very closely, but
> > it seems to me that your biggest problem with getting this merged is
> > getting consensus on where exactly this is going. Nobody wants two
> > different suspend modules in the kernel. So there are two options -
> > suspend2 is deemed the way to go, and it gets merged and replaces
> > swsusp. Or the other way around - people like swsusp more, and you are
> > doomed to maintain suspend2 outside the tree.
> 
> Generally, I agree, although my understanding of Rafael and Pavel's mindset is 
> that swsusp is a dead dog and uswsusp is the way they want to see things go. 
> swsusp is only staying for backwards compatability. If that's the case, 
> perhaps we can just replace swsusp with Suspend2 and let them have their 
> existing interface for uswsusp. Still not ideal, I agree, but it would be 
> progress.

Well, ususpend needs some core functionality to be provided by the kernel,
like freezing/thawing processes (this is also used by the STR), snapshotting
the system memory.  These should be shared with the in-kernel suspend,
be it swsusp or suspend2.
 
> > > Could I ask what might be a dumb question in this regard - why isn't
> > > Reiser4 going through the same process? Is it an indication that I
> > > shouldn't have submitted these patches and should have just asked
> > > Andrew to take Suspend2 into mm, or is there something different
> > > between Reiser4 and Suspend2 that I'm missing?
> >
> > That's not a dumb question at all. reiser4 hasn't been merged for years,
> > so you probably don't want to look at that as an example :-)
> >
> > reiser4 is pretty much a separate entity, so it doesn't make sense so
> > split that up much for submission. Core kernel changes (as always) need
> > to be split, of course.
> 
> Ok. I didn't remember when reiser4 first appeared or how it got into -mm. I 
> guess I'm picturing suspend2 as similar because I'm thinking of Suspend2 as 
> pretty much a separate subsystem - it's interface to the rest of the kernel 
> can be defined in terms of freeze|thaw_processes, drivers_suspend|resume, 
> bmap|submit_bio and I'm imagining the Reiser4 would have a similar sort of 
> limited set of functions it uses for interfacing with the rest of the kernel.

IMHO it's close enough to this, but reiser4 is considered as just another
filesystem and there are many of thses in the kernel already.  Still there
are some controversies around reiser4 as well.

Greetings,
Rafael
