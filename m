Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbULIJts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbULIJts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULIJtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 04:49:47 -0500
Received: from wylie.me.uk ([82.68.155.89]:52411 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S261465AbULIJti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 04:49:38 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16824.8109.697757.673632@devnull.wylie.me.uk>
Date: Thu, 9 Dec 2004 09:49:33 +0000
To: linux-kernel@vger.kernel.org
Cc: "EC" <wingman@waika9.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Subject: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See also: <http://lkml.org/lkml/2004/12/3/68>

With 2.4.27 patched with

<http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.27-rc3-libata1.patch.bz2>

the system works. I have not been able to make it work with any later
2.4 kernel

Motherboard: Supermicro X6DA8-G2

[snippet from LSPCI -v]
------------------------------------------------------------------------------
00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Super Micro Computer Inc: Unknown device 5680
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 18e0 [size=16]

[I hope I've got the patching right]
------------------------------------------------------------------------------

# rm -r linux-2.4.28/
# tar xIf linux-2.4.28.tar.bz2 
# cd linux-2.4.28/
# bzip2 -dc  ../patch-2.4.29-pre1.bz2     | patch -p 1 --quiet
# bzip2 -dc  ../patch-2.4.29-pre1-bk5.bz2 | patch -p 1 --quiet

[grep -v "^#" .config]
------------------------------------------------------------------------------
CONFIG_X86=y
CONFIG_UID16=y

CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y

CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

CONFIG_PCMCIA=y
CONFIG_CARDBUS=y

CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_RTC_IS_GMT=y

CONFIG_PNP=y

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_BLK_DEV_LVM=y

CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y

CONFIG_SCSI_SATA=y
CONFIG_SCSI_ATA_PIIX=y

CONFIG_NETDEVICES=y

CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

CONFIG_MOUSE=y
CONFIG_PSMOUSE=y

CONFIG_RTC=y

CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

CONFIG_MSDOS_PARTITION=y

CONFIG_VGA_CONSOLE=y

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=0

[last lines of output on screen]
------------------------------------------------------------------------------
SCSI subsystem driver revision: 1.00
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18E0 irq 14
ata1:dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1:dev 0 configured for UDMA/133 

[decoded output of ksymoops]
------------------------------------------------------------------------------
ksymoops 2.4.9 on i686 2.4.27.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000050
  c01ccd07
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01ccd07>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f7e5007c   ecx: 00000000   edx: 00000002
esi: f7e50000   edi: f7e50220   ebp: f7e50220   esp: c19b1f0c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c19b1000)
Stack: f7e5007c f7e50000 c19bed00 f7e50220 00000000 c19bed00 00000000 c19bed20
       c01cce91 f7e50220 c19bed00 00000000 c02746cc c19beda0 000003f6 00000286
       0000000e f7e75c00 00000000 f7e50220 00000001 c0105000 c02a05c0 c01ccf8d
Call Trace: [<c01cce91>] [<c0105000>] [<c01ccf8d>] [<c01bd49b>] [<c01d27ec>]
  [<c0105000>] [<c01050b9>] [<c01057de>] [<c0105090>]
Code: ff 50 50 89 da 85 c0 75 12 8b 5c 24 14 89 d0 8b 74 24 18 8b


>>EIP; c01ccd07 <ata_host_add+57/80>   <=====

Trace; c01cce91 <ata_device_add+161/200>
Trace; c0105000 <_stext+0/0>
Trace; c01ccf8d <ata_scsi_detect+5d/90>
Trace; c01bd49b <scsi_register_host+2fb/310>
Trace; c01d27ec <pci_register_driver+5c/60>
Trace; c0105000 <_stext+0/0>
Trace; c01050b9 <init+29/150>
Trace; c01057de <arch_kernel_thread+2e/40>
Trace; c0105090 <init+0/150>

Code;  c01ccd07 <ata_host_add+57/80>
00000000 <_EIP>:
Code;  c01ccd07 <ata_host_add+57/80>   <=====
   0:   ff 50 50                  call   *0x50(%eax)   <=====
Code;  c01ccd0a <ata_host_add+5a/80>
   3:   89 da                     mov    %ebx,%edx
Code;  c01ccd0c <ata_host_add+5c/80>
   5:   85 c0                     test   %eax,%eax
Code;  c01ccd0e <ata_host_add+5e/80>
   7:   75 12                     jne    1b <_EIP+0x1b>
Code;  c01ccd10 <ata_host_add+60/80>
   9:   8b 5c 24 14               mov    0x14(%esp),%ebx
Code;  c01ccd14 <ata_host_add+64/80>
   d:   89 d0                     mov    %edx,%eax
Code;  c01ccd16 <ata_host_add+66/80>
   f:   8b 74 24 18               mov    0x18(%esp),%esi
Code;  c01ccd1a <ata_host_add+6a/80>
  13:   8b 00                     mov    (%eax),%eax

  <0>Kernel panic: Attempted to kill init!


-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
