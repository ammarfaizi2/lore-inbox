Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUJEGgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUJEGgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUJEGgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:36:32 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:7040 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268839AbUJEGg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:36:29 -0400
References: <200410050216.i952Gb620657@unix-os.sc.intel.com> <Pine.LNX.4.58.0410050229380.31508@devserv.devel.redhat.com>
Message-ID: <cone.1096958170.135056.10082.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: bug in sched.c:activate_task()
Date: Tue, 05 Oct 2004 16:36:10 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> 
> On Mon, 4 Oct 2004, Chen, Kenneth W wrote:
> 
>> Update p->timestamp to "now" in activate_task() doesn't look right to me
>> at all.  p->timestamp records last time it was running on a cpu.  
>> activate_task shouldn't update that variable when it queues a task on
>> the runqueue.
> 
> correct, we are overriding it in schedule():
> 
>         if (likely(prev != next)) {
>                 next->timestamp = now;
>                 rq->nr_switches++;
> 
> the line your patch removes is a remnant of an earlier logic when we
> timestamped tasks when they touched the runqueue. (vs. timestamping when
> they actually run on a CPU.) So the patch looks good to me. Andrew, please
> apply.

	unsigned long long delta = now - next->timestamp;

	if (next->activated == 1)
		delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;

is in schedule() before we update the timestamp, no?

Con

