Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVCIAPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVCIAPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCIAOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:14:21 -0500
Received: from nevyn.them.org ([66.93.172.17]:65433 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262240AbVCIANF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:13:05 -0500
Date: Tue, 8 Mar 2005 19:12:55 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050309001254.GA1496@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Cagney <cagney@redhat.com>
References: <20050307044920.GA25093@nevyn.them.org> <200503072129.j27LTCnl030702@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503072129.j27LTCnl030702@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 01:29:12PM -0800, Roland McGrath wrote:
> > Is this semantically different from the patch I posted, i.e. is there
> > any case which one of them covers and not the other?
> 
> Yes, the second case that I described when I said there were two cases!
> (Sheesh.)

Calm down, there were already two cases.  I reread your message and
couldn't pick out the answer, or I wouldn't have asked.

>  To repeat, when the process was doing PTRACE_SINGLESTEP and then
> stops on some other signal rather than because of the single-step trap
> (e.g. single-stepping an instruction that faults), ptrace will show TF set
> in its registers.  With my patch, it will show TF clear.

I can reproduce this problem with the patch that Linus committed, so
you should probably update your patch for a current snapshot and nag
him about it.

> > That is an inability to set breakpoints in the vsyscall page.  Andrew
> > told me (last May, wow) that he thought this worked in Fedora, but I
> > haven't seen any signs of the code.  It would certainly be a Good Thing
> > if it is possible!
> 
> Fedora kernels use a normal mapping (with randomized location) for the
> page, rather than the fixed high address in the vanilla kernel.  The
> FIXADDR_USER_START area is globally mapped in a special way not using
> normal vma data structures, and is permanently read-only in all tasks.  
> COW via ptrace works normally for Fedora's flavor, but no writing is ever
> possible to the fixmap page.

Blech.  I assume that there is no way to map a normal VMA over top of
the fixed page, for a particular process?  This makes debugging the
vsyscall DSO a real pain.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
