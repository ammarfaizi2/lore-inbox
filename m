Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSHBMEn>; Fri, 2 Aug 2002 08:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318801AbSHBMEn>; Fri, 2 Aug 2002 08:04:43 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:30618 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S318799AbSHBMEm>;
	Fri, 2 Aug 2002 08:04:42 -0400
Subject: Re: A new ide warning message
From: Stephen Lord <lord@sgi.com>
To: martin@dalecki.de
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D4A7178.7050307@evision.ag>
References: <1028288066.1123.5.camel@laptop.americas.sgi.com>
	<20020802114713.GD1055@suse.de>  <3D4A7178.7050307@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Aug 2002 07:05:38 -0500
Message-Id: <1028289940.1123.19.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 06:48, Marcin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> > On Fri, Aug 02 2002, Stephen Lord wrote:
> > 
> >>In 2.5.30 I started getting these warning messages out ide during
> >>the mount of an XFS filesystem:
> >>
> >>ide-dma: received 1 phys segments, build 2
> >>
> >>Can anyone translate that into English please.
> > 
> > 
> > Well I added that message when switching to the 2.5 style request
> > mapping functions, and I think the message is perfectly clear :-). Never
> > the less, it means that a segment that came into the ide layer with an
> > advertised size of 1 segment was returned from blk_rq_map_sg() as having
> > _two_. This can be a problem with dynamically allocated sg table (not
> > that ide uses those, but still).
> > 
> > It's a bug and usually a critical one when this happens. I'd be inclined
> > to think that Adam's changes in this path are to blame for this error.
> 
> Carefull carefull. it can be that the generic BIO code doesn't honour
> the limits Adam was setting properly. And it can be of course
> as well the XFS doesn't cooperate properly with those limits as well,
> since ther kernel appears to be patched to support them.
> 

Well, this is happening when reading the log up from disk during
mount, we will be asking for somewhere around 32K of data at a
time, but it might not be well aligned. I will instrument it and
report back - will be a few hours, the box is at work and I just
tripped it up in some other code, I cannot reset it from here.

> It would be helpfull as well to know on which brand of host controller 
> chip this was found. In esp. trm290 maybe?

Since it is down I cannot give you the ide boot messages right now,
but it is a Tyan Tiger BX motherboard using the built in IDE chipset,
so pretty generic stuff.

> > 
> > Oh, and I'd be _really_ careful if you have trusted data on that drive
> > (surely not when running 2.5 ide on it :-)
> > 
> 

It's a scratch box, all it does is run development kernels and tests,
I am keeping 2.5 in a cage right now.

To answer your other question Jens, yes I can reproduce at will,
once I go in to the office.

Steve


