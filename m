Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVKHCbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVKHCbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbVKHCbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:31:22 -0500
Received: from winds.org ([68.75.195.9]:23451 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S965200AbVKHCbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:31:22 -0500
Date: Mon, 7 Nov 2005 21:31:10 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: David Lang <david.lang@digitalinsight.com>
cc: Brian Twichell <tbrian@us.ibm.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, slpratt@us.ibm.com, anton@samba.org
Subject: Re: Database regression due to scheduler changes ?
In-Reply-To: <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.63.0511072117430.21870@winds.org>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, David Lang wrote:

> Brian,
>  If I am understanding the data you posted, it looks like you are useing 
> sched_yield extensivly in your database. This is known to have significant 
> problems on SMP machines, and even bigger ones on NUMA machines, in part 
> becouse the process doing the sched_yield may get rescheduled immediatly and 
> not allow other processes to run (to free up whatever resource it's waiting 
> for). This causes the processor to look busy to the scheduler and therefor 
> the scheduler doesn't migrate other processes to the CPU that's spinning on 
> sched_yield. On NUMA machines this is even more noticable as processes now 
> have to migrate through an additional layer of the scheduler.

I have an application designed on Linux where the only processes running are
'init' and those integral to the application. Each communicates using mutual
exclusion & semaphores across a shared file/memory backing.

The application was designed to be as close intrinsically as to what Linux
does--manage processes. There's only 1 thread per process, and each process has
a different executable for its own task.

One day I plan to extend this application across multiple CPUs using either SMP
or NUMA. Therefore a lot of the mutual exclusion routines I've coded in use
sched_yield().

What should I do instead to alleviate the problem of causing the processor to
look busy? In this case I _want_ other processes to be migrated over to the
CPU in order to free up the critical section faster.

A simple test using a 2-cpu SMP system resulted in sched_yield() being a lot
faster than using futexes, but I don't know for the NUMA case.

Best regards,
  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
