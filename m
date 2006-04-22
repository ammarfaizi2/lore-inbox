Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWDVSfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWDVSfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWDVSfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:35:32 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:2988 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750888AbWDVSfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:35:31 -0400
Date: Sat, 22 Apr 2006 09:06:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com> <200604212016.36859.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604212016.36859.blaisorblade@yahoo.it>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For UML, instead, it's important to set that some peculiar syscalls are not 
> traced, that the mask is 1-extended and that errors are reported.
> 
> So, I suggest a "flags" parameter for this. Sadly, we're using the ptrace() 
> syscall and there's no 5th argument normally, we could either use it (IIRC 
> some calls use the 5th regs indeed), or pass as "data" a struct with flags 
> and the mask.
> 
> The flags could be:
> 
> MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set 
> differently than the default).
> 
> probably with a reasonable prefix to avoid namespace pollution (something like 
> "PT_SC_-").

You might as well introduce yet another ptrace call which returns the number
of system calls and for this ptrace call force user space to pass a complete
bitmap. Sounds easier to me.

> > The tracing process won't see 
> > any of the non existant syscalls it requested to see anyway.
> No, you misunderstood the code, it does the opposite very different - the loop 

Looks I missed a few "!"s :)
