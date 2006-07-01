Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWGAX5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGAX5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWGAX5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:57:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964863AbWGAX5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:57:19 -0400
Date: Sat, 1 Jul 2006 16:57:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: jesse.brandeburg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-Id: <20060701165713.71638e88.akpm@osdl.org>
In-Reply-To: <1151776582.18139.51.camel@localhost>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	<20060629120518.e47e73a9.akpm@osdl.org>
	<4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
	<20060630171212.50630182.akpm@osdl.org>
	<4807377b0606301717t35d783cbgad6d67daeb163f5a@mail.gmail.com>
	<1151713862.16221.2.camel@localhost.localdomain>
	<4807377b0607011033s3e329d7cy1081fb6c8be41e9b@mail.gmail.com>
	<1151776582.18139.51.camel@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 10:56:22 -0700
john stultz <johnstul@us.ibm.com> wrote:

> Andrew: While clearly there is the deeper issue of why interrupts are
> enabled before they should be, I may still like to push the two-liner
> above, since its a bit safer should someone accidentally enable
> interrupts early again. Looking back in my patch history it was
> previously in the order above until I switched it (I suspect
> accidentally) in the C0 rework.
> 
> I also added a warning message so we can still detect the problem w/o
> hanging.
> 
> Does the patch below look reasonable?
> 
> thanks
> -john
> 
> Signed-off-by: John Stultz <johnstul@us.ibm.com>
> 
> diff --git a/init/main.c b/init/main.c
> index b2f3b56..2984d16 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -496,8 +496,8 @@ asmlinkage void __init start_kernel(void
>  	init_timers();
>  	hrtimers_init();
>  	softirq_init();
> -	time_init();
>  	timekeeping_init();
> +	time_init();
>  

I looked at doing this and there appeared to be interdependencies between
these two functions.  In that timekeeping_init()'s behaviour would be
different if time_init() hadn't run yet.

So are you really really sure?
