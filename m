Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbRBKPml>; Sun, 11 Feb 2001 10:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129556AbRBKPmb>; Sun, 11 Feb 2001 10:42:31 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:3321 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129555AbRBKPmX>; Sun, 11 Feb 2001 10:42:23 -0500
Date: Sun, 11 Feb 2001 12:39:50 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: davej@suse.de
cc: Mike Galbraith <mikeg@wen-online.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.31.0102110227530.3652-100000@athlon.local>
Message-ID: <Pine.LNX.4.21.0102111226140.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001 davej@suse.de wrote:
> On Sat, 10 Feb 2001, Mike Galbraith wrote:
> 
> > > > o	Rebalance the 2.4.1 VM				(Rik van Riel)
> > This change makes my box swap madly under load.  It appears to be
> > keeping more cache around than is really needed, and therefore
> > having to resort to swap instead.  The result is MUCH more I/O than
> > previous kernels while doing the same exact job.
> 
> I concur this,

> It appeared, that rather than free the cached buffers and reuse
> the memory, it preferred to hit swap space. Streaming I/O
> performance seems to have taken a hit lately.

OK, so we're back to the old VM magic number game again ;(

In short, we have to be more agressive towards unmapped
cache pages than towards mapped pages in processes, except
that this horribly breaks down when somebody does streaming
IO using mmap while somebody else is at the same time re-using
data from cached files (say, .h files)...

Now the question is ... WHY do we need to change this behaviour
and HOW exactly should it be changed ?

I don't really feel comfortable just tweaking stuff until we
get a half-dozen benchmarks right, I think we need to understand
what is happening and change things accordingly.

It's fine with me to put some temporary thing in place to get
at least -ac5 behaviour back, but I don't think we should have
this as a long-term thing.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
