Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWDNWgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWDNWgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDNWgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:36:20 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:35494 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751276AbWDNWgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:36:19 -0400
Message-ID: <444023DC.9000106@tlinx.org>
Date: Fri, 14 Apr 2006 15:36:12 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: K P <kplkml@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Bogus Benchmark (was Re: JVM performance on Linux (vs. Solaris/Windows))
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
In-Reply-To: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K P wrote:
> Sun's recently published SPECjbb_2005 numbers on Linux, Windows and
> Solaris on their
> Opteron system, and the Linux result is the lowest of the three by far:
>
> Linux: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00062.html
> Solaris: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00063.html
> Windows: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00064.html
>
> It's not evident if Sun spent any time analyzing and tuning the Linux
> result. While the
> majority of the tuning opportunities for SPECjbb_2005 are likely to be
> in the JVM itself, I was
> wondering (given the large spread between the OS's) if there were
> other typical opportunities
> to tune the Linux kernel for JVM performance and SPECjbb_2005.
----
    I may have missed it, but I didn't see any information on how the
three different binary javaVM's were "built".  What compilers did
they use? What options?  Did they use the OSs' most common compilers
(gcc, MS C, & Sun's C Compiler?). 

    There are many other factors affecting performance.  It's
not clear what background processes were running (affecting memory
cache) or if they ran them in single-user mode.  Do the tests
include graphics?  What windowing/graphics software did they
use?  Where they running a desktop? 

They don't say what kernel version they used (though that might
be implied in the version of RH they used).  They don't
remark on what options were used in mounting the file systems.
They mention that they used "ext3" (which defaults to
"write-through" write operations) vs. NTFS on Windows and Ufs on
Solaris.  NTFS defaults to "write-back" by default.  I'd bet
UFS does as well. 

Were the OS and test databases on the same place on disk?  I.e.
loaded on the same partitions?  Read/Write performance varies,
easily by 100% between the slowest and fastest positions on disk.
Was the spec, _at least_, run in it's own partition?

We're talking a difference of 10-15% between the benchmarks.
Any number of factors could influence a benchmark by more than
that: Compiler options, OS & app disk location, background tasks
loaded,  file system choice and options. 

Speculating that the differences have much of anything to do
with the linux kernel seems awfully premature.

I'd tend to regard this as a fairly worthless benchmark.  In
addition to the questions above, one could still assume they
are using default settings and options.

Anyone concerned with performance is unlikely to be using
defaults.

Linda


   
