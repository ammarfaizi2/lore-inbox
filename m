Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135399AbRDMEqF>; Fri, 13 Apr 2001 00:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135401AbRDMEp4>; Fri, 13 Apr 2001 00:45:56 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:41694 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135399AbRDMEpp>; Fri, 13 Apr 2001 00:45:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alexander Viro <viro@math.psu.edu>, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
Date: Fri, 13 Apr 2001 00:45:41 -0400
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0104122154560.22287-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0104122154560.22287-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01041300454100.06447@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 April 2001 22:03, Alexander Viro wrote:
> On Thu, 12 Apr 2001, Ed Tomlinson wrote:
> > On Thursday 12 April 2001 11:12, Alexander Viro wrote:
> > What prompted my patch was observing situations where the icache (and
> > dcache too) got so big that they were applying artifical pressure to the
> > page and buffer caches. I say artifical since checking the stats these
> > caches showed over 95% of the entries unused.  At this point there is
> > usually another 10% or so of objects allocated by the slab caches but not
> > accounted for in the stats (not a problem they are accounted if the cache
> > starts using them).
>
> "Unused" as in "->d_count==0"? That _is_ OK. Basically, you will have
> positive ->d_count only on directories and currently opened files.
> E.g. during compile in /usr/include/* you will have 3-5 file dentries
> with ->d_count > 0 - ones that are opened _now_. It doesn't mean that
> everything else rest is unused in any meaningful sense. Can be freed - yes,
> but that's a different story.
>
> If you are talking about "unused" from the slab POV - _ouch_. Looks like
> extremely bad fragmentation ;-/ It's surprising, and if that's thte case
> I'd like to see more details.

>From the POV of dentry_stat.nr_unused.  From the slab POV, dentry_stat.nr_dentry
always equals the number of objects used as reported in /proc/slabinfo.  If I
could remember my stats from ages back I could take a stab at estimating the
fragmentation...  From experience if you look at memory_pressure before and 
after a shrink of the dcache you will usually see it decrease if there if
there is more that 75% or so free reported by dentry_stat.nr_unused.  

The inode cache is not as good.  With fewer inodes per page (slab) I 
would expect that percentage to be lower.  Instead it usually has to be
above 80% to get pages free...

I am trying your change now.

Ed Tomlinson

