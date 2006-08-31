Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWHaMfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWHaMfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWHaMfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:35:46 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:19763 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S932105AbWHaMfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:35:45 -0400
Subject: Re: [PATCH 7/8] Implement smp_processor_id() with the PDA.
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060831000515.338336117@goop.org>
References: <20060830235201.106319215@goop.org>
	 <20060831000515.338336117@goop.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 13:35:58 +0100
Message-Id: <1157027758.12949.327.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2006 12:37:46.0124 (UTC) FILETIME=[42CCB4C0:01C6CCFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Wed, 2006-08-30 at 16:52 -0700, Jeremy Fitzhardinge wrote:
> --- a/arch/i386/kernel/cpu/common.c
> +++ b/arch/i386/kernel/cpu/common.c@@ -664,7 +664,7 @@ static inline void set_kernel_gs(void)
>  /* Initialize the CPU's GDT and PDA */
>  static __cpuinit void init_gdt(void)
>  {
> -       int cpu = smp_processor_id();
> +       int cpu = early_smp_processor_id();
>         struct task_struct *curr = current;
>         struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
>         __u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu); 

This doesn't compile for me if CONFIG_SMP=n

          LD      .tmp_vmlinux1
        arch/i386/kernel/built-in.o: In function `cpu_init':
        (.init.text+0x1eda): undefined reference to `early_smp_processor_id'
        arch/i386/kernel/built-in.o: In function `cpu_init':
        (.init.text+0x1f11): undefined reference to `early_smp_processor_id'
        
smp_processor_id() is defined for !SMP in include/linux/smp.h, I don't
know if it would be appropriate to add early_smp_processor_id() there
since it seems i386 specific. asm/smp.h isn't included by linux/smp.h
when !SMP but you could add an explicit include to common.c I suppose.

Ian.

