Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVKPUXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVKPUXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVKPUXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:23:21 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:6664 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932603AbVKPUXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:23:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bajoPEyu0/fpGZswGWXDItRYbobj7zHIdpgpf1GK0HXmvZa5rRocSzgLOSQrBS8dOFbk4a8s1wFu13KKEda2ijWpMk5vMaraGAbrB3JnVj5TI8je1AKgWTzJEr7alru38JtjIqpXEzA2LpA9vV+1JTIB92SDU/GMTgNnv9990YI=
Message-ID: <58cb370e0511161223o2d68fc2co1fc3efd0ae9d3a5c@mail.gmail.com>
Date: Wed, 16 Nov 2005 21:23:17 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20051116200214.GT7787@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115184131.GJ7787@suse.de>
	 <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com>
	 <20051116153119.GN7787@suse.de>
	 <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com>
	 <20051116171051.GP7787@suse.de>
	 <58cb370e0511161111u7e99c74ufe0bb9019619d5d0@mail.gmail.com>
	 <20051116192205.GR7787@suse.de>
	 <58cb370e0511161146j4e85ae69y9aad4c9d4e6972e4@mail.gmail.com>
	 <58cb370e0511161155m1b260895t173c843e7a016f78@mail.gmail.com>
	 <20051116200214.GT7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> > > > which of course didn't work, so it was changed to the above which then
> > > > broke the assumption of what type of requests we expect to see in
> > > > ide_softirq_done(). We can't generically handle this case, so it's
> > > > probably best to just add this logic to __ide_end_request() - it's just
> > > > another case for _not_ using the blk_complete_request() path, just like
> > > > the partial case.
> > >
> > > Sounds better but I honestly think that you simply cannot obtain
> > > reliable nr_sectors to complete for FS/PC requests just from the
> > > request type.  Two examples are: failed disk flush requests and
> > > cd noretry requests (both are of FS type).
> >
> > first example is bad :-)
>
> Both your examples are wrong - a flush request is non-fs/pc, and noretry
> requests doesn't impact the type of the request at from this POV.

I meant doing partial completions of the real request from the
->end_flush() and noretry doesn't impact the type but it does
impact the nr_sectors to complete.  However none of these
matters any longer with your latest patch which simplifies things
a lot.

> > > IMO the best way to fix it is to actually move more (not less!) of
> > > the logic from driver->end_request() paths to ide_softirq_done().
> >
> > Your latest patch is also a good way to fix it
> > (now the only thing left is rq->errors/rq->retries discussed earlier).
>
> Yeah, that is still pending... I updated the patch series so it's a
> clean 1-2-3-4 step series now, there instead of this little additions.

Excellent!

Bartlomiej
