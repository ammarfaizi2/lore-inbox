Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSITQLW>; Fri, 20 Sep 2002 12:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbSITQLW>; Fri, 20 Sep 2002 12:11:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2137 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262804AbSITQLV>; Fri, 20 Sep 2002 12:11:21 -0400
Date: Fri, 20 Sep 2002 12:15:25 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920121525.A21220@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <3D8A6EC1.1010809@redhat.com> <Pine.LNX.3.96.1020920110940.29079A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020920110940.29079A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Fri, Sep 20, 2002 at 11:43:15AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 11:43:15AM -0400, Bill Davidsen wrote:
> > Unless major flaws in the design are found this code is intended to
> > become the standard POSIX thread library on Linux system and it will
> > be included in the GNU C library distribution.
> 
> If the comment that this doesn't work with the stable kernel is correct, I
> consider that a pretty major flaw. Unlike the kernel and NGPT which are
> developed using an open source model with lots of eyes on the WIP, this
> was done and then released whole with the decision to include it in the
> standard library already made. Having any part of glibc not work with the
> current stable kernel doesn't seem like such a hot idea, honestly.

glibc supports .note.ABI-tag notes for libraries, so there is no problem
with having NPTL libpthread.so.0 --enable-kernel=2.5.36 in say
/lib/i686/libpthread.so.0 and linuxthreads --enable-kernel=2.2.1 in
/lib/libpthread.so.0. The dynamic linker will then choose based
on currently running kernel.
(well, ATM because of libc tsd DL_ERROR --without-tls ld.so cannot be used
with --with-tls libs and vice versa, but that is beeing worked on).

That's similar to non-FLOATING_STACK and FLOATING_STACK linuxthreads,
the latter can be used with 2.4.8+ or something kernels on IA-32.

> > - - The general compiler requirement for glibc is at least gcc 3.2.  For
> >    the new thread code it is even necessary to have working support for
> >    the __thread keyword.
> > 
> >    Similarly, binutils with functioning TLS support are needed.
> > 
> >    The (Null) beta release of the upcoming Red Hat Linux product is
> >    known to have the necessary tools available after updating from the
> >    latest binaries on the FTP site.  This is no ploy to force everybody
> >    to use Red Hat Linux, it's just the only environment known to date
> >    which works.
> 
> Of course not, it's coincidence that only Redhat has these things readily
> available, perhaps because this was developed where no other vendor knew
> it existed and could have support ready for it.

Because all of glibc/gcc/binutils TLS support was developed together (and
still is)? All the changes are publicly available, mostly in the
corresponding CVS archives.

	Jakub
