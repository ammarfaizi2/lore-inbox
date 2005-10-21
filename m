Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVJUKSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVJUKSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 06:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVJUKSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 06:18:31 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:58633 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S932208AbVJUKSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 06:18:31 -0400
From: Felix Oxley <lkml@oxley.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc5-rt1
Date: Fri, 21 Oct 2005 11:18:17 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20051017160536.GA2107@elte.hu> <200510210033.49652.lkml@oxley.org> <200510211101.18391.lkml@oxley.org>
In-Reply-To: <200510211101.18391.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510211118.18363.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 October 2005 11:01, Felix Oxley wrote:
> 
> A second build error with make allyesconfig:
> 
>   CC      kernel/ktimers.o
> kernel/ktimers.c: In function ‘enqueue_ktimer’:
> kernel/ktimers.c:762: error: request for member ‘tv’ in something not a structure or union
> kernel/ktimers.c:762: error: request for member ‘tv’ in something not a structure or union
> make[1]: *** [kernel/ktimers.o] Error 1
> make: *** [kernel] Error 2
> 
> Seems to be a probelm with definition ktimer_trace :
> 
> Signed-off-by: Felix Oxley <lkml@oxley.org>
> ---
> --- include/linux/ktimer.h		2005-10-21 00:20:03.000000000 +0100
> +++ include/linux/ktimer.h	 	2005-10-21 10:55:44.000000000 +0100
> @@ -141,7 +141,7 @@ extern int ktimer_interrupt(void);
>  #define KTIME_REALTIME_RES             CONFIG_HIGH_RES_RESOLUTION
>  #define KTIME_MONOTONIC_RES            CONFIG_HIGH_RES_RESOLUTION
> 
> -#define ktimer_trace(a,b)              trace_special((a).tv.sec,(a).tv.nsec,b)
> +#define ktimer_trace(a,b)              trace_special((a).tv_sec,(a).tv_nsec,b)
> 
>  #else

Looks like that is only <50% of a fix since we still have:

 ktimer_trace(now, 0);

being called where now is not of type struct timeval.

I can't see what to do with that I'm afraid.
So since I am only build testing I will comment it out.

regards,
Felix
