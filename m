Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311879AbSCTRlp>; Wed, 20 Mar 2002 12:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311880AbSCTRlf>; Wed, 20 Mar 2002 12:41:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27908 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311879AbSCTRlW>;
	Wed, 20 Mar 2002 12:41:22 -0500
Date: Wed, 20 Mar 2002 14:41:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
In-Reply-To: <20020320173959.F4268@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203201437190.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Andrea Arcangeli wrote:
> On Wed, Mar 20, 2002 at 08:14:31AM -0800, Martin J. Bligh wrote:

> > Looking at the code for map_new_virtual, note that we start at where
> > we left off before: last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
> > So we don't scan the whole array every time - we just walk through it
> > one step (on most instances, assuming most of pool is short term use).
>
> and if we didn't find anything we call flush_all_zero_pkmaps that does a
> whole O(N) scan on the pool to try to release the entries that aren't
> pinned and then we try again. In short if we increase the pool size, we
> linearly increase the time we spend on it (actually more than linearly
> because we'll run out of l1/l2/l3 while the pool size increases)

That suggests we'd want a pool size of 1 to be O(1) buzzword
compliant ;)

Going for a smaller pool just doesn't make sense if you want
the mappings to be cached, it could even result in more processes
_sleeping_ on kmap entries to be freed.

Please make a choice, do you want kmaps to be cached or would
you be content to have just cpu-local or maybe process-local
kmaps and get rid of the global kmap pool ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

