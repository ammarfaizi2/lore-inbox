Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbQJ0QEZ>; Fri, 27 Oct 2000 12:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129262AbQJ0QEO>; Fri, 27 Oct 2000 12:04:14 -0400
Received: from ns1.wintelcom.net ([209.1.153.20]:63757 "EHLO fw.wintelcom.net")
	by vger.kernel.org with ESMTP id <S129212AbQJ0QEC>;
	Fri, 27 Oct 2000 12:04:02 -0400
Date: Fri, 27 Oct 2000 09:03:53 -0700
From: Alfred Perlstein <bright@wintelcom.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: David Schwartz <davids@webmaster.com>,
        Jonathan Lemon <jlemon@flugsvamp.com>, chat@FreeBSD.ORG,
        linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001027090352.Y28123@fw.wintelcom.net>
In-Reply-To: <20001025172702.B89038@prism.flugsvamp.com> <NCBBLIEPOCNJOAEKBEAKCEOPLHAA.davids@webmaster.com> <20001025161837.D28123@fw.wintelcom.net> <20001027172006.A28504@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001027172006.A28504@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Fri, Oct 27, 2000 at 05:20:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jamie Lokier <lk@tantalophile.demon.co.uk> [001027 08:21] wrote:
> Alfred Perlstein wrote:
> > > If a programmer does not ever wish to block under any circumstances, it's
> > > his obligation to communicate this desire to the implementation. Otherwise,
> > > the implementation can block if it doesn't have data or an error available
> > > at the instant 'read' is called, regardless of what it may have known or
> > > done in the past.
> > 
> > Yes, and as you mentioned, it was _bugs_ in the operating system
> > that did this.
> 
> Not for writes.  POLLOUT may be returned when the kernel thinks you have
> enough memory to do a write, but someone else may allocate memory before
> you call write().  Or does POLLOUT not work this way?

POLLOUT checks the socketbuffer (if we're talking about sockets),
and yes you may still block on mbuf allocation (if we're talking
about FreeBSD) if the socket isn't set non-blocking.  Actually
POLLOUT may be set even if there isn't enough memory for a write
in the network buffer pool.

> For read, you still want to declare the sockets non-blocking so your
> code is robust on _other_ operating systems.  It's pretty straightforward.

Yes, it's true, not using non-blocking sockets is like ignoring
friction in a physics problem, but assuming you have complete
control over the machine it shouldn't trip you up that often.  And
we're talking about readability, not writeability which as you
mentioned may block because of contention for the network buffer
pool.


-- 
-Alfred Perlstein - [bright@wintelcom.net|alfred@freebsd.org]
"I have the heart of a child; I keep it in a jar on my desk."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
