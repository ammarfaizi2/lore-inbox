Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293509AbSCKCYZ>; Sun, 10 Mar 2002 21:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293505AbSCKCYQ>; Sun, 10 Mar 2002 21:24:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:42501 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293498AbSCKCYK>;
	Sun, 10 Mar 2002 21:24:10 -0500
Date: Sun, 10 Mar 2002 23:23:47 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <fletch@aracnet.com>, <lse-tech@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 23 second kernel compile (aka which patches help scalibility on
 NUMA)
In-Reply-To: <20020311031425.N8949@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203102319440.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Andrea Arcangeli wrote:
> On Fri, Mar 08, 2002 at 09:47:04PM -0800, Martin J. Bligh wrote:
> > Big locks left:
> >
> > pagemap_lru_lock
> > 20.2% 57.1%  5.4us(  86us)  111us(  16ms)(14.7%)   1014988 42.9% 57.1%    0%
>
> I think this is only due the lru_cache_add executed by the anonymous
> pagefaults. Pagecache should stay in the lru constantly if you're
> running in hot pagecache as I guess. For a workload like this one
> keeping anon pages out of the lru would be an obvious win.

... but only if you're really dealing with anonymous pages,
I suspect that people will use NUMA machines more for workloads
where most pages belong to mappings, because if a scientific
calculation can be split out to a cluster you don't need the
cost of NUMA hardware.

Not sure if my guess is right though ;)

> It's a tradeoff. Just like the additional memory/cpu and locking
> overhead that rmap requires will slowdown page faults even more than
> what you see now, with the only object to get a nicer pagout behaviour
> (modulo the ram-binding "migration" stuff where rmap is mandatory to do
> it instantly and not over time).

Rmap will also make it possible to have the lru lock per
zone (or per node), which should give rather nice behaviour
for large SMP and NUMA systems ... even if the workload
isn't made up of anonymous pages ;)

Btw, what is the "ram binding migration stuff" you are
talking about and why would rmap not be able to do it in
a nice way ?

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

