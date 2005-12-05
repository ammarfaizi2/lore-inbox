Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVLEMcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVLEMcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLEMcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:32:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63893 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932396AbVLEMcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:32:41 -0500
Date: Mon, 5 Dec 2005 18:04:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: paulmck@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bug in RCU torture test
Message-ID: <20051205123409.GD3936@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051205105849.GD2385@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205105849.GD2385@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:28:49PM +0530, Srivatsa Vaddagiri wrote:
> While doing some test of RCU torture module, I hit a OOPS in rcu_do_batch,
> which was trying to processes callback of a module that was just removed.
> This is because we weren't waiting long enough for all callbacks to fire.
> 
> diff -puN kernel/rcutorture.c~rcutorture_fix kernel/rcutorture.c
> --- linux-2.6.15-rc5-mm1/kernel/rcutorture.c~rcutorture_fix	2005-12-05 15:33:06.000000000 +0530
> +++ linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c	2005-12-05 15:33:17.000000000 +0530
> @@ -408,9 +408,8 @@ rcu_torture_cleanup(void)
>  	stats_task = NULL;
>  
>  	/* Wait for all RCU callbacks to fire.  */
> +	rcu_barrier();

Andrew,

This patch is dependent on the rcu_barrier patch buried in reiser4
patchset. It makes sense to merge that patch without waiting
for reiser4 since rcutorture is already in mainline. 
I will send an updated documentation patch describing why 
and how modules using RCU should use rcu_barrier().

Thanks
Dipankar
