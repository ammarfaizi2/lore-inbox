Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRCKMeS>; Sun, 11 Mar 2001 07:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131405AbRCKMd7>; Sun, 11 Mar 2001 07:33:59 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:2576 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131410AbRCKMdz>; Sun, 11 Mar 2001 07:33:55 -0500
Message-Id: <200103111232.NAA02902@fire.malware.de>
Date: Sun, 11 Mar 2001 13:32:39 +0100
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0-ac1 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in __mark_inode_dirty (2.4.2-pre3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

had an Oops in __mark_inode_dirty running kernel 2.4.2-pre3 on i386 UP
(actually a PII-300). It did happen during the daily cron job. Currently
on proc, devpts and ext2 filesystems are used no nfs and the like. The
system is still running. So if you need further information mail me or
come on #kernelnewbies (my nick is malware). 


Michael

So Here is the Oops:

printing eip:
c0140770
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__mark_inode_dirty+92/112]
EFLAGS: 00010202
eax: 00000000   ebx: cc85b240   ecx: cc85b428   edx: cc85b248
esi: c15dc200   edi: 00000001   ebp: c361dfa4   esp: c361df24
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 2962, stackpage=c361d000)
Stack: c361c000 00000000 cc86bce0 c0141660 cc85b240 00000001 c0138d09
cc85b240
       c2bbf000 00000000 c361dfa4 bffffc24 00000001 bffffc24 c013823a
00000009
       cc86bce0 c2bbf01b 0000000b ef164d83 c01391dc c2bbf026 c361dfa4
c361dfa4
Call Trace: [update_atime+68/84] [path_walk+1701/1980] [getname+90/152]
[<ef164d83>] [__user_walk+60/88] [sys_stat64+22/120] [system_call+51/56]

Code: 89 50 04 89 43 08 8d 46 40 89 42 04 89 56 40 90 5b 5e 5f c3

And this is the code of __mark_inode_dirty:

0xc0140714 <__mark_inode_dirty>:        push   %edi
0xc0140715 <__mark_inode_dirty+1>:      push   %esi
0xc0140716 <__mark_inode_dirty+2>:      push   %ebx
0xc0140717 <__mark_inode_dirty+3>:      mov    0x10(%esp,1),%ebx
0xc014071b <__mark_inode_dirty+7>:      mov    0x14(%esp,1),%edi
0xc014071f <__mark_inode_dirty+11>:     mov    0x8c(%ebx),%esi
0xc0140725 <__mark_inode_dirty+17>:     test   %esi,%esi
0xc0140727 <__mark_inode_dirty+19>:
    je     0xc0140780 <__mark_inode_dirty+108>
0xc0140729 <__mark_inode_dirty+21>:     test   $0x7,%edi
0xc014072f <__mark_inode_dirty+27>:
    je     0xc0140745 <__mark_inode_dirty+49>
0xc0140731 <__mark_inode_dirty+29>:     mov    0x20(%esi),%eax
0xc0140734 <__mark_inode_dirty+32>:     test   %eax,%eax
0xc0140736 <__mark_inode_dirty+34>:
    je     0xc0140745 <__mark_inode_dirty+49>
0xc0140738 <__mark_inode_dirty+36>:     mov    0x8(%eax),%eax
0xc014073b <__mark_inode_dirty+39>:     test   %eax,%eax
0xc014073d <__mark_inode_dirty+41>:
    je     0xc0140745 <__mark_inode_dirty+49>
0xc014073f <__mark_inode_dirty+43>:     push   %ebx
0xc0140740 <__mark_inode_dirty+44>:     call   *%eax
0xc0140742 <__mark_inode_dirty+46>:     add    $0x4,%esp
0xc0140745 <__mark_inode_dirty+49>:     mov    0xf0(%ebx),%edx
0xc014074b <__mark_inode_dirty+55>:     mov    %edx,%eax
0xc014074d <__mark_inode_dirty+57>:     and    %edi,%eax
0xc014074f <__mark_inode_dirty+59>:     cmp    %edi,%eax
0xc0140751 <__mark_inode_dirty+61>:
    je     0xc0140780 <__mark_inode_dirty+108>
0xc0140753 <__mark_inode_dirty+63>:     or     %edi,%edx
0xc0140755 <__mark_inode_dirty+65>:     mov    %edx,0xf0(%ebx)
0xc014075b <__mark_inode_dirty+71>:     cmp    %ebx,(%ebx)
0xc014075d <__mark_inode_dirty+73>:
    je     0xc0140780 <__mark_inode_dirty+108>
            *** list_del start ***
0xc014075f <__mark_inode_dirty+75>:     lea    0x8(%ebx),%edx
0xc0140762 <__mark_inode_dirty+78>:     mov    0x4(%edx),%ecx
0xc0140765 <__mark_inode_dirty+81>:     mov    0x8(%ebx),%eax
0xc0140768 <__mark_inode_dirty+84>:     mov    %ecx,0x4(%eax)
0xc014076b <__mark_inode_dirty+87>:     mov    %eax,(%ecx)
            *** list_del end, list_add start ***
0xc014076d <__mark_inode_dirty+89>:     mov    0x40(%esi),%eax
0xc0140770 <__mark_inode_dirty+92>:     mov    %edx,0x4(%eax)
                     ^^^^^ CRASHed at above ^^^^^
0xc0140773 <__mark_inode_dirty+95>:     mov    %eax,0x8(%ebx)
0xc0140776 <__mark_inode_dirty+98>:     lea    0x40(%esi),%eax
0xc0140779 <__mark_inode_dirty+101>:    mov    %eax,0x4(%edx)
0xc014077c <__mark_inode_dirty+104>:    mov    %edx,0x40(%esi)
0xc014077f <__mark_inode_dirty+107>:    nop    
0xc0140780 <__mark_inode_dirty+108>:    pop    %ebx
0xc0140781 <__mark_inode_dirty+109>:    pop    %esi
0xc0140782 <__mark_inode_dirty+110>:    pop    %edi
0xc0140783 <__mark_inode_dirty+111>:    ret    

Versions installed:

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.24
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.17       (not used)
PPP                    2.3.11       (not used)
isdn4k-utils           3.1pre1a     (not used)
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ipv6 3c509 serial

Kernel configuration:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
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
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
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
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_XD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PG=m
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6=m
CONFIG_IPV6_EUI64=y
CONFIG_IPV6_NO_PB=y
CONFIG_IPX=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=10
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY=5
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_NCR53C7xx=m
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_SCSI_DC390T=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=m
CONFIG_VORTEX=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_NET_ISA=y
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_R128=m
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_NCP_FS=m
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_NLS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MAGIC_SYSRQ=y
