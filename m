Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSGHMXn>; Mon, 8 Jul 2002 08:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSGHMXm>; Mon, 8 Jul 2002 08:23:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31107 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316857AbSGHMXl>; Mon, 8 Jul 2002 08:23:41 -0400
Date: Mon, 8 Jul 2002 08:27:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Xinwen - Fu <xinwenfu@cs.tamu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: timer queue is still influenced by network load
In-Reply-To: <Pine.SOL.4.10.10207031839020.4769-100000@dogbert>
Message-ID: <Pine.LNX.3.95.1020708082244.19138B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Xinwen - Fu wrote:

> Richard,
> 	I did a few experiments using the example (jiq, I changed jiffies 
> to do_gettimeofday() ) from Linux Device
> Driver, 2nd version (p196). 
> 
> 	I have two machines m1 and m2. On m1, I run a timer queue (jiq)
> module. Then I download a big file from m1 to m2. The timings are
> different between before ftp and during ftp.
> 

> 
> 
> It shows that
> timer queue is still not accurate. So
> the conclusion of " you're guaranteed that the queue will run at the next
> clock tick, thus eliminating latency caused by system load" is WRONG!!!
> 
> 	What is your opinion?

Well you are guaranteed that it will run. You just don't know how fast
it will run. The bottom-half code run off the timer-queue is run with
the interrupts enabled. It can get interrupted and it may be interrupted
by network driver code that loops in ISRs, taking a large percentage
of the CPU cycles.

So, I don't think you are measuring what you think you are measuring.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

