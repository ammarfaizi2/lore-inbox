Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135239AbRDLR2R>; Thu, 12 Apr 2001 13:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135238AbRDLR2H>; Thu, 12 Apr 2001 13:28:07 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:52464 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135236AbRDLR1x>; Thu, 12 Apr 2001 13:27:53 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104121727.f3CHR4gT029899@webber.adilger.int>
Subject: Re: [CFT][PATCH] Re: Fwd: Re: memory usage - dentry_cache
In-Reply-To: <15061.27388.843554.687422@pizda.ninka.net> "from David S. Miller
 at Apr 12, 2001 01:44:44 am"
To: "David S. Miller" <davem@redhat.com>
Date: Thu, 12 Apr 2001 11:27:03 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David writes:
> Alexander Viro writes:
>  > OK, how about wider testing? Theory: prune_dcache() goes through the
>  > list of immediately killable dentries and tries to free given amount.
>  > It has a "one warning" policy - it kills dentry if it sees it twice without
>  > lookup finding that dentry in the interval. Unfortunately, as implemented
>  > it stops when it had freed _or_ warned given amount. As the result, memory
>  > pressure on dcache is less than expected.
> 
> The reason the code is how it is right now is there used to be a bug
> where that goto spot would --count but not check against zero, making
> count possibly go negative and then you'd be there for a _long_ time
> :-)

Actually, this is the case if we call shrink_dcache_memory() with priority
zero.  It calls prune_dcache(count = 0), which gets into the situation you
describe (i.e. negative count).  I first thought this was a bug, but then
realized for priority 0 (i.e. highest priority) we want to check the whole
dentry_unused list for unreferenced dentries.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
