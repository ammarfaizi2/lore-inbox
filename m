Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282083AbRKWJFU>; Fri, 23 Nov 2001 04:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281845AbRKWJFL>; Fri, 23 Nov 2001 04:05:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64713 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281814AbRKWJFB>;
	Fri, 23 Nov 2001 04:05:01 -0500
Date: Fri, 23 Nov 2001 12:02:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <1006472754.1336.0.camel@icbm>
Message-ID: <Pine.LNX.4.33.0111231155380.3988-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Nov 2001, Robert Love wrote:

> > the attached set-affinity-A1 patch is relative to the scheduler
> > fixes/cleanups in 2.4.15-pre9. It implements the following two
> > new system calls: [...]
>
> Ingo, I like your implementation, particularly the use of the
> cpu_online_map, although I am not sure all arch's implement it yet.
> [...]

cpu_online_map is (or should be) a standard component of the kernel, eg.
generic SMP code in init/main.c uses it. But this area can be changed in
whatever direction is needed - we should always keep an eye on CPU
hot-swapping's architectural needs.

> [...] I am curious, however, what you would think of using a /proc
> interface instead of a set of syscalls ?

to compare it this situation to a similar situation, i made
/proc/irq/N/smp_affinity a /proc thing because it appeared to be an
architecture-specific and nongeneric feature, seldom used by ordinary
processes and generally an admin thing. But i think setting affinity is a
natural extension of the existing sched_* class of system-calls. It could
be used by userspace webservers for example.

one issue is that /proc does not necesserily have to be mounted. But i
dont have any strong feelings either way - the syscall variant simply
looks a bit more correct.

	Ingo

