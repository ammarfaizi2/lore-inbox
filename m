Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUAZSNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUAZSMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:12:48 -0500
Received: from gprs40-2.eurotel.cz ([160.218.40.2]:24898 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261784AbUAZSMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:12:44 -0500
Date: Mon, 26 Jan 2004 19:12:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Better "Losing Ticks" Error Message
Message-ID: <20040126181214.GC315@elf.ucw.cz>
References: <20040124032147.GA177@h00a0cca1a6cf.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124032147.GA177@h00a0cca1a6cf.ne.client2.attbi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> Andrew,
> 
> Seems like a lot of people see the below error message, but aren't quite sure
> why it happens or how to fix it.  I sure didn't.
> 
> Here's my attempt at remedying that - Should apply cleanly against 2.6.1.
> 
> Thanks,
> Timothy
> 
> diff -urN linux-2.6.1-orig/arch/i386/kernel/timers/timer_tsc.c linux-2.6.1/arch/i386/kernel/timers/timer_tsc.c
> --- linux-2.6.1-orig/arch/i386/kernel/timers/timer_tsc.c	2004-01-09 01:59:46.000000000 -0500
> +++ linux-2.6.1/arch/i386/kernel/timers/timer_tsc.c	2004-01-23 21:16:24.000000000 -0500
> @@ -232,9 +232,13 @@
>  		/* sanity check to ensure we're not always losing ticks */
>  		if (lost_count++ > 100) {
>  			printk(KERN_WARNING "Losing too many ticks!\n");
> -			printk(KERN_WARNING "TSC cannot be used as a timesource."
> -					" (Are you running with SpeedStep?)\n");
> -			printk(KERN_WARNING "Falling back to a sane timesource.\n");
> +			printk(KERN_WARNING "TSC cannot be used as a timesource.  ");
> +			printk(KERN_WARNING "Possible reasons for this are:\n");
> +			printk(KERN_WARNING "  You're running with Speedstep,\n");
> +			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
> +			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
> +			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
> +
>  			clock_fallback();
>  		}
>  	} else

If something, make it "Loosing too many ticks, TSC cannot be used as a
timesource (see Documentation/time.txt)". We do not want 7 lines of
messages....
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
