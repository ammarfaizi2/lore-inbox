Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVDOXgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVDOXgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVDOXgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:36:49 -0400
Received: from fmr21.intel.com ([143.183.121.13]:51144 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262332AbVDOXgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:36:45 -0400
Date: Fri, 15 Apr 2005 16:36:33 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix sched domain degenerate
Message-ID: <20050415163633.C7296@unix-os.sc.intel.com>
References: <20050413192616.A28163@unix-os.sc.intel.com> <425FBB98.2000200@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <425FBB98.2000200@yahoo.com.au>; from nickpiggin@yahoo.com.au on Fri, Apr 15, 2005 at 11:03:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 11:03:20PM +1000, Nick Piggin wrote:
> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c	2005-04-15 22:52:25.000000000 +1000
> +++ linux-2.6/kernel/sched.c	2005-04-15 22:58:54.000000000 +1000
> @@ -4844,7 +4844,14 @@ static int __devinit sd_parent_degenerat
>  	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
>  	if (cflags & SD_WAKE_AFFINE)
>  		pflags &= ~SD_WAKE_BALANCE;
> -	if ((~sd->flags) & parent->flags)
> +	/* Flags needing groups don't count if only 1 group in parent */
> +	if (parent->groups == parent->groups->next) {
> +		pflags &= ~(SD_LOAD_BALANCE |
> +				SD_BALANCE_NEWIDLE |
> +				SD_BALANCE_FORK |
> +				SD_BALANCE_EXEC);
> +	}

This patch works fine and I like this fix. But should n't we be adding 
SD_WAKE_AFFINE and SD_WAKE_BALANCE to this list?

And about SD_BALANCE_FORK, now that we have multi level sbe/sbf, we should 
add this flag to SD_CPU/SIBLING_INIT too..

thanks,
suresh
