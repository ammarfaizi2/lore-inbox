Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbULVMjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbULVMjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbULVMjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:39:48 -0500
Received: from relay00.pair.com ([209.68.1.20]:38921 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261978AbULVMjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:39:43 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41C96B0E.1030500@cybsft.com>
Date: Wed, 22 Dec 2004 06:39:42 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesse <jessezx@yahoo.com>
CC: Con Kolivas <kernel@kolivas.org>, Paulo Marques <pmarques@grupopie.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
References: <20041221230726.51621.qmail@web52604.mail.yahoo.com>
In-Reply-To: <20041221230726.51621.qmail@web52604.mail.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse wrote:
> --- Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>jesse wrote:
>>
>>>Paulo:
>>> 
>>>   I already said in the messsage that my user
>>
>>space
>>
>>>application has a low nice priority, i set it to
>>
>>10.
>>
>>>since my application has low priority compared to
>>>other user space applications, it is supposed to
>>
>>be
>>
>>>interrupted. but it is not.
>>
>>If your task is better priority the scheduler will
>>make it preempt the 
>>worse priority task. It sounds to me like you are
>>complaining that the 
>>worse priority task is still getting cpu? If so, you
>>misunderstand 
>>priority - it orders tasks according to priority
>>giving lower latency 
>>and preemptive behaviour to the better task, and
>>gives _more_ cpu but 
>>not all the cpu. The cpu must still be shared, but
>>with more cpu 
>>distributed to the better priority task. If you want
>>your better 
>>priority task to get _all_ the cpu you have to use
>>real time scheduling.
>>
>>Cheers,
>>Con
>>
> 
> 
> ok, Con, your explaining makes some sense to me , but
> still not very well.
> 
>    suppose I have five high process: A1, A2, A3, A4,
> A5 all have nice = 0. and I also have a low priority
> process B with nice = 10.
> 
>     a) when process B is scheduled to run, it is given
> a short time slot based on its priority, for example 5
> secs. because at that point, A1/2/3/4/5 are not
> started yet. B will get CPU and run at full speed. 
>     b) at the end of time slot(5 secs), scheduler
> finds higher priority A1/A2/A3/A4/A5 are ready,
> scheduler will interrupt process B and starts to pick 
> a process from group A, even though B still needs CPU
> cycle.
>     c)unfortunately, process A1/2/3/4/5 are so active,
> thus process B should never get opportunity to run
> again, in consequence, CPU Usage% of Process B should
> be very Low.
>     
>    However, The above theretic assumption is in
> contrary to what i observed. in my LAB, the low
> priority process B seems to hold the CPU forever and
> Top command always shows Process B with a 90% CPU
> usage.
>   
>   If _more_ cpu but not _all_ the cpu are given to
> Process A1/2/3/4/5, Process B shouldn't have a 90% CPU
> usage. 

This statement is not exactly true. If process B is always ready to run 
(CPU bound, not I/O bound) it could easily consume more CPU than all the 
other processes combined. It all depends on what A1/2/3/4/5 are doing. 
Just because A1 has a higher priority doesn't mean it is ready to run. 
If processes A1/2/3/4/5 spend most of their time waiting for I/O or 
sleeping (not ready to run) and B does a lot of computation or just busy 
spins, B could easily consume more CPU than the others.

> 
>   Thus, i can't help asking why low priority process B
> gets most CPU cycle.
> 
>   thanks in advance. 
> 
> jesse
> 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

