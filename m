Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSG2UnS>; Mon, 29 Jul 2002 16:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSG2UnS>; Mon, 29 Jul 2002 16:43:18 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:59035 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S318079AbSG2UnQ>; Mon, 29 Jul 2002 16:43:16 -0400
Date: Mon, 29 Jul 2002 16:46:36 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac4
Message-Id: <20020729164636.32b8929f.glouis@dynamicro.on.ca>
In-Reply-To: <008401c2372f$8c02cea0$0100a8c0@mars>
References: <200207291740.g6THewQ19578@devserv.devel.redhat.com>
	<008401c2372f$8c02cea0$0100a8c0@mars>
Organization: Dynamicro Consulting Limited
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002 13:41:07 -0500,
 "Stephen Lee" <steve@tuxsoft.com> wrote:

> When compiling with this patch I get the following:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc3-ac4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common-fomit-f
> rame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
> -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> In file included from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h:14,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/sched.h:23,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/mm.h:4,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/slab.h:14,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h: In function
> `find_idle_package':
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: `smp_num_cpus'
> undeclared (first use in this function)
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: (Each undeclared
> identifier is reported only once
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: for each function
> it appears in.)
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:163: warning: implicit
> declaration of function `idle_cpu'
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h: In function
> `arch_load_balance':
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:177: warning: implicit
> declaration of function `cpu_rq'
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:177: warning:
> assignment makes pointer from integer without a cast
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:178: warning: implicit
> declaration of function `resched_task'
> /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:178: dereferencing
> pointer to incomplete type
> In file included from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/sched.h:23,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/mm.h:4,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/slab.h:14,
>                  from
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h: At top level:
> /usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h:58: `smp_num_cpus'
> used prior to declaration
> make: *** [init/main.o] Error 1

The two inline functions containing these errors appear to be nowhere
used, at least as far as I can tell with find -exec grep.  Removing the
code allows successful compilation on an SMP box, and it seems to be
running ok with the new kernel.  (Despite the directory name this is an
-ac4 tree).

--- linux-2.4.19rc3/include/asm-i386/smp.h~	2002-07-29 16:26:36.000000000 -0400
+++ linux-2.4.19rc3/include/asm-i386/smp.h	2002-07-29 16:26:36.000000000 -0400
@@ -140,6 +140,7 @@
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
+#if 0
 #ifdef CONFIG_SMP
 #define ARCH_HAS_LOAD_BALANCE
 /*
@@ -183,3 +184,4 @@
 }
 #endif
 #endif
+#endif

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
