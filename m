Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWGJG1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWGJG1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWGJG1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:27:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37672 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161346AbWGJG1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:27:03 -0400
Date: Mon, 10 Jul 2006 08:24:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Milton Miller <miltonm@bga.com>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: readahead support
Message-ID: <20060710062408.GA4141@suse.de>
References: <200607100546.k6A5k3qU049783@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607100546.k6A5k3qU049783@sullivan.realtime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Milton Miller wrote:
> Looking at the commit 
> 
> Date: Thu, 6 Jul 2006 08:03:28 +0000 (+0200)
> X-Git-Url: http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=40359ccb836866435b03a0cb57345002b587d875
> 
> > --- a/block/blktrace.c
> > +++ b/block/blktrace.c
> ..
> > @@ -79,6 +79,8 @@ static u32 bio_act[3] __read_mostly = { 
> >  	(((rw) & (1 << BIO_RW_BARRIER)) >> (BIO_RW_BARRIER - 0))
> >  #define trace_sync_bit(rw)	\
> >  	(((rw) & (1 << BIO_RW_SYNC)) >> (BIO_RW_SYNC - 1))
> > +#define trace_ahead_bit(rw)	\
> > +	(((rw) & (1 << BIO_RW_AHEAD)) << (BIO_RW_AHEAD - 0))
> >  
> >  /*
> >   * The worker for the various blk_add_trace*() types. Fills out a
> 
> 
> Than doesn't make sense, we are using the bit position in the BIO_RW_
> name space twice instead of factoring it out like the other uses.
> 
> Looking at  include/linux/bio.h line 147 we find
> #define BIO_RW_AHEAD    1
> 
> So this is moving it from bit 1 (value 2) to bit 2 (value 4).
> 
> I think the shift should be << (2 - BIO_RW_AHEAD).

You are right, it's a little nonsensical right now. I'll get it fixed
up.

-- 
Jens Axboe

