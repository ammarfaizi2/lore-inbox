Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293237AbSCFFmD>; Wed, 6 Mar 2002 00:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293234AbSCFFlx>; Wed, 6 Mar 2002 00:41:53 -0500
Received: from ns0.auctionwatch.com ([66.7.130.2]:15635 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S293235AbSCFFlo>; Wed, 6 Mar 2002 00:41:44 -0500
Date: Tue, 5 Mar 2002 21:41:43 -0800
From: Petro <petro@auctionwatch.com>
To: linux-kernel@vger.kernel.org
Subject: Probable Memory/VM issue.
Message-ID: <20020306054143.GN22934@auctionwatch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a persistent (since december) problem with Mysql crashing
under various versions of 2.4, ranging from 13 to 18.

I'm posted about this before, and the consensus (Both from this list,
and from the support team at Mysql) was that this was a VM issue. 

We pushed the app back on to the Sun e4500 while we dealt with several
other issues, and are now getting back around to trying to solve this
one. 

We are running the Mysql.com compiled mysql-3.23.43-pc-linux-gnu-i686 on
a VA Linux 2230 with 2 gig of ram and 2 CPUs:
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

Currently the kernel is 2.4.18 with the LVM and VFS-lock patch. 
 
I compiled in most of the kernel-debug stuff:
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_BUGVERBOSE=y

and we threw this machine into production (it's the only way we have of
generating this problem). 

It ran fine for 96+ hours, then mysql died. No oops, nothing to the
console. 

The stack trace from mysql gave me:
Bogus stack limit or frame pointer, fp=0xbfabf8c0, stack_bottom=0xbfc7fcb8, thread_stack=65536, aborting backtrace.
Trying to get some variables.
Some pointers may be invalid and cause the dump to abort...
thd->query at (nil)  is invalid pointer
thd->thread_id=20479119

Ok. So there's a problem. 

Last time I presented this, I was, IIRC, told to try the rmap patches,
but since that was almost 6 months ago in internet time, and there's
been some movement forward from both AA and Rik. I've been trying to
follow along, but (a) this stuff is pretty much over my head, and (b)
There's just too much traffic here. 

The CTO here (who is effectively my boss, if not actually) wants this
solved in one, or at least two more iterations of this (Meaning I'm
allowed one more crash of this kind under certain conditions). 

Personally, I'd prefer to solve this without applying any patches to the
kernel. I know that's not going to happen. Second best would be to apply
a patch that is going to be part of the mainstream "stable" kernel in
the near future. 

Further more, is there anything I can do from this side to get the
kernel to publish more information when this happens? 

No, let me rephrase that. 

What can I do to get better debugging information from the kernel.


Some other notes on this issue: 

When we last visited this, the machine was very heavily loaded, we did
some table optimizations, and cut the load to about 1/3 to 1/2 previous.
This was done mostly by minimizing the number of tables opend and
scanned. During the 96+ hours that this ran under Linux, the load rarely
got above .75, and only hit 1.8/2 once. As opposed to generally running
at a load of 1.2+ and hitting 4 regularly. Yes, I realize this doesn't
mean much, but I could go on for days with the metrics we've accumlated
on this. I can provide access to these metrics to a very few
individuals, as they are all in RRDs or Graphs. 

Any more information I'm missing? 


-- 
Share and Enjoy. 
