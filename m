Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRCFWvF>; Tue, 6 Mar 2001 17:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129643AbRCFWuz>; Tue, 6 Mar 2001 17:50:55 -0500
Received: from gateway.sequent.com ([192.148.1.10]:41190 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129618AbRCFWuj>; Tue, 6 Mar 2001 17:50:39 -0500
Date: Tue, 6 Mar 2001 14:45:52 -0800
From: Jonathan Lahr <lahr@sequent.com>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: Jonathan Lahr <lahr@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010306144552.G6451@w-lahr.des.sequent.com>
In-Reply-To: <20010215104656.A6856@w-lahr.des.sequent.com> <20010305113807.A3917@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010305113807.A3917@linuxcare.com>; from anton@linuxcare.com.au on Mon, Mar 05, 2001 at 11:38:08AM +1100
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Tridge and I tried out the postgresql benchmark you used here and this
> contention is due to a bug in postgres. From a quick strace, we found
> the threads do a load of select(0, NULL, NULL, NULL, {0,0}). Basically all
> threads are pounding on schedule().
...
> Our guess is that the app has some form of userspace synchronisation
> (semaphores/spinlocks). I'd argue that the app needs to be fixed not the
> kernel, or a more valid test case is put forwards. :)
...
> PS: I just looked at the postgresql source and the spinlocks (s_lock() etc)
> are in a tight loop doing select(0, NULL, NULL, NULL, {0,0}). 

Anton,

Thanks for looking into postgresql/pgbench related locking.  Yes, 
apparently postgresql uses a synchronization scheme that uses select()
to effect delays for backing off while attempting to acquire a lock.
However, it seems to me that runqueue lock contention was not entirely due 
to postgresql code, since it was largely alleviated by the multiqueue 
scheduler patch.

In using postgresql/pgbench to measure lock contention, I was attempting
to apply a typical server workload to measure scalability using only open 
software.  My goal is to load and measure the kernel for server performance, 
so I need to ensure that the software I use represents likely real world 
server configurations.  I did not use mysql, because it cannot perform 
transactions which I considered important.  Any pointers to other open 
database software or benchmarks that might be suitable for this effort 
would be appreciated.

Jonathan

