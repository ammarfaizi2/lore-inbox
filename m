Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292205AbSBBCtX>; Fri, 1 Feb 2002 21:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292204AbSBBCtP>; Fri, 1 Feb 2002 21:49:15 -0500
Received: from SLASH.REM.CMU.EDU ([128.237.165.98]:12478 "EHLO
	slash.rem.cmu.edu") by vger.kernel.org with ESMTP
	id <S292203AbSBBCtD>; Fri, 1 Feb 2002 21:49:03 -0500
Date: Fri, 1 Feb 2002 21:48:44 -0500 (EST)
From: mukesh agrawal <m.lkml@agrawals.org>
X-X-Sender: mukesh@take2.
To: Michael May <michael.may@tnt.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Memory
In-Reply-To: <200201301648.g0UGmtj32611@pcchk.intra.tnt.de>
Message-ID: <Pine.LNX.4.44.0202012143220.32631-100000@take2.>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi folks,
>
>
> I think there is a little Problem with Kernel 2.4.17-pre4 - pre7
>
> When the machine in up for longer than 2 days and is under higher load, the processes will killed, with some syslog-messages:
>
> kernel: Out of memory: Killed process <pid>
>
> I don't know what the Problem is, and all machines where it is, are SMP-Machines on i386.
>
> Two times, I traced the problem and the system reported full memory.
> But, the processes and the Utilities are the same like before updating the kernel,
> except the gcc (is now 3.0.3)

If this is the same problem that I'm seeing, what's happening is that the
buffer and cache memory (as reported in top) is not being freed early
enough.

In my situation, what happens is that (over time), buffers+cache grows to
80MB or more (out of 320MB total available; no swap). Factoring in the
memory used by running processes, the uncommitted memory falls to <10MB.
Then, when Mozilla or StarOffice tries to allocate some more memory, the
OOM killer picks one of them instead of shrinking the cache.

I'd check the amount of memory allocated to buffers and cache after one
your OOM events and see if that explains why you're now seeing low memory
conditions with the same workload.


