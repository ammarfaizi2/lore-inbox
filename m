Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUFKRw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUFKRw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFKRw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:52:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56488 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264279AbUFKRvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:51:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [7/12]
Date: Fri, 11 Jun 2004 19:55:33 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200406111759.54209.bzolnier@elka.pw.edu.pl> <20040611164501.GA4309@suse.de>
In-Reply-To: <20040611164501.GA4309@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111955.33298.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 of June 2004 18:45, Jens Axboe wrote:
> On Fri, Jun 11 2004, Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] ide: fix ide-cd to not retry REQ_DRIVE_TASKFILE requests
> >
> > 'cat /proc/ide/hdx/identify' generates REQ_DRIVE_TASKFILE request
> > (for WIN_PIDENTIFY command) even for devices controlled by ide-cd.
> >
> > All other drivers don't retry such requests.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
> >
> >  linux-2.6.7-rc3-bzolnier/drivers/ide/ide-cd.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> >
> > diff -puN drivers/ide/ide-cd.c~ide_cdrom_taskfile drivers/ide/ide-cd.c
> > --- linux-2.6.7-rc3/drivers/ide/ide-cd.c~ide_cdrom_taskfile	2004-06-10
> > 23:01:31.725338592 +0200 +++
> > linux-2.6.7-rc3-bzolnier/drivers/ide/ide-cd.c	2004-06-10
> > 23:01:31.731337680 +0200 @@ -574,7 +574,7 @@ ide_startstop_t
> > ide_cdrom_error (ide_dri
> >  	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
> >  		return ide_stopped;
> >  	/* retry only "normal" I/O: */
> > -	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
> > +	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE))
> > { rq->errors = 1;
> >  		ide_end_drive_cmd(drive, stat, err);
> >  		return ide_stopped;
>
> Was wondering whether it was clearer to use !blk_fs_request() instead,
> but that would need looking at REQ_PC and REQ_BLOCK_PC. So for now the
> above is fine with me, if you include ide_cdrom_abort() as well.

OK, thanks.

