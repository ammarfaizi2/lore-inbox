Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUH1RoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUH1RoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUH1RmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:42:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34726 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267551AbUH1RkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:40:05 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823225255.GA16820@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
	 <20040823210151.GA10949@elte.hu> <1093300882.826.28.camel@krustophenia.net>
	 <20040823225255.GA16820@elte.hu>
Content-Type: text/plain
Message-Id: <1093714808.8611.36.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 13:40:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 18:52, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> > Should this fix the 500+ usec latency I saw in rt_garbage_collect? 
> > This one took a while to occur (overnight).
> 
> i dont think it will. Does the patch below help?
> 
> 	Ingo
> 
> --- net/ipv4/route.c.orig
> +++ net/ipv4/route.c
> @@ -738,7 +738,7 @@ static int rt_garbage_collect(void)
>  
>  		if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
>  			goto out;
> -	} while (!in_softirq() && time_before_eq(jiffies, now));
> +	} while (!in_softirq() && time_before_eq(jiffies, now) && !need_resched());
>  
>  	if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
>  		goto out;
> 

Nope, the above does not actually fix it.  I got a 716 usec latency in
rt_garbage_collect:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace12.txt

I believe this is associated with heavy route cache activity, I did not
see this one again until I left a gnutella client running overnight.

Lee

