Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTEEXXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEEXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:23:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:499 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261450AbTEEXXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:23:44 -0400
Message-ID: <3EB6F546.6010802@mvista.com>
Date: Mon, 05 May 2003 16:35:34 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org,
       Chandrashekhar RS <chandra.smurthy@wipro.com>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BUG] problem with timer_create(2) for SIGEV_NONE ??
References: <E935C89216CC5D4AB77D89B253ADED2A92257F@blr-m2-msg.wipro.com>
In-Reply-To: <E935C89216CC5D4AB77D89B253ADED2A92257F@blr-m2-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> George,
> 
>  timer_create(2) fails in the case where sigev_notify parameter of
> sigevent structure is SIGEV_NONE. I believe this should not happen.
> 
  ~snip~

>  
> Line 377:
> SIGEV_NONE & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID)
> = 001 & ~(000 | 100)
> = 001 & ~(100)
> = 001 & 011
> = 001
> therefore the if condition is true
> therefore the function returns NULL from line 378.
>  
> Now in sys_timer_create() at line number 462
> Process = NULL
>  
> Now at line 489
> if (!process) becomes TRUE
> and function returns with EINVAL
> 
> Is my analysis right? If so can you comment on this behaviour?
> 
Looks like a bug :(  I feel a patch coming on...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

