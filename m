Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319525AbSIMFiU>; Fri, 13 Sep 2002 01:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319528AbSIMFiU>; Fri, 13 Sep 2002 01:38:20 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:15629 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319525AbSIMFiO>; Fri, 13 Sep 2002 01:38:14 -0400
Date: Fri, 13 Sep 2002 07:42:25 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: oops in apm.c when booting 2.4.20-pre5-ac6
Message-ID: <20020913054225.GA510@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when booting 2.4.20-pre5-ac6, I see in my dmesg:

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe (power off active).
kernel BUG at apm.c:1724!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0111e7c>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c1e28000   ecx: c0356244   edx: c1e28000
esi: c0285e37   edi: c1e28338   ebp: c1e29fec   esp: c1e29fd8
ds: 0018   es: 0018   ss: 0018
Process kapmd (pid: 5, stackpage=c1e29000)
Stack: 00000f11 c1e3ffa4 00000000 00000018 00000078 c1e3ffb0 c0105640 00000000
       00000078 c0301fc0
Call Trace:    [<c0105640>]

Code: 0f 0b bc 06 c7 5b 28 c0 66 83 3d 94 d7 36 c0 00 75 4a 0f b7
 Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP,EPP]
parport_pc: Via 686A parallel port: io=0x378
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on

ksymoops 2.4.6 on i686 2.4.20-pre5-ac6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5-ac6/ (default)
     -m /boot/System.map-2.4.20-pre5-ac6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 1004480, slice: 334826
cpu: 1, clocks: 1004480, slice: 334826
kernel BUG at apm.c:1724!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0111e7c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c1e28000   ecx: c0350244   edx: c1e28000
esi: c0281b97   edi: c1e28338   ebp: c1e29fec   esp: c1e29fd8
ds: 0018   es: 0018   ss: 0018
Process kapmd (pid: 5, stackpage=c1e29000)
Stack: 00000f11 c1e3ffa4 00000000 00000018 00000078 c1e3ffb0 c0105640 00000000 
       00000078 c02fbfc0 
Call Trace:    [<c0105640>]
Code: 0f 0b bc 06 27 19 28 c0 66 83 3d 94 77 36 c0 00 75 4a 0f b7 


>>EIP; c0111e7c <apm+5c/2e4>   <=====

>>ebx; c1e28000 <_end+1a63408/384ff468>
>>ecx; c0350244 <runqueues+9c4/13400>
>>edx; c1e28000 <_end+1a63408/384ff468>
>>esi; c0281b97 <error_table+4d7/4b80>
>>edi; c1e28338 <_end+1a63740/384ff468>
>>ebp; c1e29fec <_end+1a653f4/384ff468>
>>esp; c1e29fd8 <_end+1a653e0/384ff468>

Trace; c0105640 <kernel_thread+28/38>

Code;  c0111e7c <apm+5c/2e4>
00000000 <_EIP>:
Code;  c0111e7c <apm+5c/2e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0111e7e <apm+5e/2e4>
   2:   bc 06 27 19 28            mov    $0x28192706,%esp
Code;  c0111e83 <apm+63/2e4>
   7:   c0 66 83 3d               shlb   $0x3d,0xffffff83(%esi)
Code;  c0111e87 <apm+67/2e4>
   b:   94                        xchg   %eax,%esp
Code;  c0111e88 <apm+68/2e4>
   c:   77 36                     ja     44 <_EIP+0x44> c0111ec0 <apm+a0/2e4>
Code;  c0111e8a <apm+6a/2e4>
   e:   c0 00 75                  rolb   $0x75,(%eax)
Code;  c0111e8d <apm+6d/2e4>
  11:   4a                        dec    %edx
Code;  c0111e8e <apm+6e/2e4>
  12:   0f b7 00                  movzwl (%eax),%eax

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
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
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
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
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_HAZARD_READ=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_DE4X5=m
CONFIG_8139TOO=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_STORAGE=y
CONFIG_USB_PRINTER=y
CONFIG_USB_SCANNER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_FRAME_POINTER=y
CONFIG_MAGIC_SYSRQ=y

I suspect the lines around apm.c:1724 should be like the lines around
apm.c:511:

#ifdef CONFIG_SMP
        /* 2002/08/01 - WT
         * This is to avoid random crashes at boot time during initialization
         * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
         * Some bioses don't like being called from CPU != 0.
         * Method suggested by Ingo Molnar.
         */
        /* Some bioses don't like being called from CPU != 0 */
        if (cpu_number_map(smp_processor_id()) != 0) {
                set_cpus_allowed(current, 1 << cpu_logical_map(0));
                if (unlikely(cpu_number_map(smp_processor_id()) != 0))
                        BUG();
        }
#if 0
        if (cpu_number_map(smp_processor_id()) != 0) {
                current->cpus_allowed = 1;
                schedule();
                if (unlikely(cpu_number_map(smp_processor_id()) != 0))
                        BUG();
        }
#endif
#endif

Jurriaan
-- 
No one needs morality when there isn't enough to eat
        New Model Army
GNU/Linux 2.4.19-ac4 SMP/ReiserFS 2x1402 bogomips load av: 0.02 0.20 0.70
