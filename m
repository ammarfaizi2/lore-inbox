Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbRF0JTH>; Wed, 27 Jun 2001 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbRF0JSs>; Wed, 27 Jun 2001 05:18:48 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:14864 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S265222AbRF0JSh>;
	Wed, 27 Jun 2001 05:18:37 -0400
Date: Wed, 27 Jun 2001 11:18:28 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Message-ID: <20010627111827.A22744@pcep-jamie.cern.ch>
In-Reply-To: <3B38860D.8E07353D@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B38860D.8E07353D@kegel.com>; from dank@kegel.com on Tue, Jun 26, 2001 at 05:54:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
>        That signal is no longer delivered normally or available for
>        pickup with sigwait() et al.  Instead, it must be picked up by
>        calling read() on the file descriptor returned by sigwait();
>        the buffer passed to read() must have a size which is a
>        multiple of sizeof(siginfo_t).

Does this mean that the read() call must write sizeof(siginfo_t) bytes
for each signal delivered?

At the moment, the kernel does not have to write the whole siginfo_t
structure to userspace -- it can write just those fields which are
relevant for a particular signal.

>        A signal number cannot be opened more than once concurrently;
>        sigopen() thus provides a way to avoid signal usage clashes in
>        large programs.

sigopen() won't prevent signal usage clashes if the other user is using
sigaction() and sigtimedwait(), or will it?

Btw, this functionality is already available using sigaction().  Just
search for a signal whose handler is SIG_DFL.  If you then block that
signal before changing, checking the result, and unblocking the signal,
you can avoid race conditions too.  (This is what my programs do).

-- Jamie
