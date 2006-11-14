Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966261AbWKNTBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966261AbWKNTBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966259AbWKNTBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:01:46 -0500
Received: from brick.kernel.dk ([62.242.22.158]:65100 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S966249AbWKNTBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:01:46 -0500
Date: Tue, 14 Nov 2006 20:04:25 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
Message-ID: <20061114190425.GE23770@kernel.dk>
References: <20061110161355.GB15031@kernel.dk> <87u01717qw.fsf@sycorax.lbl.gov> <20061113200256.GC15031@kernel.dk> <87lkmfcdci.fsf@sycorax.lbl.gov> <20061113203523.GE15031@kernel.dk> <87ejs5dib1.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ejs5dib1.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > There is a second error handling patch merged with the first patch as
> > well, perhaps it'll help you out. Attached here as well.
> >
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index bddfebd..8821494 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -724,7 +724,7 @@ static int cdrom_decode_status(ide_drive
> >  		 * if we have an error, pass back CHECK_CONDITION as the
> >  		 * scsi status byte
> >  		 */
> > -		if (!rq->errors)
> > +		if (blk_pc_request(rq) && !rq->errors)
> >  			rq->errors = SAM_STAT_CHECK_CONDITION;
> >  
> >  		/* Check for tray open. */
> >
> 
> tried it again with this patch (on top of all the other patches).
> overall things are much better than they've been in a long time
> (thanks!), but... when cdparanoia gets stuck, if i abort the process
> and restart it the ripping proceeds very slowly (~5x before, ~1.5x
> after). if i eject/insert the cd and then restart cdparanoia the speed
> is as before (~5x). something doesn't get reset until the cd is
> ejected, don't know if it's the kernel's fault though. same thing
> happens if i get an error reading a sector but then cdparanoia manages
> to recover. from that point on the speed is very slow (again until i
> eject/insert the cd; a new instance of cdparanoia is just as slow).

When cdparanoia gets stuck, how is it stuck? Can you give me a backtrace
of that? If you can abort it, sounds like it isn't stuck in the kernel.

-- 
Jens Axboe

