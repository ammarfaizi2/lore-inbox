Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTDLOLc (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 10:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTDLOLc (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 10:11:32 -0400
Received: from hydra.colinet.de ([194.231.113.36]:7687 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id S262903AbTDLOL3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 10:11:29 -0400
Subject: 2.5.67 alpha compile failure
To: linux-kernel@vger.kernel.org
Cc: kirk@colinet.de
Message-Id: <kirk-1030412154541.A0214377@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
From: "T. Weyergraf" <kirk@colinet.de>
Date: Sat, 12 Apr 2003 15:45:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

kernel 2.5.67 fails to compile on alpha ( DP264, SMP ):

[...]
  gcc -Wp,-MD,kernel/.sys.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=sys -DKBUILD_MODNAME=sys -c -o kernel/sys.o kernel/sys.c
kernel/sys.c:226: conflicting types for `sys_sendmsg'
include/linux/socket.h:245: previous declaration of `sys_sendmsg'
kernel/sys.c:227: conflicting types for `sys_recvmsg'
include/linux/socket.h:246: previous declaration of `sys_recvmsg'
make[1]: *** [kernel/sys.o] Error 1
make: *** [kernel] Error 2

in include/linux/socket.h, both sys_sendmsg and sys_recvmsg are declared as follows:

extern asmlinkage long sys_sendmsg(int fd, struct msghdr *msg, unsigned flags);
extern asmlinkage long sys_recvmsg(int fd, struct msghdr *msg, unsigned flags);

Obviously, commenting-out those declarations fixes the compile problem and the rest of the
build passes just fine.
This problem is new to me. 2.5.64 and 65 do not have it.

My question is: Is commenting-out the declarations the Correct Way (TM) ?
I don't think so ...

Any Ideas ?

Regards,
Thomas Weyergraf



Options set in .config are as follows:


CONFIG_ALPHA=y
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_ALPHA_DP264=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_PCI=y
CONFIG_ALPHA_EV6=y
CONFIG_ALPHA_TSUNAMI=y
CONFIG_ALPHA_EV67=y
CONFIG_ALPHA_SRM=y
CONFIG_EARLY_PRINTK=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=2
CONFIG_VERBOSE_MCHECK=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_SRM_ENV=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_DM=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=y
CONFIG_TULIP_MMIO=y
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_ISO9660_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_OSF_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_ALPHA_LEGACY_START_ADDRESS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MATHEMU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_CRC32=y




-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


