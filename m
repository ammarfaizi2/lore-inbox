Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129662AbRBGCHq>; Tue, 6 Feb 2001 21:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRBGCHg>; Tue, 6 Feb 2001 21:07:36 -0500
Received: from [63.95.87.168] ([63.95.87.168]:46609 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129714AbRBGCHd>;
	Tue, 6 Feb 2001 21:07:33 -0500
Date: Tue, 6 Feb 2001 21:07:31 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010206210731.E1110@xi.linuxpower.cx>
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org> <20010206190624.C23960@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010206190624.C23960@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Feb 06, 2001 at 07:06:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 07:06:24PM -0700, Jeff V. Merkey wrote:
> More to add on the gcc 2.96 problems.  After compiling a Linux 2.4.1 
> kernel on gcc 2.91, running SCI benchmarks, then compiling on RedHat 
> 7.1 (Fischer) with gcc 2.96, the 2.96 build DROPPED 30% in throughput
> from the gcc 2.91 compiled version on the identical SAME 2.4.1 
> source tree. 
[snip]

Come on Jeff, don't let your annoyance make you a fudder..

The Linux kernel relies on certain undefined behaviors of the compiler to
achieve locality of various types. The optimizer in the GCC 3.0 code tree
is much smarter and is not laying out code the way GCC 2.x did. 

So it's very likely that this lossage is caused by poorer cache locality.
After GCC 3 is finalized, it's likely that kernel developers will begin
moving to it, and rethinking how they express such things as branch
probability and code alignment to the compiler. Until then, GCC 3.0
snapshots are NOT the recommended compiler for the linux-kernel and not even
RedHat compilers their kernel's with it.  User beware.

It should also be noted that this compiler almost always produces faster user
space code then the older compilers, because almost nothing includes the
type of hand-tweaked C that the kernel uses so often on critical paths, most
of that software uses assembly in such situations.

So.. It's likely that calling your performance issues 'gcc bugs' is about
the same as saying that SGI cc is buggy because it can't compile the kernel.

At least you managed to avoid calling RedHat names. :)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
