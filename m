Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbQJ0BrO>; Thu, 26 Oct 2000 21:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQJ0BrG>; Thu, 26 Oct 2000 21:47:06 -0400
Received: from ns1.wintelcom.net ([209.1.153.20]:54794 "EHLO fw.wintelcom.net")
	by vger.kernel.org with ESMTP id <S130621AbQJ0Bq4>;
	Thu, 26 Oct 2000 21:46:56 -0400
Date: Thu, 26 Oct 2000 18:46:49 -0700
From: Alfred Perlstein <bright@wintelcom.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, Gideon Glass <gid@cisco.com>,
        Simon Kirby <sim@stormix.com>, Dan Kegel <dank@alumni.caltech.edu>,
        chat@FreeBSD.ORG, linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001026184649.U28123@fw.wintelcom.net>
In-Reply-To: <20001026201042.A38500@prism.flugsvamp.com> <E13oyOE-00044z-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E13oyOE-00044z-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 27, 2000 at 02:32:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [001026 18:33] wrote:
> > the application of a close event.  What can I say, "the fd formerly known
> > as X" is now gone?  It would be incorrect to say that "fd X was closed",
> > since X no longer refers to anything, and the application may have reused
> > that fd for another file.
> 
> Which is precisely why you need to know where in the chain of events this
> happened. Otherwise if I see
> 
> 	'read on fd 5'
> 	'read on fd 5'
> 
> How do I know which read is for which fd in the multithreaded case

No you don't, you don't see anything with the current code unless
fd 5 is still around, what you're presenting to Jonathan is a
application threading problem, not something that need to be
resolved by the OS.

> > As for the multi-thread case, this would be a bug; if one thread closes
> > the descriptor, the other thread is going to get an EBADF when it goes 
> > to perform the read.
> 
> Another thread may already have reused the fd

This is another example of an application threading problem.

-- 
-Alfred Perlstein - [bright@wintelcom.net|alfred@freebsd.org]
"I have the heart of a child; I keep it in a jar on my desk."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
