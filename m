Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271600AbTGQWzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271603AbTGQWzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:55:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61431 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S271600AbTGQWy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:54:58 -0400
Message-ID: <3F172C99.40002@mvista.com>
Date: Thu, 17 Jul 2003 16:09:13 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: Re: do_div64 generic
References: <3F1360F4.2040602@mvista.com> <3F149747.3090107@mvista.com> <200307162033.34242.bernie@develer.com> <200307172310.48918.bernie@develer.com>
In-Reply-To: <200307172310.48918.bernie@develer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> On Wednesday 16 July 2003 20:33, Bernardo Innocenti wrote:
> 
> 
>>>>Bernardo, can you do the patch please?
>>
>> I would be glad to do it once the discussion has settled, whatever
>>the final decision will be. Just don't make me do it twice, please ;-)
> 
> 
> So far nobody have commented and the problem is still unaddressed.
> What shall I do? As far as I can tell, our options are:
> 
> 1) add surrogates of div_long_long_rem() in asm-generic/div64.h and in
>    all other archs that have their own optimized versions of do_div().
>    I already have a patch for this, but it has been tested only on i386
>    and m68knommu.
> 
> 2) replace all uses of div_long_long_rem() (I see onlt 4 of them in
>    2.6.0-test1) with do_div(). This is slightly less efficient, but
>    easier to maintain in the long term.  

Actually, the macro to do this is already there.  Is there a real 
reason not to use it.  The using code sure looks cleaner with it.
> 
> I shall note that I _hate_ fixing compiler problems in the kernel. The
> real fix I'm dreaming involves adding specialized patterns in GCC to
> generate an optimal instruction sequence for all these cases.

I would love to get to the instruction via normal C.
> 
> Of course we should realize that we need to support older versions of
> GCC and, even if we didn't, we can't wait for the next GCC release :-)
> 
> So, if we're going to live with do_div(), I think we could as well
> have a set of macros for the most frequent cases. I've just spotted
> another candidate in kernel/posix-timers.c: mpy_l_X_l_ll().

The mpy_l_X_l_ll() is there because it is so easy to get it wrong.  It 
is standard C (well gcc) but if you don't get the casting just right 
it will throw away the high bits.
> 
> This is not a third option for fixing our immediate problem: it's
> just an idea for future improvement.
> 
> Andrew, George, please comment.

Is there any need to change any thing at all?  Or maybe a comment 
somewhere on what direction we would like things to go.

When I look at the div code on the risc machines I begin to really 
understand why gcc avoids the div instruction so actively.  (It 
optimizes away almost all divides by constants.)
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

