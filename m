Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTE1HA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbTE1HA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:00:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19361 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264569AbTE1HAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:00:55 -0400
Date: Wed, 28 May 2003 09:13:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528071355.GO845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281533.08524.kernel@kolivas.org> <20030528060432.GF845@suse.de> <200305281713.24357.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305281713.24357.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Con Kolivas wrote:
> On Wed, 28 May 2003 16:04, Jens Axboe wrote:
> > On Wed, May 28 2003, Con Kolivas wrote:
> > > On Wed, 28 May 2003 04:04, Marc-Christian Petersen wrote:
> > > > On Tuesday 27 May 2003 19:50, manish wrote:
> > > >
> > > > Hi Manish,
> > > >
> > > > > It is not a system hang but the processes hang showing the same stack
> > > > > trace. This is certainly not a pause since the bonnie processes that
> > > > > were hung (or deadlocked) never completed after several hrs. The
> > > > > stack trace  was the same.
> > > >
> > > > then you are hitting a different bug or a bug related to the issues
> > > > Christian Klose and me and $tons of others were complaining.
> > > >
> > > > The bug you are hitting might be the problem with "process stuck in D
> > > > state" Andrea Arcangeli fixed, let me guess, over half a year ago or
> > > > so.
> > > >
> > > > In case you have a good mind to try to address your issue, you might
> > > > want to try out the patch you can find here:
> > > >
> > > > http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.2
> > > >1rc2 aa1/9980_fix-pausing-2
> > > >
> > > > ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard is
> > > > dead/: speak _NOW_ please, doesn't matter who you are!
> > >
> > > Yo!
> > >
> > > I'll throw my babushka into the ring too. I think it's obvious from MCP's
> > > comments that I've been involved in testing this problem. I've spent
> > > hours, possibly days trying to find a way to fix the pauses introduced
> > > since 2.4.19pre1. I agree with what MCP describes that the machine can
> > > come to a standstill under any sort of disk i/o and is unusable for a
> > > variable length of time. I've been playing with all sorts of numbers in
> > > my patchset to try and limit it with only mild success. The best results
> > > I've had without a major decrease in throughput was using akpm's read
> > > latency 2 patch but by significantly reducing the nr_requests. It was
> > > changing the number of requests that I discovered dropping them to 4
> > > fixed the problem but destroyed write throughput. I was pleased to see AA
> > > give the problem recognition after my contest results on his kernel but
> > > disappointed that the problem only was reduced, not fixed.
> >
> > Does the problem change at all if you force batch_requests to 0?
> 
> I've tried batch_requests to 1 by itself (without changing the
> nr_request) and that didn't fix it, but recall dropping nr_requests to
> 2 (which would make batch requests==0) made the machine fail to boot
> so I haven't tried batch requests 0 by itself. Should it boot with it
> == 0?

If you leave nr_requests as it is, I don't see why it should not boot
with batch_requests == 0.

I can't see in all of these mails whether backing out akpm's starvation
patch makes the problem go away. Does it?

-- 
Jens Axboe

