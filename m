Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264781AbRFSU5a>; Tue, 19 Jun 2001 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbRFSU5U>; Tue, 19 Jun 2001 16:57:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1664 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264781AbRFSU5H>;
	Tue, 19 Jun 2001 16:57:07 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15151.48287.782428.953466@pizda.ninka.net>
Date: Tue, 19 Jun 2001 13:57:03 -0700 (PDT)
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <p05100302b7553d481172@[10.128.7.49]>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca>
	<3B2F769C.DCDB790E@kegel.com>
	<20010619090956.R3089@work.bitmover.com>
	<p05100302b7553d481172@[10.128.7.49]>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Lundell writes:
 > Sun (or at least SPARC) is a bit of a special case, though. SPARC's 
 > register-window architecture makes thread-switching (not to mention 
 > recursion) significantly more expensive than on most other 
 > architectures.

The register window flush is a relatively constant cost with a fixed
upper bound, regardless of whether you are switching threads or
processes, the process is the same.

This cost is honestly lost in the noise during a context switch.  The
trap entry/exit in and out of userspace usually costs more cycles than
the window flush at schedule() time.

The worst case whole window flush to the stack can fit (several times
over) in the store cache of UltraSPARC-III.

So my basic point is that I don't want people to read what you said
and believe "oh then the difference between threads vs. different
processes under Solaris is due to Sparc hw architecture reasons
instead of sw reasons" which simply isn't true.

<axe_grind>
Solaris just simply bites it at context switching threads in the
kernel.
</axe_grind>

The same identical code flushes the register windows for processes and
threads under Linux, and there is no reason this should not be the
case.

<axe_grind>

Don't believe me that Solaris sucks here?  Run this experiment under
Solaris-latest and Linux on a sparc64 system (using lmbench):

Under Solaris: ./lat_proc fork
Under Linux: strace -f ./lat_proc fork

I bet the Linux case does better than the Solaris run by some orders
of magnitude.  That's how poor their fork/exit/switch code is.

</axe_grind>

Later,
David S. Miller
davem@redhat.com

