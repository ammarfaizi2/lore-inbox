Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264982AbUELGVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbUELGVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbUELGVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:21:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8342 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264982AbUELGP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:15:28 -0400
Date: Wed, 12 May 2004 09:05:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040512070543.GC1803@suse.de>
References: <20040510143024.GF14403@suse.de> <200405120532.i4C5WCF25908@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405120532.i4C5WCF25908@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11 2004, Chen, Kenneth W wrote:
> >>>> Jens Axboe wrote on Monday, May 10, 2004 7:30 AM
> > > >
> > > > Actually, with the good working batching we might get away with killing
> > > > freereq completely. Have you tested that (if not, could you?)
> > >
> > > Sorry, I'm clueless on "good working batching".  If you could please give
> > > me some pointers, I will definitely test it.
> >
> > Something like this.
> >
> > --- linux-2.6.6/drivers/block/ll_rw_blk.c~	2004-05-10 16:23:45.684726955 +0200
> > +++ linux-2.6.6/drivers/block/ll_rw_blk.c	2004-05-10 16:29:04.333792268 +0200
> > @@ -2138,8 +2138,8 @@
> >
> >  static int __make_request(request_queue_t *q, struct bio *bio)
> >  {
> > -	struct request *req, *freereq = NULL;
> >  	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
> > +	struct request *req;
> >  	sector_t sector;
> >
> >
> > [snip] ...
> 
> I'm still working on this.  With this patch, several processes stuck
> in "D" state and never finish.  Suspect it's the barrier thing, it
> jumps through blk_plug_device() and might goof up the queue afterwards.

I'll do a quick test run (and review) of the patch, it wasn't even
compiled here. So the chance of a slip-up is non-zero.

-- 
Jens Axboe

