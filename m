Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWHUG1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWHUG1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 02:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWHUG1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 02:27:21 -0400
Received: from brick.kernel.dk ([62.242.22.158]:51805 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030217AbWHUG1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 02:27:20 -0400
Date: Mon, 21 Aug 2006 08:29:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cfq_cic_link: fix? usage of wrong cfq_io_context
Message-ID: <20060821062930.GJ4290@suse.de>
References: <20060820210903.GA6123@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820210903.GA6123@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21 2006, Oleg Nesterov wrote:
> Obviously, cfq_cic_link() shouldn't free a just allocated cfq_io_context ?
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.18-rc4/block/cfq-iosched.c~7_set	2006-08-20 21:23:25.000000000 +0400
> +++ 2.6.18-rc4/block/cfq-iosched.c	2006-08-21 00:53:27.000000000 +0400
> @@ -1561,7 +1561,7 @@ restart:
>  		/* ->key must be copied to avoid race with cfq_exit_queue() */
>  		k = __cic->key;
>  		if (unlikely(!k)) {
> -			cfq_drop_dead_cic(ioc, cic);
> +			cfq_drop_dead_cic(ioc, __cic);
>  			goto restart;
>  		}

Yep, that's a typo. Applied.

-- 
Jens Axboe

