Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290107AbSAKUlq>; Fri, 11 Jan 2002 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290109AbSAKUlh>; Fri, 11 Jan 2002 15:41:37 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:34823 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S290107AbSAKUlU>; Fri, 11 Jan 2002 15:41:20 -0500
Date: Fri, 11 Jan 2002 14:41:17 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: vanl@megsinet.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020111144117.A1485@asooo.flowerfire.com>
In-Reply-To: <3C2CD326.100@athlon.maya.org> <20020103142301.C4759@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>; from brownfld@irridia.com on Thu, Jan 03, 2002 at 02:23:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After more testing, my original observations seem to be holding up,
except that under heavy VM load (e.g., "make -j bzImage") the machine's
overall performance seems far lower.  For instance, without the patch
the -j build finishes in ~10 minutes (2x933P3/256MB) but with the patch
I haven't had the patience to let it finish after more than an hour.

This is perhaps because the vmscan patch is too aggressively shrinking
the caches, or causing thrashing in another area?  I'm also noticing
that the amount of swap used is nearly an order of magnitude higher,
which doesn't make sense at first glance...  Also, there are extended
periods where idle CPU is 50-80%.

Maybe the patch or at least its intent can be merged with Andrea's work
if applicable?

Thanks,
-- 
Ken.
brownfld@irridia.com


On Thu, Jan 03, 2002 at 02:23:01PM -0600, Ken Brownfield wrote:
| Unfortunately, I lost the response that basically said "2.4 looks stable
| to me", but let me count the ways in which I agree with Andreas'
| sentiment:
| 
| 	A) VM has major issues
| 		1) about a dozen recent OOPS reports in VM code
| 		2) VM falls down on large-memory machines with a
| 		   high inode count (slocate/updatedb, i/dcache)
| 		3) Memory allocation failures and OOM triggers
| 		   even though caches remain full.
| 		4) Other bugs fixed in -aa and others
| 	B) Live- and dead-locks that I'm seeing on all 2.4 production
| 	   machines > 2.4.9, possibly related to A.  But how will I
| 	   ever find out?
| 	C) IO-APIC code that requires noapic on any and all SMP
| 	   machines that I've ever run on.
| 
| I don't have anything against anyone here -- I think everyone is doing a
| fine job.  It's an issue of acceptance of the problem and focus.  These
| issues are all showstoppers for me, and while I don't represent the 90%
| of the Linux market that is UP desktops, IMHO future work on the kernel
| will be degraded by basic functionality that continues to cause
| problems.
| 
| I think seeing some of Andrea's and Andrew's et al patches actually
| *happen* would be a good thing, since 2.4 kernels are decidedly not
| ready for production here.  I am forced to apply 26 distinct patch sets
| to my kernels, and I am NOT the right person to make these judgements.
| Which is why I was interested in an LKML summary source, though I
| haven't yet had a chance to catch up on that thread of comment.
| 
| Having a glitch in the radeon driver is one thing; having persistent,
| fatal, and reproducable failures in universal kernel code is entirely
| another.
| 
| -- 
| Ken.
| brownfld@irridia.com
| 
| 
| On Fri, Dec 28, 2001 at 09:16:38PM +0100, Andreas Hartmann wrote:
| | Hello all,
| | 
| | Again, I did a rsync-operation as described in
| | "[2.4.17rc1] Swapping" MID <3C1F4014.2010705@athlon.maya.org>.
| | 
| | This time, the kernel had a swappartition which was about 200MB. As the 
| | swap-partition was fully used, the kernel killed all processes of knode.
| | Nearly 50% of RAM had been used for buffers at this moment. Why is there 
| | so much memory used for buffers?
| | 
| | I know I repeat it, but please:
| | 
| | 	Fix the VM-management in kernel 2.4.x. It's unusable. Believe
| | 	me! As comparison: kernel 2.2.19 didn't need nearly any swap for
| | 	the same operation!
| | 
| | Please consider that I'm using 512 MB of RAM. This should, or better: 
| | must be enough to do the rsync-operation nearly without any swapping - 
| | kernel 2.2.19 does it!
| | 
| | The performance of kernel 2.4.18pre1 is very poor, which is no surprise, 
| | because the machine swaps nearly nonstop.
| | 
| | 
| | Regards,
| | Andreas Hartmann
| | 
| | -
| | To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| | the body of a message to majordomo@vger.kernel.org
| | More majordomo info at  http://vger.kernel.org/majordomo-info.html
| | Please read the FAQ at  http://www.tux.org/lkml/
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
