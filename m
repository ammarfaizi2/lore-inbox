Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQJ0PVI>; Fri, 27 Oct 2000 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbQJ0PU7>; Fri, 27 Oct 2000 11:20:59 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:28427 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129408AbQJ0PUv>;
	Fri, 27 Oct 2000 11:20:51 -0400
Date: Fri, 27 Oct 2000 17:20:06 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alfred Perlstein <bright@wintelcom.net>
Cc: David Schwartz <davids@webmaster.com>,
        Jonathan Lemon <jlemon@flugsvamp.com>, chat@FreeBSD.ORG,
        linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001027172006.A28504@pcep-jamie.cern.ch>
In-Reply-To: <20001025172702.B89038@prism.flugsvamp.com> <NCBBLIEPOCNJOAEKBEAKCEOPLHAA.davids@webmaster.com> <20001025161837.D28123@fw.wintelcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001025161837.D28123@fw.wintelcom.net>; from bright@wintelcom.net on Wed, Oct 25, 2000 at 04:18:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alfred Perlstein wrote:
> > If a programmer does not ever wish to block under any circumstances, it's
> > his obligation to communicate this desire to the implementation. Otherwise,
> > the implementation can block if it doesn't have data or an error available
> > at the instant 'read' is called, regardless of what it may have known or
> > done in the past.
> 
> Yes, and as you mentioned, it was _bugs_ in the operating system
> that did this.

Not for writes.  POLLOUT may be returned when the kernel thinks you have
enough memory to do a write, but someone else may allocate memory before
you call write().  Or does POLLOUT not work this way?

For read, you still want to declare the sockets non-blocking so your
code is robust on _other_ operating systems.  It's pretty straightforward.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
