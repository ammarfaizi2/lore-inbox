Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTE1KQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTE1KQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:16:59 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:27911 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263905AbTE1KQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:16:57 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 12:29:44 +0200
User-Agent: KMail/1.5.2
Cc: axboe@suse.de, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528032315.679e77b0.akpm@digeo.com> <200305282029.14875.kernel@kolivas.org>
In-Reply-To: <200305282029.14875.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305281229.44407.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 12:29, Con Kolivas wrote:

Hi Con, AKPM, Jens,

> > diff -puN drivers/block/ll_rw_blk.c~1 drivers/block/ll_rw_blk.c
> > --- 24/drivers/block/ll_rw_blk.c~1	2003-05-28 03:20:42.000000000 -0700
> > +++ 24-akpm/drivers/block/ll_rw_blk.c	2003-05-28 03:20:57.000000000 -0700
> > @@ -590,10 +590,10 @@ static struct request *__get_request_wai
> >  	register struct request *rq;
> >  	DECLARE_WAITQUEUE(wait, current);
> >
> > -	generic_unplug_device(q);
> >  	add_wait_queue_exclusive(&q->wait_for_requests[rw], &wait);
> >  	do {
> >  		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		generic_unplug_device(q);
> >  		if (q->rq[rw].count == 0)
> >  			schedule();
> >  		spin_lock_irq(&io_request_lock);
> It's not this because this is the layout in my -ck* and it still exhibits
> the pauses.
Same for -WOLK*

ciao, Marc

