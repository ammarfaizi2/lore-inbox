Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277476AbRJEQ3O>; Fri, 5 Oct 2001 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277478AbRJEQ27>; Fri, 5 Oct 2001 12:28:59 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59109 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277474AbRJEQ2h> convert rfc822-to-8bit; Fri, 5 Oct 2001 12:28:37 -0400
Date: Fri, 05 Oct 2001 09:25:09 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre4
Message-ID: <1546529396.1002273909@mbligh.des.sequent.com>
In-Reply-To: <20011005043751Z277310-761+15781@vger.kernel.org>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd. Compiles for me with and without SMP support turned on.
Does "linux-2.4.11-pre4-preempt" mean you're running with other
patches over the raw kernel? Which ones - just the preempt patch?
Can you point me to them?

Martin

PS. If you had other patches, can you try compiling just raw 2.4.11-pre4, and tell me if that works?

mpparse.c does this:

#include <asm/smp.h>

smp.h does this:

#ifndef clustered_apic_mode
 #ifdef CONFIG_MULTIQUAD
  #define clustered_apic_mode (1)
  #define esr_disable (1)
 #else /* !CONFIG_MULTIQUAD */
  #define clustered_apic_mode (0)
  #define esr_disable (0)
 #endif /* CONFIG_MULTIQUAD */
#endif

Or at least it should .....

--On Friday, October 05, 2001 6:38 AM +0200 Dieter Nützel <Dieter.Nuetzel@hamburg.de> wrote:

> Hello Linus,
> > the new and very cool Multiquad NUMA stuff break something...
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4-preempt/include -Wall > -Wstrict-prototypes -Wno-trigraphs -O -fomit-frame-pointer > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -mcpu=k6 > -mpreferred-stack-boundary=2 -malign-functions=4 -fschedule-insns2 > -fexpensive-optimizations     -c -o mpparse.o mpparse.c
> mpparse.c: In function `MP_processor_info':
> mpparse.c:195: `clustered_apic_mode' undeclared (first use in this function)
> mpparse.c:195: (Each undeclared identifier is reported only once
> mpparse.c:195: for each function it appears in.)
> mpparse.c: In function `smp_read_mpc':
> mpparse.c:386: `clustered_apic_mode' undeclared (first use in this function)
> make[1]: *** [mpparse.o] Error 1
> make[1]: Leaving directory > `/usr/src/linux-2.4.11-pre4-preempt/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 269.520u 29.200s 5:45.26 86.5%  0+0k 0+0io 1007275pf+0w
> > -Dieter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

