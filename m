Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSANPof>; Mon, 14 Jan 2002 10:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSANPoZ>; Mon, 14 Jan 2002 10:44:25 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10246 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286942AbSANPoS>; Mon, 14 Jan 2002 10:44:18 -0500
Date: Mon, 14 Jan 2002 07:50:07 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: cross-cpu balancing with the new scheduler
In-Reply-To: <3C42FBA7.B1084B4D@colorfullife.com>
Message-ID: <Pine.LNX.4.40.0201140749340.1486-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Manfred Spraul wrote:

> Davide Libenzi wrote:
> >
> > I've a very simple phrase when QA is bugging me with these corner cases :
> >
> > "As Designed"
> >
> > It's much much better than adding code and "Return To QA" :-)
> > I tried priority balancing in BMQS but i still prefer "As Designed" ...
> >
> Another test, now with 4 process (dual cpu):
> #nice -n 19 ./eatcpu&
> #nice -n 19 ./eatcpu&
> #./eatcpu&
> #nice -n -19 ./eatcpu&
>
> And the top output:
> <<<<<<
> 73 processes: 68 sleeping, 5 running, 0 zombie, 0 stopped
> CPU0 states: 100.0% user,  0.0% system, 100.0% nice,  0.0% idle
> CPU1 states: 98.0% user,  2.0% system, 33.0% nice,  0.0% idle
> [snip]
> PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>  1163 root      39  19   396  396   324 R N  99.5  0.1   0:28 eatcpu
>  1164 root      39  19   396  396   324 R N  33.1  0.1   0:11 eatcpu
>  1165 root      39   0   396  396   324 R    33.1  0.1   0:07 eatcpu
>  1166 root      39 -19   396  396   324 R <  31.3  0.1   0:06 eatcpu
>  1168 manfred    1   0   980  976   768 R     2.7  0.2   0:00 top
> [snip]
>
> The niced process still has it's own cpu, and the "nice -19" process has
> 33% of the second cpu.
>
> IMHO that's buggy. 4 running process, 1 on cpu0, 3 on cpu1.

Yes, a long run with 3:1 is no more "As Designed" :-)




- Davide


