Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966722AbWKOJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966722AbWKOJsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966723AbWKOJsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:48:07 -0500
Received: from brick.kernel.dk ([62.242.22.158]:39483 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S966722AbWKOJsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:48:05 -0500
Date: Wed, 15 Nov 2006 10:47:27 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: inux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       zach.brown@oracle.com
Subject: Re: linux io_submit syscall duration
Message-ID: <20061115094727.GJ23770@kernel.dk>
References: <5d96567b0611142339k23e78cc6u19b64052be5cd360@mail.gmail.com> <20061115074720.GH23770@kernel.dk> <5d96567b0611150143n1a7cc16dgea39fba748a2de7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d96567b0611150143n1a7cc16dgea39fba748a2de7f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't top post and don't drop the cc list!)

On Wed, Nov 15 2006, Raz Ben-Jehuda(caro) wrote:
> first thank you from your quick reply.
> 
> I looked and what I found is :
> "io_submit() taking a long time to return ?" from 2006-07-14.

Subject is "async I/O seems to be blocking on 2.6.15" and the posting is
from 2006-11-3. I said about a week ago, not 4 months.

> 1.  It is NOT the first IO. already took care for that in my test.

That was a different problem.

> 2.  The test uses block device and does not walk through a file system.

So would not apply.

> 3.  Taking a look at the code, it seems that the main problem is the fact
>     that in io_submit_one all the pending requests are being rerun.
> 
>    io_submit_one()
>   {
>    ...
>        if (!list_empty(&ctx->run_list)) {
>                /* drain the run list */
>              while (__aio_run_iocbs(ctx))
>                      ;
>      }
>   ...
>   }
> 
>  This code was put in remarks.
> the second is in:
>  aio_run_iocb()
>   ...
>    current->io_wait = &iocb->ki_wait;
>    if ( iocb->ki_retried >  1)
>        ret = retry(iocb);
>    else{
>        ret = -EIOCBRETRY;
>        kiocbSetKicked(iocb);
>    }
>     current->io_wait = NULL;
>  ....
> 
>  With these fixes io_submit delay reduced to zero ms.
> 
> I would appreciate your review on these fixes.

Post a patch so it can be reviewed.

-- 
Jens Axboe

