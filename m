Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318845AbSH1OMM>; Wed, 28 Aug 2002 10:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSH1OMM>; Wed, 28 Aug 2002 10:12:12 -0400
Received: from mail309.mail.bellsouth.net ([205.152.58.169]:4516 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S318845AbSH1OMK>; Wed, 28 Aug 2002 10:12:10 -0400
Date: Wed, 28 Aug 2002 10:16:23 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: kpreempt-tech@lists.sourceforge.net, <mingo@elte.hu>, <rml@tech9.net>
Subject: 2.5.32: DEBUG_SLAB and PREEMPT = constant oops in schedule()
Message-ID: <Pine.LNX.4.43.0208280944080.1736-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running the Linux Test Project's process_stress test on 2.5.32 that
is compiled with DEBUG_SLAB and PREEMPT, I am able to easily reproduce
this oops. Undef either of the above kernel options, and the system is
stable again.

Unable to handle kernel paging request at virtual address 5a5a5ace
c010ecaf
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c010ecaf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010817
eax: c9a92000   ebx: c9fd3760   ecx: c9b81288   edx: 5a5a5a5a
esi: c9b863ec   edi: c9fd31e0   ebp: c9a93ee0   esp: c9a93ec8
ds: 0068   es: 0068   ss: 0068
Stack: 7fffffff c9b863ec c9a93f60 c9fd31e0 00000282 c9a92000 c405d000 c0117e10
       00000008 c9b863ec 080dc050 00000246 c405d980 c9b863ec c01b51e4 c01b5234
       c405d000 c9b863ec c9d8c5ec c9b8640c c405d980 c405dbfc 00000000 7fffffff
Call Trace: [<c0117e10>] [<c01b51e4>] [<c01b5234>] [<c010ee2c>] [<c010ee2c>]
   [<c01b1294>] [<c0132a1b>] [<c0132bf6>] [<c010725f>]
Code: 0f ba 6a 74 00 8b 42 0c 05 00 00 00 40 0f 22 d8 8b 82 98 00


>>EIP; c010ecaf <schedule+18f/2a8>   <=====

Trace; c0117e10 <schedule_timeout+14/a4>
Trace; c01b51e4 <read_chan+354/74c>
Trace; c01b5234 <read_chan+3a4/74c>
Trace; c010ee2c <default_wake_function+0/34>
Trace; c010ee2c <default_wake_function+0/34>
Trace; c01b1294 <tty_read+d0/128>
Trace; c0132a1b <vfs_read+b7/138>
Trace; c0132bf6 <sys_read+2a/3c>
Trace; c010725f <syscall_call+7/b>

Code;  c010ecaf <schedule+18f/2a8>
00000000 <_EIP>:
Code;  c010ecaf <schedule+18f/2a8>   <=====
   0:   0f ba 6a 74 00            btsl   $0x0,0x74(%edx)   <=====
Code;  c010ecb4 <schedule+194/2a8>
   5:   8b 42 0c                  mov    0xc(%edx),%eax
Code;  c010ecb7 <schedule+197/2a8>
   8:   05 00 00 00 40            add    $0x40000000,%eax
Code;  c010ecbc <schedule+19c/2a8>
   d:   0f 22 d8                  mov    %eax,%cr3
Code;  c010ecbf <schedule+19f/2a8>
  10:   8b 82 98 00 00 00         mov    0x98(%edx),%eax

Linux razor 2.5.32 #5 Wed Aug 28 09:21:53 EST 2002 i686 unknown unknown GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12

Config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
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
CONFIG_PREEMPT=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_R128=y
CONFIG_DRM_RADEON=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_SECURITY_CAPABILITIES=y


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461



