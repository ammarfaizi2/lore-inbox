Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVD3MHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVD3MHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 08:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVD3MHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 08:07:15 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:4963 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261203AbVD3MG7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 08:06:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D8i42GrXVUBeNjnACBHs0R8bMFDjf5HuX85oCJdgmyfDgkThiKe7dN7/+Pen4avefxCX7zLhx3ltPohysq5RqiSBtipbaxM2S5FUGZjzqAGPbmYKiswfOtMYQ6FwPdVpzsSE8E7kycnv169HErk08u+gtcgFHBvtL107lWf7vVY=
Message-ID: <40f323d0050430050612fb15c9@mail.gmail.com>
Date: Sat, 30 Apr 2005 14:06:56 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [PATCH 1/6]sep initializing rework
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/05, Li Shaohua <shaohua.li@intel.com> wrote:
> Hi,
> These patches (together with 5 patches followed this one) are updated
> suspend/resume SMP patches. The patches fixed some bugs and do clean up
> as suggested. Now they work for both suspend-to-ram and suspend-to-disk.
> Patches are against 2.6.12-rc2-mm3.
> 
> Thanks,
> Shaohua
> 
> ---
> Make SEP init per-cpu, so it is hotplug safed.
> 
> Signed-off-by: Li Shaohua<shaohua.li@intel.com>
> 
> ---
> +++ linux-2.6.11-root/arch/i386/power/cpu.c     2005-04-12 10:36:00.175169792 +0800
> @@ -33,8 +33,6 @@ unsigned long saved_context_esp, saved_c
>  unsigned long saved_context_esi, saved_context_edi;
>  unsigned long saved_context_eflags;
> 
> -extern void enable_sep_cpu(void *);
> -
>  void __save_processor_state(struct saved_context *ctxt)
>  {
>         kernel_fpu_begin();


> diff -puN include/asm-i386/smp.h~sep_init_cleanup include/asm-i386/smp.h
> --- linux-2.6.11/include/asm-i386/smp.h~sep_init_cleanup        2005-04-12 10:36:00.170170552 +0800
> +++ linux-2.6.11-root/include/asm-i386/smp.h    2005-04-12 10:36:00.176169640 +0800
> @@ -37,6 +37,9 @@ extern int smp_num_siblings;
>  extern cpumask_t cpu_sibling_map[];
>  extern cpumask_t cpu_core_map[];
> 
> +extern int sysenter_setup(void);
> +extern void enable_sep_cpu(void);
> +
>  extern void smp_flush_tlb(void);
>  extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
>  extern void smp_invalidate_rcv(void);          /* Process an NMI */
> _

This change adds a warning when CONFIG_SMP is not set:

arch/i386/power/cpu.c: In function '__restore_processor_state':
arch/i386/power/cpu.c:137: warning: implicit declaration of function
'enable_sep_cpu'
Maybe those functions should be defined somewhere else.

regards,

Benoit
