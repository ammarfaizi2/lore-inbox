Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbWHJCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbWHJCCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 22:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWHJCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 22:02:49 -0400
Received: from srvr22.engin.umich.edu ([141.213.75.21]:40356 "EHLO
	srvr22.engin.umich.edu") by vger.kernel.org with ESMTP
	id S1030520AbWHJCCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 22:02:48 -0400
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] add timespec_to_us() and use it in kernel/tsacct.c
Date: Wed, 9 Aug 2006 07:57:12 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>
References: <200608062330.19628.mreuther@umich.edu> <20060806222129.f1cfffb9.akpm@osdl.org> <20060807133240.GB3691@stusta.de>
In-Reply-To: <20060807133240.GB3691@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090757.12890.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 09:32 am, Adrian Bunk wrote:
> On Sun, Aug 06, 2006 at 10:21:29PM -0700, Andrew Morton wrote:
> > On Sun, 6 Aug 2006 23:30:19 -0400

> What about the patch below that adds a timespec_to_us() to time.h and
> uses this function in kernel/tsacct.c?
>
>
> <--  snip  -->
>
>
> This patch adds a timespec_to_us() to include/linux/time.h and uses it
> to fix a compile error in kernel/tsacct.c .
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  include/linux/time.h |   12 ++++++++++++
>  kernel/tsacct.c      |    2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> --- linux-2.6.18-rc3-mm2-full/include/linux/time.h.old	2006-08-06
> 19:56:50.000000000 +0200 +++
> linux-2.6.18-rc3-mm2-full/include/linux/time.h	2006-08-06
> 20:00:51.000000000 +0200 @@ -132,6 +132,18 @@
>  }
>
>  /**
> + * timespec_to_us - Convert timespec to microseconds
> + * @ts:		pointer to the timespec variable to be converted
> + *
> + * Returns the scalar microsecond representation of the timespec
> + * parameter.
> + */
> +static inline s64 timespec_to_us(const struct timespec *ts)
> +{
> +	return ((s64) ts->tv_sec * USEC_PER_SEC) + ts->tv_nsec / NSEC_PER_USEC;
> +}
> +
> +/**
>   * timeval_to_ns - Convert timeval to nanoseconds
>   * @ts:		pointer to the timeval variable to be converted
>   *
> --- linux-2.6.18-rc3-mm2-full/kernel/tsacct.c.old	2006-08-06
> 19:54:45.000000000 +0200 +++
> linux-2.6.18-rc3-mm2-full/kernel/tsacct.c	2006-08-06 19:56:44.000000000
> +0200 @@ -36,7 +36,7 @@
>  	do_posix_clock_monotonic_gettime(&uptime);
>  	ts = timespec_sub(uptime, current->group_leader->start_time);
>  	/* rebase elapsed time to usec */
> -	stats->ac_etime = (timespec_to_ns(&ts))/NSEC_PER_USEC;
> +	stats->ac_etime = timespec_to_us(&ts);
>  	stats->ac_btime = xtime.tv_sec - ts.tv_sec;
>  	if (thread_group_leader(tsk)) {
>  		stats->ac_exitcode = tsk->exit_code;

This patch also compiles for me without errors.

Matt

