Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWD2ItL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWD2ItL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWD2ItL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:49:11 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:52017 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751162AbWD2ItK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:49:10 -0400
Date: Sat, 29 Apr 2006 10:49:07 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060429084907.GD9463@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604282228.46681.blaisorblade@yahoo.it>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, this gives us a definite proposal, which I finally like:
> 
> * to exclude sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_NOTRACE, bitmask);
> 
> * to trace only sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_TRACEONLY, bitmask);
> 
> Semantics:
> 
> in both cases, the mask is first zero-extended to the right (for syscalls not 
> known to userspace), bits for syscall not known to the kernel are checked and 
> the call fails if any of them is 1, and in the failure case E2BIG or 
> EOVERFLOW is returned (I want to avoid EINVAL and ENOSYS to avoid confusion) 
> and the part of the mask known to the kernel is 0-ed.
> 
> In case of success, for NOTRACE (which was DEFAULT_TRACE) the mask is reversed 
> before copying in the kernel syscall mask, for TRACEONLY it's copied there 
> directly.

IMHO this is way too complicated. Introducing a ptrace call that returns
the number of syscalls and forcing user space to pass a complete bitmask
is much easier. Also the semantics are much easier to understand.

In addition your proposal would already introduce a rather complicated
interface to figure out how many syscalls the kernel has. I'm sure this
will be (mis)used sooner or later.
