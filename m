Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbTCLHBL>; Wed, 12 Mar 2003 02:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTCLHBL>; Wed, 12 Mar 2003 02:01:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45441 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263067AbTCLHBK>;
	Wed, 12 Mar 2003 02:01:10 -0500
Date: Wed, 12 Mar 2003 08:11:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Luben Tuikov <luben@splentec.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix kernel oops in generic_unplug_device() for md
Message-ID: <20030312071146.GG1295@suse.de>
References: <3E6E8B6D.1000501@splentec.com> <20030311172815.46ac305d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311172815.46ac305d.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11 2003, Andrew Morton wrote:
> Luben Tuikov <luben@splentec.com> wrote:
> >
> > The following patch fixes a kernel oops when doing
> > blk_unplug_work() (oopses in generic_unplug_device()) for md.
> > 
> > The oops and the original report are here:
> > http://MARC.10East.com/?l=linux-kernel&m=104706400705154&w=2
> > 
> 
> Yup, is a bug.  I received the below fix from Neil today which looks
> simpler.
> 
> diff -puN drivers/block/ll_rw_blk.c~auto-unplugging-fix drivers/block/ll_rw_blk.c
> --- 25/drivers/block/ll_rw_blk.c~auto-unplugging-fix	Tue Mar 11 15:04:00 2003
> +++ 25-akpm/drivers/block/ll_rw_blk.c	Tue Mar 11 15:04:00 2003
> @@ -1004,7 +1004,8 @@ void generic_unplug_device(void *data)
>  
>  static void blk_unplug_work(void *data)
>  {
> -	generic_unplug_device(data);
> +	request_queue_t *q = data;
> +	q->unplug_fn(q);
>  }

this is the correct fix

-- 
Jens Axboe

