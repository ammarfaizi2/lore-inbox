Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTEFHMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTEFHMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:12:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40870 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262412AbTEFHMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:12:47 -0400
Date: Tue, 6 May 2003 09:25:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506072500.GS812@suse.de>
References: <20030505.211606.28803580.davem@redhat.com> <20030505224815.07e5240c.akpm@digeo.com> <20030505234248.7cc05f43.akpm@digeo.com> <20030505.223944.23027730.davem@redhat.com> <20030505235758.25f769fc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505235758.25f769fc.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05 2003, Andrew Morton wrote:
> "David S. Miller" <davem@redhat.com> wrote:
> >
> >    From: Andrew Morton <akpm@digeo.com>
> >    Date: Mon, 5 May 2003 23:42:48 -0700
> >    
> >    Can't think of anything very clever there, except to go and un-percpuify the
> >    disk stats.  I think that's best, really - disk requests only come in at 100
> >    to 200 per second - atomic_t's or int-plus-per-disk-spinlock will be fine.
> >    
> > Use some spinlock we already have to be holding during the
> > counter bumps.
> 
> Last time we looked at that, q->lock was already held in almost all the right
> places so yes, that'd work.

As far as I can see, queue lock _is_ held in all the right spot. At
least where it matters, adding new samples.

> > Frankly, these things don't need to be %100 accurate.  Using
> > a new spinlock or an atomic_t for this seems rediculious.
> 
> The disk_stats structure has an "in flight" member.  If we don't have proper
> locking around that, disks will appear to have -3 requests in flight for all
> time, which would look a tad odd.

So check for < 0 in flight? I totally agree with davem here.

-- 
Jens Axboe

