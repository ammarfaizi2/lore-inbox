Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265695AbUFDJul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUFDJul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUFDJuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:50:40 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36066 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265695AbUFDJrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:47:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16576.17673.548349.36588@alkaid.it.uu.se>
Date: Fri, 4 Jun 2004 11:46:49 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
In-Reply-To: <20040604093712.GU21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Fri, Jun 04, 2004 at 11:31:24AM +0200, Mikael Pettersson wrote:
 > > Please don't. cpus_addr() is useful when you need to get a
 > > handle on the representation for non-cpumask_t operations.
 > > Case in point: the perfctr kernel extension needs to communicate
 > > a cpumask_t to user-space because of the asymmetric nature of
 > > HT P4s. Unfortunately, a simple copy_to_user() won't work because:
 > > a) the size depends on kernel .config, and
 > > b) the representation is defined in terms of sequences of ulong,
 > >    which breaks 32-bit applications on 64-bit kernels.
 > > So perfctr instead converts a cpumask_t to a sequence of uint,
 > > and copies both the number of uints and the uints themselves
 > > to user-space.
 > > Having to do this conversion with a for-each-CPU type loop would
 > > be slow and ugly, and would IMO show that the cpumask_t ADT had
 > > become an obstacle to the actual work that needs to be done.
 > > So please keep cpus_addr().
 > 
 > If the marshalling code presents different formats to userspace
 > depending on BITS_PER_LONG then it's buggy.

No. Read what I wrote: binary compatibility was the very problem I
set out to solve, not cause.

For a given cpumask_t value, user-space sees the same binary
representation irregardless of how you combine 32 or 64-bit
user-spaces with 32 or 64-bit kernels.

This has all been worked out on x86 and amd64, and the conversion
is endian-neutral so e.g. ppc32 on ppc64 should work.
