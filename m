Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319318AbSHVK6a>; Thu, 22 Aug 2002 06:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319319AbSHVK6a>; Thu, 22 Aug 2002 06:58:30 -0400
Received: from [217.167.51.129] ([217.167.51.129]:45798 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S319318AbSHVK63>;
	Thu, 22 Aug 2002 06:58:29 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>,
       Yoann Vandoorselaere <yoann@prelude-ids.org>
Cc: <cpufreq@lists.arm.linux.org>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy
 calculation
Date: Thu, 22 Aug 2002 15:00:26 +0200
Message-Id: <20020822130026.20840@192.168.4.1>
In-Reply-To: <3D64BB45.4020907@iram.es>
References: <3D64BB45.4020907@iram.es>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel !

>if(abs(div)<100) div=0;
>
>> +        val = old / div * mult;
>
>Now happily divide by zero.
>
>> +
>> +        carry = old % div;
>
>Again.
>
>> +        carry = carry * mult / div;
>
>Again.
>
>> +                
>> +        return val + carry;
>>  }

None of the above can happen in the domain of application of this
function. It's used to scale up/down the loops_per_jiffy value when
scaling the CPU frequency. Anyway, the above isn't worse than the
original function. Ideally, we would want 64 bits arithmetics, but
we decided long ago not to bring the libcc support routines for that
in the kernel.
>
>And I can't see how it can be more precise, you divide the numerator and
>denominator of the fraction by 100 and then proceed forgetting 
>everything about the rest. Basically this looses about 7 bits of precision.

Which is mostly ok for what we need. I think Yoann didn't mean it's
more precise that what it replace, but rather more precise than his
original implementation that divided by 1000 ;) Anyway, it's not
significantly worse than what we had and won't overflow as easily
which is all we want for this routine now.

>Now altogether I believe that such a function pertains to a per arch 
>optimized routine.

Maybe... though in the context of cpufreq, it may not make that much
sense.

Ben.


