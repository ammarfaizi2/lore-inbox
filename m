Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUFKRsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUFKRsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUFKRsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:48:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57767 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264270AbUFKRp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:45:57 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [11/12]
Date: Fri, 11 Jun 2004 19:49:55 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200406111816.10369.bzolnier@elka.pw.edu.pl> <20040611170154.GE4309@suse.de>
In-Reply-To: <20040611170154.GE4309@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111949.55984.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 of June 2004 19:01, Jens Axboe wrote:
> On Fri, Jun 11 2004, Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] ide: kill task_[un]map_rq()
> >
> > PIO handlers under CONFIG_IDE_TASKFILE_IO=n are never used for bio
> > based requests (rq->bio is always NULL) so we can use rq->buffer
> > directly instead of calling ide_[un]map_buffer().
>
> Not so sure if it's ever used for something requiring performance, and
> even if it isn't then it may still be worth it to keep the mapping and
> instead fix the task setup to map in user data with blk_rq_map_user() by
> fixing up ide_taskfile_ioctl().

I agree about blk_rq_map_user() (I even did it once around 2.5.60-70).
However I think that we are better off (slowly) killing old taskfile
handlers completely (this patch is for old taskfile handlers only)
and using CONFIG_IDE_TASKFILE_IO versions (which know about rq->bio).

> It would make HDIO_DRIVE_TASKFILE a whole lot nicer.

