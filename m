Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVGFHXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVGFHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVGFHW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:22:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261716AbVGFGAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:00:33 -0400
Date: Wed, 6 Jul 2005 08:02:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move ioprio syscalls into syscalls.h
Message-ID: <20050706060155.GA1444@suse.de>
References: <20050705205632.GF12786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705205632.GF12786@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06 2005, Anton Blanchard wrote:
> 
> - Make ioprio syscalls return long, like set/getpriority syscalls.
> - Move function prototypes into syscalls.h so we can pick them up in the
>   32/64bit compat code.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Thanks Anton.

Signed-off-by: Jens Axboe <axboe@suse.de>

> 
> Index: foobar2/fs/ioprio.c
> ===================================================================
> --- foobar2.orig/fs/ioprio.c	2005-07-04 01:09:20.311694190 +1000
> +++ foobar2/fs/ioprio.c	2005-07-04 01:14:30.620438688 +1000
> @@ -43,7 +43,7 @@
>  	return 0;
>  }
>  
> -asmlinkage int sys_ioprio_set(int which, int who, int ioprio)
> +asmlinkage long sys_ioprio_set(int which, int who, int ioprio)
>  {
>  	int class = IOPRIO_PRIO_CLASS(ioprio);
>  	int data = IOPRIO_PRIO_DATA(ioprio);
> @@ -115,7 +115,7 @@
>  	return ret;
>  }
>  
> -asmlinkage int sys_ioprio_get(int which, int who)
> +asmlinkage long sys_ioprio_get(int which, int who)
>  {
>  	struct task_struct *g, *p;
>  	struct user_struct *user;
> Index: foobar2/include/linux/syscalls.h
> ===================================================================
> --- foobar2.orig/include/linux/syscalls.h	2005-07-04 01:09:20.311694190 +1000
> +++ foobar2/include/linux/syscalls.h	2005-07-04 01:14:43.583415901 +1000
> @@ -506,4 +506,7 @@
>  asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
>  			   unsigned long arg4, unsigned long arg5);
>  
> +asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
> +asmlinkage long sys_ioprio_get(int which, int who);
> +
>  #endif
> Index: foobar2/include/linux/ioprio.h
> ===================================================================
> --- foobar2.orig/include/linux/ioprio.h	2005-07-02 15:56:13.000000000 +1000
> +++ foobar2/include/linux/ioprio.h	2005-07-04 01:16:44.216312182 +1000
> @@ -34,9 +34,6 @@
>   */
>  #define IOPRIO_BE_NR	(8)
>  
> -asmlinkage int sys_ioprio_set(int, int, int);
> -asmlinkage int sys_ioprio_get(int, int);
> -
>  enum {
>  	IOPRIO_WHO_PROCESS = 1,
>  	IOPRIO_WHO_PGRP,
> 

-- 
Jens Axboe

