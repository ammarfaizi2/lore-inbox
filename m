Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTA3S4j>; Thu, 30 Jan 2003 13:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTA3S4h>; Thu, 30 Jan 2003 13:56:37 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:60070 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267598AbTA3S4f>;
	Thu, 30 Jan 2003 13:56:35 -0500
Message-ID: <3E39778E.90302@colorfullife.com>
Date: Thu, 30 Jan 2003 20:05:50 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Stephen Hemminger <shemminger@osdl.org>,
       Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: frlock and barrier discussion
References: <3E396CF1.5000300@colorfullife.com> <20030130182622.GR18538@dualathlon.random>
In-Reply-To: <20030130182622.GR18538@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Thu, Jan 30, 2003 at 07:20:33PM +0100, Manfred Spraul wrote:
>  
>
>>Stephen wrote:
>>
>>[snip - memory barrier for fr_write_begin]
>>
>>    
>>
>>>Using mb() is more paranoid than necessary. 
>>>      
>>>
>>What about the memory barrier in fr_read_begin?
>>If I understand the Intel documentation correctly, then i386 doesn't need 
>>them:
>>"Writes by a single processor are observed in the same order by all 
>>processors"
>>
>>I think "smp_read_barrier_depends()" (i.e. a nop for i386) is sufficient. 
>>    
>>
>
>I don't see what you mean, there is no dependency we can rely on between
>the read of the sequence number and the critical section reads, the
>critical section reads has nothing to do with the sequence number reads
>and the frlock itself.
>
You are right - "observed in the same order by all processors" only 
means that the memory interface of the cpus see all writes in order, not 
that instruction executed by the cpus will observe the writes in order.

That leaves ia64 with the acquire/release barriers.

--
    Manfred

