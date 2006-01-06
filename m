Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWAFXVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWAFXVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWAFXVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:21:13 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:6325 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932634AbWAFXVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:21:13 -0500
Message-ID: <43BEFB62.5050407@bigpond.net.au>
Date: Sat, 07 Jan 2006 10:21:06 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: Fix bug in int_sqrt() for 64 bit longs
References: <43BDFC8B.9020805@bigpond.net.au> <43BE1168.1090706@cosmosbay.com>
In-Reply-To: <43BE1168.1090706@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 6 Jan 2006 23:21:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Peter Williams a écrit :
> 
>> The implementation of int_sqrt() assumes that longs have 32 bits.  On 
>> systems that have 64 bit longs this will result in gross errors when 
>> the argument to the function is greater than 2^32 - 1 on such systems. 
>> I doubt whether any such use is currently made of int_sqrt() but the 
>> attached patch fixes the problem anyway.
>>
>> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
>>
>>
>> ------------------------------------------------------------------------
>>
>> Index: GIT-warnings/lib/int_sqrt.c
>> ===================================================================
>> --- GIT-warnings.orig/lib/int_sqrt.c    2005-10-25 13:55:22.000000000 
>> +1000
>> +++ GIT-warnings/lib/int_sqrt.c    2006-01-06 14:29:19.000000000 +1100
>> @@ -15,7 +15,7 @@ unsigned long int_sqrt(unsigned long x)
>>      op = x;
>>      res = 0;
>>  
>> -    one = 1 << 30;
>> +    one = 1 << (BITS_PER_LONG - 2);
>>      while (one > op)
>>          one >>= 2;
>>  
> 
> 
> Are you sure it works ?
> 
> I would have writen :
> 
> one = 1L << (BITS_PER_LONG - 2);

I think you're right as just using 1 would make the expression an 
integer variable and the compiler would complain about shifting too far 
unless integers were the same size as longs.  (I don't have a 64 bit 
system to confirm that on which is why it snuck by me. :-()

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
