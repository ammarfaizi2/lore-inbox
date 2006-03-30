Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWC3Oze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWC3Oze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWC3Oze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:55:34 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:45965 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbWC3Ozd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:55:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RsMkcxID4d1zFILvDq6GvaLRfH2znvu4vL1doYfPVyYG4b9yXDHv0XZf3KZKeQJKTywVLqH6zHZN/WYJV6l7GvRkCjD9qIR6+ZC8kpC5Sw7avApudTKz4JYby0o5QWkb3G0U+p4W4QIQqggITa//omVtX6tkL6E6ZXxIqLqoBIw=
Message-ID: <2cf1ee820603300655y16f46bbfn8a6d183778a9bacf@mail.gmail.com>
Date: Thu, 30 Mar 2006 17:55:29 +0300
From: "emin ak" <eminak71@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rt10 crash on ppc
Cc: "Kumar Gala" <galak@kernel.crashing.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20060330113452.GA9901@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com>
	 <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com>
	 <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu>
	 <442B4890.6000905@yahoo.com.au> <20060330071322.GA3137@elte.hu>
	 <F86880BD-2EE9-4078-AB28-F769EF507C3B@kernel.crashing.org>
	 <20060330072339.GB3941@elte.hu>
	 <2cf1ee820603300225x3c5a6f98qe8bdda1023f0d74f@mail.gmail.com>
	 <20060330113452.GA9901@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ingo,
I think I have made a big mistake..
while compiling 2.6.16 kernel with -rt10 patch for ppc, I had faced
compilation errors and replaced the code that cause the errors with 
the orijinal (before the patch) ones, and maybe they may cause this
bug. Here is the modification diff file, and I have added  compilation
error messages for each modification. If you can correct the errors, I
can test and return you the results again..
Emin

diff -Naur linux-2.6.16-rt10/arch/powerpc/kernel/init_task.c
linux-2.6.16_modif/arch/powerpc/kernel/init_task.c
--- linux-2.6.16-rt10/arch/powerpc/kernel/init_task.c 2006-03-30
15:35:22.000000000 +0300
+++ linux-2.6.16_modif/arch/powerpc/kernel/init_task.c 2006-03-30
15:20:39.000000000 +0300
@@ -7,8 +7,12 @@
#include <linux/mqueue.h>
#include <asm/uaccess.h>

-static struct fs_struct init_fs = INIT_FS(init_fs);
-static struct files_struct init_files = INIT_FILES(init_files);
+//static struct fs_struct init_fs = INIT_FS(init_fs);
+//compiler error message:arch/powerpc/kernel/init_task.c:10: error:
parse error before '(' token
+static struct fs_struct init_fs = INIT_FS;
+//static struct files_struct init_files = INIT_FILES(init_files);
+//compiler error message:arch/powerpc/kernel/init_task.c:11: error:
parse error before '(' token
+static struct files_struct init_files = INIT_FILES;
static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
struct mm_struct init_mm = INIT_MM(init_mm);
diff -Naur linux-2.6.16-rt10/include/linux/trace_irqflags.h
linux-2.6.16_modif/include/linux/trace_irqflags.h
--- linux-2.6.16-rt10/include/linux/trace_irqflags.h 2006-03-30
15:35:26.000000000 +0300
+++ linux-2.6.16_modif/include/linux/trace_irqflags.h 2006-03-30
15:15:29.000000000 +0300
@@ -11,7 +11,8 @@
#ifndef _LINUX_TRACE_IRQFLAGS_H
#define _LINUX_TRACE_IRQFLAGS_H

-#include <asm/irqflags.h>
+//#include <asm/irqflags.h>
+//compile error message: include/linux/trace_irqflags.h:14:26: error:
asm/irqflags.h: No such file or directory

/*
  * The local_irq_*() APIs are equal to the raw_local_irq*()
diff -Naur linux-2.6.16-rt10/arch/ppc/kernel/entry.S
linux-2.6.16_modif/arch/ppc/kernel/entry.S
--- linux-2.6.16-rt10/arch/ppc/kernel/entry.S 2006-03-30
15:35:22.000000000 +0300
+++ linux-2.6.16_modif/arch/ppc/kernel/entry.S 2006-03-30
15:18:14.000000000 +0300
@@ -854,7 +854,11 @@
#endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

do_work: /* r10 contains MSR_KERNEL here */
- andi. r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
+/* andi. r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)*/
+/*compile error message:
+arch/ppc/kernel/entry.S:857: Error: operand out of range (0x00010008
is not between 0x00000000 and 0x0000ffff)*/
+ andi. r0,r9,(_TIF_NEED_RESCHED)
+
beq do_user_signal

do_resched: /* r10 contains MSR_KERNEL here */
@@ -868,7 +872,10 @@
MTMSRD(r10) /* disable interrupts */
rlwinm r9,r1,0,0,18
lwz r9,TI_FLAGS(r9)
- andi. r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
+/* andi. r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)*/
+/*compile error message:
+arch/ppc/kernel/entry.S:871: Error: operand out of range (0x00010008
is not between 0x00000000 and 0x0000ffff)*/
+ andi. r0,r9,(_TIF_NEED_RESCHED)
bne- do_resched
andi. r0,r9,_TIF_SIGPENDING
beq restore_user
2006/3/30, Ingo Molnar <mingo@elte.hu>:
>
> * emin ak <eminak71@gmail.com> wrote:
>
> > Soryy fot the late answer. I have change the driver to use
> > SA_INTERRUPT, OOM messages disappeared but the ethernet throughput
> > decreased significantly as Kumar said before(90MBit for 1518Byte
> > packet, and throughput without the patch is about 900Bits) and the
> > system can't manage load balancing between to interfaces,the system
> > acts like the priorty of tsec0 (eth0) is higher then tsec1 because of
> > this, under heavy load on tsec0 blocks packet receiving on tsec1
> > (eth1). And also I have tried Nick solution, increased
> > /proc/sys/vm/min_free_kbytes to 10MB, the result did'nt changed, OOM
> > messages was repeated again.
> > I'll try Ingo patch immediately and and report you the results.
>
> well, if SA_INTERRUPT made a difference then you are likely not running
> PREEMPT_RT nor PREEMPT_HARDIRQS. Could you send me your .config?
>
>        Ingo
>
