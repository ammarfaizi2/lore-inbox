Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318796AbSHBLw0>; Fri, 2 Aug 2002 07:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318797AbSHBLw0>; Fri, 2 Aug 2002 07:52:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56200 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318796AbSHBLwZ>;
	Fri, 2 Aug 2002 07:52:25 -0400
Date: Fri, 2 Aug 2002 13:55:46 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
Message-ID: <20020802115546.GM3010@suse.de>
References: <1028288066.1123.5.camel@laptop.americas.sgi.com> <20020802114713.GD1055@suse.de> <3D4A7178.7050307@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4A7178.7050307@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02 2002, Marcin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> >On Fri, Aug 02 2002, Stephen Lord wrote:
> >
> >>In 2.5.30 I started getting these warning messages out ide during
> >>the mount of an XFS filesystem:
> >>
> >>ide-dma: received 1 phys segments, build 2
> >>
> >>Can anyone translate that into English please.
> >
> >
> >Well I added that message when switching to the 2.5 style request
> >mapping functions, and I think the message is perfectly clear :-). Never
> >the less, it means that a segment that came into the ide layer with an
> >advertised size of 1 segment was returned from blk_rq_map_sg() as having
> >_two_. This can be a problem with dynamically allocated sg table (not
> >that ide uses those, but still).
> >
> >It's a bug and usually a critical one when this happens. I'd be inclined
> >to think that Adam's changes in this path are to blame for this error.
> 
> Carefull carefull. it can be that the generic BIO code doesn't honour
> the limits Adam was setting properly. And it can be of course
> as well the XFS doesn't cooperate properly with those limits as well,
> since ther kernel appears to be patched to support them.

Sure, I'm not claiming it's an IDE bug (please re-read the paragraph)
and my recent even said out loud that this could be a bug anywhere. It
also stresses that this bug can be quite serious and cause data
corruption, since this sort of thing is not expected to happen.

I'm suggesting that this is _most likely_ a bug introduced in the recent
pcidma changes. Or it could be a bug with a request getting screwed over
somewhere. Nasty corruption likely in that case as well.

-- 
Jens Axboe

