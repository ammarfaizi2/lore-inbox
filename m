Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSJCV54>; Thu, 3 Oct 2002 17:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSJCV54>; Thu, 3 Oct 2002 17:57:56 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7066 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261290AbSJCV5z>;
	Thu, 3 Oct 2002 17:57:55 -0400
Date: Thu, 3 Oct 2002 23:05:53 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice)
Message-ID: <20021003220553.GA13540@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <200210031551.g93FpwsR000330@darkstar.example.net> <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com> <20021003165142.GA25316@suse.de> <3D9CABF5.BA216802@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9CABF5.BA216802@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 01:43:33PM -0700, Andrew Morton wrote:

 > >  > The memory management issues would qualify for 3.0, but my argument there
 > >  > is really that I doubt everybody really is happy yet. Which was why I
 > >  > asked for people to test it and complain about VM behaviour - and we've
 > >  > had some ccomplaints ("too swap-happy") although they haven't sounded like
 > >  > really horrible problems.
 > > 
 > > We still need some work for low memory boxes (where low isn't
 > > necessarily all that low). On my 128MB laptop I can lock up the box
 > > for a minute or two at a time by doing two things at the same time,
 > > like a bk pull, and switching desktops.
 > 
 > Specific version info and all the usual how-to-reproduce info
 > would help here.  Things have changed a _lot_ in the past
 > week or two.

That was 2.5.39 + bk from just before .40 hit the streets.
I'll pull something current in a tick, and give that a shot.

 > Comparisons with 2.4 are useful.  Simple "here's how to
 > reproduce" instructions are 100% golden ;)

theres usually not too much going on on the laptop.
It runs enlightenment + gnome 1.4. A few gnome-terminals,
and thats about it. After bitkeeper had sucked down a few
changesets and started its "lets grind the disk for a while"
consistency thing, interactive feel is approaching nil.
Trying to focus a different window takes about 5 seconds minimum.
Switching desktops takes 30 seconds minimum.

My completely unscientific guess here is that bitkeeper is
whoring all the I/O bandwidth, and we're trying to swap at
the same time, which is getting starved.
I'll try and reproduce after some sleep with vmstat running
if this will be of use.

 > > I dread to think how a 16 or 32MB box performs these days..
 > Well last I looked, a 2.5 kernel with NR_CPUS=8 had 22MB
 > of unreclaimable memory by the time it reached the console
 > login prompt.

Ouch.

 > Yet John Bradford says that in swapless 8MB, 2.5.40 is "springier"
 > than 2.4.x, so weird.

Depends on what tests are I suppose. "springier" doesn't
really say too much. We do minimise memory usage in a few
places if mem<16M though iirc which could be helping this case.
 
 > It should be immune to our traditional catastrophic failure
 > scenarios, and that's something which we want to keep.  There are
 > some ten- or twenty-percent regressions in some areas, but at this
 > time that's a reasonable price to pay for not locking up, not having
 > five-minute comas, not exhibiting massive stalls when there's a
 > lot of disk writeout, etc.  I think history teaches us to value
 > simplicity, predictability and robustness over performance-in-corner-cases.

Hmm, my case seems to be everything you say should not be happening
any more. Sorry 8-)
I *can't* be the only one seeing this though.
The laptop disk is no speed demon, but its quite nippy at ~12MB/s
For obvious reasons, having swap and / on the same disk is making
a considerable impact here.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
