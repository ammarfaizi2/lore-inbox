Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272312AbRHXTj7>; Fri, 24 Aug 2001 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272307AbRHXTjs>; Fri, 24 Aug 2001 15:39:48 -0400
Received: from f45.law8.hotmail.com ([216.33.241.45]:28177 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272306AbRHXTjb>;
	Fri, 24 Aug 2001 15:39:31 -0400
X-Originating-IP: [12.13.238.139]
Reply-To: ddade@digitalstatecraft.com
From: "Donald Dade" <don_dade@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is it bad to have lots of sleeping tasks?
Date: Fri, 24 Aug 2001 12:39:42 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F45F3VcuiDqPkMseLHP00010e68@hotmail.com>
X-OriginalArrivalTime: 24 Aug 2001 19:39:42.0636 (UTC) FILETIME=[856E1EC0:01C12CD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I have an application that creates a pool of 1000 threads that sleep() for 
various intervals, and then wake up and do something. I also have another 
version of the same app that uses a single thread together with program 
logic to do essentially the same thing: sleeping until it is time to wake up 
and do something. I'm surprised to see that the overhead of having 1000 
threads that each use a timer is only about 60% of the overhead of the most 
efficient attempt that I could muster using a single thread.

Since I'll need the pool size will go from 1000 to 6000 (technical hurdles 
aside), I was wondering if I can expect the kernel to continue to scale as 
well. I think that I understand why it has scaled so well thus far, and I'd 
like some type of validation/invalidation: I have a boatload of threads, but 
all except a very small number will be in the TASK_INTERRUPTIBLE state in 
stead of TASK_RUNNABLE, and therefore the scheduler doesn't have to walk a 
list of 1000+ processes, just 2 or 3.

My questions are these:
1) Are there any kernel structures that are O(n) or just as bad, where n is 
the total number of processes, not just the total number of runnable 
processes? i.e. will the performance of the system be adversely affected by 
the number of tasks in wait queues?

2) If I have 1000 threads, and each calls sleep(), I assume that my 
motherboard cannot handle 1000 timers in hardware, so the kernel has to 
somehow keep track of a timer by polling and sending SIGALRM to the owning 
process when each expires, which causes glibc's sleep() to somehow return. 
The question is this - how can asking the kernel to manage 1000 timers be so 
much more efficient than asking it to manage just 1? Or better yet, how can 
I load the system down with 1000, and see absolutely *NO* demonstrable 
difference in the system's responsiveness?

3) I am tempted to cajole linuxthreads to do that many, or get clone() to 
play nicely with glibc, or still use linuxthreads and have 6 processes with 
1000 each that share memory, but don't want to figure it all out, just to 
see it not perform well. So, if the kernel impresses the hell out of me at 
1000, will it at 6000? Or is a pool of 6000 threads, sleeping or not, just 
crazy, which was my first impression?

Thanks to any and all,

Don Dade

"I'm not going back to win32. Ever."

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

