Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTHOSLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTHOSLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:11:16 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:22033 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270682AbTHOSLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:11:15 -0400
Message-ID: <3F3D25D0.7010701@techsource.com>
Date: Fri, 15 Aug 2003 14:26:24 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O16int for interactivity
References: <200308160149.29834.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

> Preemption of tasks at the same level with twice as much timeslice has been 
> dropped as this is not necessary with timeslice granularity (may improve 
> performance of cpu intensive tasks).

Does this situation happen where two tasks at different nice levels have 
dynamic priority adjustments which make them effectively have the same 
priority?

> Preemption of user tasks is limited to those in the interactive range; cpu 
> intensive non interactive tasks can run out their full timeslice (may also 
> improve cpu intensive performance)

What can cause preemption of a task that has not used up its timeslice? 
  I assume a device interrupt could do this, but... there's a question I 
asked earlier which I haven't read the answer to yet, so I'm going to guess:

A hardware timer interrupt happens at timeslice granularity.  If the 
interrupt occurs, but the timeslice is not expired, then NORMALLY, the 
ISR would just return right back to the running task, but sometimes, it 
might decided to end the timeslice early and run some other task.

Right?

So, what might cause the scheduler to decide to preempt a task which has 
not used up its timeslice?

