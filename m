Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRBIQuk>; Fri, 9 Feb 2001 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130257AbRBIQua>; Fri, 9 Feb 2001 11:50:30 -0500
Received: from [195.6.224.218] ([195.6.224.218]:54277 "EHLO winealley.com")
	by vger.kernel.org with ESMTP id <S129321AbRBIQuN>;
	Fri, 9 Feb 2001 11:50:13 -0500
From: Jean-Luc Fontaine <jfontain@winealley.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1: unresolved symbol with nfsd as a module
Date: Fri, 9 Feb 2001 17:56:37 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01020917563700.00917@suzuki.winealley.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me.

Platform: redhat 7.0 with kgcc.

# insmod ./kernel/fs/nfsd/nfsd.o
./kernel/fs/nfsd/nfsd.o: unresolved symbol nfsd_linkage

seems the code:

#if defined(CONFIG_NFSD_MODULE)
struct nfsd_linkage *nfsd_linkage = NULL;
...

from filesystems.c did not get in, although:

# fgrep nfsd System.map 
c01f3f60 ? __kstrtab_nfsd_linkage
c01f8b90 ? __ksymtab_nfsd_linkage
c01fedc8 D nfsd_linkage

and that is where it goes beyond my comprehension...
Here is my .config without the comments:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M686=y
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
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=y
CONFIG_BLK_DEV_FD=m
CONFIG_PACKET=m
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_AUTOFS4_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_SOUND_CMPCI=m
CONFIG_MAGIC_SYSRQ=y


-- 
Jean-Luc Fontaine mailto:jfontain@winealley.com http://www.winealley.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
