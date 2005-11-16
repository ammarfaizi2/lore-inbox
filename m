Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbVKPUBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVKPUBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVKPUBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:01:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60019 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030472AbVKPUBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:01:19 -0500
Date: Wed, 16 Nov 2005 21:02:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051116200214.GT7787@suse.de>
References: <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de> <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com> <20051116153119.GN7787@suse.de> <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com> <20051116171051.GP7787@suse.de> <58cb370e0511161111u7e99c74ufe0bb9019619d5d0@mail.gmail.com> <20051116192205.GR7787@suse.de> <58cb370e0511161146j4e85ae69y9aad4c9d4e6972e4@mail.gmail.com> <58cb370e0511161155m1b260895t173c843e7a016f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511161155m1b260895t173c843e7a016f78@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> > > which of course didn't work, so it was changed to the above which then
> > > broke the assumption of what type of requests we expect to see in
> > > ide_softirq_done(). We can't generically handle this case, so it's
> > > probably best to just add this logic to __ide_end_request() - it's just
> > > another case for _not_ using the blk_complete_request() path, just like
> > > the partial case.
> >
> > Sounds better but I honestly think that you simply cannot obtain
> > reliable nr_sectors to complete for FS/PC requests just from the
> > request type.  Two examples are: failed disk flush requests and
> > cd noretry requests (both are of FS type).
> 
> first example is bad :-)

Both your examples are wrong - a flush request is non-fs/pc, and noretry
requests doesn't impact the type of the request at from this POV.

> > IMO the best way to fix it is to actually move more (not less!) of
> > the logic from driver->end_request() paths to ide_softirq_done().
> 
> Your latest patch is also a good way to fix it
> (now the only thing left is rq->errors/rq->retries discussed earlier).

Yeah, that is still pending... I updated the patch series so it's a
clean 1-2-3-4 step series now, there instead of this little additions.

-- 
Jens Axboe

