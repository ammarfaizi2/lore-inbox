Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUHUAEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUHUAEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 20:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268288AbUHUAEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 20:04:07 -0400
Received: from holomorphy.com ([207.189.100.168]:32460 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264973AbUHUAEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 20:04:02 -0400
Date: Fri, 20 Aug 2004 17:03:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040821000343.GR11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com> <20040820233126.GJ1945@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820233126.GJ1945@krispykreme>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Parallel compilation is an extremely poor benchmark in general, as the
>> workload is incapable of being effectively scaled to system sizes, the
>> linking phase is inherently unparallelizable and the compilation phase
>> too parallelizable to actually stress anything. There is also precisely
>> zero relevance the benchmark has to anything real users would do.

On Sat, Aug 21, 2004 at 09:31:26AM +1000, Anton Blanchard wrote:
> I spend most of my life compiling kernels and I consider myself a real
> user :)

Kernel hacking is not an end in itself, regardless of the fact there
are some, such as myself, who use computers for no other purpose. A
real user generally has some purpose to their activity beyond working
on the software or hardware they are "using". e.g. various real users
use their systems for entertainment: playing games, music, and movies.
Others may use their systems to make money somehow, e.g. archiving
information about customers so they can look up what they've bought
and paid for or have yet to pay for.

Regardless of the social issue, the rather serious technical deficits
of compilation of any software as a benchmark are showstopping issues.
Frankly, even the issues I've dredged up are nowhere near comprehensive.
There are further issues such as that stable (i.e. not varying across
the benchmarks being done on various systems at various times) versions
of the software being compiled and the toolchain being used to compile
it are lacking as components of any "kernel compile benchmarking suite"
and worse still the variance in target architecture of the toolchain
also defeats any attempt at meaningful benchmarking.

If you're truly concerned about compilation speed, userspace is going
to be the most productive area to work on anyway, as the vast majority
of time during compilation is spent in userspace. AIUI the userspace
algorithms in gcc are not particularly cognizant of cache locality and
in various instances have suboptimal time and space behavior, so it's
not as if there isn't work to be done there. Improving the compactness
and cache locality of data structures is important in userspace also,
and most (perhaps all) userspace programs are grossly ignorant of this.
FWIW, there are notable kernel hackers known to use very downrev gcc
versions due to regressions in compilation speed in subsequent versions,
so there are already large known differences in compilation speed that
can be obtained just by choosing a different compiler version.


-- wli
