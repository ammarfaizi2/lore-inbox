Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSDKXew>; Thu, 11 Apr 2002 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313023AbSDKXev>; Thu, 11 Apr 2002 19:34:51 -0400
Received: from asooo.flowerfire.com ([63.254.226.247]:10707 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S313022AbSDKXet>; Thu, 11 Apr 2002 19:34:49 -0400
Date: Thu, 11 Apr 2002 18:34:43 -0500
From: Ken Brownfield <ken@irridia.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Aviv Shavit <avivshavit@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
Message-ID: <20020411183443.A21005@asooo.flowerfire.com>
In-Reply-To: <20020225224050.D26077@asooo.flowerfire.com> <20020409204545.11251.qmail@web13205.mail.yahoo.com> <20020410013609.A6875@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sounds great, but I still have concerns with using -aa, or subsets
of same.

How much of the improved behavior that you're seeing is due to the vm-33
tweaks and not pte-highmem, block-highmem, or any of the 100 or so other
2.4.19-pre6aa1 patches?

For production use, I prefer to divert from mainline only with my
specific needs (or trivial fixes).  Using -aa would introduce a large
array of (to me) unknowns.  How many of the -aa patches are "ready" for
mainline and production?  vm is currently being debated on the floor --
but what about pte-highmem and block-highmem?  How many of the other
patches are as widely tested as the vm patch?  For some reason, applying
a patch called "00_readahead-got-broken-somewhere-1" doesn't give me the
utmost confidence in production.  Call it a failed bag check.

While 2.4.x is a stable kernel, it needs to be a working* kernel until
2.5 can sort out these and the vast array of other issues.  IMHO.
*Admittedly, "working" in this case only applies to larger servers, but
it would be quite tragic to delay the spread of Linux to hardware that's
been available and used in production for _years_.  Maybe 5% of the
installed base has relevant hardware, but the benefit to Linux _far_
outstrips that seemingly anemic number.  I've probably rehashed that
point too much as it is, but...

What I'd like to hear (and what I suspect many admins trying to get
higher-end hardware working optimally in a production environment would
like to hear) is what specific patches applied to mainline are needed to
correct the current VM and I/O issues in the 2.4 tree?

If it's vm, pte-highmem, and block-highmem, that's fine -- and separable
from -aa.  Otherwise it's difficult to get people to test, use, and
provide feedback that isn't polluted by unnecessary variables.

Thanks,
-- 
Ken.
ken@irridia.com


On Wed, Apr 10, 2002 at 01:36:09AM +0200, Andrea Arcangeli wrote:
| I recommend everybody to never use a 2.4 kernel without first applying
| this vm patch:
| 
| 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/vm-33.gz
| 
| It applies cleanly to both 2.4.19pre5 and 2.4.19pre6. Andrew splitted it
| into orthogonal pieces for easy merging from Marcelo's side (modulo
| -rest that is important too but that it's still quite monolithic, but
| it's pointless to invest further effort at this time until we are
| certain Marcelo will do its job and eventually merge it in mainline):
| 
| 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/
| 
| So far a first part of those patches is been merged into mainline into
| pre5 (not any previous kernel, if you've some problem reproducible with
| pre4 pre3 pre2 and pre1 or any previous kernel that's not related to the
| async flushing changes, I seen a bogus report floating around to Marcelo
| about pre1 pointing to the vm changes, it can't be the vm changes if
| it's pre[1234]).
| 
| This VM is under heavy stressing for weeks on my SMP highmem machine
| with a real life DBMS workload in a real life setup with huge VM
| pressure with mem=1024m and 1.2G of shm pushed in swap constantly by the
| kernel, performance of the workload is now very good and exactly
| reproducible and constant, so I recommend it for all production systems
| (both lowmem desktops and highend servers).
| 
| Alternatively you can use the whole -aa patchkit, to get all the other
| critical highend features like pte-highmem, highio etc...
| 
| I haven't bugreports pending on the vm patch.
| 
| Thanks,
| 
| Andrea
