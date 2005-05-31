Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVEaAXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVEaAXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVEaAVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:21:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59408 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261598AbVEaAU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:20:29 -0400
Date: Tue, 31 May 2005 02:20:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inappropriate use of in_atomic()
Message-ID: <20050531002027.GE3627@stusta.de>
References: <20050310204006.48286d17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310204006.48286d17.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 08:40:06PM -0800, Andrew Morton wrote:
> 
> in_atomic() is not a reliable indication of whether it is currently safe
> to call schedule().
> 
> This is because the lockdepth beancounting which in_atomic() uses is only
> accumulated if CONFIG_PREEMPT=y.  in_atomic() will return false inside
> spinlocks if CONFIG_PREEMPT=n.
> 
> Consequently the use of in_atomic() in the below files is probably
> deadlocky if CONFIG_PREEMPT=n:

I haven't looked deeper into it, but as a FYI the following files from 
your list still use in_atomic in 2.6.12-rc5-mm1:

>...
> 	drivers/net/irda/sir_kthread.c
> 	drivers/net/wireless/airo.c
> 	drivers/video/amba-clcd.c
> 	drivers/acpi/osl.c
> 	drivers/ieee1394/ieee1394_transactions.c
>...


> Note that the same beancounting is used for the "scheduling while atomic"
> warning, so if the code calls schedule with locks held, we won't get a
> warning.  Both are tied to CONFIG_PREEMPT=y.
> 
> The kernel provides no reliable runtime way of detecting whether or not it
> is safe to call schedule().
> 
> Can we please find ways to change the above code to not use in_atomic()? 
> Then we can whack #ifndef MODULE around its definition to reduce
> reoccurrences.  Will probably rename it to something more scary as well.
> 
> Thanks.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

