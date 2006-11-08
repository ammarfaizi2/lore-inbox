Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754525AbWKHLLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbWKHLLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbWKHLLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:11:44 -0500
Received: from tornado.reub.net ([203.222.131.131]:16060 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S1754525AbWKHLLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:11:44 -0500
Message-ID: <4551BB5E.6090602@reub.net>
Date: Wed, 08 Nov 2006 22:11:26 +1100
From: Reuben Farrelly <reuben-linuxkernel@reub.net>
User-Agent: Thunderbird 2.0b1pre (Windows/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: 2.6.19-rc5-mm1
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2006 8:54 PM, Andrew Morton wrote:
> Temporarily at
> 
> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> 
> will turn up at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> 
> 
> when kernel.org mirroring catches up.
> 
> 
> 
> - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for 
> userspace tools, instructions, etc.
> 
> It needs a recent binutils to build.
> 
> - The hrtimer+dynticks code still doesn't work right for machines which halt 
> their TSC in low-power states.

I think this might be a davej thing:

   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_cpu_exit':
/usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:762:
undefined reference to `cpufreq_frequency_table_put_attr'
arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_target':
/usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:406:
undefined reference to `cpufreq_frequency_table_target'
arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_verify':
/usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:491:
undefined reference to `cpufreq_frequency_table_verify'
arch/x86_64/kernel/built-in.o: In function `acpi_cpufreq_cpu_init':
/usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:698:
undefined reference to `cpufreq_frequency_table_cpuinfo'
/usr/src/linux/linux-mm/arch/x86_64/kernel/cpufreq/../../../i386/kernel/cpu/cpufreq/acpi-cpufreq.c:734:
undefined reference to `cpufreq_frequency_table_get_attr'
arch/x86_64/kernel/built-in.o: In function `trampoline_end':
(.data+0x40c0): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
drivers/built-in.o: In function `ondemand_powersave_bias_init':
/usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:164: undefined
reference to `cpufreq_frequency_get_table'
drivers/built-in.o: In function `powersave_bias_target':
/usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:126: undefined
reference to `cpufreq_frequency_table_target'
/usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:134: undefined
reference to `cpufreq_frequency_table_target'
/usr/src/linux/linux-mm/drivers/cpufreq/cpufreq_ondemand.c:138: undefined
reference to `cpufreq_frequency_table_target'
make: *** [.tmp_vmlinux1] Error 1
[root@tornado linux-mm]#

.config looks like this:

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_BAY=m
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_ACPI_CPUFREQ=y

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

This is the first time I'm building some of the CPU power management features, 
so the problem may not be new to this release.

Reuben
