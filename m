Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWKHUGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWKHUGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWKHUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:06:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422777AbWKHUGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:06:31 -0500
Date: Wed, 8 Nov 2006 12:05:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-linuxkernel@reub.net>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061108120547.78048229.akpm@osdl.org>
In-Reply-To: <4551BB5E.6090602@reub.net>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<4551BB5E.6090602@reub.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 22:11:26 +1100
Reuben Farrelly <reuben-linuxkernel@reub.net> wrote:

> 
> 
> On 8/11/2006 8:54 PM, Andrew Morton wrote:
> > Temporarily at
> > 
> > http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> > 
> > will turn up at
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> > 
> > 
> > when kernel.org mirroring catches up.
> > 
> > 
> > 
> > - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for 
> > userspace tools, instructions, etc.
> > 
> > It needs a recent binutils to build.
> > 
> > - The hrtimer+dynticks code still doesn't work right for machines which halt 
> > their TSC in low-power states.
> 
> I think this might be a davej thing:
> 
>    CC      init/version.o
>    LD      init/built-in.o
>    LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_cpu_exit':
> /usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:762:
> undefined reference to `cpufreq_frequency_table_put_attr'
> arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_target':
> /usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:406:
> undefined reference to `cpufreq_frequency_table_target'
> arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_verify':
> /usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:491:
> undefined reference to `cpufreq_frequency_table_verify'
> arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_cpu_init':
> /usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:698:
> undefined reference to `cpufreq_frequency_table_cpuinfo'
> /usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:734:
> undefined reference to `cpufreq_frequency_table_get_attr'
> arch/x86_64/kernel/built-in.o: In function `trampoline_end':
> (.data+0x40c0): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
> drivers/built-in.o: In function `ondemand_powersave_bias_init':
> /usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:164: undefined
> reference to `cpufreq_frequency_get_table'
> drivers/built-in.o: In function `powersave_bias_target':
> /usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:126: undefined
> reference to `cpufreq_frequency_table_target'
> /usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:134: undefined
> reference to `cpufreq_frequency_table_target'
> /usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:138: undefined
> reference to `cpufreq_frequency_table_target'
> make: *** [.tmp_vmlinux1] Error 1
> [root@tornado linux-mm]#
> 
> .config looks like this:

It's pretty useless sending a mangled config.  In future, please send the
whole thing.  

The problem is that you have 

> CONFIG_CPU_FREQ_TABLE=m
> CONFIG_X86_ACPI_CPUFREQ=y

but acpi-cpufreq needs the stuff in freq_table.c.

This happens again and again and again and again.  I wish people would just
stop using `select'.  It.  Doesn't.  Work.

Either we fix select or we stop using the damn thing.

