Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWHEFt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWHEFt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 01:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbWHEFt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 01:49:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161407AbWHEFtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 01:49:25 -0400
Date: Fri, 4 Aug 2006 22:49:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rate-limit the RTC 'missed interrupts' warning.
Message-Id: <20060804224913.d4fb3bef.akpm@osdl.org>
In-Reply-To: <E1G9EuX-0001AR-0f@smurf.noris.de>
References: <E1G9EuX-0001AR-0f@smurf.noris.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006 01:53:08 +0200
Matthias Urlichs <smurf@smurf.noris.de> wrote:

> Cc: recipient list not shown: ;

I'm assuming there was supposed to be a mailing list there.

> Subject: [PATCH] Rate-limit the RTC 'missed interrupts' warning.
> Date: Sat, 5 Aug 2006 01:53:08 +0200
> 
> Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
> ---
>  drivers/char/rtc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
> index 7cac6d0..fbd214f 100644
> --- a/drivers/char/rtc.c
> +++ b/drivers/char/rtc.c
> @@ -1131,7 +1131,8 @@ static void rtc_dropped_irq(unsigned lon
>  
>  	spin_unlock_irq(&rtc_lock);
>  
> -	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
> +	if(printk_ratelimit())
> +		printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
>  
>  	/* Now we have new data */
>  	wake_up_interruptible(&rtc_wait);

What is causing your machine to lose so many RTC interrupts?
