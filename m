Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTDXOez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTDXOez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:34:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7922 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263370AbTDXOex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:34:53 -0400
Date: Thu, 24 Apr 2003 16:46:40 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (1/4)
In-Reply-To: <20030424082331.GE8775@suse.de>
Message-ID: <Pine.SOL.4.30.0304241639590.7711-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Apr 2003, Jens Axboe wrote:

> On Wed, Apr 23 2003, Bartlomiej Zolnierkiewicz wrote:
> >  		bio = bio_map_user(bdev, uaddr, hdr.dxfer_len, reading);
> > -		if (bio) {
> > -			if (writing)
> > -				bio->bi_rw |= (1 << BIO_RW);
> > -
> > -			nr_sectors = (bio->bi_size + 511) >> 9;
> > -
> > -			if (bio->bi_size < hdr.dxfer_len) {
> > -				bio_endio(bio, bio->bi_size, 0);
> > -				bio_unmap_user(bio, 0);
> > -				bio = NULL;
> > -			}
> > -		}
> > +		if (bio && writing)
> > +			bio->bi_rw |= (1 << BIO_RW);
>
> I think it's cleaner to have bio_map_user() set the direction bit,
> instead of having every user do it. It also uncovered an old bug where

You are right.

> blk_queue_bounce() is called without the direction bit set in the bio,
> uh oh...

Yep.

> Here's my preferred version. You also had the incremental bio processing
> as a prereq for this bio addition, I removed that for now as well.

Patch is okay.

> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/04/24	axboe@smithers.home.kernel.dk	1.1217
> # - Abstract out bio request preparation
> # - Have bio_map_user() set data direction (fixes bug where blk_queue_bounce()
> #   is called without it set)
> # - Split bio_map_user() in two
> # --------------------------------------------

Very minor issue, last comment is a bit misleading...

--
Bartlomiej Zolnierkiewicz

