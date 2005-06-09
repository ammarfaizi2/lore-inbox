Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVFILpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVFILpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVFILn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:43:26 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:18158 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262352AbVFILl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:41:58 -0400
Date: Thu, 9 Jun 2005 13:41:55 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Lockup with 2.6.12-rc5
Message-ID: <20050609114155.GH21023@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been experiencing lookups of a quite heavily used file server.
These lockups happen after some days, and I've also seen them with
2.6.11 based kernels. Kernels of the 2.6.8 series are running fine for
weeks.

The box is a dual Xeon (HT wasn't detected), network uses acenic and discs
sym53c8xx.

[540352.636582] NMI Watchdog detected LOCKUP on CPU0, eip c03937ca, registers:
[540352.657665] Modules linked in: ipt_REJECT iptable_filter ip_tables acenic
[540352.678495] CPU:    0
[540352.678497] EIP:    0060:[<c03937ca>]    Not tainted VLI
[540352.678498] EFLAGS: 00000086   (2.6.12-rc5)
[540352.715091] EIP is at _spin_lock+0xa/0x10
[540352.727482] eax: c047b51c   ebx: 000000ff   ecx: 02ae0f60   edx: 00000000
[540352.748284] esi: c047b500   edi: 00007f80   ebp: c047b51c   esp: c6877f8c
[540352.769083] ds: 007b   es: 007b   ss: 0068
[540352.781725] Process rsync (pid: 19212, threadinfo=c6876000 task=ca024020)
[540352.801966] Stack: c0138c7a 00000000 c011fe46 c0473388 0000000a c6877fbc 00000080 00000002
[540352.827577]        080b52d2 bf9039e8 c01054c9 c01037b6 00000080 00009eae 00009eba 00000002
[540352.853200]        080b52d2 bf9039e8 080a9d58 c010007b 0000007b ffffff12 0806f475 00000073
[540352.878820] Call Trace:
[540352.887010]  [<c0138c7a>] __do_IRQ+0x9a/0x140
[540352.900457]  [<c011fe46>] __do_softirq+0xd6/0xf0
[540352.914695]  [<c01054c9>] do_IRQ+0x19/0x30
[540352.927357]  [<c01037b6>] common_interrupt+0x1a/0x20
[540352.942651] Code: c3 ba 00 e0 ff ff 21 e2 81 42 14 00 01 00 00 f0 81 28 00 00 00 01 74 05 e8 04
[540353.000586] console shuts up ...


Relevant config:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_CPUSETS is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=4
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y

# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y




Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
