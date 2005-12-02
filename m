Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbVLBBeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbVLBBeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLBBeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:34:13 -0500
Received: from havoc.gtf.org ([69.61.125.42]:59533 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932711AbVLBBeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:34:13 -0500
Date: Thu, 1 Dec 2005 20:34:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dirk Henning Gerdes <mail@dirk-gerdes.de>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
Message-ID: <20051202013408.GA4225@havoc.gtf.org>
References: <1133443051.6110.32.camel@noti> <20051201172520.7095e524.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201172520.7095e524.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 05:25:20PM -0800, Andrew Morton wrote:
> Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
> >
> >  For doing benchmarks on the I/O-Schedulers, I thought it would be very
> >  useful to disable the pagecache.
> 
> That's an FAQ.   Something like this?
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> to discard as much pagecache and reclaimable slab objects as it can.
> 
> It won't drop dirty data, so the user should run `sync' first.
> 
> Caveats:
> 
> a) Holds inode_lock for exorbitant amounts of time.
> 
> b) Needs to be taught about NUMA nodes: propagate these all the way through
>    so the discarding can be controlled on a per-node basis.
> 
> c) The pagecache shrinking and slab shrinking should probably have separate
>    controls.
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>

ACK, I've wanted something like this for a while.

I really think it should be a config option, though, to discourage
people from building with it :)

	Jeff



