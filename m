Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUJOOmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUJOOmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUJOOmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:42:23 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:26898 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267936AbUJOOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:42:18 -0400
Message-ID: <416FE42A.3010305@techsource.com>
Date: Fri, 15 Oct 2004 10:52:26 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Mark_H_Johnson@raytheon.com
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Adam Heath <doogie@debian.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
References: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
In-Reply-To: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark_H_Johnson@raytheon.com wrote:

> 
> In the systems I have to deal with, I do not have a clear criteria
> to set priorities of interrupts relative to each other. For example, I
> have a real time simulation system using the following devices:
>  - occasional disk access to simulate disk I/O
>  - real time network traffic
>  - real time delivery of interrupts from a PCI timer card and APIC timers
>  - real time interrupts from a shared memory interface
> The priorities of real time tasks are basically assigned based on the
> rate of execution. 80 Hz tasks run at a higher priority than 60 Hz, 60 Hz >
> 40 Hz, and so on. A number of tasks can access each device.
> 


What if drivers could indicate how much "jitter" (essentially, latency) 
its interrupts can tolerate?  Higher jitter would SORTOF translate into 
lower priority, although the scheduler would make sure the IRQ was 
started before its tolerance ran out (ie. the priority approaches 
infinity as its tolerance period approaches the end).  The jitter 
tolerance would be measured in microseconds, I guess.

