Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUC3RIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbUC3RIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:08:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52099 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263763AbUC3RHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:07:16 -0500
Date: Tue, 30 Mar 2004 12:09:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() version 2.4.24
In-Reply-To: <4069A729.3030507@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0403301204510.7155@chaos>
References: <Pine.LNX.4.53.0403301138260.6967@chaos> <4069A729.3030507@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Chris Friesen wrote:

> Richard B. Johnson wrote:
> > Anybody know why a task that does:
> >
> > 		for(;;)
> > 		   sched_yield();
> >
> > Shows 100% CPU utiliization when there are other tasks that
> > are actually getting the CPU?
>
> What do the other tasks show for cpu in top?
>

Well in excess of 100% on a single-CPU system.

 12:02pm  up 1 day, 53 min,  4 users,  load average: 2.54, 1.25, 0.90
34 processes: 31 sleeping, 3 running, 0 zombie, 0 stopped
CPU states: 65.8% user, 134.6% system,  0.0% nice,  0.0% idle
Mem:  322352K av, 101772K used, 220580K free,      0K shrd,   9836K buff
Swap: 1044208K av, 1044208K used,      0K free                 20240K cached

 PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 7144 root      19   0  5564 5564  1444 R       0 82.5  1.7   2:27 client
 7143 root      15   0   980  976   428 S       0 59.9  0.3   1:57 server
 7142 root      18   0  1464 1464  1444 R       0 56.0  0.4   1:39 client
 7163 root      11   0   568  564   432 R       0  1.9  0.1   0:00 top
[SNIPPED...sleeping tasks]

Here, one of the 'client' tasks is yielding its CPU time when it
is waiting on a semaphore from the first one.

> Maybe it's an artifact of the timer-based process sampling for cpu
> utilization, and it just happens to be running when the timer interrupt
> fires, so it keeps getting billed?
>
> Chris
>

I think somebody forgot to put something into the 'current' structure
when sys_sched_yield() gets called.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


