Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSGQMTI>; Wed, 17 Jul 2002 08:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSGQMTI>; Wed, 17 Jul 2002 08:19:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26629 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S312619AbSGQMTG>; Wed, 17 Jul 2002 08:19:06 -0400
Date: Wed, 17 Jul 2002 09:21:50 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <3D3500AA.131CE2EB@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0207170914060.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Andrew Morton wrote:

> The rest of the VM - list management, the classzone concept, etc
> remains unchanged.

> 5: per-cpu pte_chain freelists (Rik?)

Will look into this soon.

> 6: maybe GC the pte_chain backing pages. (Seems unavoidable.  Rik?)

And probably into this, if it turns out that we're wasting
too much memory in no longer used pte_chains in real workloads,
which will probably happen ;)

> 7: multithread the page reclaim code.  (I have patches).

Rmap for 2.4 also has some code which could be used for this.

> 8: clustered add-to-swap.  Not sure if I buy this.  anon pages are
>    often well-ordered-by-virtual-address on the LRU, so it "just
>    works" for benchmarky loads.  But there may be some other loads...

Benchmarky loads without a working set probably aren't all that
suitable for evaluating page replacement. VM (and general caching)
works _because_ of the working set property.

Does anybody know of a working set simulator we could use to test
things like this ?

> 9: Fix bad IO latency in page reclaim (I have lame patches)
>
> 10: Develop tuning tools, use them.
>
> 11: The nightly updatedb run is still evicting everything.

That's the "minimal" part of "minimal rmap" ;))

Ed Tomlinson has some code for 11), which should be mergeable
soon.  In combination with changed page replacement priorities
we'll be able to make sure updatedb won't evict everything.

The importance of rmap here is making sure we're _able_ to do
this kind of tuning instead of tweaking the same magic knobs
we've (unsuccessfully) tweaked in the last 8 years.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

