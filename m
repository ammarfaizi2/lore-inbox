Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWJLSB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWJLSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWJLSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:01:57 -0400
Received: from brick.kernel.dk ([62.242.22.158]:20319 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750739AbWJLSB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:01:57 -0400
Date: Thu, 12 Oct 2006 18:51:11 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012165110.GJ6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net> <20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk> <87odshr289.fsf@sycorax.lbl.gov> <20061012152356.GE6515@kernel.dk> <87slhtfrlr.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87slhtfrlr.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > Argh damn, it needs this on top of it as well. Your second problem
> > likely stems from that missing bit, please retest with this one applied
> > as well.
> >
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index e7513e5..bddfebd 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -716,7 +716,7 @@ static int cdrom_decode_status(ide_drive
> >  		ide_error(drive, "request sense failure", stat);
> >  		return 1;
> >  
> > -	} else if (blk_pc_request(rq)) {
> > +	} else if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC) {
> >  		/* All other functions, except for READ. */
> >  		unsigned long flags;
> >  
> 
> please ignore my previous message, i am an idiot. if i actually put a
> dvd in the drive then this patch works as expected. sorry for the
> noise.

Good, thanks for the update :-)

-- 
Jens Axboe

