Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWHPXhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWHPXhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHPXhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:37:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44248 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751241AbWHPXhI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:37:08 -0400
Date: Wed, 16 Aug 2006 16:37:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] rcu: Avoid kthread_stop on invalid pointer if rcutorture reader startup fails
Message-ID: <20060816233754.GD1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1155767042.9175.41.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155767042.9175.41.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 03:24:02PM -0700, Josh Triplett wrote:
> rcu_torture_init kmallocs the array of reader threads, then creates each one
> with kthread_run, cleaning up with rcu_torture_cleanup if this fails.
> rcu_torture_cleanup calls kthread_stop on any non-NULL pointer in the array;
> however, any readers after the one that failed to start up will have invalid
> pointers, not null pointers.  Avoid this by using kzalloc instead.

Good catch!!!

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index aff0064..8b09c95 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -779,7 +779,7 @@ rcu_torture_init(void)
>  		writer_task = NULL;
>  		goto unwind;
>  	}
> -	reader_tasks = kmalloc(nrealreaders * sizeof(reader_tasks[0]),
> +	reader_tasks = kzalloc(nrealreaders * sizeof(reader_tasks[0]),
>  			       GFP_KERNEL);
>  	if (reader_tasks == NULL) {
>  		VERBOSE_PRINTK_ERRSTRING("out of memory");
> -- 
> 1.4.1.1
> 
> 
