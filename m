Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUFDRYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUFDRYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFDRYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:24:00 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:27108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265886AbUFDRXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:23:45 -0400
Date: Fri, 4 Jun 2004 10:29:46 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604102946.1d501953.pj@sgi.com>
In-Reply-To: <20040604165601.GC21007@holomorphy.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill wrote:
> This is patently ridiculous. Make a compat_sched_getaffinity(), and
> likewise for whatever else is copying unsigned long arrays to userspace.

Earlier, Andrew wrote:
> In that case the cpumask code should provide some API function which
> converts a cpumask_t into (and from?) some canonical and documented form. 
> Then you copy what it gave you to userspace.

I'd vote to have the documented form that Andrew speaks of be arrays
of 32-bit words, which is what I understood Mikael was doing.  I agree
with Andrew's suggested to/from canonical functions.

I'd prefer not copying arrays of unsigned longs, due to the confusions
of coding to them across 32/64 bit and big/little endian architectures.
At times I have wished the kernel had chosen u32 arrays instead of
unsigned long arrays for bitmaps, for the same reason.  The cpumask
sprintf and parse format is intentionally 32-bit chunk friendly.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
