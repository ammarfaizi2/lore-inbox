Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266277AbUGAUfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUGAUfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUGAUfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:35:13 -0400
Received: from nevyn.them.org ([66.93.172.17]:1439 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266277AbUGAUfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:35:04 -0400
Date: Thu, 1 Jul 2004 16:34:56 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@redhat.com, cagney@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
Message-ID: <20040701203455.GA22888@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	mingo@redhat.com, cagney@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0406282146470.24039@bigblue.dev.mdolabs.com> <200407010747.i617lxIB019894@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407010747.i617lxIB019894@magilla.sf.frob.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:47:59AM -0700, Roland McGrath wrote:
> > Roland, I don't think (pretty sure actually ;) we can handle the case 
> > where TF is set from userspace and, at the same time, the user uses 
> > PTRACE_SINGLESTEP. 
> 
> I don't know where you pulled the notion of that case from.  I certainly
> never mentioned it.  When I raised the case of user-mode setting of TF, I
> was quite clear that it's a case when ptrace is not involved.
> 
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

I am not the originator of PTRACE_O_TRACESYSGOOD, I just had the bad
luck to touch it.

I think reporting the system call using 0x80|SIGTRAP when you
PTRACE_SINGLESTEP over the trap instruction makes excellent good sense.

-- 
Daniel Jacobowitz
