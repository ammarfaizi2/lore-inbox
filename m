Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278813AbRKMUmf>; Tue, 13 Nov 2001 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278829AbRKMUmZ>; Tue, 13 Nov 2001 15:42:25 -0500
Received: from mail.impulse.net.au ([210.9.195.45]:9234 "EHLO
	mail.impulse.net.au") by vger.kernel.org with ESMTP
	id <S278813AbRKMUmT>; Tue, 13 Nov 2001 15:42:19 -0500
Date: Wed, 14 Nov 2001 07:44:59 +1100
From: Ben Ryan <ben@bssc.edu.au>
X-Mailer: The Bat! (v1.53d) UNREG / CD5BF9353B3B7091
Reply-To: Ben Ryan <ben@bssc.edu.au>
X-Priority: 3 (Normal)
Message-ID: <187493868425.20011114074459@bssc.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Uniprocessor Compile error: 2.4.15-pre4 (-tr) in kernel.o (cpu_init()) - Works with SMP
In-Reply-To: <2482591359.20011114043702@bssc.edu.au>
In-Reply-To: <2482591359.20011114043702@bssc.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux-2.4.14.tar (kernel tar)
> patch-2.4.15-pre4 (merge)
> fix-2.4.15-pre4-tr.diff (benlahaise; don't mind the filename, i just
>                          reckon calling the patch for the patch,
>                          patch-2.4.* is brokenness)

> arch/i386/kernel/kernel.o: In function 'cpu_init':
> arch/i386/kernel/kernel.o(.text.init+0x27f9): undefined reference to 'cpucount'
> arch/i386/kernel/kernel.o(.text.init+0x2831): undefined reference to 'cpucount'
> Segment of kernel.o containing the offender:
> ================
>   * cpu_init() initializes state that is per-CPU. Some data is already
> @@ -2815,14 +2817,15 @@
>   */
>  void __init cpu_init (void)
>  {
> -       int nr = smp_processor_id();
> +       int nr = cpucount;
> +       struct task_struct *cur = init_tasks[nr];
>         struct tss_struct * t = &init_tss[nr];
 
>         if (test_and_set_bit(nr, &cpu_initialized)) {
>                 printk(KERN_WARNING "CPU#%d already initialized!\n", nr);
>                 for (;;) __sti();


SMP compile succeeded. (albeit with lots of warnings on 'pure')

It seems cpucount is only defined when SMP is compiled in, I guess cpucount
hasn't been set to 1 in uniprocessor build, breaking non-smp builds?
How can I hardcode that into setup.c? I know little of C, so if someone could
point out a line of code to set this (diff even?) :)

