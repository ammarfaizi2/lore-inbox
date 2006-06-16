Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWFPDEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWFPDEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWFPDEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:04:13 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:49047 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750837AbWFPDEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:04:12 -0400
Date: Thu, 15 Jun 2006 23:00:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 12/16] 2.6.17-rc6 perfmon2 patch for review:
  modified i386 files
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Message-ID: <200606152301_MC3-1-C28E-ADE0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606150907.k5F97g7B008214@frankl.hpl.hp.com>

On Thu, 15 Jun 2006 02:07:42 -0700, Stephane Eranian wrote:

> This patch contains the modified i386 files
>
> <...>
>
> diff -ur linux-2.6.17-rc6.orig/arch/i386/kernel/apic.c linux-2.6.17-rc6/arch/i386/kernel/apic.c
> --- linux-2.6.17-rc6.orig/arch/i386/kernel/apic.c     2006-06-08 01:42:30.000000000 -0700
> +++ linux-2.6.17-rc6/arch/i386/kernel/apic.c  2006-06-08 01:49:22.000000000 -0700
> @@ -27,6 +27,7 @@
>  #include <linux/sysdev.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
> +#include <linux/perfmon.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/smp.h>
> @@ -1179,6 +1180,8 @@
>       update_process_times(user_mode_vm(regs));
>  #endif
>  
> +     pfm_handle_switch_timeout();
> +
>       /*
>        * We take the 'long' return path, and there every subsystem
>        * grabs the apropriate locks (kernel lock/ irq lock).

Please add '-p' to your diff options.  It makes it easier to see what is
happening.

>
> <...>
>
> diff -ur linux-2.6.17-rc6.orig/arch/i386/kernel/syscall_table.S linux-2.6.17-rc6/arch/i386/kernel/syscall_table.S
> --- linux-2.6.17-rc6.orig/arch/i386/kernel/syscall_table.S    2006-06-08 01:42:30.000000000 -0700
> +++ linux-2.6.17-rc6/arch/i386/kernel/syscall_table.S 2006-06-08 01:50:27.000000000 -0700
> @@ -316,3 +316,15 @@
>       .long sys_sync_file_range
>       .long sys_tee                   /* 315 */
>       .long sys_vmsplice
> +             .long sys_pfm_create_context
> +             .long sys_pfm_write_pmcs
> +             .long sys_pfm_write_pmds
> +             .long sys_pfm_read_pmds         /* 320 */
> +             .long sys_pfm_load_context
> +             .long sys_pfm_start
> +             .long sys_pfm_stop
> +             .long sys_pfm_restart
> +             .long sys_pfm_create_evtsets    /* 325 */
> +             .long sys_pfm_getinfo_evtsets
> +             .long sys_pfm_delete_evtsets
> +     .long sys_pfm_unload_context

I think there are seven spaces plus a tab here for the first 11 new
syscalls? (You won't be able to tell from my quote because my mail
program mangles quoted text.)

>
> <...>
>
> --- linux-2.6.17-rc6.orig/include/asm-i386/unistd.h   2006-06-08 01:42:35.000000000 -0700
> +++ linux-2.6.17-rc6/include/asm-i386/unistd.h        2006-06-08 01:49:22.000000000 -0700
> @@ -322,8 +322,19 @@
>  #define __NR_sync_file_range 314
>  #define __NR_tee             315
>  #define __NR_vmsplice                316
> +#define __NR_pfm_create_context      317
> +#define __NR_pfm_write_pmcs  (__NR_pfm_create_context+1)
> +#define __NR_pfm_write_pmds  (__NR_pfm_create_context+2)
> +#define __NR_pfm_read_pmds   (__NR_pfm_create_context+3)
> +#define __NR_pfm_load_context        (__NR_pfm_create_context+4)
> +#define __NR_pfm_start               (__NR_pfm_create_context+5)
> +#define __NR_pfm_stop                (__NR_pfm_create_context+6)
> +#define __NR_pfm_restart     (__NR_pfm_create_context+7)
> +#define __NR_pfm_create_evtsets      (__NR_pfm_create_context+8)
> +#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
> +#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
>  
> -#define NR_syscalls 317
> +#define NR_syscalls 329
>  
>  /*
>   * user-visible error numbers are in the range -1 - -128: see

You missed __NR_pfm_unload_context.


-- 
Chuck

