Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSKJPts>; Sun, 10 Nov 2002 10:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSKJPts>; Sun, 10 Nov 2002 10:49:48 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:35269 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264915AbSKJPtp>; Sun, 10 Nov 2002 10:49:45 -0500
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211091728140.3608-100000@barbarella.hawaga.org.uk>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: [PATCH] 2.5.46: access permission filesystem
Date: Sun, 10 Nov 2002 16:56:09 +0100
Message-ID: <87y981to4m.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Ben,

Ben Clifford <benc@hawaga.org.uk> writes:

> I've just applied this to 2.5.46, and I'm building accessfs as modules.
>
> During boot (my scripts do a probe for the accessfs modules), I get:
>
> ====
>
> Debug: sleeping function called from illegal context at mm/slab.c:1304
> Call Trace:
[stack dump]

thanks for this report. Unfortunately, I can't reproduce this
stack dump. I just built and booted a kernel with accessfs enabled as
a module. Both insmod and modprobe work here, so there must be some
additional condition, patch or config option to cause this.

> The proc/access/net/ip/bind ports appear ok and I can change permissions 
> on them. (although I haven't tested to see if their permissions actually 
> have effect).

At least this is working. Good to hear :-)

> I also get
>
> Debug: sleeping function called from illegal context at mm/slab.c:1304
> Call Trace:
[stack dump]
>
> followed by:
>
> Debug: sleeping function called from illegal context at mm/slab.c:1304
> Call Trace:
[stack dump]
>
> There is already a security framework initialized, register_security 
> failed.

You must build CONFIG_SECURITY_CAPABILITIES as a module or disable it
for usercaps to work. Usercaps employ LSM and is built as a security
module. This means, until there's a way to stack lsm security modules,
there must be no other security module loaded.

I append my .config as a reference below.

> The directory /proc/access/capabilities appears, but it has no contents.

Since usercaps cannot be loaded, this is expected and does no harm.

There might be problems with SMP. I have added spin_locks recently and
it works here on UP, but I have no SMP for testing. So there might be
some bugs in my locking code.

Regards, Olaf.


--=-=-=
Content-Disposition: attachment; filename=qwe
Content-Description: .config

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
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
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
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
CONFIG_ISA=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_PACKET=m
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_HOOKS=y
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
CONFIG_ACCESS_FS=m
CONFIG_ACCESSFS_USER_PORTS=m
CONFIG_ACCESSFS_PROT_SOCK=1024
CONFIG_ACCESSFS_USER_CAPABILITIES=m
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
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--=-=-=--
