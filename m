Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUAWQSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUAWQSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:18:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60127 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266577AbUAWQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:18:52 -0500
Date: Fri, 23 Jan 2004 17:18:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
Message-ID: <20040123161846.GR2734@suse.de>
References: <Pine.LNX.4.44.0401231456450.944-100000@neptune.local> <200401231624.14687.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401231624.14687.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 23 of January 2004 15:01, Pascal Schmidt wrote:
> > On Fri, 23 Jan 2004, Jens Axboe wrote:
> > > It's a good first start, thanks for doing this. You really want to be
> > > storing this info in the queue, though, there's a hardsector size just
> > > for this very purpose. That way other layers know about the hardware
> > > sector size as well, not just ide-cd. And you get other things right for
> > > free as well, for instance ide_cdrom_prep_fs() needs a correct hardware
> > > block size or it will build wrong cdbs.
> >
> > Hmmm. I'm doing
> >
> > 	blk_queue_hardsect_size(drive->queue, sectors_per_frame << 9);
> >
> > inside of cdrom_read_toc, is that not enough? Or do you mean that
> > I should only store it in the queue and not also in cdrom_state_flags?
> 
> I think Jens means storing it only in q->hardsect_size.  This way you
> can just use rq->q->hardsect_size << 9 to get sectors_per_frame.

Yes that's precisely what I mean, there's no need to keep the same info
in several places.

-- 
Jens Axboe

