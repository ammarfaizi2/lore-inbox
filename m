Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVG1Wft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVG1Wft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVG1Wdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:33:40 -0400
Received: from waste.org ([216.27.176.166]:34731 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261621AbVG1WbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:31:18 -0400
Date: Thu, 28 Jul 2005 15:31:05 -0700
From: Matt Mackall <mpm@selenic.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random : prefetch the whole pool, not 1/4 of it
Message-ID: <20050728223105.GN8074@waste.org>
References: <20050407212058.GU3174@waste.org> <42E95B83.8070006@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E95B83.8070006@cosmosbay.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 12:26:11AM +0200, Eric Dumazet wrote:
> Hi Matt
> 
> Could you check this patch and apply it ?
> 
> Thank you
> 
> Eric
> 
> [RANDOM] : prefetch the whole pool, not 1/4 of it,
>            (pool contains u32 words, not bytes)

You probably want r->poolinfo->poolwords as wordmask is off by one?
Please use "x * 4" rather than "x*4" too.


> --- linux-2.6.13-rc3/drivers/char/random.c	2005-07-13 06:46:46.000000000 +0200
> +++ linux-2.6.13-rc3-ed/drivers/char/random.c	2005-07-29 00:11:24.000000000 +0200
> @@ -469,7 +469,7 @@
>  	next_w = *in++;
>  
>  	spin_lock_irqsave(&r->lock, flags);
> -	prefetch_range(r->pool, wordmask);
> +	prefetch_range(r->pool, wordmask*4);
>  	input_rotate = r->input_rotate;
>  	add_ptr = r->add_ptr;
>  


-- 
Mathematics is the supreme nostalgia of our time.
