Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUCDEvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUCDEvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:51:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53512
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261450AbUCDEvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:51:33 -0500
Date: Thu, 4 Mar 2004 05:52:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zaitsev <peter@mysql.com>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040304045212.GG4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303200704.17d81bda.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 08:07:04PM -0800, Andrew Morton wrote:
> That's a larger difference than I expected.  But then, everyone has been

mysql is threaded (it's not using processes that force tlb flushes at
every context switch), so the only time a tlb flush ever happens is when
a syscall or an irq or a page fault happens with 4:4. Not tlb flush
would ever happen with 3:1 in the whole workload (yeah, some background
tlb flushing happens anyways when you type char on bash or move the
mouse of course but it's very low frequency)

(to be fair, because it's threaded it means they also find 512m of
address space lost more problematic than the db using processes, though
besides the reduced address space there would be no measurable slowdown
with 2.5:1.5)

Also the 4:4 pretty much depends on the vgettimeofday to be backported
from the x86-64 tree and an userspace to use it, so the test may be
repeated with vgettimeofday, though it's very possible mysql isn't using
that much gettimeofday as other databases, especially the I/O bound
workload shouldn't matter that much with gettimeofday.

another reason could be the xeon bit, all numbers I've seen were on p3,
that's why I was asking about xeon and p4 or more recent.

all random ideas, just guessing.

> mysteriously quiet with the 4g/4g benchmarking.

indeed.

> A kernel profile would be interesting.  As would an optimisation effort,
> which, as far as I know, has never been undertaken.

yes, though I doubt you'll find anything interesting in the kernel, the
slowdown should happen because the userspace runs slower, it's like
undercloking the cpu, it's not a bottleneck in the kernel that can be
optimized (at least unless there are bugs in the patch which I think not).
