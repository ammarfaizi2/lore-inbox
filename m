Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTARCqK>; Fri, 17 Jan 2003 21:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTARCqK>; Fri, 17 Jan 2003 21:46:10 -0500
Received: from dp.samba.org ([66.70.73.150]:64219 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261996AbTARCqJ>;
	Fri, 17 Jan 2003 21:46:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] linux-2.5.58_timer-tsc-cleanup_A0 
In-reply-to: Your message of "15 Jan 2003 16:15:14 -0800."
             <1042676113.1515.129.camel@w-jstultz2.beaverton.ibm.com> 
Date: Sat, 18 Jan 2003 12:48:14 +1100
Message-Id: <20030118025509.C295F2C0D0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1042676113.1515.129.camel@w-jstultz2.beaverton.ibm.com> you write:
> Linus, All,
> 	This patch cleans up the timer_tsc code, removing the unused use_tsc
> variable and making fast_gettimeoffset_quotient static.

But use_tsc is still used:

static int
time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
		       void *data)
{

....

#ifndef CONFIG_SMP
		if (use_tsc) {
			fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
		}
#endif


And almost any patch to the x86 boot code is too convoluted to be
"trivial" IMHO.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
