Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315215AbSD2WK2>; Mon, 29 Apr 2002 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315216AbSD2WK1>; Mon, 29 Apr 2002 18:10:27 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:37900 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315215AbSD2WK0>; Mon, 29 Apr 2002 18:10:26 -0400
Subject: 2.5.11 + framebuffer compile patch -- OOPS in blk_get_readahead+a/60
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 29 Apr 2002 15:08:19 -0700
Message-Id: <1020118099.1918.25.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops -K -L -o /lib/modules/2.5.11/ -m /boot/System.map-2.5.11 -v /usr/src/linux/vmlinux < OOPS
ksymoops 2.4.4 on i686 2.4.7-10.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.11/ (specified)
     -m /boot/System.map-2.5.11 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c01ee59a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01ee59a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 001f5f80   edx: 00000000
esi: 00000002   edi: c1321000   ebp: cff25680   esp: cff51e48
ds: 0018   es: 0018   ss: 0018
Stack: cff25680 00000001 cff25694 c135a7c0 c1321000 cff25694 c023a87c 00000000 
       cff25694 00000001 cff25680 00000008 c0300de0 cff25680 c023ab1f cff25680 
       00000002 0000004b 00000001 00000001 c0370020 cfebc534 cfebc534 c0370020 
Call Trace: [<c023a87c>] [<c023ab1f>] [<c02286eb>] [<c01eb6e5>] [<c01eb891>] 
   [<c01eb7a8>] [<c0117426>] [<c0117516>] [<c023b094>] [<c023b2d1>] [<c0105000>] 
   [<c023ddff>] [<c023d455>] [<c010506f>] [<c0105000>] [<c0105676>] [<c0105050>] 
Code: 0f b7 50 10 89 d0 c1 f8 08 c1 e0 08 81 e2 ff 00 00 00 8d 14 

>>EIP; c01ee59a <blk_get_readahead+a/60>   <=====
Trace; c023a87c <device_size_calculation+ac/230>
Trace; c023ab1f <do_md_run+11f/3d0>
Trace; c02286eb <fbcon_cursor+9b/200>
Trace; c01eb6e5 <serial_console_write+35/1f0>
Trace; c01eb891 <serial_console_write+1e1/1f0>
Trace; c01eb7a8 <serial_console_write+f8/1f0>
Trace; c0117426 <__call_console_drivers+46/60>
Trace; c0117516 <call_console_drivers+66/110>
Trace; c023b094 <autorun_array+64/b0>
Trace; c023b2d1 <autorun_devices+1f1/240>
Trace; c0105000 <_stext+0/0>
Trace; c023ddff <autostart_arrays+7f/e2>
Trace; c023d455 <register_md_personality+75/80>
Trace; c010506f <init+1f/1a0>
Trace; c0105000 <_stext+0/0>
Trace; c0105676 <kernel_thread+26/30>
Trace; c0105050 <init+0/1a0>
Code;  c01ee59a <blk_get_readahead+a/60>
00000000 <_EIP>:
Code;  c01ee59a <blk_get_readahead+a/60>   <=====
   0:   0f b7 50 10               movzwl 0x10(%eax),%edx   <=====
Code;  c01ee59e <blk_get_readahead+e/60>
   4:   89 d0                     mov    %edx,%eax
Code;  c01ee5a0 <blk_get_readahead+10/60>
   6:   c1 f8 08                  sar    $0x8,%eax
Code;  c01ee5a3 <blk_get_readahead+13/60>
   9:   c1 e0 08                  shl    $0x8,%eax
Code;  c01ee5a6 <blk_get_readahead+16/60>
   c:   81 e2 ff 00 00 00         and    $0xff,%edx
Code;  c01ee5ac <blk_get_readahead+1c/60>
  12:   8d 14 00                  lea    (%eax,%eax,1),%edx

Kernel panic: Attempted to kill init!

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_DEBUG=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y

CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y

#
# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_IDEDMA_AUTO=y

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m


