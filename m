Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVCGVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVCGVeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVCGVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:31:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261822AbVCGV3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:29:22 -0500
Date: Mon, 7 Mar 2005 13:29:12 -0800
Message-Id: <200503072129.j27LTCnl030702@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
In-Reply-To: Daniel Jacobowitz's message of  Sunday, 6 March 2005 23:49:20 -0500 <20050307044920.GA25093@nevyn.them.org>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this semantically different from the patch I posted, i.e. is there
> any case which one of them covers and not the other?

Yes, the second case that I described when I said there were two cases!
(Sheesh.)  To repeat, when the process was doing PTRACE_SINGLESTEP and then
stops on some other signal rather than because of the single-step trap
(e.g. single-stepping an instruction that faults), ptrace will show TF set
in its registers.  With my patch, it will show TF clear.

> That is an inability to set breakpoints in the vsyscall page.  Andrew
> told me (last May, wow) that he thought this worked in Fedora, but I
> haven't seen any signs of the code.  It would certainly be a Good Thing
> if it is possible!

Fedora kernels use a normal mapping (with randomized location) for the
page, rather than the fixed high address in the vanilla kernel.  The
FIXADDR_USER_START area is globally mapped in a special way not using
normal vma data structures, and is permanently read-only in all tasks.  
COW via ptrace works normally for Fedora's flavor, but no writing is ever
possible to the fixmap page.


Thanks,
Roland
