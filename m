Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTAYGQh>; Sat, 25 Jan 2003 01:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTAYGQh>; Sat, 25 Jan 2003 01:16:37 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:60177 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266200AbTAYGQd>; Sat, 25 Jan 2003 01:16:33 -0500
Date: Sat, 25 Jan 2003 07:25:13 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3-ac4 oops in kmem_cache_destroy
Message-ID: <20030125062513.GA10351@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems with the stability of my 2.4.21-pre3-ac4 machine.

It's a dual tualatin, with registered ecc DDR memory. After the oops,
the machine hangs hard. Very hard. So I've written it down by hand - and
hope I didn't make a mistake somewhere. Can anybody shed some light on
this?

Thanks,
Jurriaan

The decoded oops looks like this:

ksymoops 2.4.8 on i686 2.4.21-pre3-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac4/ (default)
     -m /boot/System.map-2.4.21-pre3-ac4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.21-pre3-ac4 failed
Unable to handle kernel paging request at virtual address aa82e440
c0138680
*pde = 00000007
Oops: 000
CPU:    0
EIP:    0010:[<c0138680>]      Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 7473090a  ebx: 7473090a ecx: d8b6c000 edx: c1606ccc
esi: 00000077  edi: 00000006 ebp: c1627e24 esp: c1627c10
ds: 0018 es: 0018 ss: 0018
Process kupdateb (pid:10, stackpage=c1627000)
Stack: c160bed4 c160bedc c160becc 00000246 000000f0 c1627e48 c01393bb c0145c8d
       c1634000 000000f0 c013b0a7 00000000 00000000 00001000 c1627e58 c0145c8d
       c160becc 000000f0 c1627e78 c0145d3b 00000000 c0142550 00000000 c10c5b10
Call Trace: [<c01393bb>] [<c013b07a>] [<c0145c8d>] [<c0145d3b>] [c0132550>]
 [<c0147c5b>] [<c0147e59>] [<c014586c>] [<c01953b6>] [<c01482cf>] [<c0148665>]
 [<c0105000>] [<c0105000>] [<c010583e>] [<c0148550>]
Code: 8b 44 81 18 0f af 5a 18 8b 51 0c 89 41 14 01 d3 40 74 30 8b


>>EIP; c0138680 <kmem_cache_destroy+3f0/4e0>   <=====

>>ecx; d8b6c000 <___strtok+187b436c/225143cc>
>>edx; c1606ccc <___strtok+124f038/225143cc>
>>ebp; c1627e24 <___strtok+1270190/225143cc>
>>esp; c1627c10 <___strtok+126ff7c/225143cc>

Trace; c01393bb <kmem_find_general_cachep+a8b/2490>
Trace; c013b07a <__alloc_pages+9a/1a0>
Trace; c0145c8d <get_unused_buffer_head+5d/b0>
Trace; c0145d3b <set_bh_page+5b/240>
Trace; c0147c5b <block_symlink+1ab/4f0>
Trace; c0147e59 <block_symlink+3a9/4f0>
Trace; c014586c <getblk+3c/140>
Trace; c01953b6 <load_nls_default+22656/2ad80>
Trace; c01482cf <try_to_free_buffers+32f/3a0>
Trace; c0148665 <block_sync_page+325/360>
Trace; c0105000 <empty_zero_page+1000/13d0>
Trace; c0105000 <empty_zero_page+1000/13d0>
Trace; c010583e <kernel_thread+2e/1c0>
Trace; c0148550 <block_sync_page+210/360>

Code;  c0138680 <kmem_cache_destroy+3f0/4e0>
00000000 <_EIP>:
Code;  c0138680 <kmem_cache_destroy+3f0/4e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0138684 <kmem_cache_destroy+3f4/4e0>
   4:   0f af 5a 18               imul   0x18(%edx),%ebx
Code;  c0138688 <kmem_cache_destroy+3f8/4e0>
   8:   8b 51 0c                  mov    0xc(%ecx),%edx
Code;  c013868b <kmem_cache_destroy+3fb/4e0>
   b:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c013868e <kmem_cache_destroy+3fe/4e0>
   e:   01 d3                     add    %edx,%ebx
Code;  c0138690 <kmem_cache_destroy+400/4e0>
  10:   40                        inc    %eax
Code;  c0138691 <kmem_cache_destroy+401/4e0>
  11:   74 30                     je     43 <_EIP+0x43>
Code;  c0138693 <kmem_cache_destroy+403/4e0>
  13:   8b 00                     mov    (%eax),%eax


1 warning and 1 error issued.  Results may not be reliable.

.config:

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
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
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
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID5=m
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
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
CONFIG_TULIP=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=y
CONFIG_EEPRO100=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
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
CONFIG_EXT3_FS=m
CONFIG_JBD=m
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
CONFIG_FB_MATROX_G100A=y
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
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_OSS=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_SCANNER=m
CONFIG_DEBUG_KERNEL=y
CONFIG_FRAME_POINTER=y
CONFIG_MAGIC_SYSRQ=y

versions:

Linux middle 2.4.21-pre3-ac4 #1 SMP Thu Jan 23 13:22:21 CET 2003 i686 unknown unknown GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.4
Modules Loaded         vmnet vmmon ext3 jbd md w83781d eeprom i2c-proc i2c-isa i2c-viapro i2c-core snd-pcm-oss snd-mixer-oss snd-emu1
0k1 snd-pcm snd-timer snd-rawmidi snd-util-mem snd-ac97-codec snd-seq-device snd-hwdep snd vfat udf ntfs isofs fat usb-storage scanne
r usb-uhci usbcore sound mga agpgart loop rtc

I know, the vmware modules are loaded. It's unstable without them also,
it just took me a while to be convinced to write the oops down by hand
:-)
-- 
Backup Not Found (A)ssasinate Bill Gates (R)etry (K)eep trying until 6 am?
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2824 bogomips load av: 0.77 0.25 0.17
