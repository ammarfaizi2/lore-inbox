Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSHDNxf>; Sun, 4 Aug 2002 09:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSHDNxf>; Sun, 4 Aug 2002 09:53:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57861 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316757AbSHDNxe>; Sun, 4 Aug 2002 09:53:34 -0400
Date: Sun, 4 Aug 2002 10:56:50 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
In-Reply-To: <200208041511.27990.agruen@suse.de>
Message-ID: <Pine.LNX.4.44L.0208041055160.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Andreas Gruenbacher wrote:
> On Sunday 04 August 2002 13:30, Hans Reiser wrote:
> > How do you ensure that caches have their (internal) aging hands pushed
> > at a speed that is proportional to their memory usage, or is your design
> > susceptible to all the usual complaints the unified memory manager crowd
> > has about separate caches?
>
> That's a policy/optimization issue; it's not even desirable to shrink the
> caches with priorities proportional to their size---they would all tend to
> become equally large.

Nope, the idea is to push all caches according to size, but
often-used caches should shrink less than caches that are
hardly ever used.

> The icache, dcache, and dqcache are shrunk using the same strategy
> (except the priority is a constant for some of the caches, which could
> be coded in the shrink function as well). This scheme has worked out
> pretty well so far, right?

Not quite, we still have some bad problems balancing the size
of these caches versus the size of the other VM occupants.

However, your shrinking function is good enough for now and
can be used with something like Ed Tomlinson's approach later
on to make reclaiming better balanced.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

