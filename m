Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTEOOgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTEOOgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:36:06 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:58767 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264039AbTEOOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:36:03 -0400
Date: Fri, 16 May 2003 00:49:33 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk[89]: software suspend compile error
Message-ID: <20030515144933.GB632@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tried to see if I could fix this myself but couldn't figure out what was
happening. the ld line that creates the built-in.o has suspend_asm.o in
it which, in turn, seems to contain the right labels so I'm a bit lost.
Anyhow, here's part of the output and the relevant (I hope) bit of the
.config.

...
   ld -m elf_i386  -R arch/i386/kernel/vsyscall-syms.o -r -o arch/i386/kernel/built-in.o arch/i386/kernel/process.o arch/i386/kernel/semaphore.o arch/i386/kernel/signal.o arch/i386/kernel/entry.o arch/i386/kernel/traps.o arch/i386/kernel/irq.o arch/i386/kernel/vm86.o arch/i386/kernel/ptrace.o arch/i386/kernel/i8259.o arch/i386/kernel/ioport.o arch/i386/kernel/ldt.o arch/i386/kernel/setup.o arch/i386/kernel/time.o arch/i386/kernel/sys_i386.o arch/i386/kernel/pci-dma.o arch/i386/kernel/i386_ksyms.o arch/i386/kernel/i387.o arch/i386/kernel/dmi_scan.o arch/i386/kernel/bootflag.o arch/i386/kernel/doublefault.o arch/i386/kernel/cpu/built-in.o arch/i386/kernel/timers/built-in.o arch/i386/kernel/acpi/built-in.o arch/i386/kernel/reboot.o arch/i386/kernel/suspend.o arch/i386/kernel/suspend_asm.o arch/i386/kernel/sysenter.o arch/i386/kernel/vsyscall.o
...
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x160a): undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x160f): undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x1615): undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x161b): undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1621): undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x1627): undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x162d): undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1633): undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x163a): undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o: In function `ret_point':
arch/i386/kernel/built-in.o(.data+0x167a): undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1680): undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1685): undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x168b): undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1691): undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1697): undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x169d): undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x16a3): undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x16ae): undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel_s4bios':
arch/i386/kernel/built-in.o(.data+0x16c2): undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x16c7): undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x16cd): undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x16d3): undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x16d9): undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x16df): undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x16e5): undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x16eb): undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x16f2): undefined reference to `saved_context_eflags'
make: *** [.tmp_vmlinux1] Error 1

.config:

...
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_SPEEDSTEP=y

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
