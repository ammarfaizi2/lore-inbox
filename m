Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318858AbSHRF6k>; Sun, 18 Aug 2002 01:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318860AbSHRF6k>; Sun, 18 Aug 2002 01:58:40 -0400
Received: from waste.org ([209.173.204.2]:35302 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318858AbSHRF6k>;
	Sun, 18 Aug 2002 01:58:40 -0400
Date: Sun, 18 Aug 2002 01:02:39 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818060239.GO21643@waste.org>
References: <3D5F291E.5040806@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5F291E.5040806@pacbell.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:57:02PM -0700, David Brownell wrote:
> > Questionable Sources and Time Scales
> >
> >  Due to the vagarities of computer architecture, things like keyboard
> >  and mouse interrupts occur on their respective scanning or serial
> >  clock edges, and are clocked relatively slowly. Worse, devices like
> >  USB keyboards, mice, and disks tend to share interrupts and probably
> >  line up on USB clock boundaries.
> 
> Last time I looked, USB didn't feed into the pool of randomness at
> any level ... certainly none of the host controller drivers do, and
> I didn't notice any drivers layered on top of those bus drivers
> doing so either.  That includes keyboards, mice, and disks; as well
> as network devices, webcams, and more.  So that "worse" isn't real.

I may be mistaken, but I believe the USB HID devices go through the
generic input layer, which did get touched by my second patch.

> It's likely correct that the host controller drivers don't use the
> SA_SAMPLE_RANDOM flag: they're effectively sharing interrupts from
> many kinds of devices, some of which may be very predictable (like
> webcams).  But it might be OK for for some of those layered drivers
> (HID, storage, ...) to act as entropy sources ... if such timescale
> issues get addressed!  Maybe an URB_SAMPLE_RANDOM flag would be the
> right kind of model.

Shared interrupts are actually ok as long as my context switch
criteria (or something similar) is met.

Storage is a bad source of entropy. We go out of our way to leak that
timing information as accurately as possible in the typical server
configuration. It's still ok to use as seed though.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
