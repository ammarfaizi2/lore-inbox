Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270510AbSISIkj>; Thu, 19 Sep 2002 04:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbSISIkj>; Thu, 19 Sep 2002 04:40:39 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:29907 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S270510AbSISIki>; Thu, 19 Sep 2002 04:40:38 -0400
Date: Thu, 19 Sep 2002 10:42:33 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac2
Message-ID: <20020919104233.A1812@brodo.de>
References: <200209182133.g8ILXhk08396@devserv.devel.redhat.com> <Pine.NEB.4.44.0209191003250.15721-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.NEB.4.44.0209191003250.15721-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Thu, Sep 19, 2002 at 10:06:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not really CPUfreq related, but this should fix it:
(note to Alan: second part already sent to you directly)

	Dominik

--- linux/include/asm/hw_irq.h.original	Thu Sep 19 10:28:43 2002
+++ linux/include/asm/hw_irq.h	Thu Sep 19 10:37:43 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <asm/current.h>
 
 /*
  * IDT vectors usable for external interrupt sources start
--- linux-24ac/include/linux/interrupt.h.original	Thu Sep 19 01:38:24 2002
+++ linux-24ac/include/linux/interrupt.h	Thu Sep 19 01:38:36 2002
@@ -10,6 +10,7 @@
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
+#include <asm/system.h>
 
 struct irqaction {
 	void (*handler)(int, void *, struct pt_regs *);




On Thu, Sep 19, 2002 at 10:06:34AM +0200, Adrian Bunk wrote:
> On Wed, 18 Sep 2002, Alan Cox wrote:
> 
> >...
> > Linux 2.4.20-pre7-ac1
> >...
> > o	CPUfreq update					(Dominik Brodowski)
> >...
> 
> <--  snip  -->
> 
> ...
> gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
> -iwithprefix include -DKBUILD_BASENAME=cpufreq  -c -o cpufreq.o cpufreq.c
> In file included from
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/irq.h:69,
>                  from
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hardirq.h:6,
>                  from
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/interrupt.h:45,
>                  from cpufreq.c:21:
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h: In
> function `x86_do_profile':
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h:201:
> `current' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h:201:
> (Each undeclared identifier is reported only once
> /home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/asm/hw_irq.h:201:
> for each function it appears in.)
> make[2]: *** [cpufreq.o] Error 1
> make[2]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/kernel'
> 
> cu
> Adrian
