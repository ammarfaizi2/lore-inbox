Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbRDJDUV>; Mon, 9 Apr 2001 23:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132910AbRDJDUL>; Mon, 9 Apr 2001 23:20:11 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:60422 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132909AbRDJDT6>; Mon, 9 Apr 2001 23:19:58 -0400
Subject: Swap Corruption in 2.4.3 ?
From: Richard Russon <kernel@flatcap.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10+cvs.2001.04.09.08.06 (Preview Release)
Date: 10 Apr 2001 04:20:09 +0100
Message-Id: <986872810.8240.0.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When I unmount the swapfile I get:

VM: Undead swap entry 000bb300
VM: Undead swap entry 00abb300
VM: Undead swap entry 016fb300

I can repeat this fairly reliably.  First fill up the conventional
memory, and a few 10s of Mb of swap, then put the machine under a bit
of a load.  It may not be the loading that's causing this, just the
movement in swap.

First things stop working, e.g. shared libraries appear to be missing
or corrupt, every program segfaults on startup, occasionally the whole
machines hangs.  I have seen Oopses but if memory is being corrupted I
doubt they'll be any use.

If I reboot, everything is fine again.

The machine is a 800Mhz PIII, all IDE, all ext2, not overclocked, with a
vanilla 2.4.3 kernel (compiled with gcc-2.91.66).

I can reproduce this with DMA turned off.
I cannot reproduce this with the swap file off, however hard I try.
If the swapfile isn't touched the machine seems stable under load.

Below is my .config (if it's useful)

Can anyone think of anything else I can test to give you any pointers?

Cheers,
  FlatCap (Richard Russon)
  kernel@flatcap.org

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_SR_EXTRA_DEVS=2
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP_SIS=y
CONFIG_AUTOFS4_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_8139TOO=m
CONFIG_NE2K_PCI=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_SOUND_ES1371=m


