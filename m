Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273413AbRINPBL>; Fri, 14 Sep 2001 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273408AbRINPBB>; Fri, 14 Sep 2001 11:01:01 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:3619 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S273407AbRINPAt>; Fri, 14 Sep 2001 11:00:49 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: Arjan Filius <iafilius@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <3BA1B222.806F43AA@mvista.com>
In-Reply-To: <Pine.LNX.4.33.0109102323450.24212-100000@sjoerd.sjoerdnet>
	<1000402027.23162.45.camel@phantasy>  <3BA1B222.806F43AA@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.12.07.08 (Preview Release)
Date: 14 Sep 2001 11:01:41 -0400
Message-Id: <1000479706.2147.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-14 at 03:30, george anzinger wrote:
> Right, the same problem as using floating point in the kernel (mmx uses
> the FP regs and they are not saved).

Right, and I suspect we will find more problems of this type as we go
on.  In fact, the more general case "things that are SMP-safe but not
preempt safe" will be issues, too.  The highmem bug was one of these -
code that was SMP-safe but did not have lock points because it was
per-CPU code.  Preemption ruins all that.

> The question is: Just how long do these routines take?  If it is very long
> it may be best to just say no. One way would be to always pretend that
> the"in_interrupt" flag is set.  I think possibly some routines are
> short and the switch off/ switch on pair is right, but for the long ones,
> well the preemption patch is supposed to make the kernel more preemptable,
> not less.  Any one have execution times for these functions?

Well, its the routines in arch/i386/lib/mmx.c -- and just the ones that
call kernel_begin/end_fpu.  My patch pushes a ctx_sw_off/on pair into
those functions.  Anyhow, if you look, they aren't too long.

However, I agree that we may be destroying our purpose here.  A user of
the patch actually put together a patch that will disable the CONFIG to
use the fast MMX memcpy stuff if preemption was enabled.  He benchmarked
against the two and I can send you those results when I sort through
them.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

