Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUKBX1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUKBX1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKBX13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:27:29 -0500
Received: from verein.lst.de ([213.95.11.210]:42704 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262944AbUKBXYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:24:46 -0500
Date: Wed, 3 Nov 2004 00:24:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] [PATCH 2/14] FRV: Fujitsu FR-V arch include files
Message-ID: <20041102232426.GA7040@lst.de>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JUKFH023161@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JUKFH023161@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/a.out.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/asm-frv/a.out.h	2004-11-01 11:47:04.877656380 +0000

do you really want to support a.out binaries on a new port?

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/bootinfo.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/asm-frv/bootinfo.h	2004-11-01 11:47:04.888655465 +0000
> @@ -0,0 +1,2 @@
> +
> +/* Nothing for m68knommu */

did you just copy & paste this maybe?

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/errno.h linux-2.6.10-rc1-bk10-frv/include/asm-frv/errno.h
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/errno.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/asm-frv/errno.h	2004-11-01 11:47:04.915653217 +0000
> @@ -0,0 +1,133 @@
> +#ifndef _ASM_ERRNO_H
> +#define _ASM_ERRNO_H
> +
> +#define	EPERM		 1	/* Operation not permitted */

please use the asm-generic/ errno defintions for new ports.

> +#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
> +#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
> +#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))

this moved out of arch code long ago.

> + * Are we doing bottom half or hardware interrupt processing?
> + * Are we in a softirq context? Interrupt context?
> + */
> +#define in_irq()		(hardirq_count())
> +#define in_softirq()		(softirq_count())
> +#define in_interrupt()		(irq_count())
> +
> +#define hardirq_trylock()	(!in_interrupt())
> +#define hardirq_endlock()	do { } while (0)

dito..

> +#ifdef CONFIG_PREEMPT
> +# include <linux/smp_lock.h>
> +# define in_atomic()		((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
> +# define IRQ_EXIT_OFFSET	(HARDIRQ_OFFSET-1)
> +#else
> +# define in_atomic()		(preempt_count() != 0)
> +# define IRQ_EXIT_OFFSET	HARDIRQ_OFFSET
> +#endif

dito..

> +#ifndef CONFIG_SMP
> +#define synchronize_irq(irq)	barrier()
> +#else
> +#error SMP not available on FR-V
> +#endif /* CONFIG_SMP */

dito..

> +#endif /* _ASM_IRQ_ROUTING_H */
> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/keyboard.h linux-2.6.10-rc1-bk10-frv/include/asm-frv/keyboard.h
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/keyboard.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/asm-frv/keyboard.h	2004-11-01 11:47:04.935651552 +0000

<asm/keyboard.h> isn't needed anymore in 2.6

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/linux_logo.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/asm-frv/linux_logo.h	2004-11-01 11:47:04.947650553 +0000

dito for <asm/linux_logo.h>

> +//#define MAP_NR(addr)		(((unsigned long)(addr) - PAGE_OFFSET) >> PAGE_SHIFT)
> +//#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)

this has no place in a 2.6 port, not even commented out..

> + * and that's it. There's no excuse for not highmem enabling YOUR driver. /jens
> + */
> +struct scatterlist {
> +	char		*address;	/* Location data is to be transferred to, NULL for

In 2.6 struct scatterlist should not have an address member.

> +/* format on the sun3 is similar, but bits 30, 31 are set to zero and all
> +   others are reduced by 2. --m */
> +
> +#ifndef CONFIG_SUN3
> +#define SHM_ID_SHIFT	9
> +#else
> +#define SHM_ID_SHIFT	7
> +#endif

WTF?

> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/asm-frv/smplock.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/asm-frv/smplock.h	2004-11-01 11:47:05.033643395 +0000

<asm/smplock.h> is long gone.

> +struct __old_kernel_stat {
> +	unsigned short st_dev;
> +	unsigned short st_ino;
> +	unsigned short st_mode;
> +	unsigned short st_nlink;
> +	unsigned short st_uid;
> +	unsigned short st_gid;
> +	unsigned short st_rdev;
> +	unsigned long  st_size;
> +	unsigned long  st_atime;
> +	unsigned long  st_mtime;
> +	unsigned long  st_ctime;
> +};

no need to implement an old stat in a new port.

> + */
> +#define kernel_termios_to_user_termio(termio, termios) \
> +({ \
> +	put_user((termios)->c_iflag, &(termio)->c_iflag); \
> +	put_user((termios)->c_oflag, &(termio)->c_oflag); \
> +	put_user((termios)->c_cflag, &(termio)->c_cflag); \
> +	put_user((termios)->c_lflag, &(termio)->c_lflag); \
> +	put_user((termios)->c_line,  &(termio)->c_line); \
> +	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \

no error checking at all?

> +#ifdef __KERNEL__
> +#define __ARCH_WANT_IPC_PARSE_VERSION
> +/* #define __ARCH_WANT_OLD_READDIR */
> +#define __ARCH_WANT_OLD_STAT
> +#define __ARCH_WANT_STAT64
> +#define __ARCH_WANT_SYS_ALARM
> +/* #define __ARCH_WANT_SYS_GETHOSTNAME */
> +#define __ARCH_WANT_SYS_PAUSE
> +/* #define __ARCH_WANT_SYS_SGETMASK */
> +/* #define __ARCH_WANT_SYS_SIGNAL */
> +#define __ARCH_WANT_SYS_TIME
> +#define __ARCH_WANT_SYS_UTIME
> +#define __ARCH_WANT_SYS_WAITPID
> +#define __ARCH_WANT_SYS_SOCKETCALL
> +#define __ARCH_WANT_SYS_FADVISE64
> +#define __ARCH_WANT_SYS_GETPGRP
> +#define __ARCH_WANT_SYS_LLSEEK
> +#define __ARCH_WANT_SYS_NICE
> +/* #define __ARCH_WANT_SYS_OLD_GETRLIMIT */
> +#define __ARCH_WANT_SYS_OLDUMOUNT
> +/* #define __ARCH_WANT_SYS_SIGPENDING */
> +#define __ARCH_WANT_SYS_SIGPROCMASK
> +#define __ARCH_WANT_SYS_RT_SIGACTION
> +#endif

most of this should go.  new architectures are not supposed to implement
obsolete syscalls.

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/swap.h linux-2.6.10-rc1-bk10-frv/include/linux/swap.h
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/swap.h	2004-10-27 17:32:36.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/include/linux/swap.h	2004-11-01 11:47:05.131635237 +0000
> @@ -7,6 +7,7 @@
>  #include <linux/mmzone.h>
>  #include <linux/list.h>
>  #include <linux/sched.h>
> +#include <linux/pagemap.h>

this creates too much of an include file mess.  Just include it in the
few files that need it for !MMU

