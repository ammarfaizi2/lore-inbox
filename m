Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUEaCRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUEaCRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 22:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUEaCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 22:17:43 -0400
Received: from main.gmane.org ([80.91.224.249]:40662 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264513AbUEaCRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 22:17:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: How to use floating point in a module?
Date: Mon, 31 May 2004 04:18:28 +0200
Message-ID: <yw1xbrk5baq3.fsf@kth.se>
References: <200405310152.i4V1qNk03732@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:JWm6+FKx3wyFHTb6PxEZXzKRl0s=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ndiamond@despammed.com writes:

> A driver, implemented as a module, must do some floating-point
> computations including trig functions.

Sorry, floating point in the Linux kernel isn't allowed.

> Fortunately the architecture is x86.  A few hundred kilograms of
> searching (almost a ton of searching :-) seems to reveal the
> following possibilities.
>
> Recompile GNU's libc with option "--without-fp".  If I understand
> correctly, the resulting libc will completely avoid using
> floating-point hardware while providing floating-point computations to
> its client.  Do I understand correctly?

Probably, but it doesn't matter, since the kernel doesn't link with
libc.

> Compile the module's .c files with gcc's "-msoft-float" option and
> "-D__NO_MATH_INLINES".  (Actually I think "-D__NO_MATH_INLINES" is
> probably unnecessary here.)

Using floating point emulation will be VERY slow.

> Link the module's .o files with the version of libc produced above,
> and try to get a loadable .ko from this... or a loadable .o since the
> target is still kernel 2.4.something.

As I said, the kernel doesn't link with libc.

> But I'm sure there must be a ton of pitfalls that I'm not seeing here.
> I'm not the first poor slob who got tasked with shoving some
> floating-point into a module.  My searches found a few tricks that
> people used for a few floating-point operations, but they used the
> real floating-point hardware and they didn't really reveal all the
> trickery they used.  (Not that I can blame them, since the hackery
> they did must be virtually unteachable.)  I didn't find anyone saying
> that they found a safe method of doing it, whether or not a safe
> method might somewhat resemble the ideas I've just presented.  I
> didn't find anyone saying they got trig functions into it either.  If
> my ideas could possibly work, surely they would have been done
> already.  So, what am I missing?

Floating point is forbidden in kernel code since the floating point
registers (and other floating point context) is not saved/restored
during system calls, for efficiency.  I'm speculating here, but it
might be possible to manually save the floating point context while
doing some floating point operations.  The problem arises if this code
is interrupted midway.  Using a preemptive 2.6 kernel would easily
break here.

What you should do is think again about why you need all this floating
point in the kernel.  Could it be moved to userspace somehow?  Maybe
you could use lookup tables instead of doing floating point
arithmetic.

-- 
Måns Rullgård
mru@kth.se

