Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbVKBAbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbVKBAbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVKBAbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:31:15 -0500
Received: from [67.137.28.189] ([67.137.28.189]:61058 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751477AbVKBAbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:31:15 -0500
Message-ID: <4367F592.60702@utah-nac.org>
Date: Tue, 01 Nov 2005 16:09:06 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carlos Antunes <cmantunes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Realtime-preempt performs worse for many threads?
References: <cb2ad8b50511011202l5bdc8c82se145adf158221e28@mail.gmail.com>	 <Pine.OSF.4.05.10511020010590.29420-100000@da410.phys.au.dk>	 <cb2ad8b50511011553x57ff9e4dv7f49875cf8a5d7e0@mail.gmail.com> <cb2ad8b50511011629g3e5c4b41t82c1763b029acae2@mail.gmail.com>
In-Reply-To: <cb2ad8b50511011629g3e5c4b41t82c1763b029acae2@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oink Oink. Verified.

Jeff

Carlos Antunes wrote:

>On 11/1/05, Carlos Antunes <cmantunes@gmail.com> wrote:
>  
>
>>On 11/1/05, Esben Nielsen <simlo@phys.au.dk> wrote:
>>    
>>
>>>On Tue, 1 Nov 2005, Carlos Antunes wrote:
>>>
>>>      
>>>
>>>>Hi!
>>>>
>>>>I've been developing some code for the OpenPBX project
>>>>(http://www.openpbx.org) and wrote a program to test how the system,
>>>>responds when hundreds of threads are spawned. These threads run at
>>>>high priority (SCHED_FIFO) and use clock_nanocleep with absolute
>>>>timeouts on a 20ms loop cycle.
>>>>
>>>>With the stock 2.6.14 kernel, I get latencies in the order of several
>>>>milliseconds (but less than 20ms) when running 1250 threads
>>>>simultaneously. However, when I switch to a kernel patched with
>>>>realtime-preempt latency increases to several hundred milliseconds in
>>>>many cases.
>>>>        
>>>>
>>>There is only one explanation:
>>>Some of the operations (task switch, nanosleep etc.) are more expensive in
>>>the RT kernel. Thus your 1250 threads spend 100% CPU doing what they do.
>>>You therefore get very bad latencies.
>>>
>>>      
>>>
>>Esben,
>>
>>Thanks for replying. Let me chalenge this assumption of yours, though.
>>
>>I just ran a test with those 1250 threads (all they do is sleep for
>>20ms, wake up, increment a number, and repeat the process). The CPU
>>was 86% *IDLE* while running this. One thread took 1.3 seconds to wake
>>up once. Do you think this is, well, normal, given how RT is supposed
>>to operate?
>>
>>    
>>
>
>Esben,
>
>If, instead of SCHD_FIFO, I use SCHED_OTHER, I get max latency in the
>order 13ms running those 1250 threads. With SCHED_FIFO (the only
>change), I get 1.3 seconds. Makes sense to you?
>
>Thanks!
>
>Carlos
>
>--
>"We hold [...] that all men are created equal; that they are
>endowed [...] with certain inalienable rights; that among
>these are life, liberty, and the pursuit of happiness"
>        -- Thomas Jefferson
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

