Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUGMM6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUGMM6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGMM6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:58:50 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:3169 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264946AbUGMM54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:57:56 -0400
Message-ID: <40F3DC52.1030308@yahoo.com.au>
Date: Tue, 13 Jul 2004 22:57:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com> <40F3DACC.9070703@yahoo.com.au> <20040713125331.GA21066@holomorphy.com>
In-Reply-To: <20040713125331.GA21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>+		unsigned long preempt_exit
>>>+				= (unsigned long)__builtin_return_address(0);
>>>+		hold = sched_clock() - __get_cpu_var(preempt_timings) + 
>>>999999;
>>>+		do_div(hold, 1000000);
>>>+		if (preempt_thresh && hold > preempt_thresh &&
>>>+							printk_ratelimit()) {
> 
> 
> On Tue, Jul 13, 2004 at 10:51:24PM +1000, Nick Piggin wrote:
> 
>>This looks wrong. This means hold times of 1ns to 1000000ns trigger the
>>exceeded 1ms threshold, 1000001 to 2000000 trigger the 2ms one, etc.
>>Removing the + 999999 gives the correct result:
>>1000000 - 1999999ns triggers the 1ms threshold
>>2000000 - 2999999ns triggers the 2ms threshold
>>etc
>>Or have I missed something?
> 
> 
> AFAICT this is nothing more than rounding up.
> 

But you want to round down by definition of preempt_thresh, don't you?

preempt_thresh = 1ms = 1000000us
ie. warn me if the lock hold goes _to or above_ 1000000us
