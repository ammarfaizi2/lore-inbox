Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUFKRtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUFKRtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUFKRs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:48:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59019 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264247AbUFKRr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:47:59 -0400
Date: Fri, 11 Jun 2004 19:47:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [11/12]
Message-ID: <20040611174757.GA4436@suse.de>
References: <200406111816.10369.bzolnier@elka.pw.edu.pl> <20040611170154.GE4309@suse.de> <200406111949.55984.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406111949.55984.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2004, Bartlomiej Zolnierkiewicz wrote:
> On Friday 11 of June 2004 19:01, Jens Axboe wrote:
> > On Fri, Jun 11 2004, Bartlomiej Zolnierkiewicz wrote:
> > > [PATCH] ide: kill task_[un]map_rq()
> > >
> > > PIO handlers under CONFIG_IDE_TASKFILE_IO=n are never used for bio
> > > based requests (rq->bio is always NULL) so we can use rq->buffer
> > > directly instead of calling ide_[un]map_buffer().
> >
> > Not so sure if it's ever used for something requiring performance, and
> > even if it isn't then it may still be worth it to keep the mapping and
> > instead fix the task setup to map in user data with blk_rq_map_user() by
> > fixing up ide_taskfile_ioctl().
> 
> I agree about blk_rq_map_user() (I even did it once around 2.5.60-70).
> However I think that we are better off (slowly) killing old taskfile
> handlers completely (this patch is for old taskfile handlers only)
> and using CONFIG_IDE_TASKFILE_IO versions (which know about rq->bio).

Ah these are the old handlers. Then I fully agree, nuk the mappings.

-- 
Jens Axboe

