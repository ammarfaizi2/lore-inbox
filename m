Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTBGPFq>; Fri, 7 Feb 2003 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTBGPFp>; Fri, 7 Feb 2003 10:05:45 -0500
Received: from adsl-63-205-114-68.dsl.lsan03.pacbell.net ([63.205.114.68]:37589
	"HELO mydns2.compustrat.com") by vger.kernel.org with SMTP
	id <S265305AbTBGPFh>; Fri, 7 Feb 2003 10:05:37 -0500
Date: Fri, 7 Feb 2003 07:15:16 -0800 (PST)
From: Mailing Lists <thelittleprince-lists@asteroid-b612.org>
X-X-Sender: thelittleprince-lists@mydns2.compustrat.com
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: optional features error - promise raid card fs
Message-ID: <Pine.LNX.4.44.0302070635540.32473-100000@mydns2.compustrat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BACKGROUND:
Have a RH 7.2 system with SMP (P3x2) and a Promise SX6000 raid card.
Kernel is RH's 2.4.7-10smp. Drive/Array partitions formatted as ext3 
initially, but then downgraded to ext2 (had problems with ext3 and quotas 
on this kernel) (removed journal,updated fstab)
The only Promise released driver is for RH 7.2 and 2.4.7 kernel.


PROBLEM:
Trying to upgrade driver and kernel. Newer kernels dodn't work with 7.2 
drivers (whole other issue). 
I finally get new driver from Promise for 7.3 and download the 2.4.20 
kernel, compile, compile driver as module, mk_initrd, and reboot.
On reboot it loads the driver, but then i get:

EXT2-fs: sd(8,3): couldn't mount because of unsupported optional features 
(4).
mount: error 22 mounting ext2
pivotroot: pivot_root(/sysroot, /sysroot/initrd) failed: 2
Kernel panic: No init found. Try passing init= option to kernel


SOFTWARE:
RH 7.2
kernel-smp-2.4.7-10
quota-3.01pre9-3
e2fsprogs-1.26-1.72
fileutils-4.1-4
mount-2.11g-5
promise sx6000 driver 1.32 (compiled,pti_st.o)


NOTES:
Also tried with compiled 2.4.18 to same results.
Also tried with 2.4.18 kernel (rpm) from RH (2.4.18-24.7.xsmp) to 
"Failed to exec /sbin/modprobe -s -k block-major-8, errno = 2" and " 
"VFS: Unable to mount root fs"
Any help is appreciated. Thanx.


CONFIGS AND CMD DEBUG (under 2.4.7):
* /etc/fstab
LABEL=/                 /                       ext2    defaults,usrquota 
1 1
LABEL=/boot             /boot                   ext2    defaults        1 
2
none                    /dev/pts                devpts  gid=5,mode=620  0 
0
none                    /proc                   proc    defaults        0 
0
none                    /dev/shm                tmpfs   defaults        0 
0
/dev/sda2               swap                    swap    defaults        0 
0
/dev/cdrom              /mnt/cdrom              iso9660 
noauto,owner,kudzu,ro 0
0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 
0 0


* /etc/modules.conf
alias parport_lowlevel parport_pc
alias eth0 eepro100
alias eth1 eepro100
alias scsi_hostadapter pti_st


* lsmod
Module                  Size  Used by
iptable_filter          3008   0  (autoclean) (unused)
ip_tables              14752   1  [iptable_filter]
autofs                 14404   0  (autoclean) (unused)
eepro100               21840   2
ext3                   67728   1
jbd                    44480   1  [ext3]
pti_st                 24112   3
sd_mod                 11584   3
scsi_mod               98512   2  [pti_st sd_mod]


* tune2fs -l /dev/sda3

tune2fs 1.26 (3-Feb-2002)
Filesystem volume name:   /
Last mounted on:          <not available>
Filesystem UUID:          3181bb30-bde4-11d6-85cf-90354e82042b
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              9945088
Block count:              19880192
Reserved block count:     994009
Free blocks:              17076914
Free inodes:              9551245
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Last mount time:          Fri Feb  7 08:42:04 2003
Last write time:          Fri Feb  7 08:42:04 2003
Mount count:              4
Maximum mount count:      -1
Last checked:             Tue Feb  4 22:50:29 2003
Check interval:           0 (<none>)
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            8
Journal device:           0x0000
First orphan inode:       0

* od -A x -t x1 /dev/sda3

000400 00 20 00 00 f0 7f 00 00 65 06 00 00 32 4b 00 00
000410 c9 1f 00 00 01 00 00 00 00 00 00 00 00 00 00 00
000420 00 20 00 00 00 20 00 00 00 08 00 00 b1 b7 43 3e
000430 b1 b7 43 3e 04 00 ff ff 53 ef 00 00 01 00 00 00
000440 0f 8a 40 3e 00 00 00 00 00 00 00 00 01 00 00 00
000450 00 00 00 00 0b 00 00 00 80 00 00 00 04 00 00 00
000460 02 00 00 00 01 00 00 00 86 71 2c 84 bd e4 11 d6
000470 94 b0 f4 5a eb 8f 08 26 2f 62 6f 6f 74 00 00 00
000480 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


* 2.4.20 kernel config
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
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
CONFIG_X86_MCE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
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
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_INTEL_RNG=y
CONFIG_RTC=y
CONFIG_QUOTA=y
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
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y


* /etc/grub.conf
default=0
timeout=10
splashimage=(hd0,0)/grub/splash.xpm.gz
title Red Hat Linux (2.4.20)
        root (hd0,0)
        kernel /vmlinuz-2.4.20 ro root=/dev/sda3
        initrd /initrd-2.4.20


-Tony


