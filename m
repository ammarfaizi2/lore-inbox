Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUDEIKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUDEIKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:10:30 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:59986 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261798AbUDEIKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:10:23 -0400
Date: Mon, 5 Apr 2004 01:08:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040405010839.65bf8f1c.pj@sgi.com>
In-Reply-To: <1081150967.20543.23.camel@bach>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Throw away mask.h, and make any needed enhancements to bitmap.h (eg.
> inlines which check for the case of len <= BITS_PER_LONG).

That seems like a good, easy and localized change.  Ok,
I will see if how it looks after I try to code it.


> get rid of the
> asm-generic/cpumask_optimized_for_large_smp_with_sparse_array_and_small_stack.h

My mask patch does this.


> then finally look at how ugly it would be to change users to
> directly using the bitmap.h functions on cpumasks.

That boils down to a very straightforward question.  Do we ask
them to write:

	cpus_or(s.bits, d1.bits, d2.bits)

or:

	bitmap_or(s.bits, d1.bits, d2.bits, NR_CPUS);

I prefer the first choice.  It requires a thin cpumask.h header
to wrap the bitmap ops, and add the final NR_CPUS to each one.

I believe the 2nd choice introduces one more way to screw up,
by specifying the wrong bitsize.  I've got enough such ways
already - don't need more.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
