Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTE3O6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTE3O6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:58:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53641 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263729AbTE3O57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:57:59 -0400
Date: Fri, 30 May 2003 11:12:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Werner Almesberger <wa@almesberger.net>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Carl Spalletta <cspalletta@yahoo.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Dan Carpenter <d_carpenter@sbcglobal.net>
Subject: Re: inventing the wheel?
In-Reply-To: <20030530113009.A1667@almesberger.net>
Message-ID: <Pine.LNX.4.53.0305301111160.30122@chaos>
References: <20030527180546.15656.qmail@web41501.mail.yahoo.com>
 <3ED3E224.1000402@gmx.net> <20030530113009.A1667@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Werner Almesberger wrote:

> Carl-Daniel Hailfinger wrote:
> > Now we only need one additional tool to *prove* correctness of the
> > kernel ;-)
>
> Perhaps another interesting approach for such source code analyzers
> would be to take a top-down view, i.e. assume a certain functional
> structure, and check that all the elements are there and in the
> right order.
>
> This should be feasible for code that basically follows a certain
> template, e.g. network card drivers.
>
> This would also help with the update problem of "fill in the blanks"
> type of templates, i.e. if the template changes or is augmented,
> some drivers using it may no longer conform to it.
>
> Such a top-down view could be layered on top of a bottom-up analyzer,
> e.g. by - manually or automatically - translating some "skeleton"
> into a set of rules of the type "if you've called X, you must later
> call Y", etc.
>
> - Werner


The problem with 'correctness" is in the definition
of 'correct'. In many cases there are hundreds of
methods that can be used to implement a particular
software algorithm. Ultimately, it will come down
to how the implementor "wants" to code it, rather than
how it "should" be coded.

Which of the following are "correct"?

     for(i=0; i< NR; i++)
         do_domething();

     i = NR;
     while(i--)
        do_something();

Since 'i' is only used as a counter, it doesn't matter
if the count is up or down. There are some that would
argue that down-counting is 'better' because the setting
of a 'zero' flag on some CPU happens without additional
code if one decrements to zero. However, that depends
upon the implementation and upon the 'C' compiler itself.
There is no guarantee that the 'C' compiler will create
any particular code sequence, only that the logic and the
mathematics will correspond to the rules defined by the
standards.

FYI, using egcs-2.91.66 both methods produce code that is
larger and has more jumps than code written like:

         i = NR;
         again: if(!i) goto quit;
         i--;
         do_something();
         goto again;
         quit:;

It is unlikely that code such as this would be allowed in
software that can be reviewed by others. Goto freaks would
be committing crimes against humanity and civilization,
as we know it now, would cease to exist.

So, we are left with the correctness definition problem
that seems unsolvable.

One can, however, create an analysis engine that determines
compliance with certain rules and, or, certain templates.
For instance, a 'kernel-aware' kind of 'lint', one that
can follow in-line assembly and review all possible code-
paths through a kernel just might find deadlock situations,
and memory leaks, using an automated mechanism. However,
such a mechanism will still not verify, or even evaluate
'correctness'.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

