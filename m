Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRLGT7I>; Fri, 7 Dec 2001 14:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285489AbRLGT65>; Fri, 7 Dec 2001 14:58:57 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:11668 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S284324AbRLGT6p>; Fri, 7 Dec 2001 14:58:45 -0500
Date: Fri, 7 Dec 2001 11:58:39 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: Allan Steel <allan@maths.usyd.edu.au>,
        Paul Sargent <Paul.Sargent@3dlabs.com>
Subject: Maximizing brk() space on stock ia32 Linux 2.4.x
Message-ID: <Pine.LNX.4.33.0112071128500.440-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Given the limitation of running under a stock ia32 Linux 2.4.x kernel
(e.g. TASK_UNMAPPED_BASE = 0x40000000 and __PAGE_OFFSET = 0xC0000000), how
can one write a program in a way to maximize the address space available
for brk()?  For example:

1) With static linking and glibc there is still one mmap() mapping that
looks like this: "40000000-40001000 rw-p 00000000 00:00 0".  Someone once
commented that this is a buffer for stdio.  If so, how would one modify
glibc to move it (MAP_FIXED) or get rid of it?  Or would it be possible to
use an alternative libc and sidestep this issue?

2) If dynamic linking is required, it seems that one needs to intercept
all mmap() calls, for example to insert addresses and MAP_FIXED.  This
seems a bit tricky, since the dynamic loader uses mmap(), so probably
LD_PRELOAD would not work.  What would be required for this?

3) Alternatively, it seems like it would be enough for a single, large
brk() to be executed early in the startup of the program, before any
mmap()'s.  Then the mmap()'s would automatically get placed higher in the
address space.  Where would one need to put this brk() call?  Would having
2-3 GB mapped but untouched have negative VM consequences?

4) Lastly, it seems that executables by default load at 0x08000000.  How 
does one build an executable that loads at a lower address, e.g. 
0x00002000?  How low is safe to go?

It seems that both (2) and (4) are possible, as Paul Sargent's email "2GB
process crashing on 2.4.14" shows the /proc/<pid>/maps of a (binary-only)
program that does them.

Thanks, Wayne




