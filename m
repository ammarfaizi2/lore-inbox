Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267329AbUHPCKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267329AbUHPCKc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHPCKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:10:32 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:10967 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S267336AbUHPCKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:10:13 -0400
Date: Sun, 15 Aug 2004 19:10:08 -0700
Message-Id: <200408160210.i7G2A8HZ029707@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] waitid system call
In-Reply-To: Andi Kleen's message of  Monday, 16 August 2004 02:03:37 +0200 <m3smaoc5k6.fsf@averell.firstfloor.org>
X-Zippy-Says: ...It's REAL ROUND..  And it's got a POINTY PART right in the
   MIDDLE!!  The shape is SMOOTH..  ..And COLD.. It feels very
   COMFORTABLE on my CHEEK..  I'm getting EMOTIONAL..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure you converted the new _rusage member properly 
> in the 64->32bit siginfo converter? struct rusage uses long.

Aha!  Indeed I did not.  Thanks for pointing that out.

> Better use compat_alloc_user_space() for this. Otherwise it won't
> work for UML/x86-64. Also that will make it easier to port to other
> architectures. 

I followed the model of sys32_rt_sigtimedwait and various compat_*
functions in kernel/compat.c.  In fact, nothing in kernel/compat.c uses
compat_alloc_user_space--and most things in arch/x86_64/ia32/sys_ia32.c use
the direct stack method as well.  To address your concerns, I imagine all
these places should be changed en masse.  

> 
> +	/* 1 if group stopped since last SIGCONT, -1 if SIGCONT since report */
> +  	int			stop_state;
> 
> Can't this be merged into some other field? No need to waste memory
> unnecessarily.

I think it could be merged into group_stop_count.  I just didn't really
want to perturb all that code for the first go-round.  I can make an
attempt at that if all the other potential concerns with the patch are
ironed out.  So far the patch doesn't really touch existing signal code
paths much at all, so it's easier to evaluate.



Thanks,
Roland

