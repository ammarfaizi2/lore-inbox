Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbRDZELl>; Thu, 26 Apr 2001 00:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133091AbRDZELb>; Thu, 26 Apr 2001 00:11:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30744 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133088AbRDZEL1>; Thu, 26 Apr 2001 00:11:27 -0400
Date: Thu, 26 Apr 2001 06:11:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <rsmcelrath@students.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: it isn't aa's rwsem-generic-6 bug but something else [Re: aa's rwsem-generic-6 bug?  Process stuck in 'R' state.]
Message-ID: <20010426061110.A819@athlon.random>
In-Reply-To: <20010425223939.A26763@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010425223939.A26763@draal.physics.wisc.edu>; from rsmcelrath@students.wisc.edu on Wed, Apr 25, 2001 at 10:39:39PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 10:39:39PM -0500, Bob McElrath wrote:
> Running 2.4.4pre4 with Andrea's rwsem-generic-6 patch, I have just
> gotten a process stuck in the 'R' state.  According to the ps man page
> this is: "runnable (on run queue)".  The 'ps aux' output is:
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root      7921  0.8 26.9 91720 68608 ?       R<   00:33  11:20 /usr/X11R6/bin/X
> 
> X is niced at -10 and doesn't respond to kill or kill -9.
> 
> alpha 21164 (ev56) architecture.  kernel compiled with:
> gcc version 2.96 20000731 (Red Hat Linux 7.0)

The fact X is also part of the equation makes things even less obvious
(now we're not even sure it's a kernel bug).

generic-rwsem-6 is a very trivial implementation and I'm pretty sure it
is the _last_ thing that could go wrong in your equation. I mean if it
goes wrong then it's more likely to be a bug in the spinlocks or
whatever in the architectural part of the kernel than in the common code
(rwsem-generic-6 was all common code btw).

Furthmore the X server shouldn't really be such an heavy user of the
rwsemaphores, as first it's not even threaded.

You can also press SYSRQ+P and get some EIP so we see a bit more what's
going on with the X server (assuming such cpu still receives interrupt).

BTW, could you also try to compile with egcs 1.1.2 just in case? I
learnt the hard way that for the alpha gcc 2.95.* isn't going to work
well (I didn't tried official 95.3 exactly yet, but certainly an older .3
from the 2_95-branch of gcc cvs definitely miscompiled all my 2.4
kernels, 2.96 with some houndred of patches [literally] is certainly
better than 2.95.* on the alpha but egcs is definitely still worth a
try) (personally I'm using egcs 1.1.2 for the 2.[24] alpha kernels and
2.95.4 (2_95-branch of cvs) for the 2.[24] x86 kernels [and gcc 3.1 for
x86-64 ;])

Andrea
