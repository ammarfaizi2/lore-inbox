Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRACUI7>; Wed, 3 Jan 2001 15:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRACUIk>; Wed, 3 Jan 2001 15:08:40 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:44037 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129601AbRACUIc>;
	Wed, 3 Jan 2001 15:08:32 -0500
Date: Wed, 3 Jan 2001 20:38:03 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
In-Reply-To: <3A536ADD.BB38E3C7@innominate.de>
Message-ID: <Pine.LNX.4.21.0101032016180.4684-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Daniel Phillips wrote:

> Tobias Ringstrom wrote:
> > 3) The 2.2 kernels outperform the 2.4 kernels for few clients (see
> >    especially the "dbench 1" numbers for the PII-128M.  Oops!
> 
> I noticed that too.  Furthermore I noticed that the results of the more
> heavily loaded tests on the whole 2.4.0 series tend to be highly
> variable (usually worse) if you started by moving the whole disk through
> cache, e.g., fsck on a damaged filesystem.

Yes, they do seem to vary a lot.

> It would be great if you could track the ongoing progress - you could go
> so far as to automatically download the latest patch and rerun the
> tests.  (We have a script like that here to keep our lxr/cvs tree
> current.)  And yes, it gets more important to consider some of the other
> usage patterns so we don't end up with self-fullfilling prophecies.

I was thinking about an automatic test, build, modify lilo, reboot cycle
for a while, but I don't think it's worth it.  Benchmarking is hard, and
making it automatic is probably even harder, not mentioning trying to
interpret the numbers...  Probably "Samba feels slower" works quite well.  
:-)

But then it is even unclear to me what the vm people are trying to
optimize for.  Probably a system that "feels good", which according to
myself above, may actually be a good criteria, although a but imprecise.  
Oh, well...

> For benchmarking it would be really nice to have a way of emptying
> cache, beyond just syncing.  I took a look at that last week and
> unfortunately it's not trivial.  The things that have to be touched are
> optimized for the steady-state running case and tend to take their
> marching orders from global variables and embedded heuristics that you
> don't want to mess with.  Maybe I'm just looking at this problem the
> wrong way because the shortest piece of code I can imagine for doing
> this would be 1-200 lines long and would replicate a lot of the
> functionality of page_launder and flush_dirty_pages, in other words it
> would be a pain to maintain.

How about allocating lots of memory and locking it in memory?  I have not
looked at the source, but it seems (using strace) that hdbench uses shm to
do just that.  I'll dig into the hdbench code and try to make a program
that empties the cache.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
