Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSFMKZM>; Thu, 13 Jun 2002 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317583AbSFMKZM>; Thu, 13 Jun 2002 06:25:12 -0400
Received: from isolaweb.it ([213.82.132.2]:10002 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S317581AbSFMKZL>;
	Thu, 13 Jun 2002 06:25:11 -0400
Message-Id: <5.1.1.6.0.20020613115257.03b03ec0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 13 Jun 2002 12:25:12 +0200
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020613113158.I22429@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11.31 13/06/02 +0200, Ingo Oeser wrote:

>On Thu, Jun 13, 2002 at 11:08:27AM +0200, Roberto Fichera wrote:
> > You are right! But "computational intensive" is not totaly right as I 
> say ;-),
> > because most of thread are waiting for I/O, after I/O are performed the
> > computational intensive tasks, finished its work all the result are sent
> > to thread-father, the father collect all the child's result and perform 
> some
> > computational work and send its result to its father and so on with many
> > thread-father controlling other child. So I think the main problem/overhead
> > is thread creation and the thread's numbers.
>
>So you are creating a simulation/emulation application/engine, right?
>Or a measured data analysis engine? (which is basically the same
>task)

Yes! It's a simulation/emulation application.

>For these kind of tasks creating your own kind of "threads" is
>probably better.
>
>Split it in the following data structure:
>
>struct my_thread {
>    actor_function_t actor;
>    input_t inbuf;
>    output_t outbuf;
>    state_t statebuf;
>}
>
>And provide rules and primitives for accessing inbuf/outbuf, if
>they might be shared (which is probable).

This can be a solution.


>Now you can build a dependency tree/graph for the whole stuff
>easily and schedule works of the same level to some real worker
>threads (which might be on different machines), which are one per CPU.
>
>The problem is to build the actor as a REAL primitive, that
>scales only by the size of inbuf and not by the contents of it.

Yes!

>Everything else is going to be bloated and not really scalable,
>but can be implemented by every "Joe Programmer" after finishing
>high school ;-)

Depending by the threading library, if it's totaly userspace or not!
With so many thread that aren't totaly userspace the scheduler
performances/caratteristics are much important. I prefer a mixed
solution for example. Because some problem can be easily resolved
with a userspace threads and other not.


>Regards
>
>Ingo Oeser
>--
>Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

Roberto Fichera.

