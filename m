Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVCMUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVCMUGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVCMUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:06:40 -0500
Received: from nevyn.them.org ([66.93.172.17]:22934 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261442AbVCMUGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:06:34 -0500
Date: Sun, 13 Mar 2005 15:06:26 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050313200626.GB21521@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050309001254.GA1496@nevyn.them.org> <200503130827.j2D8RwBn025542@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503130827.j2D8RwBn025542@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 12:27:58AM -0800, Roland McGrath wrote:
> This patch further cleans up the appearance of TF in eflags when ptrace is
> involved.  With this, PTRACE_SINGLESTEP will not cause TF to appear in
> eflags as seen by PTRACE_GETREGS and the like, when the instruction faulted
> for some reason other than the single-step trap.
> 
> This moves the check added by Dan's patch from setup_sigcontext to
> handle_signal.  This is a cosmetic difference, but I think it makes more
> sense to consolidate all the "reset registers to canonical state" work in
> the same place (i.e. put it with the syscall rollback code), separate from
> the signal handler setup.  The change that matters is moving the similar
> check out of do_debug, where it only covers the case of a single-step trap.
> Instead, it goes into the ptrace_signal_deliver macro, which is called
> before the ptrace stop for whatever signal results from whatever kind of
> fault in that instruction (or asynchronous signal).  With that, the
> handle_signal check is still needed only for the case of PTRACE_SINGLESTEP
> with a handled signal.
> 
> 
> Thanks,
> Roland

Thanks, looks right to me!


-- 
Daniel Jacobowitz
CodeSourcery, LLC
