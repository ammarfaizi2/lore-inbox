Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUAYJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 04:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUAYJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 04:21:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50166 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263823AbUAYJV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 04:21:57 -0500
Message-ID: <40138A92.8000908@mvista.com>
Date: Sun, 25 Jan 2004 01:21:22 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eric.piel@tremplin-utc.net
CC: Andrew Morton <akpm@osdl.org>, minyard@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX
References: <1074979873.4012e421714b1@mailetu.utc.fr> <20040124143037.5116ccc9.akpm@osdl.org> <1074983859.4012f3b32e87a@mailetu.utc.fr>
In-Reply-To: <1074983859.4012f3b32e87a@mailetu.utc.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we are going to open this, I would like to eliminate the "MIGS_SIGEV" stuff. 
  If you can wait till Monday...

Another issue is that this is the only place in the kernel where SIGRTMAX is 
used (or it was a few months ago).  If memory serves, it also seems that it is 
the wrong value in at least some archs.

George


eric.piel@tremplin-utc.net wrote:
> Quoting Andrew Morton <akpm@osdl.org>:
> 
> 
> 
>>b) it's casting the result of (foo > N) to unsigned which is nonsensical.
>>
>>Your patch doesn't address b).
>>
>>I don't thik there's a case in which sigev_signo can be negative anyway. 
>>But if there is, the cast should be done like the below, yes?
> 
> God! I hadn't catch this one :-) Actually, the cast is needed because
> sigev_signo is an int, this catches the (all fobidden) negative values.
> 
> Your patch is the right one :-)
> Eric
>  
> 
>> kernel/posix-timers.c |    3 +--
>> 1 files changed, 1 insertion(+), 2 deletions(-)
>>
>>diff -puN kernel/posix-timers.c~SIGRTMAX-fix kernel/posix-timers.c
>>--- 25/kernel/posix-timers.c~SIGRTMAX-fix	2004-01-24 14:27:13.000000000
>>-0800
>>+++ 25-akpm/kernel/posix-timers.c	2004-01-24 14:28:21.000000000 -0800
>>@@ -344,8 +344,7 @@ static inline struct task_struct * good_
>> 		return NULL;
>> 
>> 	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
>>-			event->sigev_signo &&
>>-			((unsigned) (event->sigev_signo > SIGRTMAX)))
>>+	    (((unsigned)event->sigev_signo > SIGRTMAX) || !event->sigev_signo))
>> 		return NULL;
>> 
>> 	return rtn;
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

