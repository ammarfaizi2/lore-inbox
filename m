Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278962AbRKMUxz>; Tue, 13 Nov 2001 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278960AbRKMUxs>; Tue, 13 Nov 2001 15:53:48 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:40173 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S278962AbRKMUxa>; Tue, 13 Nov 2001 15:53:30 -0500
Message-Id: <200111132053.fADKrdW07245@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops in kswapd (2.4.14)
Date: Tue, 13 Nov 2001 15:53:28 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a well-loaded web server serving files off the root IDE disk and 
NFS.  It lasted a week on 2.4.10 and 2.4.14 before nixing kswapd and going 
haywire.  There were several later oopses, but I would assume the death of 
kswapd was a major part of those.

Unable to handle kernel NULL pointer dereference at virtual address 
0000000a
 printing eip:
c0137498
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[prune_dcache+24/296]    Not tainted
EFLAGS: 00010212
eax: c020613c   ebx: cad7b058   ecx: d9da1020   edx: 0000000a
esi: d9da1cc0   edi: 00000000   ebp: 00002adc   esp: c1873f60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1873000)
Stack: 00000001 000001d0 00000020 00000006 c01377fb 00002e45 c01227e0 
00000006
       000001d0 00000006 000001d0 c02054e8 00000000 c02054e8 c012281c 
00000020
       c02054e8 00000001 c1872000 c01228b3 c0205440 00000000 c1872249 
0008e000
Call Trace: [shrink_dcache_memory+27/52] [shrink_caches+108/132]
   [try_to_free_pages+36/68] [kswapd_balance_pgdat+67/140]
   [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]
Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54 a8 08 74 27 24 f7 89

The system is a P3/750 and was rock solid on 2.2.  The only disk is a WD 
on a PIIX4.  The NIC is an eepro100.  The kernel was compiled on Debian 
sid using "gcc version 2.95.4 20011006 (Debian prerelease)".

The config for it is:
CONFIG_X86=y
CONFIG_ISA=y
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
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=4
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_TMPFS=y
CONFIG_PROC_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y

Any help is appreciated
	-- Brian
