Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277716AbRJIEzQ>; Tue, 9 Oct 2001 00:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277718AbRJIEzG>; Tue, 9 Oct 2001 00:55:06 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20624 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277716AbRJIEy6>; Tue, 9 Oct 2001 00:54:58 -0400
Date: Mon, 8 Oct 2001 22:55:23 -0600
Message-Id: <200110090455.f994tNB22322@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: arjan@fenrus.demon.nl, kravetz@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <20011004.145239.62666846.davem@redhat.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl>
	<20011004.142523.54186018.davem@redhat.com>
	<200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca>
	<20011004.145239.62666846.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: Richard Gooch <rgooch@ras.ucalgary.ca>
>    Date: Thu, 4 Oct 2001 15:39:05 -0600
> 
>    David S. Miller writes:
>    > lat_ctx doesn't execute any FPU ops.  So at worst this happens once
>    > on GLIBC program startup, but then never again.
>    
>    Has something changed? Last I looked, the whole lmbench timing harness
>    was based on using the FPU.
> 
> Oops, that's entirely possible...
> 
> But things are usually layed out like this:
> 
> 	capture_start_time();
> 	context_switch_N_times();
> 	capture_end_time();
> 
> So the FPU hit is only before/after the runs, not during each and
> every iteration.

Hm. Perhaps when I did my tests (where I noticed a penalty), we didn't
have lazy FPU saving. Now we disable the FPU, and restore state when
we trap, right?

I do note this comment in arch/i386/kernel/process.c:
 * We fsave/fwait so that an exception goes off at the right time
 * (as a call from the fsave or fwait in effect) rather than to
 * the wrong process. Lazy FP saving no longer makes any sense
 * with modern CPU's, and this simplifies a lot of things (SMP
 * and UP become the same).

So what exactly is the difference between our "delayed FPU restore
upon trap" (which I think of as lazy FPU saving), and the "lazy FP"
saving in the comments?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
