Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTDTFWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 01:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTDTFWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 01:22:44 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:9124 "EHLO fed1mtao07.cox.net")
	by vger.kernel.org with ESMTP id S263528AbTDTFWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 01:22:41 -0400
Message-ID: <3EA22FDD.6010109@cox.net>
Date: Sat, 19 Apr 2003 22:27:57 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 oops booting with initrd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very small and simple kernel configuration (includes devfs, which is 
where this problem came from), using Etherboot to load it along with a 
small (768K) initrd.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c0109835
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0109835>]    Not tainted
EFLAGS: 00010002
EIP is at __down+0x55/0xc0
eax: 00000000   ebx: c021c190   ecx: c021c190   edx: c151de5c
esi: 00000286   edi: dfece040   ebp: c021c198   esp: c151de50
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c151c000 task=dfece040)
Stack: 00000001 dfece040 c0114000 c021c198 00000000 63736900 69642f73 
00306373
        c154bd80 00000000 c154be6c dfcfe6c0 c01099cc c021c190 c021c180 
00000000
        c01772d9 c154be40 c01a292a dff228a0 c154bd80 dff294c0 c017722c 
c021c180
Call Trace:
  [<c0114000>] default_wake_function+0x0/0x20
  [<c01099cc>] __down_failed+0x8/0xc
  [<c01772d9>] .text.lock.util+0x55/0x7c
  [<c01a292a>] blk_unregister_region+0x9a/0xa0
  [<c017722c>] devfs_remove_partitions+0x3c/0x50
  [<c01687ed>] del_gendisk+0xfd/0x100
  [<c01a567f>] initrd_release+0x3f/0x70
  [<c014002b>] __fput+0x9b/0xa0
  [<c013e8bd>] filp_close+0x4d/0x80
  [<c013e940>] sys_close+0x50/0x60
  [<c010a98b>] syscall_call+0x7/0xb
  [<c026b6dd>] rd_load_image+0xbd/0x390
  [<c026be96>] initrd_load+0x56/0x80
  [<c026ae93>] prepare_namespace+0x33/0x120
  [<c010506a>] init+0x2a/0x140
  [<c0105040>] init+0x0/0x140
  [<c0108a3d>] kernel_thread_helper+0x5/0x18

Code: 89 10 89 44 24 10 ff 43 04 89 f6 8b 43 04 48 01 03 0f 98 c0
  <0>Kernel panic: Attempted to kill init!

.config is as follows:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_NOHIGHMEM=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_MD=y
CONFIG_BLK_DEV_DM=y
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_KALLSYMS=y
CONFIG_X86_BIOS_REBOOT=y

