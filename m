Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265486AbRF1Cuv>; Wed, 27 Jun 2001 22:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265485AbRF1Cul>; Wed, 27 Jun 2001 22:50:41 -0400
Received: from alumnus.caltech.edu ([131.215.50.236]:5857 "EHLO
	alumnus.caltech.edu") by vger.kernel.org with ESMTP
	id <S265486AbRF1Cu3>; Wed, 27 Jun 2001 22:50:29 -0400
Date: Wed, 27 Jun 2001 19:49:19 -0700 (PDT)
From: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Message-Id: <200106280249.TAA06507@alumnus.caltech.edu>
To: balbir.singh@wipro.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir.singh@wipro.com> wrote:

>Shouldn't there be a sigclose() and other operations to make the API
>orthogonal.

No, plain old close() on the file descriptor returned by sigopen()
would do the trick.

>sigopen() should be selective about the signals it allows
>as argument. Try and make sigopen() thread specific, so that if one
>thread does a sigopen(), it does not imply it will do all the signal
>handling for all the threads.

IMHO sigopen()/read() should behave just like sigwait() with respect 
to threads.  That means that in Posix, it would not be thread specific,
but in Linux, it would be thread specific, because that's how signals
and threads work there at the moment.

>Does using sigopen() imply that signal(), sigaction(), etc cannot be used.
>In the same process one could do a sigopen() in the library, but the
>process could use sigaction()/signal() without knowing what the library
>does (which signals it handles, etc).

Between sigopen() and close(), calling signal() or sigaction() on that 
signal would probably return EBUSY.   A well-behaved program already
looks for an unoccupied signal using sigaction (as Jamie Lokier
points out), so they shouldn't try to reuse a signal in use by sigopen().

- Dan

