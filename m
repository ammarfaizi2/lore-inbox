Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVHXHIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVHXHIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVHXHIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:08:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24244 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750722AbVHXHIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:08:09 -0400
Date: Wed, 24 Aug 2005 09:08:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050824070809.GA27956@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824010346.GA1021@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24 2005, Nathan Scott wrote:
> On Tue, Aug 23, 2005 at 02:32:36PM +0200, Jens Axboe wrote:
> > Hi,
> > 
> > This is a little something I have played with. It allows you to see
> > exactly what is going on in the block layer for a given queue. Currently
> > it can logs request queueing and building, dispatches, requeues, and
> > completions.
> 
> Ah, fabulous.  Thanks Jens!
> 
> > +	t.magic		= BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
> > +	t.sequence	= atomic_add_return(1, &bt->sequence);
> > +	t.time		= sched_clock() / 1000;
> 
> Wouldn't it be better to pass out the highest precision available here
> & then do the conversion in userspace instead?  I guess one might want
> that little bit more for a RAM disk or something ... actually, talking
> to one of the SGI people here with alot of experience on IRIX with a
> similar facility, the msec resolution there is apparently sometimes an
> issue already with fast storage.

This isn't msec precision, it's usec. sched_clock() is in ns! I already
decided that msec is too coarse, but usec _should_ be enough.

-- 
Jens Axboe

