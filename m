Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSEaHOj>; Fri, 31 May 2002 03:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSEaHOi>; Fri, 31 May 2002 03:14:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40391 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315178AbSEaHOg>;
	Fri, 31 May 2002 03:14:36 -0400
Date: Fri, 31 May 2002 09:14:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.19 : drivers/mtd/nftlcore.c
Message-ID: <20020531071425.GH841@suse.de>
In-Reply-To: <Pine.LNX.4.33.0205301946500.22691-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30 2002, Frank Davis wrote:
> @@ -899,7 +899,7 @@
>  			DEBUG(MTD_DEBUG_LEVEL2,"NFTL read request completed OK\n");
>  			up(&nftl->mutex);
>  			goto repeat;
> -		} else if (req->cmd == WRITE) {
> +		} else if ((int)req->cmd == WRITE) {

Irk, this is very wrong :-)

		} else if (rq_data_dir(rq) == WRITE) {

should work.

> @@ -1015,10 +1015,11 @@
>  };
>  
>  extern char nftlmountrev[];
> +static spinlock_t nftl_lock = SPIN_LOCK_UNLOCKED;
>  
>  int __init init_nftl(void)
>  {
> -	int i;
> +spin_lock_init(&nftl_lock);

You don't need the spin_lock_init(), you just set it SPIN_LOCK_UNLOCKED
above.

The rest looks ok.

-- 
Jens Axboe

