Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273033AbTHKUzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273071AbTHKUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:55:51 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:36502 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S273033AbTHKUzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:55:48 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0C35E6E0@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik.habbinga@hp.com>
To: "'Francois Romieu'" <romieu@fr.zoreil.com>,
       "HABBINGA,ERIK (HP-Loveland,ex1)" <erik.habbinga@hp.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: RE: [BUG] 2.6.0-test3 and cciss driver (or blk_queue_hardsect_siz
	e)
Date: Mon, 11 Aug 2003 16:55:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed my problem, I now boot without any pesky kernel oopsen.

Thanks!
Erik

> -----Original Message-----
> From: Francois Romieu [mailto:romieu@fr.zoreil.com]
> Sent: Monday, August 11, 2003 2:11 PM
> To: HABBINGA,ERIK (HP-Loveland,ex1)
> Cc: linux-kernel@vger.kernel.org; axboe@suse.de
> Subject: Re: [BUG] 2.6.0-test3 and cciss driver (or
> blk_queue_hardsect_size)
> 
> 
> Greetings,
> 
> HABBINGA,ERIK (HP-Loveland,ex1) <erik.habbinga@hp.com> :
> > I'm wondering if anyone else is having problems with 
> 2.6.0-test3 and the
> > cciss driver, or with the function blk_queue_hardsect_size. 
>  I was able to
> > successfully boot 2.6.0-test2 in previous weeks, but trying 
> 2.6.0-test3
> > today gave me:
> 
> 
> Jens, does the following patch make sense ?
> 
> hba[i]->queue went from 'struct request_queue queue' to
> 'struct request_queue *queue' and it now needs to be explicitly set.
> 
> 
>  drivers/block/cciss.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN drivers/block/cciss.c~oops-cciss drivers/block/cciss.c
> --- linux-2.6.0-test3/drivers/block/cciss.c~oops-cciss	
> Mon Aug 11 21:53:11 2003
> +++ linux-2.6.0-test3-fr/drivers/block/cciss.c	Mon Aug 
> 11 22:00:55 2003
> @@ -2537,6 +2537,7 @@ err_all:
>  	cciss_procinit(i);
>  
>          q->queuedata = hba[i];
> +	hba[i]->queue = q;
>  	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
>  
>  	/* This is a hardware imposed limit. */
> 
> _
> 
