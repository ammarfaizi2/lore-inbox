Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSHLAY6>; Sun, 11 Aug 2002 20:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSHLAY6>; Sun, 11 Aug 2002 20:24:58 -0400
Received: from ping.uio.no ([129.240.78.2]:62477 "EHLO ping.uio.no")
	by vger.kernel.org with ESMTP id <S318502AbSHLAYJ>;
	Sun, 11 Aug 2002 20:24:09 -0400
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: kernel BUG at filemap.c:843!
From: ilmari@ping.uio.no (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Date: 12 Aug 2002 02:27:56 +0200
Message-ID: <d8jsn1k9b03.fsf@wirth.ping.uio.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

I have been bitten a few times by the BUG() in unlock_page(), both
with 2.4.19-rc3-xfs and 2.4.19-xfs (the latter checked out from SGI's
CVS on Aug 10). The system is SCSI-only, with a raid5 array as an LVM
physical volume and XFS on all the volumes.

Software-wise it's Debian Woody, but the kernel is compiled on a Sid
box with gcc 2.95.4-16.

Attached are the decoded oops, the module list and the config. 

-- 
ilmari


--=-=-=
Content-Disposition: attachment; filename=decoded
Content-Description: Decoded oops

ksymoops 2.4.6 on i686 2.4.19-rc2.  Options used
     -v vmlinux (specified)
     -k ksyms (specified)
     -l lsmod (specified)
     -o /lib/modules/2.4.19-rc2/ (default)
     -m System.map (specified)

kernel BUG at filemap.c:843!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012574e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c11e6fb8   ecx: 00000017   edx: c02712f4
esi: c1420b24   edi: c6ba5a00   ebp: cdcc2be0   esp: cf6c3a64
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 29540, stackpage=cf6c3000)
Stack: ce9217e0 d787f958 c01a38d4 ce9217e0 d787f958 d787f800 ffffffff c11e6fb8 
       c01a3911 ce9217e0 00000001 00000001 d88ae190 ce9217e0 00000001 d787f000 
       d787f800 00000000 ce9217e0 00000000 00000000 ffffffe4 00000000 00000000 
Call Trace:    [<c01a38d4>] [<c01a3911>] [<d88ae190>] [<d88ae487>] [<d889914c>]
  [<c01cc68c>] [<c01a3900>] [<c01a3d03>] [<c0125989>] [<c01a3e81>] [<c01a435d>]
  [<c01a3f77>] [<c01a36d6>] [<c01a30e0>] [<c0198d1c>] [<c0185b18>] [<c0186b27>]
  [<c0184c91>] [<c0143b66>] [<c0184fda>] [<c019a0bc>] [<c019e0e3>] [<c01a8744>]
  [<c013a00b>] [<c013a737>] [<c0139d8d>] [<c013a9d6>] [<c013ad61>] [<c0137e5d>]
  [<c01316c3>] [<c010856f>]
Code: 0f 0b 4b 03 20 54 24 c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03 


>>EIP; c012574e <unlock_page+42/64>   <=====

>>ebx; c11e6fb8 <_end+efce40/1859bee8>
>>edx; c02712f4 <contig_page_data+b4/340>
>>esi; c1420b24 <_end+11369ac/1859bee8>
>>edi; c6ba5a00 <_end+68bb888/1859bee8>
>>ebp; cdcc2be0 <_end+d9d8a68/1859bee8>
>>esp; cf6c3a64 <_end+f3d98ec/1859bee8>

Trace; c01a38d4 <_end_pagebuf_page_io_multi+dc/108>
Trace; c01a3911 <_end_io_multi_full+11/18>
Trace; d88ae190 <[raid5]handle_stripe+ce8/e48>
Trace; d88ae487 <[raid5]raid5_make_request+df/104>
Trace; d889914c <[md]md_make_request+38/64>
Trace; c01cc68c <generic_make_request+128/138>
Trace; c01a3900 <_end_io_multi_full+0/18>
Trace; c01a3d03 <_pagebuf_page_io+3d3/440>
Trace; c0125989 <find_or_create_page+45/d0>
Trace; c01a3e81 <_page_buf_page_apply+111/120>
Trace; c01a435d <_pagebuf_segment_apply+b5/114>
Trace; c01a3f77 <pagebuf_iorequest+e7/138>
Trace; c01a36d6 <pagebuf_iostart+76/90>
Trace; c01a30e0 <pagebuf_get+d4/110>
Trace; c0198d1c <xfs_trans_read_buf+3c/2f4>
Trace; c0185b18 <xfs_itobp+100/1b0>
Trace; c0186b27 <xfs_iread+4b/198>
Trace; c0184c91 <xfs_iget_core+1d1/4a4>
Trace; c0143b66 <iget4_locked+ba/cc>
Trace; c0184fda <xfs_iget+76/138>
Trace; c019a0bc <xfs_dir_lookup_int+174/2f4>
Trace; c019e0e3 <xfs_lookup+87/bc>
Trace; c01a8744 <linvfs_lookup+44/98>
Trace; c013a00b <real_lookup+53/c4>
Trace; c013a737 <link_path_walk+5cf/854>
Trace; c0139d8d <getname+5d/9c>
Trace; c013a9d6 <path_walk+1a/1c>
Trace; c013ad61 <__user_walk+35/50>
Trace; c0137e5d <sys_stat64+19/70>
Trace; c01316c3 <sys_close+43/54>
Trace; c010856f <system_call+33/38>

