Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135192AbRDRO0r>; Wed, 18 Apr 2001 10:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135187AbRDRO0h>; Wed, 18 Apr 2001 10:26:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135185AbRDRO0Z>; Wed, 18 Apr 2001 10:26:25 -0400
Date: Wed, 18 Apr 2001 10:26:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: schedule() seems to have changed.
Message-ID: <Pine.LNX.3.95.1010418102332.1771A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that the nature of schedule() has changed in recent
kernels. I am trying to update my drivers to correspond to
the latest changes. Here is an example:


This waits for some hardware (interrupt sets flag), time-out in one
second. This is in an ioctl(), i.e., user context:

    set_current_state(TASK_INTERRUPTIBLE);
    current->policy = SCHED_YIELD;
    timer = jiffies + HZ;
    while(time_before(jiffies, timer))
    {
        if(flag) break;
        schedule();
    }
    set_current_state(TASK_RUNNING);

The problem is that schedule() never returns!!! If I use 
schedule_timeout(1), it returns, but the granularity
of the timeout interval is such that it slows down the
driver (0.1 ms).

So, is there something that I'm not doing that is preventing
schedule() from returning?  It returns on a user-interrupt (^C),
but otherwise gives control to the kernel forever.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


