Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268587AbTBZB6a>; Tue, 25 Feb 2003 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268593AbTBZB63>; Tue, 25 Feb 2003 20:58:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:37117 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S268587AbTBZB61>;
	Tue, 25 Feb 2003 20:58:27 -0500
Message-ID: <3E5C218D.7060004@mvista.com>
Date: Tue, 25 Feb 2003 18:08:13 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.63
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com> <20030224203046.A14425@infradead.org>
In-Reply-To: <20030224203046.A14425@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>>George Anzinger <george@mvista.com>:
>>  o POSIX clocks & timers
> 
> 
> Care to explain what  FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
> is supposed to do?  It's always defined in signal.h, so we can
> aswell get rid of it..

It is there in case some one might want nanosleep to NOT be folded 
into clock_nanosleep.  For a while this was a moving target and I got 
a bit paranoid  :)  I see no real reason to keep it...
> 
> And what's this:
> 
> #ifndef div_long_long_rem
> +#include <asm/div64.h>
> +
> +#define div_long_long_rem(dividend,divisor,remainder) ({ \
> +                      u64 result = dividend;           \
> +                      *remainder = do_div(result,divisor); \
> +                      result; })
> +
> +#endif                         /* ifndef div_long_long_rem */
> 
> Any reason you can't just use do_div directly like everyone else? :)

Actually I have coded a better function as part of the expanded 
high-res-timers which does a 64-bit/32-bit div in a much cleaner way. 
  Again, it is part of the full high-res-timers patch.  I have been 
thinking of submitting the complete set of these math routines outside 
of the high-res patch.  They are designed to make scaled math easy.  I 
  have both a generic and a i386 header file, but they still need a 
bit of testing.

The issue is getting around the C limitation of not being able to use 
the div and mpy instructions that take 64-bits/32-bits and return 2 
32-bit results and the mpy which takes 2 32-bit operands and returns a 
64-bit result.

For scaled operations, they also roll a shift into the mix in an 
efficient way (i.e. a small inline asm function).


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

