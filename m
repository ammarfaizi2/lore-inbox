Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131409AbRCUJyX>; Wed, 21 Mar 2001 04:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRCUJyN>; Wed, 21 Mar 2001 04:54:13 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:26108 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131407AbRCUJx5>; Wed, 21 Mar 2001 04:53:57 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103210951.f2L9pot18383@webber.adilger.int>
Subject: Re: Question about memory usage in 2.4 vs 2.2
In-Reply-To: <20010321172800.A11353@comp.nus.edu.sg> from Zou Min at "Mar 21,
 2001 05:28:00 pm"
To: Zou Min <zoum@comp.nus.edu.sg>
Date: Wed, 21 Mar 2001 02:51:49 -0700 (MST)
CC: Rik van Riel <riel@conectiva.com.br>, Josh Grebe <squash@primary.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zou Min writes:
> Then how to interpret slabinfo in 2.2.16 box? 
> e.g. grep cache /proc/slabinfo
> 
> kmem_cache            32     42
> skbuff_head_cache   2676   2730
> dentry_cache       15626  16988
> files_cache          103    108
> uid_cache             10    127
> slab_cache            85    126
> 
> what does those numbers mean?

First number is in-use objects in that cache, second number is
currently-allocated objects in that cache.

> Furthermore, are those cache info above reported as part of the total
> cache in /proc/meminfo ? 

Don't know.

> Lastly, which cache can be reclaimed, and which can't?

Slab cache will shrink if there are whole pages which are empty (it may
be that they have to be at the end of the cache).  It is hard to tell
from the above numbers if any of the caches could shrink, because it
depends on the number of objects per page, and if there are any whole
pages without allocated objects.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
