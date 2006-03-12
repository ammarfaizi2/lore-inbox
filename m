Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWCLMNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWCLMNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 07:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCLMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 07:13:45 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:24467 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932237AbWCLMNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 07:13:45 -0500
Date: Sun, 12 Mar 2006 13:13:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <20060312080332.274315000@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603121302590.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
 <20060312080332.274315000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Mar 2006, Thomas Gleixner wrote:

> @@ -633,11 +631,8 @@ static inline void run_hrtimer_queue(str
>  
>  		spin_lock_irq(&base->lock);
>  
> -		/* Another CPU has added back the timer */
> -		if (timer->state != HRTIMER_INACTIVE)
> -			continue;
> -
> -		if (restart != HRTIMER_NORESTART)
> +		if (restart != HRTIMER_NORESTART &&
> +		    !hrtimer_active(timer))
>  			enqueue_hrtimer(timer, base);
>  	}
>  	set_curr_timer(base, NULL);

BTW the active check can be removed again, as it was added for a state 
machine problem, I only didn't want to remove it for 2.6.16.

bye, Roman
