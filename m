Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288744AbSANEcB>; Sun, 13 Jan 2002 23:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288742AbSANEbu>; Sun, 13 Jan 2002 23:31:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:60690 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288733AbSANEbg>;
	Sun, 13 Jan 2002 23:31:36 -0500
Subject: Re: [PATCH] update: preemptive kernel for O(1) sched
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
In-Reply-To: <1010961108.814.12.camel@phantasy>
In-Reply-To: <1010961108.814.12.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 23:34:43 -0500
Message-Id: <1010982884.1527.52.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A version of preempt-stats for the 2.5 series kernel is available at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-stats

and your favorite mirror.  Patches for 2.4 are available, too.

This patch, used on top of preempt-kernel, allows the measuring of
periods of non-preemptible so that we can identify long-held locks.  The
patch creates a proc entry, latencytimes, which contains the top 20
worst-case recorded periods since it was last read.  To begin recording,
read the file once.  Subsequent reads will return the results. I.e.,

[23:25:08]rml@langston:~$ cat /proc/latencytimes 
Worst 20 latency times of 277 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  9982  spin_lock        0   488/sched.c         c0117ee2   645/irq.c
   968        BKL        0   666/tty_io.c        c0193d58   645/irq.c
   430  spin_lock        0    69/i387.c          c010f34f    96/mmx.c
   103       ide0        0   583/irq.c           c010ab1c   645/irq.c
   100        BKL        0  2562/buffer.c        c014abda  2565/buffer.c
    54        BKL        0   702/tty_io.c        c019406b   704/tty_io.c
... etc

The goal would be to identity the problem areas and fix them.

	Robert Love


