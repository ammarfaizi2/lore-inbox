Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276813AbRJCApQ>; Tue, 2 Oct 2001 20:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276814AbRJCApG>; Tue, 2 Oct 2001 20:45:06 -0400
Received: from nrg.org ([216.101.165.106]:20490 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S276813AbRJCAot>;
	Tue, 2 Oct 2001 20:44:49 -0400
Date: Tue, 2 Oct 2001 17:43:49 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: Robert Love <rml@ufl.edu>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Latency measurements
In-Reply-To: <9121494397.20011002150120@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.05.10110021735300.15078-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001, VDA wrote:
> >> These are the longest held locks on my system
> >> (PII 233 UP, 32MB RAM, SVGA 16bit color fb console, X)
> >> Kernel: 2.4.10 + ext3 + preemption
> >> I am very willing to test any patches to reduce latency.
> >> 
> >> 418253       BKL        1   712/tty_io.c        c01b41c5   714/tty_io.c
> >> 222609       BKL        1   712/tty_io.c        c01b41c5   697/sched.c   
> >> 152903 spin_lock        5   547/sched.c         c0114fd5   714/tty_io.c  
> >> 132422       BKL        5   712/tty_io.c        c01b41c5   714/tty_io.c  
> >> 104548       BKL        1   712/tty_io.c        c01b41c5  1380/sched.c


> >> 222609       BKL 1 712/tty_io.c  697/sched.c
> I don't quite understand how locked region can start in
> 712/tty_io.c and end in 697/sched.c?

The BKL is dropped whenever the task voluntarily blocks in the kernel.
This is what you are seeing reported here.  It will be reacquired when
the task is rescheduled:

> This is strange too:
> >> 152903 spin_lock 5 547/sched.c   714/tty_io.c
> spinlock? Unlocked by unlock_kernel()???

The latency measuring code isn't always accurate in reporting the cause
in this case: if it's unlocked by unlock_kernel and locked in sched.c,
then it's the reacqusition of the BKL by a task that was blocked while
holding the lock.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

