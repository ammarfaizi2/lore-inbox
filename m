Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265455AbUF2FQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbUF2FQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUF2FQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:16:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:42382 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265455AbUF2FQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:16:00 -0400
Date: Mon, 28 Jun 2004 22:15:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200406290432.i5T4WU7k022887@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406282209070.28764@ppc970.osdl.org>
References: <200406290432.i5T4WU7k022887@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jun 2004, Roland McGrath wrote:
> 
> The issue does indeed arise using sysenter, as I explained and is easily
> demonstrated by trying it.  I'm not sure what you mean here when you say,
> "by hand".  The TF trap taken in kernel mode upon sysenter entry causes the
> kernel to return using iret, which restores the TF flag in exactly the same
> way as returning from other kinds of traps, and likewise executes the
> following user-mode instruction.

They are "user-mode" only in theory.

They are really kernel instructions set up by the kernel, and user-mode 
only in the sense that yes, they run in ring3. No actual user-compiled 
code executed anywhere.

At least to me, that vsyscall trampoline is all kernel code. But yes,
you're right, we no longer do the eflags save/restore in user mode, that
was too slow (some of my first versions just cleared TF unconditionally,
and the trampoline was responsible for re-enabling it).

> Are you referring to the signal trampoline for returning from signal
> handlers?  If you are referring to some other trampoline, please clear up
> my confusion.

I was talking about the vsyscall code. 

		Linus
