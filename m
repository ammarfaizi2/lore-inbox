Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGAHsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGAHsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUGAHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:48:12 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:38534 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264251AbUGAHsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:48:04 -0400
Date: Thu, 1 Jul 2004 00:47:59 -0700
Message-Id: <200407010747.i617lxIB019894@magilla.sf.frob.com>
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
In-Reply-To: Davide Libenzi's message of  Tuesday, 29 June 2004 00:00:50 -0700 <Pine.LNX.4.58.0406282146470.24039@bigblue.dev.mdolabs.com>
X-Shopping-List: (1) Grievous chowder
   (2) Medical money
   (3) Mauve bag lunches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland, I don't think (pretty sure actually ;) we can handle the case 
> where TF is set from userspace and, at the same time, the user uses 
> PTRACE_SINGLESTEP. 

I don't know where you pulled the notion of that case from.  I certainly
never mentioned it.  When I raised the case of user-mode setting of TF, I
was quite clear that it's a case when ptrace is not involved.

> The PTRACE_SINGLESTEP gives you the SYSGOOD behaviour, if you set it. And 
> sends a SIGTRAP notification to the ptrace'ing parent process.

Like I said before, that is a change in the behavior.  Since its inception,
SYSGOOD has meant exactly and only that when you use PTRACE_SYSCALL you
will get a different notification for a syscall-tracing stop than other
sources of SIGTRAP that may arise during execution of user code between
system calls.  At no time ever before, has it been possible to get the
SIGTRAP|0x80 wait result when you had not just called PTRACE_SYSCALL.
After your change, calling PTRACE_SINGLESTEP can now produce that result.
I don't think that change is a good thing.  

As the originator of the SYSGOOD option, Dan might have a comment about this.



Thanks,
Roland
