Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUDFGkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbUDFGkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:40:12 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:30662 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262720AbUDFGkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:40:05 -0400
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       colpatch@us.ibm.com
In-Reply-To: <20040405230601.62c0b84c.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1081128401.18831.6.camel@bach> <20040405000528.513a4af8.pj@sgi.com>
	 <1081150967.20543.23.camel@bach> <20040405010839.65bf8f1c.pj@sgi.com>
	 <1081227547.15274.153.camel@bach>  <20040405230601.62c0b84c.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1081233543.15274.190.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 16:39:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 16:06, Paul Jackson wrote:
> > You'll have covered about 300 of them.  I don't think a complete
> > abstraction is actually required or desirable:
> 
> I suspect we've hit on our first area of actual disagreement here.
> 
> You observe that providing inline wrappers for the 5 most commonly
> used cpumask macros would cover 300 of the 420 uses.  The other 23
> or so macros are less commonly used.  Sounds about right ...
> 
> I prefer to provide all 28 macros.  I don't see a cost, but do see
> a gain.

Because I believe one should *always* resist the urge to write
infrastructure.  Wait until the users of your functionality gather out
the front of your house with torches because they're all sick of the
burden of using existing infrastructure.

Really.

I don't even want to learn 28 bitops primitives.  I certainly don't want
to learn 28 nodemask and 28 cpumask primitives.

I prefer a single set of operators, but preempting complaints means
figuring out what people want.  I'd be happy with the obviously
cpu-specific ones, myself:

	first_cpu
	next_cpu
	any_online_cpu
	cpumask_of_cpu

> The gain is that someone coding some operations on a cpumask doesn't
> have to go fishing around in multiple places to find out what ops
> are supported

Agreed.  That's a big benefit of cutting it out altogether.

> Just to be specific, a typical implementation for such an operator would look like:
> 
>     typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
> 
>     static inline void cpus_or(cpumask_t d, const cpumask_t s1, const cpumask_t s2)
>     {
> 	bitmap_or(d.bits, s1.bits, s2.bits, NR_CPUS);
>     }

That'd be a noop, I think.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

