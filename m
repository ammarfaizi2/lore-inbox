Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWAYShS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWAYShS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWAYShS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:37:18 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:56594 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932071AbWAYShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:37:16 -0500
Message-ID: <43D7C2F0.5020108@symas.com>
Date: Wed, 25 Jan 2006 10:26:56 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hancockr@shaw.ca
Subject: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com>
In-Reply-To: <43D7BA0F.5010907@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> Howard Chu wrote:
>>
>> Robert Hancock wrote:
>
>>  > This says nothing about requiring a reschedule. The "scheduling 
>> policy"
>>  > can well decide that the thread which just released the mutex can
>>  > re-acquire it.
>>
>> No, because the thread that just released the mutex is obviously not 
>> one of  the threads blocked on the mutex. When a mutex is unlocked, 
>> one of the *waiting* threads at the time of the unlock must acquire 
>> it, and the scheduling policy can determine that. But the thread the 
>> released the mutex is not one of the waiting threads, and is not 
>> eligible for consideration.
>
> Is it *required* that the new owner of the mutex is determined at the 
> time of mutex release?
>
> If the kernel doesn't actually determine the new owner of the mutex 
> until the currently running thread swaps out, it would be possible for 
> the currently running thread to re-aquire the mutex.

The SUSv3 text seems pretty clear. It says "WHEN pthread_mutex_unlock() 
is called, ... the scheduling policy SHALL decide ..." It doesn't say 
MAY, and it doesn't say "some undefined time after the call." There is 
nothing optional or implementation-defined here. The only thing that is 
not explicitly stated is what happens when there are no waiting threads; 
in that case obviously the running thread can continue running.

re: forcing the mutex to ping-pong between different threads - if that 
is inefficient, then the thread scheduler needs to be tuned differently. 
Threads and thread context switches are supposed to be cheap, otherwise 
you might as well just program with fork() instead. (And of course, back 
when Unix was first developed, *processes* were lightweight, compared to 
other extant OSs.)

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

