Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135385AbRDMCER>; Thu, 12 Apr 2001 22:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRDMCEH>; Thu, 12 Apr 2001 22:04:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21398 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135385AbRDMCEB>;
	Thu, 12 Apr 2001 22:04:01 -0400
Date: Thu, 12 Apr 2001 22:03:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Tomlinson <tomlins@cam.org>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
In-Reply-To: <01041221342400.27841@oscar>
Message-ID: <Pine.GSO.4.21.0104122154560.22287-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Ed Tomlinson wrote:

> On Thursday 12 April 2001 11:12, Alexander Viro wrote:
> What prompted my patch was observing situations where the icache (and dcache 
> too) got so big that they were applying artifical pressure to the page and 
> buffer caches. I say artifical since checking the stats these caches showed 
> over 95% of the entries unused.  At this point there is usually another 10% 
> or so of objects allocated by the slab caches but not accounted for in the 
> stats (not a problem they are accounted if the cache starts using them).

"Unused" as in "->d_count==0"? That _is_ OK. Basically, you will have
positive ->d_count only on directories and currently opened files.
E.g. during compile in /usr/include/* you will have 3-5 file dentries
with ->d_count > 0 - ones that are opened _now_. It doesn't mean that
everything else rest is unused in any meaningful sense. Can be freed - yes,
but that's a different story.

If you are talking about "unused" from the slab POV - _ouch_. Looks like
extremely bad fragmentation ;-/ It's surprising, and if that's thte case
I'd like to see more details.
								Al

