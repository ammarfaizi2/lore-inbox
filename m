Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTDLTNv (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTDLTNv (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:13:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24053 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263378AbTDLTNu (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 15:13:50 -0400
Message-ID: <3E986814.4060606@mvista.com>
Date: Sat, 12 Apr 2003 12:25:08 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] settimeofday(2) succeeds for microsecond value more than
 USEC_PER_SEC and for negative value
References: <94F20261551DC141B6B559DC491086723E10C2@blr-m3-msg.wipro.com>
In-Reply-To: <94F20261551DC141B6B559DC491086723E10C2@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> |Aniruddha M Marathe wrote:
> |> Even then, I think, we can modify the settimeofday  code to 
> |check -1 and USEC_PER_SEC
> |> Conditions, can't we?
> |> 
> 
> George wrote:
> 
> |Uh, sure.  This is the test I prefer:
> |
> |	if( (unsigned long)tv->usec > USEC_PER_SEC)
> |		return EINVAL;
> |
> |
> |This change should go in do_sys_settimeofday() in kernel/time.c.  It 
> |will fix both settimeofday and clock_settime(CLOCK_REALTIME,...  And 
> |also fixes it in all archs.
> |
> |-g
> 
> How about
> If( (unsigned long)tv->usec >= USEC_PER_SEC)
> 	return EINVAL;

Right, my mistake ;)
-g
> 
> Even if tv_usec value is 10^6, it should give EINVAL.
> Man page must also be updated
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

