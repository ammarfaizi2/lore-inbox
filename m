Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUBTPAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBTPAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:00:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17099 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261236AbUBTPAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:00:46 -0500
Date: Fri, 20 Feb 2004 16:00:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <thornber@redhat.com>
Cc: Miquel van Smoorenburg <miquels@cistron.net>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       miquels@cistron.nl, linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bdi_congestion_funp (was: Re: [PATCH] per process request limits (was Re: IO scheduler, queue depth, nr_requests))
Message-ID: <20040220150013.GY27190@suse.de>
References: <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl> <40353E30.6000105@cyberone.com.au> <20040219235303.GI32263@drinkel.cistron.nl> <40355F03.9030207@cyberone.com.au> <20040219172656.77c887cf.akpm@osdl.org> <40356599.3080001@cyberone.com.au> <20040219183218.2b3c4706.akpm@osdl.org> <20040220144042.GC20917@traveler.cistron.net> <20040220145944.GM27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220145944.GM27549@reti>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20 2004, Joe Thornber wrote:
> > +	devices = dm_table_get_devices(t);
> > +	for (d = devices->next; d != devices; d = d->next) {
> > +		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
> > +		request_queue_t *q = bdev_get_queue(dd->bdev);
> > +		r |= test_bit(bdi_state, &(q->backing_dev_info.state));
> 
> Shouldn't this be calling your bdi_*_congested function rather than
> assuming it is a real device under dm ? (often not true).
> 
> I'm also very slightly worried that or'ing together the congestion
> results for all the seperate devices isn't always the right thing.
> These devices include anything that the targets are using, exception
> stores for snapshots, logs for mirror, all paths for multipath (or'ing
> is most likely to be wrong for multipath).

Yeah the patch is pretty much crap in that area, I don't think Miquel
was aiming for inclusion :)

I'd suggest making queue functions for congestion state as well so it
stacks properly.

-- 
Jens Axboe

