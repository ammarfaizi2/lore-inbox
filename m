Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUDEHnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUDEHnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:43:01 -0400
Received: from ozlabs.org ([203.10.76.45]:40326 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261786AbUDEHm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:42:58 -0400
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       haveblue@us.ibm.com, colpatch@us.ibm.com
In-Reply-To: <20040405000528.513a4af8.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1081128401.18831.6.camel@bach>  <20040405000528.513a4af8.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1081150967.20543.23.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 17:42:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 17:05, Paul Jackson wrote:
>  P.S. - Perhaps you real concern here is that I'm not going far enough.
> 
> 	Instead of just putting the cpumask_t internals on a diet
> 	and allowing for a nodemask_t that shares implementation,
> 	rather I should change both outright, to the more explicit
> 	style that is perhaps what you have in mind:
> 
> 	    struct cpumap { DECLARE_BITMAP(bits, NR_CPUS); };
> 	    struct cpumask s, d1, d2;
> 	    bitmap_or(s.bits, d1.bits, d2.bits);
> 
> 	Nuke cpumask_t, nodemask_t and the existing cpus_or,
> 	nodes_or, ... and similar such 60 odd various macros
> 	specific to these two types.
> 
> 	I rather like that approach.  It would build nicely on
> 	what I've done so far.  It would be a more intrusive patch,
> 	changing all declarations and operations on cpumasks.

Yes,  this is exactly the point I was incoherently groping towards. 
Throw away mask.h, and make any needed enhancements to bitmap.h (eg.
inlines which check for the case of len <= BITS_PER_LONG).

Then change cpumask_t and nodemask_t ops to inlines which just use
bitmap.h, and get rid of the
asm-generic/cpumask_optimized_for_large_smp_with_sparse_array_and_small_stack.h etc. and then finally look at how ugly it would be to change users to directly using the bitmap.h functions on cpumasks.

> 	If I thought it would sell, I would be most interested.

I guess I'd like to see the cost of perfection.  It could just be that
the current cpumask_t headers creep me out...

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

