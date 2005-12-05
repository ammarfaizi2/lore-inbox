Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVLEVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVLEVWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVLEVWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:22:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64738 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932534AbVLEVWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:22:35 -0500
Date: Mon, 5 Dec 2005 22:22:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: paulmck@us.ibm.com, Dipankar <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Extend RCU torture module to test tickless idle CPU
Message-ID: <20051205212222.GC1728@elf.ucw.cz>
References: <20051205110527.GF2385@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205110527.GF2385@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch forces RCU torture threads off various CPUs in the system
> allowing them to become idle and go tickless.  Meant to test support for 
> such tickless idle CPU in RCU.
> 
> Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>
> 
> ---
> 
>  linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c |   89 +++++++++++++++++++++++++-
>  1 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff -puN kernel/rcutorture.c~rcutorture kernel/rcutorture.c
> --- linux-2.6.15-rc5-mm1/kernel/rcutorture.c~rcutorture	2005-12-05 15:33:34.000000000 +0530
> +++ linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c	2005-12-05 15:33:42.000000000 +0530
> @@ -51,6 +51,8 @@ static int nreaders = -1;	/* # reader th
>  static int stat_interval = 0;	/* Interval between stats, in seconds. */
>  				/*  Defaults to "only at end of test". */
>  static int verbose = 0;		/* Print more debug info. */
> +static int test_no_idle_hz = 0; /* Test RCU's support for tickless idle CPUs. */

0 initializers are not needed. Also comment formatting is
"interesting".

> @@ -375,12 +382,77 @@ rcu_torture_stats(void *arg)
>  	return 0;
>  }
>  
> +int rcu_idle_cpu;	/* Force all torture tasks off this CPU */

Missing static?

> +/* Shuffle tasks across CPUs, with the intent of allowing each CPU in the
> + * system to become idle at a time and cut off its timer ticks. This is meant
> + * to test the support for such tickless idle CPU in RCU.
> + */
> +static int
> +rcu_torture_shuffle(void *arg)
> +{
> +	VERBOSE_PRINTK_STRING("rcu_torture_shuffle task started");

Do you really need to append _STRING here?

							Pavel
-- 
Thanks, Sharp!
