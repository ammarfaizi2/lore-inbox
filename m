Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUGAUY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUGAUY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUGAUY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:24:56 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:4580 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S266257AbUGAUYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:24:54 -0400
Date: Thu, 1 Jul 2004 13:24:51 -0700
Message-Id: <200407012024.i61KOp3J021841@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@redhat.com, cagney@redhat.com, Daniel Jacobowitz <drow@false.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: Davide Libenzi's message of  Thursday, 1 July 2004 08:14:54 -0700 <Pine.LNX.4.58.0407010808010.19793@bigblue.dev.mdolabs.com>
X-Windows: all the problems and twice the bugs.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's documented in x86 manuals and I don't think we should even try to
> have the userspace-TF to have a different behaviour from what x86 describe.

The behavior described for the chip is that it traps after executing one
instruction.  From the user-mode perspective, the system call instruction
is one instruction that does not normally generate any kind of exception.
It just does one magic thing, that being having the kernel do something for
you.  If someone sets TF in user mode then they probably expect that they
will get a trap after executing one instruction, even that one.

> Here I meant that if you set SINGLESTEP|SYSGOOD, the patch will give you 
> SIGTRAP|0x80, while if you set only SINGLESTEP the patch will give you 
> SIGTRAP. Enforcing the SINGLESTEP|SYSGOOD is invalid or only gives SIGTRAP 
> should be no more that three lines of code out of the fast path.

There is no "set SINGLESTEP|SYSGOOD".  PTRACE_SINGLESTEP is a one-time
operation.  PTRACE_O_TRACESYSGOOD is a persistent flag you set when you
intend to at some point use the PTRACE_SYSCALL operation.

