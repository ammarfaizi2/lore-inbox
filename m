Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265616AbSJRSyz>; Fri, 18 Oct 2002 14:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265278AbSJRSvc>; Fri, 18 Oct 2002 14:51:32 -0400
Received: from [195.223.140.120] ([195.223.140.120]:15448 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265277AbSJRSpV>; Fri, 18 Oct 2002 14:45:21 -0400
Date: Fri, 18 Oct 2002 20:51:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       george anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
Message-ID: <20021018185132.GW23930@dualathlon.random>
References: <20021018171139.GM23930@dualathlon.random> <Pine.LNX.4.44.0210181018070.21302-100000@home.transmeta.com> <20021018172121.GO23930@dualathlon.random> <1034966240.5851.20.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034966240.5851.20.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:37:19AM -0700, Stephen Hemminger wrote:
> 
> > agreed. Hear my idea:
> > 
> > 	actually my idea on 64bit was to use the high 8 bit of each 64bit word to
> > 	give you the cpuid, to get out the coherent data, including the sequence
> > 	number that are read and written inversely with mb() like now (the
> > 	sequence number as well will become per-cpu), so it is definitely doable
> > 	without any single problem and in a very performant way, just not as
> > 	easy as without the per-cpu info. Even if segmentation per-cpu tricks
> > 	would be possible or available (remeber long mode is pure paging, no
> > 	segmentation) it would be not worthwhile IMHO, the cpuid encoded
> > 	atomically in each 64bit data provided by the vsyscall seems a much
> > 	simpler and possibly more performant solution. You set a different
> > 	per-cpu data-mapping with different pte settings in each cpu. The
> > 	vsyscall bytecode remains the same, aware about this cpuid encoded in
> > 	each 64bit word. Doing it in 32bit is ugly (or at least much slower)
> > 	since most data is natively at least 32bit, it would need some slow
> > 	demultiplexing.
> 
> At least on IA32 you could still use XCHG64 to atomically access the
> values, but that always forces a write so it isn't cache friendly. Still

yep, it would hurt scalability if possible at all, and I doubt the
chpxchg64 could work on a readonly piece of memory, the pte is marked
writeprotect, so it should generate a sigsegv.

> it probably is better than encoding the data in 32bit.  It all depends

yes.

> on how much data is needed.
> 


Andrea
