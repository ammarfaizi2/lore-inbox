Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbTCOVNw>; Sat, 15 Mar 2003 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbTCOVNw>; Sat, 15 Mar 2003 16:13:52 -0500
Received: from ns.suse.de ([213.95.15.193]:25348 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261585AbTCOVNu>;
	Sat, 15 Mar 2003 16:13:50 -0500
Date: Sat, 15 Mar 2003 22:24:38 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Hammer thread fixes
Message-ID: <20030315212438.GA8113@wotan.suse.de>
References: <3E739514.8010300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E739514.8010300@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 01:03:16PM -0800, Ulrich Drepper wrote:
> The appended two fixes are necessary to get NPTL threads running on
> hammer.  The changes should be obvious.  The exit_group syscall isn't
> present at all so far and the r10 -> r8 register use is necessary
> because syscall parameter #4 (in r10) is already used for the child_tid
> parameter.

It's incorrect like I told you last time. arg 4 is in r10. Linus please don't
apply.

The clone prototype is 

	int clone(int flags, unsigned long newsp, void *parent_tid, void *child_tid) ;

	rax: __NR_clone
	rdi: flags
	rsi: newsp 
	rdx: parent_tid
	r10: child_tid

See appendix A of the x86-64 ABI for details.	 The kernel ABI 
is different from the user space ABI because of the SYSCALL clobbers.

For exit_group please wait for my next merge.

-Andi
