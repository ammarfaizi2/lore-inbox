Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286454AbSAEXlw>; Sat, 5 Jan 2002 18:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286422AbSAEXld>; Sat, 5 Jan 2002 18:41:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:520 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286454AbSAEXl2>; Sat, 5 Jan 2002 18:41:28 -0500
Date: Sat, 5 Jan 2002 15:46:14 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <E16N0RW-0001We-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201051540010.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Alan Cox wrote:

> > > In fact it's the cr3 switch (movl %0, %%cr3) that accounts for about 30%
> > > of the context switch cost. On x86. On other architectures it's often
> > > much, much cheaper.
> >
> > TLB flushes are expensive everywhere, and you know exactly this and if you
>
> Not every processor is dumb enough to have TLB flush on a context switch.
> If you have tags on your tlb/caches it's not a problem.

Yep true, 20% of CPUs are dumb but this 20% of CPUs run 95% of the Linux world.



> > Again, the history of our UP scheduler thought us that noone has been able
> > to makes it suffer with realistic/high not-stupid-benchamrks loads.
>
> Apache under load, DB2, Postgresql, Lotus domino all show bad behaviour.
> (Whether apache, db2, and postgresql want fixing differently is a seperate
>  argument)

Alan, near to my box i've a dual cpu appliance that is running an mta that
uses pthread and that is routing ( under test ) about 600000 messages / hour
Its rq load is about 9-10 and the cs is about 8000-9000.
You know what is the scheduler weight, barely 8-10% with the the 2.4.17
scheduler. It drops to nothing using BMQS w/out any O(1) mirage.




- Davide



