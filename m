Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTCGB3N>; Thu, 6 Mar 2003 20:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbTCGB3N>; Thu, 6 Mar 2003 20:29:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50171 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261330AbTCGB3L>;
	Thu, 6 Mar 2003 20:29:11 -0500
Message-ID: <3E67F844.2090902@mvista.com>
Date: Thu, 06 Mar 2003 17:39:16 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>	<3E67DF8E.9080005@mvista.com> <15975.62823.5398.712934@napali.hpl.hp.com>
In-Reply-To: <15975.62823.5398.712934@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Thu, 06 Mar 2003 15:53:50 -0800, george anzinger <george@mvista.com> said:
> 
> 
>   George> I think there is a bit of a problem in the idr code
>   George> (.../lib/idr.c) which manages the id allocation.  Seems we
>   George> are returning "long" from functions declared as int.  If I
>   George> remember the code correctly this will work, but it does
>   George> eliminate the sequence number that should be in the high 8
>   George> bits of the id.
> 
> Yes.  We have had some reports of problems with POSIX timers and I
> suspect this might be the reason (though I don't know what the exact
> code-base was that the person reporting the problem was using).
> 
>   George> This assumes that you never allocate more than 2,147,483,647
>   George> timers at once :) I will look at this and send in a patch.
>   George> I think we should return what ever timer_t is, so we should
>   George> run that to ground first.
> 
> Yes, that would be better.  According to Uli, a 32-bit timer_t is fine
> as far as the standards are concerned.  That's good.
> 
>   George> I suspect we should also have a look at all the structures
>   George> with a view to alignment issues or is this not a problem?
>   George> I.e. is this struct ok:
> 
>   George> struct { long a; int b; long c; }
> 
> Such code may be OK correctnesswise, but to avoid wasting space, it's
> clearly better to list larger members first.

Ok, I will fix all the above and shoot you a patch.  I assume you can 
test it on a 64-bit platform.  Right?

-g
> 
> 	--david
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

