Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUJEEqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUJEEqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 00:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268771AbUJEEqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 00:46:09 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:41189 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268769AbUJEEqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 00:46:06 -0400
References: <200410050216.i952Gb620657@unix-os.sc.intel.com> <cone.1096943670.717018.10082.502@pc.kolivas.org> <416211A3.8060806@yahoo.com.au>
Message-ID: <cone.1096951549.783170.10082.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Chen@bhhdoa.org.au,
       Kenneth W <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:activate_task()
Date: Tue, 05 Oct 2004 14:45:49 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:

> Con Kolivas wrote:
> 
>> Chen, Kenneth W writes:
>>
>>> Update p->timestamp to "now" in activate_task() doesn't look right
>>> to me at all.  p->timestamp records last time it was running on a
>>> cpu.  activate_task shouldn't update that variable when it queues
>>> a task on the runqueue.
>>>
>>> This bug (and combined with others) triggers improper load balancing.
>>
>>
>> The updated timestamp was placed there by Ingo to detect on-runqueue 
>> time. If it is being used for load balancing then it is being used in 
>> error.
>>
> 
> Load balancing wants to know if a task is considered cache hot.

Yes I know. It used to be performed based on jiffies which was adequate 
resolution for cache warmth at the time. The timestamp was being used for on 
runqueue length measurement before the load balancing was modified to use 
that value.

Con

