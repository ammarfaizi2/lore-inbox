Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318807AbSHBL4R>; Fri, 2 Aug 2002 07:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318809AbSHBL4Q>; Fri, 2 Aug 2002 07:56:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14217 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318807AbSHBL4Q>;
	Fri, 2 Aug 2002 07:56:16 -0400
Date: Fri, 2 Aug 2002 13:59:40 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
Message-ID: <20020802115940.GF1055@suse.de>
References: <1028288066.1123.5.camel@laptop.americas.sgi.com> <3D4A6F43.4010908@evision.ag> <20020802115321.GE1055@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020802115321.GE1055@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02 2002, Jens Axboe wrote:
> On Fri, Aug 02 2002, Marcin Dalecki wrote:
> > U?ytkownik Stephen Lord napisa?:
> > >In 2.5.30 I started getting these warning messages out ide during
> > >the mount of an XFS filesystem:
> > >
> > >ide-dma: received 1 phys segments, build 2
> > >
> > >Can anyone translate that into English please.
> > 
> > It can be found in pcidma.c.
> > It is repoting that we have one physical segment needed by
> > the request in question but the sctter gather list allocation
> > needed to break it up for mapping in two.
> 
> You don't seem to realise that this is a BUG (somewhere, could even be
> in the generic mapping functions)! blk_rq_map_sg() must never map a
> request to more entries that rq->nr_segments, that's just very wrong.
> 
> That's why I'm suspecting the recent pcidma changes. Just a feeling, I
> have not looked at them.

I'll take that back. Having looked at Adam's changes there are perfectly
fine. I'm now putting my money on IDE breakage somewhere instead. It
would be interesting to dump request state when this happens. Stephen,
can you reproduce this at will?

-- 
Jens Axboe

