Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUAPIUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUAPIUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:20:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29835 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265316AbUAPIUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:20:39 -0500
Date: Fri, 16 Jan 2004 09:20:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bug waiting to happen in rq_for_each_bio
Message-ID: <20040116082038.GE5507@suse.de>
References: <1074203537.20197.77.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074203537.20197.77.camel@bip.parateam.prv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15 2004, Xavier Bestel wrote:
> This bug would have been caught at compile time anyway, unless somebody
> uses a weird name for bio.
> 
> --- ./include/linux/blkdev.h.orig       2004-01-15 22:43:29.000000000 +0100
> +++ ./include/linux/blkdev.h    2004-01-15 22:44:23.000000000 +0100
> @@ -493,9 +493,9 @@
>  }
>  #endif /* CONFIG_MMU */
>   
> -#define rq_for_each_bio(bio, rq)       \
> +#define rq_for_each_bio(_bio, rq)      \
>         if ((rq->bio))                  \
> -               for (bio = (rq)->bio; bio; bio = bio->bi_next)
> +               for (_bio = (rq)->bio; _bio; _bio = _bio->bi_next)
>   
>  struct sec_size {
>         unsigned block_size;

Yep, should be added. Thanks.

-- 
Jens Axboe

