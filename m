Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422913AbWJYFL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422913AbWJYFL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 01:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422952AbWJYFL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 01:11:28 -0400
Received: from brick.kernel.dk ([62.242.22.158]:63537 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422913AbWJYFL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 01:11:27 -0400
Date: Wed, 25 Oct 2006 07:12:39 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061025051238.GO4281@kernel.dk>
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E9C18.70803@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453E9C18.70803@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2006, Martin Peschke wrote:
> >>>I have to say it's news to
> >>>me that it's performance intensive, tests I did with Alan Brunelle a
> >>>year or so ago showed it to be quite low impact.
> >>I found some discussions on linux-btrace (Feburary 2006).
> >>There is little information on how the alleged 2 percent impact has
> >>been determined. Test cases seem to comprise formatting disks ...hmm.
> >
> >It may sound strange, but formatting a large drive generates a huge
> >flood of block layer events from lots of io queued and merged. So it's
> >not a bad benchmark for this type of thing. And it's easy to test :-)
> 
> Just wondering to what degree this might resemble I/O workloads run
> by customers in their data centers.

It wont of course, the point is to generate a flood of events to put as
much pressure on blktrace logging as possible. Dirtying tons of data
does that.

> >>>You'd be silly to locally store traces, send them out over the network.
> >>Will try this next and post complaints, if any, along with numbers.
> >
> >Thanks! Also note that you do not need to log every event, just register
> >a mask of interesting ones to decrease the output logging rate. We could
> >so with some better setup for that though, but at least you should be
> >able to filter out some unwanted events.
> 
> ...and consequently try to scale down relay buffers, reducing the risk of
> memory constraints caused by blktrace activation.

Pretty pointless, unless you are tracing lots of disks. 4x128kb gone
wont be a showstopper for anyone.

> >>However, a fast network connection plus a second system for blktrace
> >>data processing are serious requirements. Think of servers secured
> >>by firewalls. Reading some counters in debugfs, sysfs or whatever
> >>might be more appropriate for some one who has noticed an unexpected
> >>I/O slowdown and needs directions for further investigation.
> >
> >It's hard to make something that will suit everybody. Maintaining some
> >counters in sysfs is of course less expensive when your POV is cpu
> >cycles.
> 
> Counters are also cheaper with regard to memory consumption. Counters
> are probably cause less side effects, but are less flexible than
> full-blown traces.

And the counters are special cases and extremely inflexible.

-- 
Jens Axboe

