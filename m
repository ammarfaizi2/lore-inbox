Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131332AbQL0RmG>; Wed, 27 Dec 2000 12:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbQL0Rl4>; Wed, 27 Dec 2000 12:41:56 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:54092 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S131332AbQL0Rln>; Wed, 27 Dec 2000 12:41:43 -0500
Message-ID: <3A4A22A8.D434B7F@holly-springs.nc.us>
Date: Wed, 27 Dec 2000 12:11:04 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
CC: Arnaud Installe <ainstalle@filepool.com>, linux-kernel@vger.kernel.org
Subject: Re: high load & poor interactivity on fast thread creation
In-Reply-To: <3A266895.F522A0E2@austin.ibm.com>
	 <20001130081443.A8118@bach.iverlek.kotnet.org>
	 <3A266895.F522A0E2@austin.ibm.com> <4.3.2.7.2.20001227110018.00e5ba90@cam-pop.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> No. Java on NT uses proper NT threads. However, a thread on NT is a rather
> different beast to a cloned thread on Linux. I don't know whether the
> differences are important.

On Linux, threads are processes. On NT, processes are distinct from
threads, and usually have at least one thread within them. On Linux, the
process and the initial (sole) thread are the same thing. On NT, they
are distinct.

CreateProcess() creates a process and its initial thread (because that
is what you would expect to happen). On Linux, clone() creates a new
process; sometimes that process can be construed as a thread, because of
shared memory, file descriptors, or whatever. On NT, because a process
contains threads and is not itself a thread, you can use CreateProcess()
to create a process whose only thread is suspended. I don't know if that
kind of thing is possible with clone(). You might have to clone() then
suspend.

You use CreateThread() to create more threads inside an existing
process. CreateRemoteThread() creates new threads inside a different
process. A process is more of a virtual memory environment and container
for threads than a context of execution itself. With clone() on Linux
you can mimic a lot of the behavior of NT processes and threads, but not
all of it.

One notable difference between Linux and NT threads and processes is
that it is more expensive to create new processes on NT than on Linux,
and on NT thread creation is cheaper than process creation. Typically
Windows programs use multiple threads rather than multiple processes,
whereas on Unix the reverse is true.

http://www.byte.com/art/9511/sec11/art3.htm
http://msdn.microsoft.com/library/winresource/dnwinnt/S7FC7.HTM
http://msdn.microsoft.com/library/psdk/winbase/prothred_9dpv.htm
http://msdn.microsoft.com/library/psdk/winbase/prothred_4084.htm
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