Code;  c012574e <unlock_page+42/64>
00000000 <_EIP>:
Code;  c012574e <unlock_page+42/64>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0125750 <unlock_page+44/64>
   2:   4b                        dec    %ebx
Code;  c0125751 <unlock_page+45/64>
   3:   03 20                     add    (%eax),%esp
Code;  c0125753 <unlock_page+47/64>
   5:   54                        push   %esp
Code;  c0125754 <unlock_page+48/64>
   6:   24 c0                     and    $0xc0,%al
Code;  c0125756 <unlock_page+4a/64>
   8:   8d 46 04                  lea    0x4(%esi),%eax
Code;  c0125759 <unlock_page+4d/64>
   b:   39 46 04                  cmp    %eax,0x4(%esi)
Code;  c012575c <unlock_page+50/64>
   e:   74 0e                     je     1e <_EIP+0x1e> c012576c <unlock_page+60/64>
Code;  c012575e <unlock_page+52/64>
  10:   31 c9                     xor    %ecx,%ecx
Code;  c0125760 <unlock_page+54/64>
  12:   ba 03 00 00 00            mov    $0x3,%edx

--=-=-=
Content-Disposition: attachment; filename=lsmod
Content-Description: Loaded modules

mga_vid                 8376   0 (autoclean) (unused)
rtc                     5884   0 (autoclean) (unused)
i2c-matroxfb            2996   0 (unused)
i2c-algo-bit            7048   3 [i2c-matroxfb]
matroxfb_base          16804  63 [i2c-matroxfb]
matroxfb_DAC1064        6260   0 [matroxfb_base]
matroxfb_accel          7240   0 [matroxfb_base matroxfb_DAC1064]
fbcon-cfb24             4168   0 [matroxfb_accel]
fbcon-cfb8              3240   0 [matroxfb_accel]
fbcon-cfb32             3592   0 [matroxfb_accel]
fbcon-cfb16             3880   0 [matroxfb_accel]
g450_pll                3360   0 [matroxfb_DAC1064]
matroxfb_misc          14060   0 [i2c-matroxfb matroxfb_base matroxfb_DAC1064 matroxfb_accel g450_pll]
snd-seq-midi            3136   0 (autoclean) (unused)
snd-seq-oss            22368   0 (unused)
snd-seq-midi-event      2696   0 [snd-seq-midi snd-seq-oss]
snd-seq                35824   2 [snd-seq-midi snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            35076   0 (unused)
snd-mixer-oss           8764   0 (unused)
snd-ens1371             9420   0
snd-pcm                46528   0 [snd-pcm-oss snd-ens1371]
snd-timer               9704   0 [snd-seq snd-pcm]
snd-rawmidi            11648   0 [snd-seq-midi snd-ens1371]
snd-seq-device          3648   0 [snd-seq-midi snd-seq-oss snd-seq snd-rawmidi]
snd-ac97-codec         22724   0 [snd-ens1371]
snd                    24012   0 [snd-seq-midi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-ens1371 snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3332   8 [snd]
8139too                13704   1 (autoclean)
mii                     1056   0 (autoclean) [8139too]
ipt_state                568   6 (autoclean)
ip_conntrack_ftp        3104   0 (unused)
ip_conntrack           12828   2 (autoclean) [ipt_state ip_conntrack_ftp]
iptable_filter          1672   1 (autoclean)
ip_tables              10328   2 [ipt_state iptable_filter]
sr_mod                 12848   0 (autoclean) (unused)
cdrom                  28640   0 (autoclean) [sr_mod]
lvm-mod                60672  22
raid5                  16392   1 (autoclean)
xor                     8692   0 (autoclean) [raid5]
md                     56864   2 (autoclean) [raid5]
mousedev                3768   1
eeprom                  3504   0 (unused)
w83781d                19224   0 (unused)
i2c-proc                6128   0 [eeprom w83781d]
i2c-piix4               3888   0 (unused)
i2c-core               12132   0 [i2c-algo-bit eeprom w83781d i2c-proc i2c-piix4]


--=-=-=
Content-Disposition: attachment; filename=config
Content-Description: Kernel configuration

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
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
CONFIG_X86_MCE=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m
CONFIG_FS_POSIX_ACL=y
CONFIG_REISERFS_FS=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_EXT2_FS=m
CONFIG_XFS_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

--=-=-=--
