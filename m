Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310693AbSCHGQL>; Fri, 8 Mar 2002 01:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310694AbSCHGQB>; Fri, 8 Mar 2002 01:16:01 -0500
Received: from server.divms.uiowa.edu ([128.255.44.21]:39402 "EHLO
	server.divms.uiowa.edu") by vger.kernel.org with ESMTP
	id <S310693AbSCHGP4>; Fri, 8 Mar 2002 01:15:56 -0500
From: Doug Siebert <dsiebert@divms.uiowa.edu>
Message-Id: <200203080615.g286Fqh24770@server.divms.uiowa.edu>
Subject: Fast Userspace Mutexes (futex) vs. msem_*
To: linux-kernel@vger.kernel.org
Date: Fri, 8 Mar 2002 00:15:52 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a long-time lurker in linux-kernel, but the discussion about fast
userspace mutexes ("futexes") has piqued my interest.  I made great
use of the msem_* (msem_init, msem_lock, msem_unlock) functions on HP-UX
in the mid 90s (HP-UX 9.01 and on)  At the time, they were invaluable for
me, with 1000+ processes needing exclusive access to resources on a 50MHz
machine.  Requiring a system call for this purpose would have been a major
performance hit (remember HP-UX's system calls are not nearly so light
weight as Linux's)

The direction that the futex implementation is going is looking a lot like
how they are implemented on HP-UX (as well as Tru64 and AIX)  I am curious
though why the case of "what happens if the process holding the lock dies"
is considered unimportant by some people.  It wouldn't be all that much
more work to "do it right" (IMHO) and handle this case.  AFAIK, on HP-UX
the implementation kept a "locker id" and a linked list of waiters' lock
ids (to allow first come first served as well as handling the case of a
lock holder dying)  There was an underlying system call that was made when
the userspace part in libc found the lock already held and waiting for the
lock was desired.

If the implementation does move further towards the msem_* standard, it
might make sense to just implement it as defined, and provide source
compatibility with existing applications on HP-UX, AIX, and Tru64 that
use it.

I'm not subscribed (I skim the hypermail archives on zork a couple times
a week, so please cc: me on comments for a faster response)

-- 
Douglas Siebert
douglas-siebert@uiowa.edu
