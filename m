Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUJEG6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUJEG6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUJEG6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:58:01 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:35970 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268856AbUJEG5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:57:55 -0400
Message-ID: <416245EF.1030202@yahoo.com.au>
Date: Tue, 05 Oct 2004 16:57:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@redhat.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: bug in sched.c:activate_task()
References: <200410050216.i952Gb620657@unix-os.sc.intel.com> <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com> <cone.1096958170.135056.10082.502@pc.kolivas.org>
In-Reply-To: <cone.1096958170.135056.10082.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Ingo Molnar writes:
> 
>>
>> On Mon, 4 Oct 2004, Chen, Kenneth W wrote:
>>
>>> Update p->timestamp to "now" in activate_task() doesn't look right to me
>>> at all.  p->timestamp records last time it was running on a cpu.  
>>> activate_task shouldn't update that variable when it queues a task on
>>> the runqueue.
>>
>>
>> correct, we are overriding it in schedule():
>>
>>         if (likely(prev != next)) {
>>                 next->timestamp = now;
>>                 rq->nr_switches++;
>>
>> the line your patch removes is a remnant of an earlier logic when we
>> timestamped tasks when they touched the runqueue. (vs. timestamping when
>> they actually run on a CPU.) So the patch looks good to me. Andrew, 
>> please
>> apply.
> 
> 
>     unsigned long long delta = now - next->timestamp;
> 
>     if (next->activated == 1)
>         delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
> 
> is in schedule() before we update the timestamp, no?
> 

Yeah right, unfortunately.
