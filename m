Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWDYQ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWDYQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWDYQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:59:18 -0400
Received: from [198.99.130.12] ([198.99.130.12]:37299 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932255AbWDYQ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:59:17 -0400
Date: Tue, 25 Apr 2006 11:59:42 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060425155942.GA22807@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com> <200604212016.36859.blaisorblade@yahoo.it> <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 09:06:10AM +0200, Heiko Carstens wrote:
> > The flags could be:
> > 
> > MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> > MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> > MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set 
> > differently than the default).

I'd prefer (given that there aren't any unused ptrace arguments) using
the operation for this - PTRACE_SYSCALL_MASK_TRACE,
PTRACE_SYSCALL_MASK_IGNORE.  We'd need better names than these
horribly over-long ones, though.

> You might as well introduce yet another ptrace call which returns the number
> of system calls and for this ptrace call force user space to pass a complete
> bitmap. Sounds easier to me.

I think that's just building in fragility whenever userspace doesn't
happen to match the kernel.  Both UML and strace will know what system
calls they are interested in.  Having the kernel 1- or 0-extend the
mask will automatically do the right thing.  If userspace is newer
than the kernel, and asks for special treatment for system calls that
don't exist, then it should get a -EINVAL.

				Jeff
