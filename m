Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285554AbRLGVXT>; Fri, 7 Dec 2001 16:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285556AbRLGVXK>; Fri, 7 Dec 2001 16:23:10 -0500
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:7577 "HELO
	sanosuke.troilus.org") by vger.kernel.org with SMTP
	id <S285554AbRLGVW4>; Fri, 7 Dec 2001 16:22:56 -0500
To: Padraig Brady <padraig@antefacto.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
	<Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
	<20011207185847.A20876@wotan.suse.de>
	<87wuzyq4ms.fsf@sanosuke.troilus.org> <3C110C0B.4030102@antefacto.com>
From: Michael Poole <poole@troilus.org>
Date: 07 Dec 2001 16:22:55 -0500
In-Reply-To: <3C110C0B.4030102@antefacto.com>
Message-ID: <87snampvww.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady <padraig@antefacto.com> writes:

> This breaks for the case discussed @
> http://sources.redhat.com/ml/bug-glibc/2001-11/msg00079.html
> I.E. if you have a multithreaded lib being linked by
> single threaded apps (Note multithreaded lib, not just a
> threadsafe lib (I.E. the lib calls pthread_create())).

That's an interesting, but very contrived, example.  Can you find a
single multi-threaded lib that uses FILE*'s shared with the
application using it?

Linus's suggestion to add hooks to pthread_create() gets around that
problem, anyway.  Alternatively, the multi-threaded library could
require any application linking to it to define _REENTRANT.

After all, it's silly to talk about a 'multi-threaded' library linked
to a 'single-threaded' application -- the application plus any
libraries, as a whole, are either multithreaded or not.  They have to
be on the same page to deal with *any* locking issues.

-- Michael
