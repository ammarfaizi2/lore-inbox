Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUJEHIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUJEHIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 03:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUJEHIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 03:08:36 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:50083 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268883AbUJEHIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 03:08:32 -0400
Message-ID: <4162486B.3030700@yahoo.com.au>
Date: Tue, 05 Oct 2004 17:08:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@redhat.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: bug in sched.c:activate_task()
References: <200410050216.i952Gb620657@unix-os.sc.intel.com> <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com> <cone.1096958170.135056.10082.502@pc.kolivas.org> <Pine.LNX.4.58.0410050250580.4941@devserv.devel.redhat.com> <cone.1096959567.406629.10082.502@pc.kolivas.org>
In-Reply-To: <cone.1096959567.406629.10082.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Ingo Molnar writes:
> 
>>
>> On Tue, 5 Oct 2004, Con Kolivas wrote:
>>
>>>     unsigned long long delta = now - next->timestamp;
>>>
>>>     if (next->activated == 1)
>>>         delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
>>>
>>> is in schedule() before we update the timestamp, no?
>>
>>
>> indeed ... so the patch is just random incorrect damage that happened to
>> distrub the scheduler fixing some balancing problem. Kenneth, what
>> precisely is the balancing problem you are seeing?
> 
> 
> We used to compare jiffy difference in can_migrate_task by comparing it to
> cache_decay_ticks. Somewhere in the merging of sched_domains it was 
> changed to task_hot which uses timestamp.
> 

It always used ->timestamp though, even when that was in jiffies.
sched domains didn't change anything there (and IIRC it used
task_hot before sched domains).
