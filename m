Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbSLGAXm>; Fri, 6 Dec 2002 19:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267695AbSLGAXl>; Fri, 6 Dec 2002 19:23:41 -0500
Received: from holomorphy.com ([66.224.33.161]:15249 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267682AbSLGAXD>;
	Fri, 6 Dec 2002 19:23:03 -0500
Date: Fri, 6 Dec 2002 16:30:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207003025.GU9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <20021206235032.GR4335@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206235032.GR4335@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
> My point is that making any distinction will lead to inevitable
> fragmentation of memory.

It's mostly userspace; the kernel is usually (hello drivers/ !) cautious
and uses slab.c's anti-internal fragmentation techniques for most structs.


At some point in the past, I wrote:
>> Hmm, from the appearances of the patch (my ability to test the patch
>> is severely hampered by its age) it should actually maintain hardware
>> pagesize mmap() granularity, ABI compatibility, etc.

On Sat, Dec 07, 2002 at 12:50:32AM +0100, Andrea Arcangeli wrote:
> If it only implements the MMUPAGE_SIZE, yes, it can.
> You break the ABI as soon as you change the kernel wide PAGE_SIZE. it is
> allowed only on 64bit binaries running on a x86-64 kernel.  The 32bit
> binaries running in compatibility mode as said would suffer a bit, but
> most things should run and we can make hacks like using anon mappings if
> the files are small just for the sake of running some app 32bit (like we
> use anon mappings for a.out binaries needing 1k offsets today).

I'm not sure what to make of this. The distinction and PTE vectoring
API (AFAICT) allows PTE's to map sub-PAGE_SIZE-sized (MMUPAGE_SIZE to
be exact) regions. Someone start screaming if I misread the patch.


On Sat, Dec 07, 2002 at 12:50:32AM +0100, Andrea Arcangeli wrote:
> Said that even the MMUPAGE_SIZE alone would be useful, but I'd prefer if
> the kernel wide PAGE_SIZE would be increased (with the disavantage of
> breaking the ABI, but it would be a config option, even the 2G/3.5G/1G
> split has the chance of breaking some app despite I wouldn't classify it
> as an ABI violation for the reason explained in one of the last emails).

Userspace is required to have >= 3GB of virtualspace, according to the
SVR4 i386 ABI spec. But we don't follow that strictly anyway.


At some point in the past, I wrote:
>> I think this is a perfect example of how the increased awareness of
>> space consumption highmem gives us helps us optimize all boxen.

On Sat, Dec 07, 2002 at 12:50:32AM +0100, Andrea Arcangeli wrote:
> In this case funnily it has a chance to help some 64bit boxes too ;).

I've heard the sizeof(mem_map) footprint is worse on 64-bit because
while PAGE_SIZE remains the same, but pointers double in size. This
would help a bit there, too.


Bill
