Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318154AbSG2U7z>; Mon, 29 Jul 2002 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSG2U7z>; Mon, 29 Jul 2002 16:59:55 -0400
Received: from iris.mc.com ([192.233.16.119]:32753 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S318154AbSG2U7y>;
	Mon, 29 Jul 2002 16:59:54 -0400
Message-Id: <200207292103.RAA25686@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: Greg Louis <glouis@dynamicro.on.ca>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac4
Date: Mon, 29 Jul 2002 17:07:41 -0400
X-Mailer: KMail [version 1.3.1]
References: <200207291740.g6THewQ19578@devserv.devel.redhat.com> <008401c2372f$8c02cea0$0100a8c0@mars> <20020729164636.32b8929f.glouis@dynamicro.on.ca>
In-Reply-To: <20020729164636.32b8929f.glouis@dynamicro.on.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sched.c calls arch_load_balance() which calls find_idle_package()

at least on a p4.  

(tried your fix and build failed due to that.)

On Monday 29 July 2002 16:46, Greg Louis wrote:
> On Mon, 29 Jul 2002 13:41:07 -0500,
>
>  "Stephen Lee" <steve@tuxsoft.com> wrote:
> > When compiling with this patch I get the following:
> >
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc3-ac4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common-fomit-f
> > rame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
> > -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> > In file included from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h:14,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/sched.h:23,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/mm.h:4,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/slab.h:14,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/proc_fs.h:5,
> >                  from init/main.c:15:
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h: In function
> > `find_idle_package':
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: `smp_num_cpus'
> > undeclared (first use in this function)
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: (Each undeclared
> > identifier is reported only once
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: for each function
> > it appears in.)
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:163: warning: implicit
> > declaration of function `idle_cpu'
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h: In function
> > `arch_load_balance':
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:177: warning: implicit
> > declaration of function `cpu_rq'
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:177: warning:
> > assignment makes pointer from integer without a cast
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:178: warning: implicit
> > declaration of function `resched_task'
> > /usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:178: dereferencing
> > pointer to incomplete type
> > In file included from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/sched.h:23,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/mm.h:4,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/slab.h:14,
> >                  from
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/proc_fs.h:5,
> >                  from init/main.c:15:
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h: At top level:
> > /usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h:58: `smp_num_cpus'
> > used prior to declaration
> > make: *** [init/main.o] Error 1
>
> The two inline functions containing these errors appear to be nowhere
> used, at least as far as I can tell with find -exec grep.  Removing the
> code allows successful compilation on an SMP box, and it seems to be
> running ok with the new kernel.  (Despite the directory name this is an
> -ac4 tree).
>
> --- linux-2.4.19rc3/include/asm-i386/smp.h~	2002-07-29 16:26:36.000000000
> -0400 +++ linux-2.4.19rc3/include/asm-i386/smp.h	2002-07-29
> 16:26:36.000000000 -0400 @@ -140,6 +140,7 @@
>
>  #define NO_PROC_ID		0xFF		/* No processor magic marker */
>
> +#if 0
>  #ifdef CONFIG_SMP
>  #define ARCH_HAS_LOAD_BALANCE
>  /*
> @@ -183,3 +184,4 @@
>  }
>  #endif
>  #endif
> +#endif

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
