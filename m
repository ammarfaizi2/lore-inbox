Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282792AbRLOQGQ>; Sat, 15 Dec 2001 11:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282784AbRLOQGH>; Sat, 15 Dec 2001 11:06:07 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:47352 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S282778AbRLOQFz>; Sat, 15 Dec 2001 11:05:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
Date: Sat, 15 Dec 2001 11:05:21 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011215160522.7103D6D97@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Sat, Dec 15, 2001 at 01:36:11PM +0100, Chris Chabot wrote:
>> inode_cache       686896 686896    480 85862 85862    1 :  124   62
>> dentry_cache      696810 696810    128 23227 23227    1 :  252  126
> 
> this is an icache/dcache problem, can you reproduce on 2.4.17rc1aa1, it
> will shrink more aggressively.
> 
> really to get an even better balance we should add the icache/dcache
> slab pages into the lru as well... that would trigger the icache/dcache
> flushes more easily when too much ram is in those caches.

Interesting idea.  Is this what you are thinking?  We find a slab page at the tail of the
lru so we call the related shrink function.  If the page is still active after shrinking, we 
requeue it at the head of the lru.   The slab page freeing logic would have to how to 
unlink from the lru.

The priority arguement of the shink functions would now allow us to keep the ratio of
lru size vs icache/dcache/dqcache under control.   This might be a knob that would
be interesting to have in proc...

Comments?
Ed Tomlinson

