Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWDRM5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDRM5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDRM5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:57:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21898 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750756AbWDRM5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:57:46 -0400
Date: Tue, 18 Apr 2006 14:57:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060418125728.GA26554@elf.ucw.cz>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> traced.  It takes a bitmask and a length.  A system call is traced
> if its bit is one.  Otherwise, it executes normally, and is
> invisible to the ptracing parent.
> 
> This is not just useful for UML - strace -e could make good use of it as well.

> +	if((current->syscall_mask != NULL) &&

Please put space between if and (.

> @@ -690,6 +693,11 @@ int do_syscall_trace(struct pt_regs *reg
>  	if (!(current->ptrace & PT_PTRACED))
>  		goto out;
>  
> +	if((current->syscall_mask != NULL) && ((long) regs->orig_eax != -1) &&
> +	   !(current->syscall_mask[regs->orig_eax / (8 * sizeof(long))] &
> +	     (1 << (regs->orig_eax % (8 * sizeof(long))))))
> +		goto out;
> +

Same here... and perhaps you can use __get_bit/__set_bit? (this
applies to few more places).

Are you going to fix non-i386, too?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
