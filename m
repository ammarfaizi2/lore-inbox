Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRCHWQu>; Thu, 8 Mar 2001 17:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCHWQk>; Thu, 8 Mar 2001 17:16:40 -0500
Received: from mnh-1-02.mv.com ([207.22.10.34]:48392 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S130073AbRCHWQb>;
	Thu, 8 Mar 2001 17:16:31 -0500
Message-Id: <200103082326.SAA04080@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: timw@splhi.com
cc: Jonathan Lahr <lahr@sequent.com>, Anton Blanchard <anton@linuxcare.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability 
In-Reply-To: Your message of "Wed, 07 Mar 2001 14:13:21 PST."
             <20010307141321.B1254@kochanski.internal.splhi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Mar 2001 18:26:20 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timw@splhi.com said:
> On a uniprocessor system, a simple fallback is to just use a semaphore
> instead of a spinlock, since you can guarantee that there's no point
> in scheduling the current task until the holder of the "lock" releases
> it. 

Yeah, that works.  But I'm not all that interested in compiling UML 
differently for UP and SMP hosts.

> Otherwise, the spin calling sched_yield() each iteration isn't too
> horrible. 

This looks a lot better.  For UML, if there's a thread spinning on a lock, 
there has to be a runnable thread holding it, and that thread will get a 
timeslice before the spinning one (assuming that the thread holding the lock 
hasn't called a blocking system call, which is something that I intend to make 
sure can't happen).

> > That sounds like a pretty fundamental (and abusable) mechanism.
> 
> It would be if it were generally available. The implementation on
> DYNIX/ptx requires a privilege (PRIV_SCHED IIRC), to be able to use
> it.

OK, that makes sense.

				Jeff


