Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRGIUBq>; Mon, 9 Jul 2001 16:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbRGIUBg>; Mon, 9 Jul 2001 16:01:36 -0400
Received: from maus.spack.org ([204.245.198.90]:39943 "EHLO maus.spack.org")
	by vger.kernel.org with ESMTP id <S261651AbRGIUBS>;
	Mon, 9 Jul 2001 16:01:18 -0400
Date: Mon, 9 Jul 2001 13:01:17 -0700 (PDT)
From: Adam Shand <larry@spack.org>
To: <linux-kernel@vger.kernel.org>
Subject: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>
X-PGP-Key: http://www.spack.org/~larry/gnupgkey.html
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where I just started work we run large processes for simulations and
testing of semi-conductors.  Currently we use Solaris because of past
limitations on the amount of RAM that a single process can address under
Linux.  Recently we tried to run some tests on a Dell dual Xeon 1.7GHz
with 4GB of RAM running Redhat 7.1 box (with the stock Redhat SMP kernel).
Speedwise it kicked the crap out of our Sunblade (Dual 750MHz with 8GB of
RAM)but we had problems with process dying right around 2.3GB (according
to top).

So I started to investigate, and quickly discovered that there is no good
source for finding this sort of information on line.  At least not that I
could find.  Nearly every piece of information I found conflicted in at
least some small way with another piece of information I found.
So I ask here in the hopes of a definitive answer.

 * What is the maximum amount of RAM that a *single* process can address
   under a 2.4 kernel, with PAE enabled?  Without?

 * And, what (if any) paramaters can effect this (recompiling the app
   etc)?

What I think I know so far is listed below.  I welcome being flamed, told
that I'm stupid and that I should have looked "here" so long as said
messages also contain pointers to definitive information :-)

Linux 2.4 does support greater then 4GB of RAM with these caveats ...

 * It does this by supporting Intel's PAE (Physical Address Extension)
   features which are in all Pentium Pro and newer CPU's.
 * The PAE extensions allow up to a maximum of 64GB of RAM that the OS
   (not a process) can address.
 * It does this via indirect pointers to the higher memory locations, so
   there is a CPU and RAM hit for using this.
 * Benchmarks seem to indicated around 3-6% CPU hit just for using the PAE
   extensions (ie. it applies regardless of whether you are actually
   accessing memory locations greater then 4GB).
 * If the kernel is compiled to use PAE, Linux will not boot on a computer
   whose hardware doesn't support PAE.
 * PAE does not increase Linux's ability for *single* processes to see
   greater then 3GB of RAM (see below).

So what are the limits without using PAE? Here I'm still having a little
problem finding definitive answers but ...

 * With PAE compiled into the kernel the OS can address a maximum of 4GB
   of RAM.
 * With 2.4 kernels (with a large memory configuration) a single process
   can address up to the total amount of RAM in the machine minus 1GB
   (reserved for the kernel), to a maximum 3GB.
 * By default the kernel reserves 1GB for it's own use, however I think
   that this is a tunable parameter so if we have 4GB of RAM in a box we
   can tune it so that most of that should be available to the processes
   (?).

I have documented the below information on my web site, and will post
whatever answers I recieve there:

	http://www.spack.org/index.cgi/LinuxRamLimits

Thanks,
Adam.




