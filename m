Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312350AbSCYIPc>; Mon, 25 Mar 2002 03:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSCYIPW>; Mon, 25 Mar 2002 03:15:22 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:56287 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312350AbSCYIPG>; Mon, 25 Mar 2002 03:15:06 -0500
Date: Mon, 25 Mar 2002 10:04:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: preempt-related hangs
In-Reply-To: <3C9E8497.9355C462@zip.com.au>
Message-ID: <Pine.LNX.4.44.0203251001510.14794-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Andrew Morton wrote:

> I sent this email to Ingo last week; seems that he's
> having some downtime.  It was happening on my dual PIII
> and I now discover that the quad pIII does the same
> thing.  Any ideas?
> 
> 
> Kernel is 2.5.7, dual PIII.  When I enable preempt it
> locks during boot.

same 2.5.7 here with quad ppro emulation, i have preempt disabled.

> I applied the kgdb patch and had a poke.
> 
> (gdb) info threads
> * 6 Thread 6  preempt_schedule () at sched.c:848
>   5 Thread 5  preempt_schedule () at sched.c:848
>   4 Thread 4  context_thread (startup=0xc0395f90) at context.c:101
>   3 Thread 3  migration_thread (unused=0x0) at sched.c:1646
>   2 Thread 2  migration_thread (unused=0x0) at sched.c:1646
>   1 Thread 1  spawn_ksoftirqd () at softirq.c:407
> 
> Note that init is stuck in spawn_ksoftirqd.  It's spinning in
> that function, yielding, waiting for the softirqd threads to
> come alive.  They're threads 5 and 6.

I'm locking in the same place i have my last CPU spinning, waiting for its 
softirqd thread. Then i get a smp_migrate_task IPI from an alive CPU, at 
which case i'm stuck.

	Zwane


