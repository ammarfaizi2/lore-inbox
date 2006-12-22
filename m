Return-Path: <linux-kernel-owner+w=401wt.eu-S1945909AbWLVCZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945909AbWLVCZe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 21:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWLVCZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 21:25:34 -0500
Received: from pool-71-111-57-167.ptldor.dsl-w.verizon.net ([71.111.57.167]:3577
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1945909AbWLVCZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 21:25:33 -0500
Date: Thu, 21 Dec 2006 18:25:44 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] rcu: rcutorture suspend fix
Message-ID: <20061222022544.GD4451@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061222000813.GA4092@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222000813.GA4092@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 01:08:13AM +0100, Ingo Molnar wrote:
> Subject: [patch] rcu: rcutorture suspend fix
> From: Ingo Molnar <mingo@elte.hu>
> 
> fix suspend hang: rcutorture threads need to be nofreeze.

Looks straightforward enough -- I take it that rcutorture continues
upon resume?  So I have to ask...  Would it make sense to simply unload
the rcutorture module upon suspend?

But either way this is an improvement, so...

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/rcutorture.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux/kernel/rcutorture.c
> ===================================================================
> --- linux.orig/kernel/rcutorture.c
> +++ linux/kernel/rcutorture.c
> @@ -522,6 +522,7 @@ rcu_torture_writer(void *arg)
> 
>  	VERBOSE_PRINTK_STRING("rcu_torture_writer task started");
>  	set_user_nice(current, 19);
> +	current->flags |= PF_NOFREEZE;
> 
>  	do {
>  		schedule_timeout_uninterruptible(1);
> @@ -561,6 +562,7 @@ rcu_torture_fakewriter(void *arg)
> 
>  	VERBOSE_PRINTK_STRING("rcu_torture_fakewriter task started");
>  	set_user_nice(current, 19);
> +	current->flags |= PF_NOFREEZE;
> 
>  	do {
>  		schedule_timeout_uninterruptible(1 + rcu_random(&rand)%10);
> @@ -591,6 +593,7 @@ rcu_torture_reader(void *arg)
> 
>  	VERBOSE_PRINTK_STRING("rcu_torture_reader task started");
>  	set_user_nice(current, 19);
> +	current->flags |= PF_NOFREEZE;
> 
>  	do {
>  		idx = cur_ops->readlock();
