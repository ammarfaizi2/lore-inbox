Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWF2TnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWF2TnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWF2TnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:43:23 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:27858 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932347AbWF2TnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:43:21 -0400
Date: Thu, 29 Jun 2006 21:43:20 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] constify sched.c stat_nam strings
Message-ID: <20060629194320.GA11245@rhlx01.fht-esslingen.de>
References: <20060613195509.GF24167@rhlx01.fht-esslingen.de> <448F2C97.2090103@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448F2C97.2090103@tls.msk.ru>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2006 at 01:22:31AM +0400, Michael Tokarev wrote:
> Andreas Mohr wrote:
> > Hi all,
> > 
> > Signed-off-by: Andreas Mohr <andi@lisas.de>
> > 
> > 
> > diff -urN linux-2.6.17-rc6-mm2.orig/kernel/sched.c linux-2.6.17-rc6-mm2.my/kernel/sched.c
> > --- linux-2.6.17-rc6-mm2.orig/kernel/sched.c	2006-06-13 19:28:17.000000000 +0200
> > +++ linux-2.6.17-rc6-mm2.my/kernel/sched.c	2006-06-13 19:32:03.000000000 +0200
> > @@ -4662,7 +4662,7 @@
> >  	task_t *relative;
> >  	unsigned state;
> >  	unsigned long free = 0;
> > -	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
> > +	static const char * const stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
> >  
> >  	printk("%-13.13s ", p->comm);
> >  	state = p->state ? __ffs(p->state) + 1 : 0;
> 
> How about the following instead:
> 
> --- kernel/sched.c.orig 2006-05-31 22:23:53.000000000 +0400
> +++ kernel/sched.c      2006-06-14 01:19:17.000000000 +0400
> @@ -5287,14 +5287,11 @@ static void show_task(task_t *p)
>  	task_t *relative;
>  	unsigned state;
>  	unsigned long free = 0;
> -	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
> +	static const char stat_nam[] = "RSDTtZX";
> 
> -	printk("%-13.13s ", p->comm);
>  	state = p->state ? __ffs(p->state) + 1 : 0;
> -	if (state < ARRAY_SIZE(stat_nam))
> -		printk(stat_nam[state]);
> -	else
> -		printk("?");
> +	printk("%-13.13s %c", p->comm,
> +		state < sizeof(stat_nam) - 1 ? stat_nam[state] : '?');
>  #if (BITS_PER_LONG == 32)
>  	printk(" %08lX ", (unsigned long)p);
>  #else
> 
> ?

Sounds nice, especially as it saves 124 Bytes compared to my version.

I'm planning to merge it into my sched.c cleanup with proper attribution.

Thanks!

Andreas Mohr
