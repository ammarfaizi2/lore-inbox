Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTGBRvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTGBRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:51:54 -0400
Received: from rj.sgi.com ([192.82.208.96]:55497 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264226AbTGBRvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:51:52 -0400
Message-ID: <3F031F0F.4020600@sgi.com>
Date: Wed, 02 Jul 2003 13:06:07 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to
 hang in 2.4.22-pre2 -- second try
References: <20030701051719.B2B702C090@lists.samba.org>
In-Reply-To: <20030701051719.B2B702C090@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Um, Ray?  2.4's yield also does:
> 
> 	void yield(void)
> 	{
> 		set_current_state(TASK_RUNNING);
> 		sys_sched_yield();
> 		schedule();
> 	}
> 
> So how did the below patch make any difference?
> 
> Now thoroughly confused,
> Rusty.
> 
> --- linux-2.4.22-pre2.orig/mm/page_alloc.c      Thu Nov 28 17:53:15 2002
> +++ linux-2.4.22-pre2/mm/page_alloc.c   Fri Jun 27 13:47:49 2003
> @@ -418,6 +418,7 @@
>                  return NULL;
> 
>          /* Yield for kswapd, and try again */
> +        set_current_state(TASK_RUNNING);
>          yield();
>          goto rebalance;
>   }
> 
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 

Duh.  My fault.  I didn't see this in 2.4.22-pre2.  Some checking shows 
that it is also in 2.4.20.  How this didn't get into our SGI 2.4.20 tree 
is beyond me (this where we originally found this problem).  So there is 
no problem in 2.4.22-pre2.

Rusty -- thanks for your perseverence on this.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
Jun 23-Jul 18 I will be at: 970-513-4743
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

