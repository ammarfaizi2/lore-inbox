Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132719AbRBEEDD>; Sun, 4 Feb 2001 23:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132703AbRBEECx>; Sun, 4 Feb 2001 23:02:53 -0500
Received: from [63.89.188.10] ([63.89.188.10]:14602 "EHLO xchange.zambeel.com")
	by vger.kernel.org with ESMTP id <S132720AbRBEECl>;
	Sun, 4 Feb 2001 23:02:41 -0500
Message-ID: <2B8089144916D411896D00D0B73C8353DB2C20@exchange.zambeel.com>
From: Mohit Aron <aron@Zambeel.com>
To: "'David Schwartz'" <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Date: Sun, 4 Feb 2001 20:02:32 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>	I'm using 2.4.1-pre10, glibc 2.1.3.

And I'm using Linux 2.2. And the sched_yield bug exists in Linux 2.2. I
found 
a huge number of posted bug reports on linux-kernel regarding this issue. 
Check http://boudicca.tux.org/hypermail/linux-kernel/2000week21/0858.html
for one.


> 	Thread1
> 	Thread1
> 	Thread1
> 	Thread1
> 	Thread1
> 	Thread2
> 	Thread2
> 	Thread2
> 	Thread2
> 	Thread2
>
>	That's totally reasonable, although you probably just forgot to
fflush.

Maybe to you. Not to anyone else who knows anything about systems. FYI,
stdout
is line buffered - so a printf ending in a "\n" is an automatic flush.


>	It's also possible Thread1 did all its work, yields and all, before
Thread2
> even got started. Thus Thread1 had no 'ready to run' thread to yield to.
> (The main thread may not have been ready to run, it may still have been
> waiting to synchronize to the new thread it created.)

What synchronization ? Even if thread1 started before main thread has a
chance to
create thread2, the first sched_yield would give main thread a chance to
create 
thread2. 


>	Find one pthreads expert who agrees with this claim. Post it to
> comp.programming.threads and let the guys who created the standard laugh
at
> you. Scheduling is not a substitute for synchronization, ever.

I for one am one. And I find your statement about laughable. Try posting
your
stuff on comp.programming.threads and see if you don't get the laughter that

you're expecting is lying in wait for me. Here is simple 
logic for you to figure out - if you have one run queue, and two threads
calling sched_yield() (and hence theoretically putting themselves at the end
of run queue), perfect alternation should be seen. Also, who's said I'm
trying to
synchronize based on scheduling - sched_yield() just isn't working, that's
all.


>	Your reasoning is totally invalid and ignores so many possible other
>factors. For example, who says that the writes that your threads are doing
> don't block?

If the printfs are blocking, then there's even more reason that the other
thread should run. And print its stuff. Put some pressure on your brain and
it might come to you.

>	I'm not sure I understand what this has to do with anything. If you
think
>so, then I don't think you appreciate with a standard actually is. Perfect
>alternation is reasonable, expecting perfect alternation is not. Probably
>the reason you got perfect alternation in Solaris is because you only had
>one kernel execution vehicle. Try it with system contention scope threads.


My Linux system is also idle. Even if one assumes that a sched_yield causes 
some other process to run on the CPU, the thread that caused sched_yield is
theoretically the last on the run queue. Hence no matter what other system
process is run first, the other thread should always run before the thread
that called sched_queue. Again my point of putting some pressure on your
brain ...

Also, I won't reply any further to anything you post. If you don't
understand
systems, kindly stay out of this discussion.


- Mohit

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
