Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272291AbTHRTcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272307AbTHRTcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:32:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:15122 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272291AbTHRTct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:32:49 -0400
Message-ID: <3F412D9E.4070807@techsource.com>
Date: Mon, 18 Aug 2003 15:48:46 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O16int for interactivity
References: <200308160149.29834.kernel@kolivas.org> <3F3D25D0.7010701@techsource.com> <200308161231.50661.kernel@kolivas.org> <3F40F4DA.5050705@techsource.com> <3F40F43A.4050709@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>>   If another task exists at a higher priority, then it gets run at 
>> that point.
> 
> 
> 
> Well loosely, yes. Actually, it happens if the task exists and is 
> "running",
> and has timeslice left. 

> That only happens in scheduler_tick when the 
> current
> task has finished its timeslice and the priority arrays are about to be
> switched. 

What only happens then?

I'm confused again.  Are you talking about swapping the active and 
expired arrays?

Of course, all bets are off if the current task actually uses up it 
whole timeslice.  Then it's not being preempted in quite the same way.

So, then, if there are not tasks left in the active array, naturally, 
the highest priority task from what was once the expired array will be 
run, and that may be of higher priority.

Is that what you're saying?


 > The required conditions for preemption can also occur when a task
> is being woken up, (after sleeping or newly forked).

This is the case that I was thinking of.  No swapping of queues.  It's 
just that a higher priority task was sleeping (or not existing) which 
could cause the current task to be preempted before its timeslice ends.

