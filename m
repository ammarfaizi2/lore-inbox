Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTJCVcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTJCVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:32:52 -0400
Received: from tolkor.SGI.COM ([198.149.18.6]:35784 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261245AbTJCVcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:32:50 -0400
Message-ID: <3F7DEB01.5080904@sgi.com>
Date: Fri, 03 Oct 2003 16:32:49 -0500
From: Steve Modica <modica@sgi.com>
Organization: SGI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Modica <modica@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: simple mod_timer patch
References: <3F7DEABF.2040606@sgi.com>
In-Reply-To: <3F7DEABF.2040606@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention.. please leave me on the CC list. Thanks!
Steve



Steve Modica wrote:
> I pulled this back from the 2.6 kernel to reduce some serious contention 
> on the timerlist_lock when I had 8 gigabit cards runnings.
> 
> 
> diff -u -r1.23 -r1.24
> --- linux/linux/kernel/timer.c       2003/08/11 20:16:19     1.23
> +++ linux/linux/kernel/timer.c       2003/10/01 21:09:20     1.24
> @@ -207,6 +207,14 @@
>         int ret;
>         unsigned long flags;
> 
> +        /*
> +        * This is a common optimization triggered by the
> +        * networking code - if the timer is re-modified
> +        * to be the same thing then just return:
> +        */
> +        if (timer->expires == expires && timer_pending(timer))
> +               return 1;
> +
>         spin_lock_irqsave(&timerlist_lock, flags);
>         timer->expires = expires;
>         ret = detach_timer(timer);
> 
> 
> 


-- 
Steve Modica
work: 651-683-3224
MTS-Technical Lead
"Give a man a fish, and he will eat for a day, hit him with a fish and
he leaves you alone" - me

