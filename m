Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262775AbSITPpc>; Fri, 20 Sep 2002 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSITPpb>; Fri, 20 Sep 2002 11:45:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8467 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262775AbSITPpa>; Fri, 20 Sep 2002 11:45:30 -0400
Date: Fri, 20 Sep 2002 11:43:15 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <3D8A6EC1.1010809@redhat.com>
Message-ID: <Pine.LNX.3.96.1020920110940.29079A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Ulrich Drepper wrote:

> We are pleased to announce the first publically available source
> release of a new POSIX thread library for Linux.  As part of the
> continuous effort to improve Linux's capabilities as a client, server,
> and computing platform Red Hat sponsored the development of this
> completely new implementation of a POSIX thread library, called Native
> POSIX Thread Library, NPTL.
> 
> Unless major flaws in the design are found this code is intended to
> become the standard POSIX thread library on Linux system and it will
> be included in the GNU C library distribution.

If the comment that this doesn't work with the stable kernel is correct, I
consider that a pretty major flaw. Unlike the kernel and NGPT which are
developed using an open source model with lots of eyes on the WIP, this
was done and then released whole with the decision to include it in the
standard library already made. Having any part of glibc not work with the
current stable kernel doesn't seem like such a hot idea, honestly.
 
> The work visible here is the result of close collaboration of kernel
> and runtime developers.  The collaboration proceeded by developing the
> kernel changes while writing the appropriate parts of the thread
> library.  Whenever something couldn't be implemented optimally some
> interface was changed to eliminate the issue.  The result is this
> thread library which is, unlike previous attempts, a very thin layer
> on top of the kernel.  This helps to achieve a maximum of performance
> for a minimal price.

>    Initial confirmations were test runs with huge numbers of threads.
>    Even on IA-32 with its limited address space and memory handling
>    running 100,000 concurrent threads was no problem at all, creating
>    and destroying the threads did not take more than two seconds.  This
>    all was made possible by the kernel work performed as part of this
>    project.

Is there a performance comparison with current pthreads and NGPT and more
typical levels of 5-10k threads as seen on news/mail/dns/web servers?
Eliminating overhead is good, but in most cases there just isn't all that
much overhead in NGPT. I haven't measured Linux threads, but there are a
lot of bad urban legends about them ;-)

> Building glibc with the new thread library is demanding on the
> compilation environment.
> 
> - - The 2.5.36 kernel or above must be installed and used.  To compile
>    glibc it is necessary to create the symbolic link
> 
>       /lib/modules/$(uname -r)/build
> 
>    to point to the build directory.
> 
> - - The general compiler requirement for glibc is at least gcc 3.2.  For
>    the new thread code it is even necessary to have working support for
>    the __thread keyword.
> 
>    Similarly, binutils with functioning TLS support are needed.
> 
>    The (Null) beta release of the upcoming Red Hat Linux product is
>    known to have the necessary tools available after updating from the
>    latest binaries on the FTP site.  This is no ploy to force everybody
>    to use Red Hat Linux, it's just the only environment known to date
>    which works.

Of course not, it's coincidence that only Redhat has these things readily
available, perhaps because this was developed where no other vendor knew
it existed and could have support ready for it.

Modulo my comments on not putting things in libraries which don't widely
work, this souncds as if it is less complex and hopefully more stable (not
that NGPT isn't) and lower maintenence. I'd love to see comparisons of the
three libraries under some typical load, how about a Redhat DNS server
running threaded bind? Run a day with each library and look at response
time, load average, and of course stability.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

