Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUCTQOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbUCTQOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:14:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17297 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263457AbUCTQOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:14:43 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 17:23:11 +0100
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
References: <20040319153554.GC2933@suse.de> <200403200059.22234.bzolnier@elka.pw.edu.pl> <20040320095341.GA2711@suse.de>
In-Reply-To: <20040320095341.GA2711@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201723.11906.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 10:53, Jens Axboe wrote:
> On Sat, Mar 20 2004, Bartlomiej Zolnierkiewicz wrote:
> > - do not use hwgroup->wrq (die!) and do not add drive->special_buf,
> >   just do what PM code does and other special commands do - use taskfile
> >   (yes, dirty stack allocation)
>
> Doesn't work for split flush, ie issue a bunch of flushes to devices,
> then wait for them. I agree using ->wrq and special_buf is ugly as hell,
> though.

I can't see why it doesn't work, please explain.

> > - ide_get_error_location() is cool but clean other places doing same
> > thing as you are duplicating existing code
> >   (please use u64 not sector_t - you are getting raw info from the disk)
>
> Ok

Cool.

> > - why does blkdev_issue_flush() add REQ_BLOCK_PC to rq->flags?
>
> Ehm, because it _is_ a REQ_BLOCK_PC? ;-)

Ok, it is PC till SCSI->IDE transform, then it is no longer PC. :)

> > - why are we doing pre-flush?
>
> To ensure previously written data is on platter first.

I know this, I want to know what for you are doing this?

Previously written data is already acknowledgment to the upper layers so you
can't do much even if you hit error on flush cache.  IMO if error happens we
should just check if failed sector is of our ordered write if not well report
it and continue.  It's cleaner and can give some (small?) performance gain.

Regards,
Bartlomiej

