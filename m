Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVA1CAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVA1CAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVA1CAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:00:44 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:43184 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261387AbVA1CAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:00:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=d5VOqCpVJI4F43FdVe26tfQiBO9X6rfyUfF+Z47AkLLRAdoBlHNPJb+KMSlBN8hdwPk5hY96J/SSBH8og7xjiQerNzXBroQm3kH3RcXXuKa+nNSjde4T0Zaom7Zf2yYmxphl9XVHO58zSyfS1YY0OWaiAgm9mDhnAqlZgPKQXG8=
Message-ID: <aa4c40ff0501271800184390d7@mail.gmail.com>
Date: Fri, 28 Jan 2005 02:00:04 +0000
From: James Lamanna <jlamanna@gmail.com>
Reply-To: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel OOPS with i915 DRM Driver - 2.6.10
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this oops today when setting up a box with a i865G chipset:
I'm using Xorg 6.8.0.
I also experience virtual terminal corruption when I switch to any of
them after X starts up.

Thanks.
-- James Lamanna

drm:i830_dma_initialize] *ERROR* can not find dma buffer map!
[drm:i830_irq_emit] *ERROR* i830_irq_emit called without lock held
Unable to handle kernel paging request at virtual address f000e829
 printing eip:
c02793c1
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c02793c1>]    Not tainted VLI
EFLAGS: 00013296   (2.6.10-gentoo-r6)
EIP is at i830_kernel_lost_context+0x11/0x70
eax: f000e819   ebx: 00000000   ecx: 0000000c   edx: 00003282
esi: c05a99a0   edi: 00000000   ebp: 00000000   esp: db26fecc
ds: 007b   es: 007b   ss: 0068
Process X (pid: 8049, threadinfo=db26f000 task=de4d3020)
Stack: 00000000 c027b4a7 c05a99a0 00003282 c01270d7 c027bed0 c05a99a0 c027bedf
       c05a99a0 c0274fd4 c05a99a0 c05aa0d8 c05aa0e0 00000000 00000000 00000000
       00000000 00000001 0000000a 00000000 de4d3020 c01187e0 00000000 00000000
Call Trace:
 [<c027b4a7>] i830_dma_quiescent+0x17/0xb0
 [<c01270d7>] block_all_signals+0x37/0x80
 [<c027bed0>] i830_driver_dma_quiescent+0x0/0x20
 [<c027bedf>] i830_driver_dma_quiescent+0xf/0x20
 [<c0274fd4>] i830_lock+0x264/0x310
 [<c01187e0>] default_wake_function+0x0/0x20
 [<c01187e0>] default_wake_function+0x0/0x20
 [<c01744a3>] dput+0x33/0x1d0
 [<c0274cf5>] i830_ioctl+0xe5/0x160
 [<c015d879>] fget+0x49/0x60
 [<c016f5da>] sys_ioctl+0xca/0x230
 [<c01031af>] syscall_call+0x7/0xb
Code: b9 8b 53 0c 01 d0 89 43 1c e9 60 ff ff ff 8d b6 00 00 00 00 8d
bf 00 00 00 00 53 8b 44 24 08 8b 98 34 07 00 00 8b 43 04 8d 4b 0c <8b>
40 10 8b 90 34 20 00 00 81 e2 fc ff 1f 00 89 51 14 8b 43 04

relevant parts of .config:

# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-gentoo-r6
# Mon Jan 24 17:30:52 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
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
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set


CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
CONFIG_AGP_INTEL_MCH=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_I915=y

CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VESA_STD is not set
CONFIG_FB_VESA_TNG=y
CONFIG_FB_VESA_DEFAULT_MODE="1280x1024@75"
# CONFIG_VIDEO_SELECT is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

lspci:
0000:00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated
Graphics Device (rev 02) (prog-if 00 [VGA])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device fb61
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f0000000 (32-bit, prefetchable)
        Region 1: Memory at fc100000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at c000 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
