Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbSIPOOm>; Mon, 16 Sep 2002 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261954AbSIPOOl>; Mon, 16 Sep 2002 10:14:41 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:57094 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S261952AbSIPOOk>;
	Mon, 16 Sep 2002 10:14:40 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209161419.g8GEJXF09937@oboe.it.uc3m.es>
Subject: Re: end_request error procedure in 2.5?
In-Reply-To: <20020916135444.GK12364@suse.de> from Jens Axboe at "Sep 16, 2002
 03:54:44 pm"
To: Jens Axboe <axboe@suse.de>
Date: Mon, 16 Sep 2002 16:19:33 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jens Axboe wrote:"
> >  end_request( req, (req->errors == 0) ? 1 : 0 );
> >  ..
> > 
> >  static void end_request(struct request *req, int uptodate) {
> >  struct bio *bio;
> >  while ((bio = req->bio) != NULL) {
> >              blk_finished_io(bio_sectors(bio));
> >              req->bio = bio->bi_next;
> >              bio->bi_next = NULL;
> >              bio_endio(bio, uptodate);
> >      }
> >      blk_put_request(req);
> >  }
> > 
> > 
> > It works fine except on error.  Kernel 2.5.31.  I understand that
> > put_request adds the request back to a free list (if gotten from there
> > via get_request).  The request is ordinary, except out of range ...
> > it's produced by an e2fsck of the device when the device itself is
> > unformatted, and the out of range request gets passed to the driver and
> > is errored there, and "kapow" ..
> 
> The error is most likely in the driver calling end_that_request_first(),

Hmmm ... it's not called. The above is exactly all that is called
and LOCAL_END_REQUEST is set. OK. I see what you are saying. Yes, I
will direct my attention to that function instead ...

 ... and yes, I see a possible path in which the queue spinlock may be
taken twice. OK!

Thanks!

> not the function itself. Maybe you can try to do at least some
> debugging, I hope you are not expecting anyone to be able to help you
> from the above report.

!! :-)

Thanks, yes I know! However, it's taken me about 4 days to get it this
far. As you know, complete lockups are hard to debug! There's a race
condition between the printk appearing on the console and the machine
stopping :-(. 

Thanks again.

Peter
