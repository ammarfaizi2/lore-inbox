Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUGMOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUGMOwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUGMOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:52:54 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:4218 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265287AbUGMOww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:52:52 -0400
Message-ID: <40F3F73D.7090004@yahoo.com.au>
Date: Wed, 14 Jul 2004 00:52:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Joe Korty <joe.korty@ccur.com>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com> <20040713143600.GA22758@tsunami.ccur.com> <20040713144028.GH21066@holomorphy.com>
In-Reply-To: <20040713144028.GH21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, Jul 13, 2004 at 05:28:05AM -0700, William Lee Irwin III wrote:
> 
>>>This patch uses the preemption counter increments and decrements to time
>>>non-preemptible critical sections.
>>>This is an instrumentation patch intended to help determine the causes of
>>>scheduling latency related to long non-preemptible critical sections.
>>>Changes from 2.6.7-based patch:
>>>(1) fix unmap_vmas() check correctly this time
>>>(2) add touch_preempt_timing() to cond_resched_lock()
>>>(3) depend on preempt until it's worked out wtf goes wrong without it
> 
> 
> On Tue, Jul 13, 2004 at 10:36:00AM -0400, Joe Korty wrote:
> 
>>You preemption-block hold times will improve *enormously* if you move all
>>softirq processing down to the daemon (and possibly raise the daemon to
>>one of the higher SCHED_RR priorities, to compensate for softirq processing
>>no longer happening at interrupt level).
> 
> 
> Plausible. Got a patch?
> 

Make MAX_SOFTIRQ_RESTART 1?

I don't think you should make ksoftirq a realtime task, because that
defeats the purpose of having it to prevent livelocking userspace
doesn't it?

However, you may want to increase it from nice +19. Probably just to
nice 0 would be an idea.
