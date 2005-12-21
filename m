Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVLUW7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVLUW7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVLUW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:59:13 -0500
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:10308 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964922AbVLUW7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:59:12 -0500
Message-ID: <43A9DE3E.1080809@bigpond.net.au>
Date: Thu, 22 Dec 2005 09:59:10 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive
 response
References: <200512211610.jBLGAW05003489@laptop11.inf.utfsm.cl> <CB5409C3-80FE-4C6B-8E9C-0D3FEECD8384@mac.com>
In-Reply-To: <CB5409C3-80FE-4C6B-8E9C-0D3FEECD8384@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Dec 2005 22:59:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Dec 21, 2005, at 11:10, Horst von Brand wrote:
> 
>> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>>
>>> On Dec 21, 2005, at 08:21, Trond Myklebust wrote:
>>>
>>>> ...and if you stick in a faster server?...
>>>> There is _NO_ fundamental difference between NFS and a local  
>>>> filesystem that warrants marking one as "interactive" and the  other 
>>>> as "noninteractive". What you are basically saying is that  all I/O 
>>>> should be marked as TASK_NONINTERACTIVE.
>>>
>>>
>>> Uhh, what part of disk/NFS/filesystem access is "interactive"?   
>>> Which of those sleeps directly involve responding to user- interface  
>>> events?
>>
>>
>> And if it is a user waiting for the data to display? Can't  
>> distinguish that so easily from the compiler waiting for something  to 
>> do...
> 
> 
> No, but in that case the program probably _already_ has some  
> interactivity bonus just from user interaction.

And if it doesn't then it is (by definition) not interactive. :-)

As you imply, this change is targetting those tasks whose ONLY 
interruptible sleeps are due to NFS use.

>  On the other hand,  UI 
> programming guidelines say that any task which might take more  than a 
> half-second or so should not be run in the event loop, but in  a 
> separate thread (either a drawing thread or similar).  In that  case, 
> your event loop thread is the one with the interactivity bonus,  and the 
> others are just data processing threads (like the compile you  have 
> running in the background or the webserver responding to HTTP  
> requests), that the user would need to manually arbitrate between  with 
> nice levels.
> 
> The whole point of the interactivity bonus was that processes that  
> follow the cycle <waiting-for-input> => <respond-to-input-for-less- 
> than-time-quantum> => <waiting-for-input> would get a boost; things  
> like dragging a window or handling mouse or keyboard events should  
> happen within a small number of milliseconds, whereas background  tasks 
> really _don't_ care if they are delayed running their time  quantum by 
> 400ms, as long as they get their full quantum during each  cycle.

Exactly.  It's all about latency and doesn't really effect the 
allocation of CPU resources according to niceness as that is handled via 
differential time slice allocations.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
