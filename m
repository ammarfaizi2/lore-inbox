Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbULGSlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbULGSlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbULGSlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:41:01 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:15077 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261882AbULGSkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:40:45 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
Date: Tue, 7 Dec 2004 13:40:42 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Eran Mann <emann@mrv.com>
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <41B5C038.1090501@mrv.com> <20041207153720.GA20712@elte.hu>
In-Reply-To: <20041207153720.GA20712@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412071340.42731.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.153.76.102] at Tue, 7 Dec 2004 12:40:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 December 2004 10:37, Ingo Molnar wrote:
>* Eran Mann <emann@mrv.com> wrote:
>> On my machine, disabling CONFIG_LATENCY_TRACE causes the kernel to
>> stop reporting preempt latencies. After
>>
>> # echo 1 > /proc/sys/kernel/preempt_max_latency
>>
>> /proc/sys/kernel/preempt_max_latency always shows 1 no matter what
>> load is on the machine. I´ve seen this behavior since the first
>> time I tried to disable CONFIG_LATENCY_TRACE, around
>> V0.7.31.something.
>
>indeed - there was a thinko in trace_stop_sched_switched() that
> likely caused this problem. Does the -32-8 patch (freshly uploaded)
> work better for you?
>
> Ingo

I'd like to report a slight improvement in the reports from tvtime
while running 32-6 with full preemtion turned on, cfq scheduler:

------
Dec  7 13:29:39 coyote kernel: wow!  That was a 15 millisec bump
Dec  7 13:29:39 coyote kernel: `IRQ 8'[838] is being piggy.
need_resched=0, cpu=0
Dec  7 13:29:39 coyote kernel: Read missed before next interrupt
-----
Each second of the log contains about 27 of these, so its pretty
steady.  Picture looks pretty good though.

Although, that particular snip was taken from the log while I was
*not* on the same screen as tvtime.  Switching back it its screen
returned the slip times to the 22 millisecond area.  And on quiting,
this was output:
-----------------
Dec  7 13:29:47 coyote kernel: rtc latency histogram of {tvtime/4038,
7565 samples}:
Dec  7 13:29:47 coyote kernel: 3 401
Dec  7 13:29:47 coyote kernel: 4 3348
Dec  7 13:29:47 coyote kernel: 5 1104
Dec  7 13:29:47 coyote kernel: 6 435
Dec  7 13:29:47 coyote kernel: 7 294
Dec  7 13:29:47 coyote kernel: 8 246
Dec  7 13:29:47 coyote kernel: 9 236
Dec  7 13:29:47 coyote kernel: 10 241
Dec  7 13:29:47 coyote kernel: 11 301
Dec  7 13:29:47 coyote kernel: 12 232
Dec  7 13:29:47 coyote kernel: 13 146
Dec  7 13:29:47 coyote kernel: 14 52
Dec  7 13:29:47 coyote kernel: 15 9
Dec  7 13:29:47 coyote kernel: 16 4
Dec  7 13:29:47 coyote kernel: 17 2
Dec  7 13:29:47 coyote kernel: 19 1
Dec  7 13:29:47 coyote kernel: 20 1
Dec  7 13:29:47 coyote kernel: 23 1
Dec  7 13:29:47 coyote kernel: 24 1
Dec  7 13:29:47 coyote kernel: 4545 1
Dec  7 13:29:47 coyote kernel: 9999 509

So there not much real change after all. Heavy duty wishfull thinking
I guess.  How can I decode the above output into english?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

