Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUFDLR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUFDLR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUFDLR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:17:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:48264 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264236AbUFDLR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:17:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16576.23059.490262.610771@alkaid.it.uu.se>
Date: Fri, 4 Jun 2004 13:16:35 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
In-Reply-To: <20040604095929.GX21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > William Lee Irwin III writes:
 > >> If the marshalling code presents different formats to userspace
 > >> depending on BITS_PER_LONG then it's buggy.
 > 
 > On Fri, Jun 04, 2004 at 11:46:49AM +0200, Mikael Pettersson wrote:
 > > No. Read what I wrote: binary compatibility was the very problem I
 > > set out to solve, not cause.
 > > For a given cpumask_t value, user-space sees the same binary
 > > representation irregardless of how you combine 32 or 64-bit
 > > user-spaces with 32 or 64-bit kernels.
 > > This has all been worked out on x86 and amd64, and the conversion
 > > is endian-neutral so e.g. ppc32 on ppc64 should work.
 > 
 > cpumask_scnprintf() is correct to all appearances... testcase please.

How large buf does it need? I don't see any spec for that in 2.6.6.

Second, let's just say that while some kernel people think that
converting stuff to ASCII is "neat", I'm not one of them. It's
just a waste of time and space, for both kernel and user-space.
I'd rather do a for-each-CPU loop which strictly keeps to cpumask_t
operations than take a detour via ASCII.
