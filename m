Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVHWIvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVHWIvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVHWIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 04:51:14 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:14812 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932098AbVHWIvO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 04:51:14 -0400
Message-ID: <430ACC5C.1060507@aitel.hist.no>
Date: Tue, 23 Aug 2005 09:12:28 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050821165723.5531.qmail@web33304.mail.mud.yahoo.com>
In-Reply-To: <20050821165723.5531.qmail@web33304.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:

>--- Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
>  
>
>>On 8/21/05, Danial Thom <danial_thom@yahoo.com>
>>wrote:
>>    
>>
>>>I just started fiddling with 2.6.12, and
>>>      
>>>
>>there
>>    
>>
>>>seems to be a big drop-off in performance
>>>      
>>>
>>from
>>    
>>
>>>2.4.x in terms of networking on a
>>>      
>>>
>>uniprocessor
>>    
>>
>>>system. Just bridging packets through the
>>>machine, 2.6.12 starts dropping packets at
>>>~100Kpps, whereas 2.4.x doesn't start
>>>      
>>>
>>dropping
>>    
>>
>>>until over 350Kpps on the same hardware
>>>      
>>>
>>(2.0Ghz
>>    
>>
>>>Opteron with e1000 driver). This is pitiful
>>>prformance for this hardware. I've
>>>increased the rx ring in the e1000 driver to
>>>      
>>>
>>512
>>    
>>
>>>with little change (interrupt moderation is
>>>      
>>>
>>set
>>    
>>
>>>to 8000 Ints/second). Has "tuning" for MP
>>>destroyed UP performance altogether, or is
>>>      
>>>
>>there
>>    
>>
>>>some tuning parameter that could make a
>>>      
>>>
>>4-fold
>>    
>>
>>>difference? All debugging is off and there
>>>      
>>>
>>are
>>    
>>
>>>no messages on the console or in the error
>>>      
>>>
>>logs.
>>    
>>
>>>The kernel is the standard kernel.org dowload
>>>config with SMP turned off and the intel
>>>      
>>>
>>ethernet
>>    
>>
>>>card drivers as modules without any other
>>>changes, which is exactly the config for my
>>>      
>>>
>>2.4
>>    
>>
>>>kernels.
>>>
>>>      
>>>
>>If you have preemtion enabled you could disable
>>it. Low latency comes
>>at the cost of decreased throughput - can't
>>have both. Also try using
>>a HZ of 100 if you are currently using 1000,
>>that should also improve
>>throughput a little at the cost of slightly
>>higher latencies.
>>
>>I doubt that it'll do any huge difference, but
>>if it does, then that
>>would probably be valuable info.
>>
>>    
>>
>Ok, well you'll have to explain this one:
>
>"Low latency comes at the cost of decreased
>throughput - can't have both"
>  
>
Configuring "preempt" gives lower latency, because then
almost anything can be interrupted (preempted).  You can then
get very quick responses to some things, i.e. interrupts and such.

The cost comes, because _something_ was interrupted, something
that instead would run to completion first in a kernel made without 
"preempt".
So that other thing, whatever it is, got slower. 

And the problem is bigger than merely "things happens in a different order".
Switching the cpu from one job to another have a big overhead.  
Particularly,
the cpu caches have to be refilled more often, which takes time.  
Running one
big job to completion fills the cache with that job's data _once_.  If 
the job
is preempted a couple of times you have to bring it into cache three
times instead, and that will cost you, performance wise.

This is not _necessarily_ your problem, but trying a 2.6 kernel without 
preempt
and with hz=100 (both things configurable through normal kernel 
configuration)
will clearly show if this is the problem in your case.  If you're lucky, 
this is all
you need to get your performance back.  If not, then at least it is an
important datapoint for those trying to figure it out.  Nobody here want
2.6 to have 1/4 of the performance of 2.4!

Helge Hafting
