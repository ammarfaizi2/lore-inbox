Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbTCYMYB>; Tue, 25 Mar 2003 07:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTCYMYB>; Tue, 25 Mar 2003 07:24:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54187 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262302AbTCYMX6>;
	Tue, 25 Mar 2003 07:23:58 -0500
Date: Tue, 25 Mar 2003 13:35:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, dougg@torque.net, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Message-ID: <20030325123502.GW2371@suse.de>
References: <200303211056.04060.pbadari@us.ibm.com> <3E7C4251.4010406@torque.net> <20030322030419.1451f00b.akpm@digeo.com> <3E7C4D05.2030500@torque.net> <20030322040550.0b8baeec.akpm@digeo.com> <20030325105629.GS2371@suse.de> <3E803FDF.1070401@cyberone.com.au> <20030325120121.GV2371@suse.de> <3E8047C7.4070009@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8047C7.4070009@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25 2003, Nick Piggin wrote:
> Jens Axboe wrote:
> 
> >On Tue, Mar 25 2003, Nick Piggin wrote:
> >
> >>
> >>Nice Jens. Very good in theory but I haven't looked at the
> >>code too much yet.
> >>
> >>Would it be possible to have all queues allocate out of
> >>the one global pool of free requests. This way you could
> >>have a big minimum (say 128) and a big maximum
> >>(say min(Mbytes, spindles).
> >>
> >
> >Well not really, as far as I can see we _need_ a pool per queue. Imagine
> >a bio handed to raid, needs to be split to 6 different queues. But our
> >minimum is 4, deadlock possibility. It could probably be made to work,
> >however I greatly prefer a per-queue reserve.
> >
> OK yeah you are right there. In light of your comment below
> I'm happy with that. I was mostly worried about queues being
> restricted to a small maximum.

Understandable, we'll make max tunable.

> >>This way memory usage is decoupled from the number of
> >>queues, and busy spindles could make use of more
> >>available free requests.
> >>
> >>Oh and the max value can easily be runtime tunable, right?
> >>
> >
> >Sure. However, they don't really mean _anything_. Max is just some
> >random number to prevent one queue going nuts, and could be completely
> >removed if the vm works perfectly. Beyond some limit there's little
> >benefit to doing that, though. But MAX could be runtime tunable. Min is
> >basically just to make sure we don't kill ourselves, I don't see any
> >point in making that runtime tunable. It's not really a tunable.
> >
> OK thats good then. I would like to see max removed, however perhaps
> the VM isn't up to that yet. I'll be testing this when your code
> solidifies!

Only testing will tell, so yes you are very welcome to give it a shot.
Let me release a known working version first :)

-- 
Jens Axboe

