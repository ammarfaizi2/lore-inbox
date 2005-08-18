Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVHRLpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVHRLpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVHRLpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:45:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:15599 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932205AbVHRLpx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:45:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: Re: xtensa-clean-up-system-call-list-and-interface.patch added to -mm tree
Date: Thu, 18 Aug 2005 13:37:34 +0200
User-Agent: KMail/1.7.2
Cc: czankel@tensilica.com, chris@zankel.net
References: <200508171949.j7HJnltq005970@shell0.pdx.osdl.net>
In-Reply-To: <200508171949.j7HJnltq005970@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508181337.35277.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 17 August 2005 21:52, akpm@osdl.org wrote:
> +#ifdef __KERNEL_SYSCALLS__
>  
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <linux/syscalls.h>
> +
> +struct pt_regs;
> +struct sigaction;
> +asmlinkage long xtensa_execve(char *filenamei, char **argv, char **envp,
> +                             struct pt_regs *regs);
> +asmlinkage long xtensa_clone(unsigned long clone_flags, unsigned long newsp,
> +                            struct pt_regs *regs);
> +asmlinkage long xtensa_pipe(unsigned long *fildes);
> +asmlinkage long xtensa_ptrace(long request, long pid, long addr, long data);
> +asmlinkage long xtensa_rt_sigaction(int sig,
> +                                   const struct sigaction __user *act,
> +                                   struct sigaction __user *oact,
> +                                   size_t sigsetsize);
>  

These definitions should not be #ifdef __KERNEL_SYSCALLS__. That define
used to have a very different meaning, which is now deprecated.

I think it would be best to simply put all the above stuff into a new
asm/syscalls.h which is then included from arch/xtensa/kernel/syscalls.c.

	Arnd <><
