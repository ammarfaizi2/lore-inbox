Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSJAONC>; Tue, 1 Oct 2002 10:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJAONC>; Tue, 1 Oct 2002 10:13:02 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:26287 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261689AbSJAOM7>; Tue, 1 Oct 2002 10:12:59 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.39: hdparm: HDIO_SET_DMA failed: Operation not permitted
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Tue, 01 Oct 2002 16:18:08 +0200
Message-ID: <87vg4mqm3j.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with 2.5.39 I get the following error (2.5.40/www.kernel.org is
unavailable at the moment):

# hdparm -d 1 /dev/hda/0

/dev/hda/0:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

It works with 2.4.14. I haven't tried any other.

$ ls -la /dev/hda/0 
brw-rw----    1 root     disk       3,   0 21. Jul 1998  /dev/hda/0

$ /sbin/hdparm -V
hdparm v5.2

# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: Elitegroup Computer Systems: Unknown device 0996
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e4000000-e7ffffff
	Capabilities: [80] Power Management version 2

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d000 [size=256]
	Memory at ea000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: Elitegroup Computer Systems: Unknown device 0996
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d400 [size=16]
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 5446
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 10
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	I/O ports at c000 [size=256]
	Memory at e9000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2

Motherboard is an Elitegroup K7VTA3

.config is:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_PACKET=m
CONFIG_NETFILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

If you need more info, please tell me.

Regards, Olaf.
