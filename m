Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSFMLVx>; Thu, 13 Jun 2002 07:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317441AbSFMLVw>; Thu, 13 Jun 2002 07:21:52 -0400
Received: from isolaweb.it ([213.82.132.2]:11268 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S316632AbSFMLVu>;
	Thu, 13 Jun 2002 07:21:50 -0400
Message-Id: <5.1.1.6.0.20020613122534.02efe850@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 13 Jun 2002 13:21:54 +0200
To: David Schwartz <davids@webmaster.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020613101337.AAA26116@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03.13 13/06/02 -0700, you wrote:


>On Thu, 13 Jun 2002 11:08:27 +0200, Roberto Fichera wrote:
> >You are right! But "computational intensive" is not totaly right as I say ;-
> >),
>
>         It's really not fair to change the premises in the middle of an 
> argument.

Sorry ;-)!


> >because most of thread are waiting for I/O,
>
>         Still wrong. You don't tie up threads waiting for I/O. You can 
> wait without
>having a thread doing the waiting.
>
> >after I/O are performed the
> >computational intensive tasks, finished its work all the result are sent
> >to thread-father,
>
>         Okay, so you need a new abstraction -- separate the waiting from the
>working. Create as many threads to do the work as you have processors to do
>the work on. As for the waiting, minimize threads waiting, they're pure
>overhead. If it's sockets, use 'poll' so one thread can do lots of waiting.

This's a possible solution.

> >the father collect all the child's result and perform some
> >computational work and send its result to its father and so on with many
> >thread-father controlling other child. So I think the main problem/overhead
> >is thread creation and the thread's numbers.
>
>         So get rid of the problem! Don't create so many threads, create 
> only as many
>threads as can do useful work and reuse them rather than destroying and
>recreating them. Solve the actual problem/overhead since it's totally
>artificial and due to your model rather than your problem!

Depending by the applications. With my simulation/emulation program I need 
to create
many thread because each thread resolve/manage/compute a specific problem and
it's live depend by some factors. Each thread is create only if needed to 
avoid the
overhead. The simulation/emulation is a "merge" of many and many object, 
each object
work to resolve/manage/compute a specific problem. All the low objects are 
grouped to
resolve a specific problem and are managed by a thread controller that 
should take some
decision or doing some work. Some thread controller are grouped and managed 
by another
thread controller and so on. Do not think that I need always 400 threads 
active they are
create only if need by the controller. You must thinks this 
simulation/emulation as collection
of many and many object that should interoperate, and the model is designed 
to scale easily
on a distribuite environment.


>         DS

Roberto Fichera.

