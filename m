Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbUK1R33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbUK1R33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUK1R33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:29:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:32412 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261529AbUK1R3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:29:22 -0500
Date: Sun, 28 Nov 2004 18:39:06 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: janitor@sternwelten.at
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch 18/25]  ds1620: replace schedule_timeout() with 	msleep()
In-Reply-To: <E1C2cAP-0007Rx-JK@sputnik>
Message-ID: <Pine.LNX.4.61.0411281835430.3389@dragon.hygekrogen.localhost>
References: <E1C2cAP-0007Rx-JK@sputnik>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 janitor@sternwelten.at wrote:

> 
> I would appreciate any comments from the janitor@sternweltens list. This is one (of
> many) cases where I made a decision about replacing
> 
> set_current_state(TASK_INTERRUPTIBLE);
> schedule_timeout(some_time);
> 
> with
> 
> msleep(jiffies_to_msecs(some_time));
> 
> msleep() is not exactly the same as the previous code, but I only did
> this replacement where I thought long delays were *desired*. If this is
> not the case here, then just disregard this patch.
> 
> Note: I looked for the appropriate maintainer of this driver, but I did
> not find anyone. If someone could tell me who that would be, I would
> appreciate it.
> 
> Thanks,
> Nish
> 
> 
> 
> Description: Uses msleep() instead of schedule_timeout() to guarantee
> the task delays at least the desired time amount.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> 
> 
> 
> ---
> 
>  linux-2.6.9-rc1-bk7-max/drivers/char/ds1620.c |    3 +--
>  1 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN drivers/char/ds1620.c~msleep-drivers_char_ds1620 drivers/char/ds1620.c
> --- linux-2.6.9-rc1-bk7/drivers/char/ds1620.c~msleep-drivers_char_ds1620	2004-09-01 19:34:43.000000000 +0200
> +++ linux-2.6.9-rc1-bk7-max/drivers/char/ds1620.c	2004-09-01 19:34:43.000000000 +0200
> @@ -373,8 +373,7 @@ static int __init ds1620_init(void)
>  	th_start.hi = 1;
>  	ds1620_write_state(&th_start);
>  
> -	set_current_state(TASK_INTERRUPTIBLE);
> -	schedule_timeout(2*HZ);
> +	msleep(2000);
>  
>  	ds1620_write_state(&th);
>  
I'm wondering if 2000 is really the value we want here. As far as I can 
see, the  schedule_timeout(2*HZ);  line has been there as long back as 
since HZ was 100, so back then the delay would have been 200. if 200 is 
all it needs, then we are now sleeping 10 times as long as really needed.
What is the argument behind the value used?

-- 
Jesper Juhl <juhl-lkml@dif.dk>


