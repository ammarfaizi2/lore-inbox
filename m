Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSFOJBq>; Sat, 15 Jun 2002 05:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSFOJBp>; Sat, 15 Jun 2002 05:01:45 -0400
Received: from isolaweb.it ([213.82.132.2]:1552 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S315182AbSFOJBn>;
	Sat, 15 Jun 2002 05:01:43 -0400
Message-Id: <5.1.1.6.0.20020615104206.05291720@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 15 Jun 2002 11:01:44 +0200
To: David Schwartz <davids@webmaster.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020614205601.AAA9369@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13.56 14/06/02 -0700, David Schwartz wrote:


>On Thu, 13 Jun 2002 18:26:54 +0200, Roberto Fichera wrote:
> >At 04.58 13/06/02 -0700, David Schwartz wrote:
>
> >This is a scheduler problem! All threads waiting for I/O are blocked by
> >the scheduler, and this doesn't have any impact for the context switches
> >it increase only the waitqueue, using the Ingo's O(1) scheduler, a big piece
> >of code, it should make a big difference for example.
>
>         You are incorrect. If you have ten threads each waiting for an 
> I/O and all
>ten I/Os are ready, then ten context switches are needed. If you have one
>thread waiting for ten I/Os, and then I/Os come ready, one context switch is
>needed.

You are right with this specific case, but always depending what kind of I/O
you must be done. Not all the case could be reduce to your logic, only a
specific case. It's a only "local" optimization.

>[snip]
>
> >I don't think "more threads == more work done"! With the thread's approch
> >it's
> >possible to split a big sequential program in a variety of concurrent
> >logical
> >programs with a big win for code revisions and new implementation.
>
>         I'm not advising eliminating the threads approach. I'm only 
> advising not
>using threads as your abstraction for clients or work to be done. Use threads
>as the execution vehicles that pick up work when there's work to be done.
>(Think thread pools, think separating I/O from computation.)

Yes! This is what I want!

>[snip]
> >You are right! But depend by the application! If you have todo I/O like
> >signal acquisition,
> >sensors acquisitions and so on, you must have a one thread for each type of
> >data acquisition,
>
>         Even if that's true, and it's often not, how many different types 
> of data
>acquisition can you have? Ten? Twenty? That's a far cry from 300.

Currently are 190! Always active are ~110! So thinking by separating I/O from
the computation we double the threads.

Roberto Fichera.

