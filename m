Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWJLQyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWJLQyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWJLQyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:54:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:45502 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422862AbWJLQyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:54:20 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
From: Mike Galbraith <efault@gmx.de>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
In-Reply-To: <87r6xd1qpl.fsf@sycorax.lbl.gov>
References: <87hcya8fxk.fsf@sycorax.lbl.gov>
	 <20061012065346.GY6515@kernel.dk>
	 <1160648885.5897.6.camel@Homer.simpson.net>
	 <1160662435.6177.3.camel@Homer.simpson.net>
	 <20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
	 <87odshr289.fsf@sycorax.lbl.gov> <20061012152356.GE6515@kernel.dk>
	 <87r6xd1qpl.fsf@sycorax.lbl.gov>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 19:00:27 +0000
Message-Id: <1160679627.7956.7.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 08:47 -0700, Alex Romosan wrote:
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
> no more strange messages but, once again, i am not able to read movie
> dvd's with the above patch applied.

Hmm.  Xine still works fine here.

I tried starting xine with no dvd in the drive for grins, and _without_
this patch, I had to resort to SysRq-E to regain control of my box, and
that still took quite a while.  I got no oops, but a zillion IO retries
and sector blah messages.  DoSed me bigtime.  With this patch, I just
got the expected can't open failure.

	-Mike

