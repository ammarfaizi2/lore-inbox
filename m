Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUDFFAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 01:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUDFFAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 01:00:25 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:49891 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263618AbUDFFAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 01:00:18 -0400
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       haveblue@us.ibm.com, colpatch@us.ibm.com
In-Reply-To: <20040405010839.65bf8f1c.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1081128401.18831.6.camel@bach> <20040405000528.513a4af8.pj@sgi.com>
	 <1081150967.20543.23.camel@bach>  <20040405010839.65bf8f1c.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1081227547.15274.153.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 14:59:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 18:08, Paul Jackson wrote:
> > get rid of the
> > asm-generic/cpumask_optimized_for_large_smp_with_sparse_array_and_small_stack.h
> 
> My mask patch does this.

Yes, which is why I'm such a fan.

> > then finally look at how ugly it would be to change users to
> > directly using the bitmap.h functions on cpumasks.
> 
> That boils down to a very straightforward question.  Do we ask
> them to write:
> 
> 	cpus_or(s.bits, d1.bits, d2.bits)
> 
> or:
> 
> 	bitmap_or(s.bits, d1.bits, d2.bits, NR_CPUS);
> 
> I prefer the first choice.  It requires a thin cpumask.h header
> to wrap the bitmap ops, and add the final NR_CPUS to each one.

Well, you'd do presumably:
	cpus_or(&s, &d1, &d2);

And make cpus_or() an inline so you get typechecking.

But my rough grepping reveals that there are around 420 uses of all the
cpu macros throughout the kernel.  But if you merely implement:

	any_online_cpu
	cpumask_of_cpu
	cpu_isset
	cpu_set
	cpu_clear

You'll have covered about 300 of them.  I don't think a complete
abstraction is actually required or desirable: if someone wants to do
something tricky (like anding, oring, etc), there's nothing wrong with
accessing cpu.bits.

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

