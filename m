Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbTAOPkj>; Wed, 15 Jan 2003 10:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbTAOPkj>; Wed, 15 Jan 2003 10:40:39 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:54472 "EHLO
	sparsus.humilis.net") by vger.kernel.org with ESMTP
	id <S266006AbTAOPkh>; Wed, 15 Jan 2003 10:40:37 -0500
Date: Wed, 15 Jan 2003 16:49:30 +0100
From: Ookhoi <ookhoi@humilis.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.58-bk Oops, EIP is at sysfs_remove_dir, Process swapper
Message-ID: <20030115164930.A24339@humilis>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 14:06:34 up 24 days,  2:45, 20 users,  load average: 0.28, 0.10, 0.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Current 2.5.58 out of bk (Wed Jan 15 16:14:41 CET 2003) gives me the
following Oops on boot (typed of the screen):

RAMDISK: Compressed image found at block 0
Unable to handle kernel NULL pointer dereference at virtual address 00000064
 printing eip:
c016494b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c016494b>]    Not tainted
EFLAGS: 00010206
EIP is at sysfs_remove_dir+0xb/0x160
eax: 0000003c   ebx: 0000003c   ecx: dfffdb98   edx: 00000050
esi: dfd8c534   edi: dfd0130c   ebp: c153fe64   esp: c153fe50
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c153e000 task=c153c040)
Stack: 0000003c 0000003c 0000003c dfd8c534 dfd0130c c153fe74 c016e66d 0000003c
       0000003c c153fe84 c016e68d 0000003c dfd8c57c c153fe94 c0188426 0000003c
       dfd8c534 c153fea4 c018bf1d dfd8c534 00000000 c153fec0 c0163574 dfd8c534
Call Trace:
 [<c016e66d>] kobject_del+0xd/0x20
 [<c016e68d>] kobject_unregister+0xd/0x20
 [<c0188426>] elv_unregister_queue+0x16/0x30
 [<c018bf1d>] unlink_gendisk+0xd/0x30
 [<c0163574>] del_gendisk+0x64/0x140
 [<c0195d3b>] initrd_release+0x3b/0x60
 [<c013d114>] __fput+0xb4/0xc0
 [<c013b9f8>] flip_close+0x38/0x60
 [<c013ba67>] sys_close+0x47/0x60
 [<c010b007>] syscall_call+0x7/0xb
 [<c01603e0>] proc_register+0x10/0xa0
 [<c0105345>] prepare_namespace+0xd5/0x140
 [<c010505a>] init+0xZa/0x140
 [<c0105030>] init+0x0/0x140
 [<c0109135>] kernel_thread_helper+0x5/0x10

Code: 8b 78 28 85 ff 0f 48 38 01 00 00 8b 07 85 c0 75 08 0f 0b 02
 <0>Kernel panic: Attempted to kill init!


gcc is gcc (GCC) 3.2.2 20030109 (Debian prerelease)

I try to boot from a floppy with an initrd. It worked for 2.5.54 iirc.

config (no modules):

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_LOG_BUF_SHIFT_17=y
CONFIG_MODULES=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_X86_PC=y
CONFIG_M586MMX=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_NOHIGHMEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_NET=y
CONFIG_INET=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_BIOS_REBOOT=y


I hope this is of any help.
