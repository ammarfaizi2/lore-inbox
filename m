Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSGCXwT>; Wed, 3 Jul 2002 19:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSGCXwS>; Wed, 3 Jul 2002 19:52:18 -0400
Received: from pophost.cs.tamu.edu ([128.194.130.106]:63948 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S317280AbSGCXwR>;
	Wed, 3 Jul 2002 19:52:17 -0400
Date: Wed, 3 Jul 2002 18:54:47 -0500 (CDT)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: timer queue is still influenced by network load
In-Reply-To: <Pine.LNX.3.95.1020703143207.1862A-100000@chaos.analogic.com>
Message-ID: <Pine.SOL.4.10.10207031839020.4769-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,
	I did a few experiments using the example (jiq, I changed jiffies 
to do_gettimeofday() ) from Linux Device
Driver, 2nd version (p196). 

	I have two machines m1 and m2. On m1, I run a timer queue (jiq)
module. Then I download a big file from m1 to m2. The timings are
different between before ftp and during ftp.

----------------------------------------
before ftp
----------------------------------------
time       pid     cpu command
   420590   1       0   0 swapper
   430580   1       0   0 swapper
   440579   1       0   0 swapper
   450579   1       0   0 swapper
   460579   1       0   0 swapper
   470579   1       0   0 swapper
   480579   1       0   0 swapper
   490579   1       0   0 swapper
   500579   1       0   0 swapper

----------------------------------------
during ftp
----------------------------------------
time       pid       cpu command
   370605   1524      0 in.ftpd
   380645   0         0 swapper
   390583   0         0 swapper
   400667   0         0 swapper
   410703   1524      0 in.ftpd
   420679   0         0 swapper
   430634   0         0 swapper
   440624   0         0 swapper
   450648   0         0 swapper
	


It shows that
timer queue is still not accurate. So
the conclusion of " you're guaranteed that the queue will run at the next
clock tick, thus eliminating latency caused by system load" is WRONG!!!

	What is your opinion?

Xinwen Fu


On Wed, 3 Jul 2002, Richard B. Johnson wrote:

> On Wed, 3 Jul 2002, Xinwen - Fu wrote:
> 
> > Hi, all,
> > 	I'm curious that if a network card interrupt happens at the same
> > time as the kernel timer expires, what will happen?
> > 
> > 	It's said the kernel timer is guaranteed accurate. But if
> > interrupts are not masked off, the network interrupt also should get
> > response when a kernel timer expires. So I don't know who will preempt
> > who.
> > 
> > 	Thanks for information!
> > 
> > Xinwen Fu
> 
> The highest priority interrupt will get serviced first. It's the timer.
> Interrupts are serviced in priority-order. Hardware "remembers" which
> ones are pending so none are lost if some driver doesn't do something
> stupid.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> 
>                  Windows-2000/Professional isn't.
> 
> 

