Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132730AbRDQPqk>; Tue, 17 Apr 2001 11:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRDQPqa>; Tue, 17 Apr 2001 11:46:30 -0400
Received: from ns.caldera.de ([212.34.180.1]:38664 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132730AbRDQPqM>;
	Tue, 17 Apr 2001 11:46:12 -0400
Date: Tue, 17 Apr 2001 17:45:57 +0200
Message-Id: <200104171545.RAA12410@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: andrea@suse.de (Andrea Arcangeli)
Cc: linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010417170717.H2696@athlon.random>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010417170717.H2696@athlon.random> you wrote:
> My generic rwsem should be also cleaner and faster than the generic ones in
> 2.4.4pre3 and they can be turned off completly so an architecture can really
> takeover with its own asm implementation (while with the 2.4.4pre3 design this
> is obviously not possible because lib/rwsem.c compilation isn't conditional and
> such file knows the internals of the struct rw_semaphore).
>
> In the below generic implementation of the rw sem the max limit of concurrent
> readers in the critical section is 2^sizeof(int) and down_read is recursive.
> There's no limit of tasks sleeping in the slow path either by down_read or
> down_write. The waitqueue wakeups are done without any additional lock (the
> lock in the waitqueue is unused).
>
> So please try to reproduce the hang with 2.4.4pre3 with those two
> patches applied:

> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre3aa3/00_alpha-numa-3
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre3aa3/00_rwsem-generic-1

Hey it looks like someone finally fixed the rwsems :P

A little comment on the path:

In lib/Makefile you should _always_ add rwsem.o the export-objs, not only if
CONFIG_GENERIC_RWSEM is 'y' - that's the whole idea behind export-objs.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
