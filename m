Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317776AbSFMQ0v>; Thu, 13 Jun 2002 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317777AbSFMQ0u>; Thu, 13 Jun 2002 12:26:50 -0400
Received: from isolaweb.it ([213.82.132.2]:3340 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S317776AbSFMQ0u>;
	Thu, 13 Jun 2002 12:26:50 -0400
Message-Id: <5.1.1.6.0.20020613171707.03f09720@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 13 Jun 2002 18:26:54 +0200
To: David Schwartz <davids@webmaster.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020613115808.AAA1253@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04.58 13/06/02 -0700, David Schwartz wrote:

>         If it's a simulation, you don't *really* need the threads, you 
> just need to
>be able to act as if you had them. After all, what are you simulating if what
>work gets done when is up to the random vagaries of the OS scheduler?
>
>         If it's a real application wanting real performance, the 
> suggestions I made
>stand -- you don't want many more threads working than you have CPUs and you
>don't want a lot of threads sitting around waiting for work (and thus forcing
>bazillions of extra context switches).

This is a scheduler problem! All threads waiting for I/O are blocked by
the scheduler, and this doesn't have any impact for the context switches
it increase only the waitqueue, using the Ingo's O(1) scheduler, a big piece
of code, it should make a big difference for example.

>         It sounds to me like your design is broken, needlessly mapping 
> threads to
>I/Os that are being waited for one-to-one. This is a common error among
>programmers who consciously or subconsciously have accepted the 'more threads
>can do more work' philosophy.

I don't think "more threads == more work done"! With the thread's approch it's
possible to split a big sequential program in a variety of concurrent logical
programs with a big win for code revisions and new implementation.

>         What you need to do is take whatever it is you're thinking of as 
> a 'thread'
>right now, which I'd roughly define as 'one logical task, from start to
>completion' and realize that there is absolutely no reason to map this
>one-to-one to actual pthreads threads and every reason in the world not to.
>
>         This will conserve resources (12 thread stacks instead of 300, 12 
> KSEs
>instead of 300), reduce context switches (context switches will only occur
>when there's no work to do at all or a thread uses up its entire timeslice
>rather than every time we change which client/task we're doing work for/on),
>improve scheduler efficiency (because the number of ready threads will not
>exceed the number of CPUs by much) and more often than not, clean up a lot of
>ugliness in your architecture (because threads are probably being used
>instead of a sane abstraction for 'work to be done' or 'a client I'm doing
>work for').

You are right! But depend by the application! If you have todo I/O like 
signal acquisition,
sensors acquisitions and so on, you must have a one thread for each type of 
data acquisition,
you must have a thread that perform some data computation with a subset, 
for examples,
of this data, and generate the output that could be a new input for an 
other thread.
This make the environment more realistic. I agree with you that if we 
increase the thread's
numbers the system could collapse (= context switches become expensive = we 
must increase
the CPU numbers or new box is required or new approch should be make).


Roberto Fichera.

