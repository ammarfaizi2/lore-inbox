Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290109AbSAORjh>; Tue, 15 Jan 2002 12:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSAORj2>; Tue, 15 Jan 2002 12:39:28 -0500
Received: from [66.89.142.2] ([66.89.142.2]:60462 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S290109AbSAORjO>;
	Tue, 15 Jan 2002 12:39:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update: preemptive kernel for O(1) sched
Date: Tue, 15 Jan 2002 15:58:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: kpreempt-tech@lists.sourceforge.net
In-Reply-To: <1010961108.814.12.camel@phantasy> <1010982884.1527.52.camel@phantasy>
In-Reply-To: <1010982884.1527.52.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QXbx-0000wW-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 05:34 am, Robert Love wrote:
> A version of preempt-stats for the 2.5 series kernel is available at:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-stats
> 
> and your favorite mirror.  Patches for 2.4 are available, too.
> 
> This patch, used on top of preempt-kernel, allows the measuring of
> periods of non-preemptible so that we can identify long-held locks.  The
> patch creates a proc entry, latencytimes, which contains the top 20
> worst-case recorded periods since it was last read.  To begin recording,
> read the file once.  Subsequent reads will return the results. I.e.,

Nice, but you need a way to turn it off, for example:

   echo >/proc/latencytimes

i.e., truncate.

> [23:25:08]rml@langston:~$ cat /proc/latencytimes 
> Worst 20 latency times of 277 measured in this period.
>   usec      cause     mask   start line/file      address   end line/file
>   9982  spin_lock        0   488/sched.c         c0117ee2   645/irq.c
>    968        BKL        0   666/tty_io.c        c0193d58   645/irq.c
>    430  spin_lock        0    69/i387.c          c010f34f    96/mmx.c
>    103       ide0        0   583/irq.c           c010ab1c   645/irq.c
>    100        BKL        0  2562/buffer.c        c014abda  2565/buffer.c
>     54        BKL        0   702/tty_io.c        c019406b   704/tty_io.c
> ... etc

A more typical form for the file/line would be, e.g., irq.c:645

> The goal would be to identity the problem areas and fix them.

Yep, sorry about the nits but that's the way we nitbots are programmed.

--
Daniel

