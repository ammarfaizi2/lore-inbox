Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVBQEOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVBQEOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVBQEOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:14:34 -0500
Received: from mail.renesas.com ([202.234.163.13]:33926 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262204AbVBQEO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:14:26 -0500
Date: Thu, 17 Feb 2005 13:14:18 +0900 (JST)
Message-Id: <20050217.131418.179964000.takata.hirokazu@renesas.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.11-rc4] m32r: fix sys_clone() (was [PATCH 2.6.10-bk4]
 m32r: fix sys_clone())
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050217.121833.102580134.takata.hirokazu@renesas.com>
References: <20050217.121833.102580134.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I missed the previous mail's subject.
This patch is against 2.6.11-rc4 or 2.6.11-rc4-bk4.

-- Takata

From: Hirokazu Takata <takata@linux-m32r.org>
Subject: [PATCH 2.6.10-bk4] m32r: fix sys_clone()
Date: Thu, 17 Feb 2005 12:18:33 +0900 (JST)
> Hi,
> 
> This patch is required to fix sys_clone() for m32r.
> 
> 	* arch/m32r/kernel/process.c:
> 	- Fix sys_clone; add arguments, parent_tidptr and child_tidptr.
> 	- Cosmetics: Change indentation of function parameters for
> 	  sys_clone(), sys_vfork().
> Thanks,
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> ---
> 
>  arch/m32r/kernel/process.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff -ruNp a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
> --- a/arch/m32r/kernel/process.c	2004-12-25 06:35:49.000000000 +0900
> +++ b/arch/m32r/kernel/process.c	2005-02-16 21:19:35.000000000 +0900
> @@ -1,6 +1,5 @@
>  /*
>   *  linux/arch/m32r/kernel/process.c
> - *    orig : sh
>   *
>   *  Copyright (c) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
>   *                            Hitoshi Yamamoto
> @@ -290,13 +289,16 @@ asmlinkage int sys_fork(unsigned long r0
>  }
>  
>  asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp,
> -	unsigned long r2, unsigned long r3, unsigned long r4, unsigned long r5,
> -	unsigned long r6, struct pt_regs regs)
> +			 unsigned long parent_tidptr,
> +			 unsigned long child_tidptr,
> +			 unsigned long r4, unsigned long r5, unsigned long r6,
> +			 struct pt_regs regs)
>  {
>  	if (!newsp)
>  		newsp = regs.spu;
>  
> -	return do_fork(clone_flags, newsp, &regs, 0, NULL, NULL);
> +	return do_fork(clone_flags, newsp, &regs, 0,
> +		       (int __user *)parent_tidptr, (int __user *)child_tidptr);
>  }
>  
>  /*
> @@ -320,9 +322,10 @@ asmlinkage int sys_vfork(unsigned long r
>  /*
>   * sys_execve() executes a new program.
>   */
> -asmlinkage int sys_execve(char __user *ufilename, char __user * __user *uargv, char __user * __user *uenvp,
> -  unsigned long r3, unsigned long r4, unsigned long r5, unsigned long r6,
> -  struct pt_regs regs)
> +asmlinkage int sys_execve(char __user *ufilename, char __user * __user *uargv,
> +			  char __user * __user *uenvp,
> +			  unsigned long r3, unsigned long r4, unsigned long r5,
> +			  unsigned long r6, struct pt_regs regs)
>  {
>  	int error;
>  	char *filename;
> @@ -354,4 +357,3 @@ unsigned long get_wchan(struct task_stru
>  	/* M32R_FIXME */
>  	return (0);
>  }
> -
> 
> --
> Hirokazu Takata <takata@linux-m32r.org>
> Linux/M32R Project:  http://www.linux-m32r.org/
> 
