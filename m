Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936467AbWLAPW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936467AbWLAPW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936471AbWLAPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:22:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:8076 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S936467AbWLAPW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:22:58 -0500
Date: Fri, 1 Dec 2006 07:24:13 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] Add Sparse annotations to SRCU wrapper functions in rcutorture
Message-ID: <20061201152413.GB1927@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <456F9D2D.9090305@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456F9D2D.9090305@freedesktop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 07:10:37PM -0800, Josh Triplett wrote:
> The SRCU wrapper functions srcu_torture_read_lock and srcu_torture_read_unlock
> in rcutorture intentionally change the SRCU context; annotate them
> accordingly, to avoid a warning.

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index cd27547..ddafbbf 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -401,7 +401,7 @@ static void srcu_torture_cleanup(void)
>  	cleanup_srcu_struct(&srcu_ctl);
>  }
>  
> -static int srcu_torture_read_lock(void)
> +static int srcu_torture_read_lock(void) __acquires(&srcu_ctl)
>  {
>  	return srcu_read_lock(&srcu_ctl);
>  }
> @@ -419,7 +419,7 @@ static void srcu_read_delay(struct rcu_random_state *rrsp)
>  		schedule_timeout_interruptible(longdelay);
>  }
>  
> -static void srcu_torture_read_unlock(int idx)
> +static void srcu_torture_read_unlock(int idx) __releases(&srcu_ctl)
>  {
>  	srcu_read_unlock(&srcu_ctl, idx);
>  }
> -- 
> 1.4.4.1
> 
> 


