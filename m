Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129077AbQKFOOH>; Mon, 6 Nov 2000 09:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbQKFON5>; Mon, 6 Nov 2000 09:13:57 -0500
Received: from neuron.moberg.com ([209.152.208.195]:6406 "EHLO
	neuron.moberg.com") by vger.kernel.org with ESMTP
	id <S129077AbQKFONj>; Mon, 6 Nov 2000 09:13:39 -0500
Date: Mon, 6 Nov 2000 09:13:25 -0500 (EST)
From: George Talbot <george@brain.moberg.com>
To: Marc Lehmann <pcg@goof.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a
 user-land  programmer...
In-Reply-To: <20001105042410.C3961@fuji.laendle>
Message-ID: <Pine.LNX.4.21.0011060906280.4984-100000@brain.moberg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I respectfully disagree that programs which don't surround some of the
most common system calls with

	do
	{
		rv = __some_system_call__(...);
	} while (rv == -1 && errno == EINTR);

are broken.  Especially if those programs don't use signals.  The problem
that I'm raising is that the default behavior of returning EINTR from
system calls is, in my opinion, an application reliabilty problem.  The
specific problem I'm having is that glibc uses signals to implement
multiple threads, and because of the EINTR behavior, expose multithreaded
programs to this behavior that weren't necessarily written to use signals.

It's a useability and portability issue, especially considering that I
might be using pthreads so that I can avoid signal handling entirely.  I
might want to do this because I want to be portable to non-UNIX systems
that implement the pthreads API.

I _was_not_ too lazy to read the documentation, though I don't have a copy
of POSIX.

Does POSIX require that pthreads programs be signal-aware in the EINTR
sense?  Could this be considered a bug?

--
George T. Talbot
<george@moberg.com>




On Sun, 5 Nov 2000, Marc Lehmann wrote:

> On Fri, Nov 03, 2000 at 02:49:37PM -0500, george@moberg.com wrote:
> > After reading about SA_RESTART, ok.  However, couldn't those
> > applications that require it enable this behaviour explicitly?
> 
> No, broken applications that require specific bsd behaviour should just be
> compiled with -D_BSD_SOURCE. If you need newer features then be prepared
> to fix the program.
> 
> > The problem I'm having right now is with pthread_create() failing
> > because deep somewhere in either the kernel or glibc, nanosleep()
> > returns EINTR during said pthread_create() and pthread_create() fails.
> 
> This has hardly something to do with the signal reliability issue, unless
> you compiled your own threads library. You might want to file a bug report
> for libpthread otherwise.
> 
> > I don't mean to sound like a psycho on this, but I can't see why
> > SA_RESTART isn't the default behavior. Maybe I'm missing something
> > somewhere.
> 
> Yes, you are missing signal(2) or the glibc info file, so the real
> question is: why were you too lazy to read the documentation???
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
