Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTDKGPH (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 02:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTDKGPH (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 02:15:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51964 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264294AbTDKGPF (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 02:15:05 -0400
Message-ID: <3E966009.1060501@mvista.com>
Date: Thu, 10 Apr 2003 23:26:17 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org,
       Chandrashekhar RS <chandra.smurthy@wipro.com>
Subject: Re: [BUG] settimeofday(2) succeeds for microsecond value more than
 USEC_PER_SEC and for negative value
References: <94F20261551DC141B6B559DC491086723E0EB7@blr-m3-msg.wipro.com>
In-Reply-To: <94F20261551DC141B6B559DC491086723E0EB7@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> Settimeofday(2) should return EINVAL in case where tv.tv_usec parameter is more than 
> USEC_PER_SEC (more than 10^6 ) or for negative values of tv.tv_usec. 
> It returns 0 (success) instead.
> 
> Clock_settimeofday(2) (kernel/posix-timers.c) also uses do_sys_settimeofday() and faces the
> Same problem.
> 
> I think this is a bug. If you confirm, I will send a patch.

Yes, it is a known problem, turned up by some the posix timers tests. 
  I suppose it is too much to ask, but it would be nice if 
do_sys_settimeofday() took a timespec instead of a timeval.  Of course 
this changes the interface for all the archs, but it would allow the 
clock_settimeofday to send in the nsec value.

-g

> 
> Regards,
> Aniruddha Marathe
> WIPRO Technologies, India
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

