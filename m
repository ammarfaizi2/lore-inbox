Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbTCPLW2>; Sun, 16 Mar 2003 06:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbTCPLW2>; Sun, 16 Mar 2003 06:22:28 -0500
Received: from holomorphy.com ([66.224.33.161]:47829 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262654AbTCPLW1>;
	Sun, 16 Mar 2003 06:22:27 -0500
Date: Sun, 16 Mar 2003 03:32:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
Message-ID: <20030316113254.GH20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20030316101055.GG20188@holomorphy.com> <17275.1047813144@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17275.1047813144@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 02:10:55 -0800, William Lee Irwin III wrote:
>> Hmm. It shouldn't make a difference with respect to optimizing them.
>> My API passes transparently by reference:
>> #define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)

On Sun, Mar 16, 2003 at 10:12:24PM +1100, Keith Owens wrote:
> Some of the 64 bit archs implement test_bit() as taking int * instead
> of long *.  That generates unoptimized code for the case of NR_CPUS <
> 64.
> #if NR_CPUS < 64
> #define cpu_isset(cpu, map)		(map.mask & (1UL << (cpu)))
> ...
> generates better code on those architectures.  Yet another special case :(

NUMA-Q is 32-bit so maybe there's more to be done, but never mind that.
But in general, what else can I do for you here? IIRC the MIPS tree is
still stuck around 2.5.47, and I've got little or no idea about the
status of larger MIPS boxen in 2.4.x and much less of one for 2.5.x.
I might need a little more to go on.

One of the major sticking points I appear to have developed here is
that I need to go around sweeping arch code for this stuff, but I don't
have the boxen and can barely build the trees (if at all) for non-x86.
What's the state of 2.5.x on the big machines where you're at?

Another thought I had was wrapping things in structures for both small
and large, even UP systems so proper typechecking is enforced at all
times. That would probably need a great deal of arch sweeping to do,
especially as a number of arches are UP-only (non-SMP case's motive #2).

I'm glad that _someone_ is talking, the lack of feedback on this has
been a bit depressing, especially given its "we needed this 5 years ago"
(from multiple vendors/arches) nature and general triviality.


-- wli
