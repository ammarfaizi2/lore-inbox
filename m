Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135569AbRDXMUN>; Tue, 24 Apr 2001 08:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135572AbRDXMTx>; Tue, 24 Apr 2001 08:19:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38502 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135569AbRDXMTm>; Tue, 24 Apr 2001 08:19:42 -0400
Date: Tue, 24 Apr 2001 14:19:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424141928.C8253@athlon.random>
In-Reply-To: <20010424121747.A1682@athlon.random> <6252.988108393@warthog.cambridge.redhat.com> <20010424124621.D1682@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010424124621.D1682@athlon.random>; from andrea@suse.de on Tue, Apr 24, 2001 at 12:46:21PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in both the C version and asm version of my rwsem
and it is the slow path where I forgotten to drop the _irq part
from the spinlock calls ;) Silly bug. (I inherit it also in the
asm fast path version because I started hacking the same C slow path)

I catched it now because it locks hard my alpha as soon as I play with
any rwsem testcase, not sure why x86 is apparently immune by the hard lockup.

then I also added your trick of returning the semaphore so I can declare "a"
(sem) as read only (that is an improvement for the fast path).

Because of that changes I rerun all the benchmarks. I finished now to
re-benchmark the asm version as it runs even faster than before in the write
contention, the other numbers are basically unchanged. the read down fast path
now runs exactly like yours (so yes it seems the "+a" was giving a no sensical
improvement to my code for the down read fast path).

Of course my down write fast path remains significantly faster than yours and that
really make sense because my smarter algorithm allows me to avoid all your
cmpxchg stuff.

I'm starting the benchmarks of the C version and I will post a number update
and a new patch in a few minutes.

If you can ship me the testcase (also theorical) that breaks my algorihtm in the
next few minutes that would help.

Andrea
