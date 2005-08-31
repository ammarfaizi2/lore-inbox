Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVHaPui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVHaPui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVHaPui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:50:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964846AbVHaPuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:50:37 -0400
Date: Wed, 31 Aug 2005 17:50:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: CFQ refcounting fix
Message-ID: <20050831155023.GE4018@suse.de>
References: <200508302241.j7UMf8ag018433@d01av03.pok.ibm.com> <20050831072830.GG4018@suse.de> <4315B366.5040906@us.ibm.com> <20050831134259.GW4018@suse.de> <4315B74D.8020100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4315B74D.8020100@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Brian King wrote:
> diff -puN drivers/block/cfq-iosched.c~cfq_refcnt_fix drivers/block/cfq-iosched.c
> --- linux-2.6/drivers/block/cfq-iosched.c~cfq_refcnt_fix	2005-08-30 17:26:55.000000000 -0500
> +++ linux-2.6-bjking1/drivers/block/cfq-iosched.c	2005-08-31 08:48:30.000000000 -0500
> @@ -2260,8 +2260,6 @@ static void cfq_put_cfqd(struct cfq_data
>  	if (!atomic_dec_and_test(&cfqd->ref))
>  		return;
>  
> -	blk_put_queue(q);
> -
>  	cfq_shutdown_timer_wq(cfqd);
>  	q->elevator->elevator_data = NULL;
>  
> @@ -2318,7 +2316,6 @@ static int cfq_init_queue(request_queue_
>  	e->elevator_data = cfqd;
>  
>  	cfqd->queue = q;
> -	atomic_inc(&q->refcnt);
>  
>  	cfqd->max_queued = q->nr_requests / 4;
>  	q->nr_batching = cfq_queued;
> _

That looks better. I'll add this to my outgoing queue, thanks!

-- 
Jens Axboe

