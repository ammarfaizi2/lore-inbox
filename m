Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265687AbTBXJRb>; Mon, 24 Feb 2003 04:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbTBXJRb>; Mon, 24 Feb 2003 04:17:31 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:61572 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S265687AbTBXJRa>; Mon, 24 Feb 2003 04:17:30 -0500
Date: Mon, 24 Feb 2003 01:24:27 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: wli@holomorphy.com, lm@work.bitmover.com, mbligh@aracnet.com,
       davidsen@tmr.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224092427.GA6733@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085617.GA6483@gnuppy.monkey.org> <20030224010938.35de6275.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224010938.35de6275.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:09:38AM -0800, Andrew Morton wrote:
> That's a 5% difference across five dbench runs.  If it is even 
> statistically significant, dbench is notoriously prone to chaotic
> effects (less so in 2.5)  It is a long stretch to say that any
> increase in dbench numbers can be generalised to "improved IO
> performance" across the board.

I think the test is valid. If the scheduler can't deal with some
kind IO event in a very tight time window, then you'd think that 
it might influence the performance of that IO system.

> The preempt stuff is all about *worst-case* latency.  I doubt if
> it shifts the average latency (which is in the 50-100 microsecond
> range) by more that 50 microseconds.

You obviously don't know what the current patch is suppose to do, I'm
assuming that's what you're refering to at this point. A fully preemptive
kernel, like the one from TimeSys, is about constraining worst case
latency by using sleeping locks that enable preemption across critical
section where that's normally turned off courtesy of spinlocks. Combine
that with heavy weight interrupts you have a mix for constraining maximum
latency to about 50us in their kernel.

The patch and locking schema in Linux in it's current form only reduces
the latency on "average", which is an inverse to your claim if concerning
maximum latency. The last time I looked at 2.5.62 there were still quite
a few place where there was the possibility of a critical section bounded
by spinlocks (with interrupts turned off) to iterate over a data structure
(VM), copy, move memory in critical sections that have very large upper
bounds.

I can't believe an engineer of your stature would blow something this
basic to the understanding of locking. You can't mean what you just
said above.

Read:
	http://linuxdevices.com/articles/AT6106723802.html

That's basically what I'm refering to...

bill

