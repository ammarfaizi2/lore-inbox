Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSFQISD>; Mon, 17 Jun 2002 04:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSFQISD>; Mon, 17 Jun 2002 04:18:03 -0400
Received: from isolaweb.it ([213.82.132.2]:28679 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S316838AbSFQISC>;
	Mon, 17 Jun 2002 04:18:02 -0400
Message-Id: <5.1.1.6.0.20020617094803.00a96bd0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 17 Jun 2002 10:17:52 +0200
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Developing multi-threading applications
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020615123016.M22429@nightmaster.csn.tu-chemnitz.de>
References: <5.1.1.6.0.20020615104206.05291720@mail.tekno-soft.it>
 <5.1.1.6.0.20020613171707.03f09720@mail.tekno-soft.it>
 <20020614205601.AAA9369@shell.webmaster.com@whenever>
 <5.1.1.6.0.20020615104206.05291720@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12.30 15/06/02 +0200, Ingo Oeser wrote:

>On Sat, Jun 15, 2002 at 11:01:44AM +0200, Roberto Fichera wrote:
> > >         Even if that's true, and it's often not, how many different 
> types
> > > of data
> > >acquisition can you have? Ten? Twenty? That's a far cry from 300.
> >
> > Currently are 190! Always active are ~110! So thinking by separating 
> I/O from
> > the computation we double the threads.
>
>So basically you are just traversing your data depedency graph
>wrongly. Do a level order traversion if it is a dependency forest
>or an breadth first traversion if not.

Ok! I've semplified too much ;-)!

>If this node require IO -> schedule the IO and return back to the upper
>level noticing it, that you like to be woken, if the IO is
>finished.
>
>If this node require Computation -> do it, if this CPU is the one with
>lowest load, else schedule it for the CPU with lowest load.

How can I do it ? Shouldn't be a kernel problem ? I could collect
a various patch around that implement a CPU process bind/affinity and
CPU load balance but how can I determine which CPU have the lowest
load in a given time ?

>Continue with next node.
>
>(load is meant "number of compuations with same metric scheduled
>on this thread")
>
>Use only one thread per CPU. Try to make the IO-Waiting as unique
>as possible (poll would be perfect).

This could be implemented by the process affinity to bind the
process to a CPU. But I continue to not hunderstand why
I must have only one thread per CPU. There is some URL
where can I see some kernel/sched/vm/I-O/other-think graph about
this point ?


>So this is all doable, once you analyze your data dependency
>graph properly and make the simulation data driven (which it
>usally is).
>
>Regards
>
>Ingo Oeser
>--
>Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

Roberto Fichera.

