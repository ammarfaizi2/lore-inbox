Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbULMKux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbULMKux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 05:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbULMKux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 05:50:53 -0500
Received: from wylie.me.uk ([82.68.155.89]:29336 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S262221AbULMKuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 05:50:08 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16829.29661.747368.799519@devnull.wylie.me.uk>
Date: Mon, 13 Dec 2004 10:50:05 +0000
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       EC <wingman@waika9.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
In-Reply-To: <41BB41DC.6020808@pobox.com>
References: <16824.8109.697757.673632@devnull.wylie.me.uk>
	<41BB41DC.6020808@pobox.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Dec 2004 13:52:12 -0500, Jeff Garzik <jgarzik@pobox.com> said:

> If you are getting an oops there, it looks like your ata_piix driver
> is mismatched from the libata core.  Did you compile them both at
> the same time, from the same source kernel?

> The assembly code above is where function ata_host_add in
> libata-core.c calls "ap->ops->port_start", which definitely exists
> in ata_piix.c.

I've just reproduced the boot, taking care and double checking every
step, this time with 2.4.29-pre1-bk7

I get the pretty much same crash.

The same kernel with BIOS "Native Mode" set to BOTH works.

# cd tmp

# ls -l
total 8
drwxr-xr-x    2 root     root         4096 Dec 10 15:40 .
drwxr-xr-x   15 root     root         4096 Dec 10 16:25 ..

# tar xIf .../linux-2.4.28.tar.bz2

# cd linux-2.4.28/
# bzip2 -dc .../patch-2.4.29-pre1.bz2     | patch -p 1 --quiet
# bzip2 -dc .../patch-2.4.29-pre1-bk7.bz2 | patch -p 1 --quiet

# cp .../.config .
# make oldconfig

# sed -i '/^#export\tINSTALL_PATH=\/boot/s/#//' Makefile

# grep -v "^#" .config | cat -s

CONFIG_X86=y
CONFIG_UID16=y

CONFIG_EXPERIMENTAL=y

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
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

CONFIG_MSDOS_PARTITION=y

CONFIG_VGA_CONSOLE=y

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=0

# make dep && make clean && make

# make install

# date
Mon Dec 13 10:15:00 GMT 2004

# ls -lrt /boot
total 2588
...
-rw-r--r--    1 root     root       690354 Dec 13 10:14 vmlinuz
-rw-r--r--    1 root     root       359525 Dec 13 10:14 System.map

[reboot]

[BIOS setup - Native Mode Operation AUTO ]

[OOPS]

PCI: Sharing IRQ 10 with 04:02.0
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bdma 0x18E0 irq 14
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133

ksymoops 2.4.9 on i686 2.4.29-pre1-bk5.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000050
c01afb37
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01afb37>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f7e6b878   ecx: 00000000   edx: 00000002
esi: f7e6b800   edi: f7e6ba20   ebp: f7e6ba20   esp: c19b7f18
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c19b7000)
Stack: f7e6b878 f7e6b800 c19bfa00 f7e6ba20 00000000 c19bfa00 00000000 c19bfa1c
       c01afcc0 f7e6ba20 c19bfa00 00000000 c0208ccb 00000286 000003f6 000018e0
       0000000e c19b0800 00000000 f7e6ba20 00000001 c0105000 c0226ce0 c01afda2
Call Trace:    [<c01afcc0>] [<c0105000>] [<c01afda2>] [<c01a0ab5>] [<c01b536c>]
  [<c01b53dc>] [<c0105000>] [<c010507b>] [<c0105000>] [<c010569e>] [<c0105070>]
Code: ff 50 50 89 da 85 c0 75 12 8b 5c 24 14 89 d0 8b 74 24 18 8b


>>EIP; c01afb37 <ata_host_add+57/80>   <=====

Trace; c01afcc0 <ata_device_add+160/200>
Trace; c0105000 <_stext+0/0>
Trace; c01afda2 <ata_scsi_detect+42/60>
Trace; c01a0ab5 <scsi_register_host+2e5/2f0>
Trace; c01b536c <pci_announce_device+6c/80>
Trace; c01b53dc <pci_register_driver+5c/60>
Trace; c0105000 <_stext+0/0>
Trace; c010507b <init+b/100>
Trace; c0105000 <_stext+0/0>
Trace; c010569e <arch_kernel_thread+2e/40>
Trace; c0105070 <init+0/100>

Code;  c01afb37 <ata_host_add+57/80>
00000000 <_EIP>:
Code;  c01afb37 <ata_host_add+57/80>   <=====
   0:   ff 50 50                  call   *0x50(%eax)   <=====
Code;  c01afb3a <ata_host_add+5a/80>
   3:   89 da                     mov    %ebx,%edx
Code;  c01afb3c <ata_host_add+5c/80>
   5:   85 c0                     test   %eax,%eax
Code;  c01afb3e <ata_host_add+5e/80>
   7:   75 12                     jne    1b <_EIP+0x1b>
Code;  c01afb40 <ata_host_add+60/80>
   9:   8b 5c 24 14               mov    0x14(%esp),%ebx
Code;  c01afb44 <ata_host_add+64/80>
   d:   89 d0                     mov    %edx,%eax
Code;  c01afb46 <ata_host_add+66/80>
   f:   8b 74 24 18               mov    0x18(%esp),%esi
Code;  c01afb4a <ata_host_add+6a/80>
  13:   8b 00                     mov    (%eax),%eax

  <0>Kernel panic: Attempted to kill init!

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
