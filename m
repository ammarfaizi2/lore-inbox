Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbUCTJyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbUCTJyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:54:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63711 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263270AbUCTJyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:54:01 -0500
Date: Sat, 20 Mar 2004 10:53:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320095341.GA2711@suse.de>
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <200403200059.22234.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403200059.22234.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 19 of March 2004 17:34, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > > Cosmetic stuff that will get ironed out. You can find the patches here:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.5-rc1
> > >-mm2/
> > >
> > > ide-barrier-2.6.5-rc1-mm2-1
> > > 	ide/core part
> 
> Jens, am I right that you didn't do any changes/cleanups I asked you to do?
> Here they are once again (probably some new items added as a bonus). ;-)

Probably, ide code was idle for some time :). As I said to Chris, there
are a bunch of things I want to do to the code over the weekend, I
wanted to get something out there before that though (raises the
incentive to finish it)

> - do not use hwgroup->wrq (die!) and do not add drive->special_buf,
>   just do what PM code does and other special commands do - use taskfile
>   (yes, dirty stack allocation)

Doesn't work for split flush, ie issue a bunch of flushes to devices,
then wait for them. I agree using ->wrq and special_buf is ugly as hell,
though.

> - SCSI -> IDE transform should die, please use something like REQ_FLUSH
>   and let subsystems deal with it

That's what I wanted to avoid, adding more flags. However, if you see
the comment in there this is being changed to ->issue_flush() instead.
So it's dying, don't worry.

> - ide_get_error_location() is cool but clean other places doing same thing
>   as you are duplicating existing code
>   (please use u64 not sector_t - you are getting raw info from the disk)

Ok

> - why does blkdev_issue_flush() add REQ_BLOCK_PC to rq->flags?

Ehm, because it _is_ a REQ_BLOCK_PC? ;-)

> - why are we doing pre-flush?

To ensure previously written data is on platter first.

-- 
Jens Axboe

