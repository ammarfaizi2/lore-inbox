Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280133AbRKSGBc>; Mon, 19 Nov 2001 01:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRKSGBW>; Mon, 19 Nov 2001 01:01:22 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:22534 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280133AbRKSGBO>;
	Mon, 19 Nov 2001 01:01:14 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111190601.fAJ616Q32518@saturn.cs.uml.edu>
Subject: Re: Bug or feature? Priority in /proc/<pid>/stat for RT processes
To: mlev@despammed.com (Lev Makhlis)
Date: Mon, 19 Nov 2001 01:01:06 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01101314091204.09135@portent.dyndns.org> from "Lev Makhlis" at Oct 13, 2001 02:09:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lev Makhlis writes:

> I have noticed that when the scheduling policy of a process is SCHED_FIFO
> or SCHED_RR, proc_pid_stat() in fs/proc/array.c still uses the counter field
> in the task structure to calculate the priority in /proc/<pid>/stat.
> For such processes, the counter field is ignored by the scheduler in favour
> of the rt_priority field.  Thus, even though the actual priority is available
> via sched_getparam(2), the priority in /proc/<pid>/stat -- and, consequently,
> in the output of ps(1) and top(1) -- seems to be, for SCHED_FIFO/SCHED_RR
> processes, a value that is not representative at all of how the process is
> scheduled.
> 
> I have thrown together a patch to address this, but I can't say I feel
> entirely comfortable about scaling from 1..99 to -20..20.

Do not do this. Just supply the raw value for ps(1) and top(1) to use.
Also supply the scheduling policy type. You can tack this on the end
of /proc/<pid>/stat and tell me when Linus accepts it so that I can
make ps(1) and top(1) support the new info.
