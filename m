Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbTDAQuN>; Tue, 1 Apr 2003 11:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbTDAQuN>; Tue, 1 Apr 2003 11:50:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11157 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262652AbTDAQuL>; Tue, 1 Apr 2003 11:50:11 -0500
Date: Tue, 1 Apr 2003 12:00:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Anderson <david-anderson2003@mail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Regarding task queues
In-Reply-To: <20030401155608.27069.qmail@mail.com>
Message-ID: <Pine.LNX.4.53.0304011146530.26085@chaos>
References: <20030401155608.27069.qmail@mail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, David Anderson wrote:

> Hi,
>
> Is it possible for a task, run from a schedule task queue(tq_schedule)
> to sleep / block ?? Can tasks be queued to this queue from a
> interrupt context ??
>

All tasks that are queued can sleep. However you cannot ever
sleep or schedule, etc., in interrupt context. Not to worry,
though, you  can wake up any tasks from interrupt context and,
of course,  you can set up any pointers, etc., in the interrupt.

So, you can make a kernel thread. This is a fully-functioning
task that runs in kernel space. It can sleep "interruptible_
sleep_on()", when it is sleeping, your interrupt can give it
something to do, then wake it up "wake_up_interruptible()".
The interrupt  continues as a normal interrupt and, after it
completes,  the kernel will awaken your task to do whatever
you told it to do. FYI, you can "tell it to do many things"
by changing a pointer to some procedure. That pointer can,
of course, be  changed in interrupt context. You just make
sure that your kernel thread is sleeping and isn't going to
be awakened while your pointer is being changed (possible in
a SMP machine, you may need a spin-lock).

This is a real easy way to do kernel-space processing based
upon some interrupt. There are other ways, too.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

