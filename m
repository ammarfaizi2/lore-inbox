Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316263AbSEQPjV>; Fri, 17 May 2002 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316264AbSEQPjU>; Fri, 17 May 2002 11:39:20 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:31229 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316263AbSEQPjT>;
	Fri, 17 May 2002 11:39:19 -0400
Date: Fri, 17 May 2002 11:39:15 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cpqarray-1: Convert to modern module_init mechanism
Message-ID: <20020517153915.GA27771@www.kroptech.com>
In-Reply-To: <20020517005146.GA32719@www.kroptech.com> <Pine.LNX.4.44.0205170929350.26436-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 09:35:31AM -0500, Kai Germaschewski wrote:
> 
> On Thu, 16 May 2002, Adam Kropelin wrote:
> 
> > Below is a patch (against 2.5.15-dj1) to convert cpqarray over to the modern
> > module_init mechanism. This eliminates the need to call cpqarray_init() from
> > genhd.c and starts the process of simplifying the cpqarray init sequence.
> > It lays the groundwork for converting over to the "new" PCI registration
> > mechanism as well. Also included in the patch are some simple cleanups for
> > a few obvious formatting flaws.
> > 
> > Comments and critique are welcome. I'm also curious if this work is
> > considered worthwhile. If so, I'll continue on and do the PCI init conversion
> > (and any other fixups that may be warranted) as well.
> 
> Patch looks basically good to me (I basically have the same thing sitting
> around here, as I was cleaning up drivers/block/genhd.c) If you want to I 
> can send you what I have, so you can base the further changes (e.g. PCI) 
> on it.

That would be great; thanks.

> >  /*
> >   *  This is it.  Find all the controllers and register them.  I really hate
> >   *  stealing all these major device numbers.
> > - *  returns the number of block devices registered.
> > + *  returns 0 on success, -EIO on failure
> 
> I'd suggest to go ahead and make it return sensible values, i.e. -EBUSY if
> it can't get the major, -ENODEV if there's no hardware, -ENOMEM if the
> allocations fail.

Ok, I'll go ahead and do that. I was tempted to do it in the first pass but 
wanted to make sure it would be the Right Thing first.

> >  int __init cpqarray_init(void)
> 
> This should be static now.

Surely you're right...

> Also, you need to remove the explicit call to 
> cpqarray_init() from drivers/block/genhd.c, otherwise it'll get called 
> twice. (That part's already in my patch).

This was against 2.5.15-dj1 which already removes the call from genhd.c.
If this goes to Linus at some point I'll add that bit.

Thanks for your suggestions; they are much appreciated.

--Adam

