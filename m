Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSGNFhy>; Sun, 14 Jul 2002 01:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSGNFhx>; Sun, 14 Jul 2002 01:37:53 -0400
Received: from egil.codesourcery.com ([66.92.14.122]:63880 "EHLO
	egil.codesourcery.com") by vger.kernel.org with ESMTP
	id <S315607AbSGNFhx>; Sun, 14 Jul 2002 01:37:53 -0400
Date: Sat, 13 Jul 2002 22:40:44 -0700
From: Zack Weinberg <zack@codesourcery.com>
To: linux-kernel@vger.kernel.org
Subject: Re: What is supposed to replace clock_t?
Message-ID: <20020714054044.GF30675@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207131103410.16670-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
...
> Many of the binary interfaces are perfectly fine. In fact, there are
> very few binary interfaces that are fundamentally broken, the
> obvious one being the "times()" system call that nobody actually
> uses any more.

Er, no; people do still use times().  It is (as far as I know) the
only way for a process to determine how much wall-clock, user CPU, and
system CPU time it has consumed, all at once.  If you use getrusage()
instead, you also have to call gettimeofday() to get the wall-clock
time, which at least doubles the overhead.  [Both getrusage and
gettimeofday are somewhat more expensive than times, but I'm pretty
sure the trap cost dominates.]  Profiling code tries very hard to have
as little overhead as possible.

As an application programmer, I would be perfectly happy to use an
extended getrusage() that gave me wall-clock time as a struct timeval.
But please do provide such an interface before deprecating times().

[While we're at it, it would be nice if the kernel would provide
useful values for more of the fields of struct rusage.]

zw
