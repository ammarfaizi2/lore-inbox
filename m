Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWHAH1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWHAH1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWHAH1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:27:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:63105 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161340AbWHAH1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:27:08 -0400
Date: Tue, 1 Aug 2006 12:57:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       mason@suse.com
Subject: Re: [PATCH] [AIO] remove unused aio_run_iocbs()
Message-ID: <20060801072731.GA20484@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060731221229.18058.82700.sendpatchset@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731221229.18058.82700.sendpatchset@tetsuo.zabbo.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 03:12:29PM -0700, Zach Brown wrote:
> [AIO] remove unused aio_run_iocbs()
> 
> Nothing is calling the aio_run_iocbs() variant of *aio_run_*iocb*().  Let's try
> and make life just a little less complicated by getting rid of it.

Chris Mason's aio pipe patches used these to reduce the large
number of context switches he was observing when running pipetest.
Of course aio pipe support hasn't been merged into mainline so far, and hence
you could argue that we put these back in if/when we hit that problem. But why
not just put in a comment there for now to ease the confusion ... generally
I'd rather go a little slow in removing apparently unused code at this
point when we are churning things up again.

Regards
Suparna

> 
> Signed-off-by: Zach Brown <zach.brown@oracle.com>
> ---
> 
>  fs/aio.c |   21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> Index: 2.6.18-rc3-trivialaio/fs/aio.c
> ===================================================================
> --- 2.6.18-rc3-trivialaio.orig/fs/aio.c
> +++ 2.6.18-rc3-trivialaio/fs/aio.c
> @@ -814,30 +814,13 @@ static void aio_queue_work(struct kioctx
>  	queue_delayed_work(aio_wq, &ctx->wq, timeout);
>  }
>  
> -
>  /*
> - * aio_run_iocbs:
> + * aio_run_all_iocbs:
>   * 	Process all pending retries queued on the ioctx
> - * 	run list.
> + * 	run list.  It will retry until the list stays empty.
>   * Assumes it is operating within the aio issuer's mm
>   * context.
>   */
> -static inline void aio_run_iocbs(struct kioctx *ctx)
> -{
> -	int requeue;
> -
> -	spin_lock_irq(&ctx->ctx_lock);
> -
> -	requeue = __aio_run_iocbs(ctx);
> -	spin_unlock_irq(&ctx->ctx_lock);
> -	if (requeue)
> -		aio_queue_work(ctx);
> -}
> -
> -/*
> - * just like aio_run_iocbs, but keeps running them until
> - * the list stays empty
> - */
>  static inline void aio_run_all_iocbs(struct kioctx *ctx)
>  {
>  	spin_lock_irq(&ctx->ctx_lock);
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

