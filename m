Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRKMRen>; Tue, 13 Nov 2001 12:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKMRee>; Tue, 13 Nov 2001 12:34:34 -0500
Received: from mail.sandhurstridge.com.au ([210.9.195.45]:11018 "EHLO
	mail.impulse.net.au") by vger.kernel.org with ESMTP
	id <S277435AbRKMReR>; Tue, 13 Nov 2001 12:34:17 -0500
Date: Wed, 14 Nov 2001 04:37:02 +1100
From: Ben Ryan <ben@bssc.edu.au>
X-Mailer: The Bat! (v1.53d) UNREG / CD5BF9353B3B7091
Reply-To: Ben Ryan <ben@bssc.edu.au>
X-Priority: 3 (Normal)
Message-ID: <2482591359.20011114043702@bssc.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Compile error: 2.4.15-pre4 (-tr) in kernel.o (cpu_init()) - advice req'd
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all

hope this doesn't turn out to be spurious traffic...

ia32/uniproc

linux-2.4.14.tar (kernel tar)
patch-2.4.15-pre4 (merge)
fix-2.4.15-pre4-tr.diff (benlahaise; don't mind the filename, i just
                         reckon calling the patch for the patch,
                         patch-2.4.* is brokenness)


there is some weirdness on the box i'm compiling on; please check the
following for obvious causes...
pre-compile make's worked fine, but the compile itself crashed out
with:

arch/i386/kernel/kernel.o: In function 'cpu_init':
arch/i386/kernel/kernel.o(.text.init+0x27f9): undefined reference to 'cpucount'
arch/i386/kernel/kernel.o(.text.init+0x2831): undefined reference to 'cpucount'


Can anyone spot if it's code or meatware related??
Thanx, I won't be able to sleep till I know what's going on :)

cheers
ben





Segment of kernel.o containing the offender:
================
  * cpu_init() initializes state that is per-CPU. Some data is already
@@ -2815,14 +2817,15 @@
  */
 void __init cpu_init (void)
 {
-       int nr = smp_processor_id();
+       int nr = cpucount;
+       struct task_struct *cur = init_tasks[nr];
        struct tss_struct * t = &init_tss[nr];
 
        if (test_and_set_bit(nr, &cpu_initialized)) {
                printk(KERN_WARNING "CPU#%d already initialized!\n", nr);
                for (;;) __sti();

