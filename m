Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265344AbSJRSba>; Fri, 18 Oct 2002 14:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbSJRSba>; Fri, 18 Oct 2002 14:31:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265344AbSJRSb3>;
	Fri, 18 Oct 2002 14:31:29 -0400
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       george anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021018172121.GO23930@dualathlon.random>
References: <20021018171139.GM23930@dualathlon.random>
	<Pine.LNX.4.44.0210181018070.21302-100000@home.transmeta.com> 
	<20021018172121.GO23930@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 11:37:19 -0700
Message-Id: <1034966240.5851.20.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> agreed. Hear my idea:
> 
> 	actually my idea on 64bit was to use the high 8 bit of each 64bit word to
> 	give you the cpuid, to get out the coherent data, including the sequence
> 	number that are read and written inversely with mb() like now (the
> 	sequence number as well will become per-cpu), so it is definitely doable
> 	without any single problem and in a very performant way, just not as
> 	easy as without the per-cpu info. Even if segmentation per-cpu tricks
> 	would be possible or available (remeber long mode is pure paging, no
> 	segmentation) it would be not worthwhile IMHO, the cpuid encoded
> 	atomically in each 64bit data provided by the vsyscall seems a much
> 	simpler and possibly more performant solution. You set a different
> 	per-cpu data-mapping with different pte settings in each cpu. The
> 	vsyscall bytecode remains the same, aware about this cpuid encoded in
> 	each 64bit word. Doing it in 32bit is ugly (or at least much slower)
> 	since most data is natively at least 32bit, it would need some slow
> 	demultiplexing.

At least on IA32 you could still use XCHG64 to atomically access the
values, but that always forces a write so it isn't cache friendly. Still
it probably is better than encoding the data in 32bit.  It all depends
on how much data is needed.


