Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbSJQQ0k>; Thu, 17 Oct 2002 12:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261602AbSJQQ0k>; Thu, 17 Oct 2002 12:26:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59125 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261598AbSJQQ0j>;
	Thu, 17 Oct 2002 12:26:39 -0400
Message-ID: <3DAEE607.AD6451D5@mvista.com>
Date: Thu, 17 Oct 2002 09:32:07 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.43-tick
References: <E18289i-0007u2-00@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> This patch appears not to be in 2.5.43, but applies cleanly.
> 
> On some ARM platforms, CLOCK_TICK_RATE is not a constant (it is specified
> at boot time), which means that TICK_USEC/TICK_NSEC is not constant.
> We therefore can not initialise static variables with these definitions;
> they must be done at run time.

I must be missing something here.  Why can't both be done? 
That is, leave timer.c alone and add code to the arch time
init to correct the values?

-g
> 
>  kernel/timer.c |    7 +++++--
>  1 files changed, 5 insertions, 2 deletions
> 
> diff -ur orig/kernel/timer.c linux/kernel/timer.c
> --- orig/kernel/timer.c Wed Oct 16 09:17:13 2002
> +++ linux/kernel/timer.c        Wed Oct 16 09:15:00 2002
> @@ -376,8 +376,8 @@
>  /*
>   * Timekeeping variables
>   */
> -unsigned long tick_usec = TICK_USEC;           /* ACTHZ   period (usec) */
> -unsigned long tick_nsec = TICK_NSEC(TICK_USEC);        /* USER_HZ period (nsec) */
> +unsigned long tick_usec;       /* ACTHZ   period (usec) */
> +unsigned long tick_nsec;       /* USER_HZ period (nsec) */
> 
>  /* The current time */
>  struct timespec xtime __attribute__ ((aligned (16)));
> @@ -1069,6 +1069,9 @@
>  void __init init_timers(void)
>  {
>         int i, j;
> +
> +       tick_usec = TICK_USEC;
> +       tick_nsec = TICK_NSEC(TICK_USEC);
> 
>         for (i = 0; i < NR_CPUS; i++) {
>                 tvec_base_t *base;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
