Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbTCKXZw>; Tue, 11 Mar 2003 18:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbTCKXZv>; Tue, 11 Mar 2003 18:25:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5105 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261685AbTCKXZs>;
	Tue, 11 Mar 2003 18:25:48 -0500
Message-ID: <3E6E72DC.7070507@mvista.com>
Date: Tue, 11 Mar 2003 15:35:56 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@digeo.com>, felipe_alfaro@linuxmail.org,
       cobra@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
References: <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 11 Mar 2003, Andrew Morton wrote:
> 
>>gcc will generate 64bit * 64bit multiplies without resorting to
>>any library code
> 
> 
> However, gcc is unable to do-the-right-thing and generate 32x32->64 
> multiplies, or 32x64->64 multiplies, even though those are both a _lot_ 
> faster than the full 64x64->64 case.
> 
> And in quite a _lot_ of cases, that's actually what you want. It might 
> actually make sense to add a "do_mul()" thing to allow architectures to do 
> these cases right, since gcc doesn't.
> 
> 
>>and you can probably do the division with do_div().
> 
> 
> Yes. This is the same issue - gcc will always promote a 64-bit divide to
> be _fully_ 64-bit, even if the mixed-size 64/32 -> [64,32] case is much
> faster and simpler. Which is why do_div() exists in the first place.

Often the 64/32 -> [32,32] is all that is needed and that is even 
faster if we could get to it.
> 
> 		Linus
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

