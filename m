Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265410AbSJSABo>; Fri, 18 Oct 2002 20:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265411AbSJSABn>; Fri, 18 Oct 2002 20:01:43 -0400
Received: from ns.suse.de ([213.95.15.193]:23819 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265410AbSJSABm>;
	Fri, 18 Oct 2002 20:01:42 -0400
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
References: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Oct 2002 02:07:41 +0200
In-Reply-To: "Nakajima, Jun"'s message of "19 Oct 2002 01:53:00 +0200"
Message-ID: <p73u1jjnvea.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> writes:


> -asmlinkage int sys_iopl(unsigned long unused)
> +asmlinkage int sys_iopl(struct pt_regs * regs)
>  {
> -       struct pt_regs * regs = (struct pt_regs *) &unused;

The change is wrong. The pt_regs are passed by value on the stack, not by reference.

> 
> -/* Enable FXSR and company _before_ testing for FP problems. */
> -       /*
> -        * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
> -        */
> -       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
> -               extern void __buggy_fxsr_alignment(void);
> -               __buggy_fxsr_alignment();
> -       }

Why does that not work? IMHO it is legal ISO-C

-Andi
