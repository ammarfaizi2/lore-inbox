Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317556AbSFMJI1>; Thu, 13 Jun 2002 05:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317557AbSFMJI0>; Thu, 13 Jun 2002 05:08:26 -0400
Received: from isolaweb.it ([213.82.132.2]:43536 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S317556AbSFMJIZ>;
	Thu, 13 Jun 2002 05:08:25 -0400
Message-Id: <5.1.1.6.0.20020613104128.02c119a0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 13 Jun 2002 11:08:27 +0200
To: David Schwartz <davids@webmaster.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020613082659.AAA17584@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01.26 13/06/02 -0700, you wrote:

>On Thu, 13 Jun 2002 10:13:35 +0200, Roberto Fichera wrote:
>
> >I'm designing a multithreding application with many threads,
> >from ~100 to 300/400. I need to take some decisions about
> >which threading library use, and which patch I need for the
> >kernel to improve the scheduler performances. The machines
> >will be a SMP Xeon with 4/8 processors with 4Gb RAM.
> >All threads are almost computational intensive and the library
> >need a fast interprocess comunication and syncronization
> >because there are many sync & async threads time
> >dependent and/or critical. I'm planning, in the future, to distribuite
> >all the threads in a pool of SMP box.
>
>         With 4/8 processors, you don't want to create 100-400 threads doing
>computation intensive tasks. So redesign things so that the number of threads
>you create is more in line with the number of CPUs you have available. That
>is, use a 'thread per CPU' (or slightly more threads than their are CPUs per
>node) approach and you'll perform a lot better. Distribute the available work
>over the available threads.

You are right! But "computational intensive" is not totaly right as I say ;-),
because most of thread are waiting for I/O, after I/O are performed the
computational intensive tasks, finished its work all the result are sent
to thread-father, the father collect all the child's result and perform some
computational work and send its result to its father and so on with many
thread-father controlling other child. So I think the main problem/overhead
is thread creation and the thread's numbers.


>         DS

Roberto Fichera.

