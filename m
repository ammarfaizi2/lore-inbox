Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUIXPzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUIXPzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268845AbUIXPzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:55:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62179 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268824AbUIXPzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:55:13 -0400
Date: Fri, 24 Sep 2004 08:55:34 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: janitor@sternwelten.at
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 02/26]  char/cyclades: replace 	schedule_timeout() with msleep_interruptible()
Message-ID: <20040924155534.GA1757@us.ibm.com>
References: <E1CAa9D-0007mL-31@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CAa9D-0007mL-31@sputnik>
X-Operating-System: Linux 2.6.8.1 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:24:58PM +0200, janitor@sternwelten.at wrote:
> 
> 
> 
> Any comments would be appreciated. 
> 
> Description: Use msleep_interruptible() instead of schedule_timeout()
> to guarantee the task delays as expected.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> ---
> 
>  linux-2.6.9-rc2-bk7-max/drivers/char/cyclades.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff -puN drivers/char/cyclades.c~msleep_interruptible-drivers_char_cyclades drivers/char/cyclades.c
> --- linux-2.6.9-rc2-bk7/drivers/char/cyclades.c~msleep_interruptible-drivers_char_cyclades	2004-09-21 21:07:58.000000000 +0200
> +++ linux-2.6.9-rc2-bk7-max/drivers/char/cyclades.c	2004-09-21 21:07:58.000000000 +0200
> @@ -2717,8 +2717,7 @@ cy_wait_until_sent(struct tty_struct *tt
>  #ifdef CY_DEBUG_WAIT_UNTIL_SENT
>  	    printk("Not clean (jiff=%lu)...", jiffies);
>  #endif
> -	    current->state = TASK_INTERRUPTIBLE;
> -	    schedule_timeout(char_time);
> +	    msleep_interruptible(msecs_to_jiffies(char_time));

Looks like the wrong macro was used here (should be jiffies_to_msecs()).
Max, want me to send it to you again?

-Nish
