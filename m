Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261262AbRERRY6>; Fri, 18 May 2001 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261261AbRERRYs>; Fri, 18 May 2001 13:24:48 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:3333 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S261255AbRERRYi>; Fri, 18 May 2001 13:24:38 -0400
Date: Fri, 18 May 2001 19:24:22 +0200
From: Kurt Roeckx <Q@ping.be>
To: Chris Evans <chris@scary.beasts.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Kernel bug with UNIX sockets not detecting other end gone?
Message-ID: <20010518192422.B18162@ping.be>
In-Reply-To: <Pine.LNX.4.30.0105172353480.13175-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <Pine.LNX.4.30.0105172353480.13175-100000@ferret.lmh.ox.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 11:57:45PM +0100, Chris Evans wrote:
> 
> Hi,
> 
> I wonder if the following is a bug? It certainly differs from FreeBSD 4.2
> behaviour, which gives the behaviour I would expect.
> 
> The following program blocks indefinitely on Linux (2.2, 2.4 not tested).
> Since the other end is clearly gone, I would expect some sort of error
> condition. Indeed, FreeBSD gives ECONNRESET.

I'm having a simular problem, but somehow can't recreate it.

The difference is that I set the sockets to non-blocking, and
expect it to return some error.

read() returns 0, with errno set to 0, if the socket is still
open it returns -1 with errno set 11 (EAGAIN).  I can understand
those behaviours.

What I'm seeing however in an other program is that select says I
can read from the socket, and that read returns 0, with errno set
to EGAIN.  I call select() again, with returns and says I can read
from that socket ..., which keeps going on.  It stops from the
moment there is any i/o on an other socket.

Is there any way you can detect the other side is gone without
using write()?  write() shoud return an EPIPE.  Should I be able
to detect it with read(), or some oter system call?


Kurt

