Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWG0BLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWG0BLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWG0BLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:11:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46477 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750759AbWG0BLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:11:44 -0400
Date: Wed, 26 Jul 2006 18:12:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] [rcu] Add lock annotations to rcu{,_bh}_torture_read_{lock,unlock}
Message-ID: <20060727011216.GC4338@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1153940986.12517.66.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153940986.12517.66.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 12:09:46PM -0700, Josh Triplett wrote:
> rcu_torture_read_lock and rcu_bh_torture_read_lock acquire locks without
> releasing them, and the matching functions rcu_torture_read_unlock and
> rcu_bh_torture_read_unlock get called with the corresponding locks held and
> release them.  Add lock annotations to these four functions so that sparse can
> check callers for lock pairing, and so that sparse will not complain about
> these functions since they intentionally use locks in this manner.

Good stuff!!!

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index 4d1c3d2..4f2c427 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -192,13 +192,13 @@ static struct rcu_torture_ops *cur_ops =
>   * Definitions for rcu torture testing.
>   */
>  
> -static int rcu_torture_read_lock(void)
> +static int rcu_torture_read_lock(void) __acquires(RCU)
>  {
>  	rcu_read_lock();
>  	return 0;
>  }
>  
> -static void rcu_torture_read_unlock(int idx)
> +static void rcu_torture_read_unlock(int idx) __releases(RCU)
>  {
>  	rcu_read_unlock();
>  }
> @@ -250,13 +250,13 @@ static struct rcu_torture_ops rcu_ops = 
>   * Definitions for rcu_bh torture testing.
>   */
>  
> -static int rcu_bh_torture_read_lock(void)
> +static int rcu_bh_torture_read_lock(void) __acquires(RCU_BH)
>  {
>  	rcu_read_lock_bh();
>  	return 0;
>  }
>  
> -static void rcu_bh_torture_read_unlock(int idx)
> +static void rcu_bh_torture_read_unlock(int idx) __releases(RCU_BH)
>  {
>  	rcu_read_unlock_bh();
>  }
> 
> 
