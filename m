Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUGAPPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUGAPPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUGAPPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:15:09 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:55938 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264275AbUGAPPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:15:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 1 Jul 2004 08:14:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@redhat.com, cagney@redhat.com, Daniel Jacobowitz <drow@false.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200407010747.i617lxIB019894@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0407010808010.19793@bigblue.dev.mdolabs.com>
References: <200407010747.i617lxIB019894@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Roland McGrath wrote:

> > Roland, I don't think (pretty sure actually ;) we can handle the case 
> > where TF is set from userspace and, at the same time, the user uses 
> > PTRACE_SINGLESTEP. 
> 
> I don't know where you pulled the notion of that case from.  I certainly
> never mentioned it.  When I raised the case of user-mode setting of TF, I
> was quite clear that it's a case when ptrace is not involved.

Sorry, since it was obvious that if the user sets TF in userspace, he 
won't see the instruction following the int80, I thought you meant the 
interaction between userspace-TF and ptrace. That's documented in x86 
manuals and I don't think we should even try to have the userspace-TF to 
have a different behaviour from what x86 describe.



> > The PTRACE_SINGLESTEP gives you the SYSGOOD behaviour, if you set it. And 
> > sends a SIGTRAP notification to the ptrace'ing parent process.
> 
> Like I said before, that is a change in the behavior.  Since its inception,
> SYSGOOD has meant exactly and only that when you use PTRACE_SYSCALL you
> will get a different notification for a syscall-tracing stop than other
> sources of SIGTRAP that may arise during execution of user code between
> system calls.  At no time ever before, has it been possible to get the
> SIGTRAP|0x80 wait result when you had not just called PTRACE_SYSCALL.
> After your change, calling PTRACE_SINGLESTEP can now produce that result.
> I don't think that change is a good thing.  
> 
> As the originator of the SYSGOOD option, Dan might have a comment about this.

Here I meant that if you set SINGLESTEP|SYSGOOD, the patch will give you 
SIGTRAP|0x80, while if you set only SINGLESTEP the patch will give you 
SIGTRAP. Enforcing the SINGLESTEP|SYSGOOD is invalid or only gives SIGTRAP 
should be no more that three lines of code out of the fast path.



- Davide

