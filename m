Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbTAURE3>; Tue, 21 Jan 2003 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAURE3>; Tue, 21 Jan 2003 12:04:29 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:38810 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267114AbTAURE2>;
	Tue, 21 Jan 2003 12:04:28 -0500
Message-ID: <3E2D7FB2.80806@colorfullife.com>
Date: Tue, 21 Jan 2003 18:13:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] smp_call_function_mask
References: <Pine.LNX.4.44.0301210318540.2653-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.44.0301210318540.2653-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Tue, 21 Jan 2003, Zwane Mwaikambo wrote:
>
>  
>
>>On Tue, 21 Jan 2003, Manfred Spraul wrote:
>>
>>    
>>
>>>from 2.5.52, <asm-i386/atomic.h>
>>>    #define atomic_read(v)          ((v)->counter)
>>>AFAIK atomic_read never contained locked bus cycles.
>>>
>>>Btw, Zwane, what about removing non_atomic from the prototype?
>>>      
>>>
>>The funny thing is, there are about 3 different versions of 
>>smp_call_function and removing nonatomic would reduce the argument count 
>>    
>>
You can blame me for the mess with smp_call_function:
2.2 supported nonatomic calls. I have no idea if that was deadlock free.

But noone used the 'retry/nonatomic' parameter, noone handled an error 
return of  smp_call_function (some callers panic).
Thus I've removed these features from i386, without changing the 
prototype. I think all archs have picked that up now.
But retry/nonatomic should not spread into new functions.

--
    Manfred

