Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVCOXha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVCOXha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVCOXha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:37:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11942 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262126AbVCOXgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:36:47 -0500
Date: Wed, 16 Mar 2005 00:36:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make md thread NO_FREEZE.
Message-ID: <20050315233636.GD21292@elf.ucw.cz>
References: <1110924908.6454.136.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110924908.6454.136.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The md driver is currently frozen during suspend. I'm told this
>doesn't help much if you're seeking to suspend to RAID :>

Hmm, and does suspend actually work on md with this patch applied?

							Pavel

> diff -ruNp 213-missing-refrigerator-calls-old/drivers/md/md.c 213-missing-refrigerator-calls-new/drivers/md/md.c
> --- 213-missing-refrigerator-calls-old/drivers/md/md.c	2005-02-14 09:05:26.000000000 +1100
> +++ 213-missing-refrigerator-calls-new/drivers/md/md.c	2005-03-11 09:35:15.000000000 +1100
> @@ -2763,6 +2762,7 @@ int md_thread(void * arg)
>  	 */
>  
>  	daemonize(thread->name, mdname(thread->mddev));
> +	current->flags |= PF_NOFREEZE;
>  
>  	current->exit_signal = SIGCHLD;
>  	allow_signal(SIGKILL);
> @@ -2787,8 +2787,6 @@ int md_thread(void * arg)
>  
>  		wait_event_interruptible(thread->wqueue,
>  					 test_bit(THREAD_WAKEUP, &thread->flags));
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
>  
>  		clear_bit(THREAD_WAKEUP, &thread->flags);
>  
>  
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
