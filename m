Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSHBO54>; Fri, 2 Aug 2002 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHBO54>; Fri, 2 Aug 2002 10:57:56 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:954 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S315168AbSHBO5w>; Fri, 2 Aug 2002 10:57:52 -0400
Message-ID: <3D4A9EBD.6FA4FB4A@attbi.com>
Date: Fri, 02 Aug 2002 11:01:17 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Martin Dalecki <dalecki@evision-ventures.com>
Subject: 2.5.30 minor crash in shutdown/reboot
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.30 fail reboot with ide-scsi device loaded.
modules and config follow oops.

Albert

ksymoops 2.4.5 on i686 2.5.30.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.30/ (default)
     -m /System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

flushing ATA/ATAPI devices: hda <1>Unable to handle kernel paging request at virtual address 656d616e
c016c396
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c016c396>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: cf4914b8   ecx: ffffffff   edx: 656d616e
esi: cf491414   edi: 656d616e   ebp: d0939bc0   esp: ce6afda4
ds: 0018   es: 0018   ss: 0018
Stack: c1285f7c cf2cae40 cf2cae40 656d616e c1285f7c 00000292 cfe1f1c0 cf4914b8 
       cf491414 c016c66c cf6af740 656d616e cf491424 c01bd807 cf4914b8 656d616e 
       cf491424 d092b3d1 cf491424 d0931220 cf491400 00000000 cfe21800 d0935109 
Call Trace: [<c016c66c>] [<c01bd807>] [<d092b3d1>] [<d0931220>] [<d0935109>] 
   [<d0936e40>] [<c01f4bec>] [<c011ce8d>] [<d0938bda>] [<d0939bc0>] [<c01ecb3f>] 
   [<c01286fd>] [<c0128ae6>] [<c012ebd3>] [<c0117a5e>] [<c014f81d>] [<c0119032>] 
   [<c0125739>] [<c01256c0>] [<c0125879>] [<c010917f>] 
Code: f2 ae f7 d1 49 89 4c 24 10 31 db 89 d7 49 83 f9 ff 74 2a 8d 


>>EIP; c016c396 <get_dentry+16/80>   <=====

>>ebx; cf4914b8 <_end+f138c58/105297a0>
>>ecx; ffffffff <END_OF_CODE+2f642300/????>
>>edx; 656d616e Before first symbol
>>esi; cf491414 <_end+f138bb4/105297a0>
>>edi; 656d616e Before first symbol
>>ebp; d0939bc0 <[ide-scsi]template+0/80>
>>esp; ce6afda4 <_end+e357544/105297a0>

Trace; c016c66c <driverfs_remove_file+3c/90>
Trace; c01bd807 <device_remove_file+37/60>
Trace; d092b3d1 <[cdrom]unregister_cdrom+d1/110>
Trace; d0931220 <[cdrom].text.end+1561/17e1>
Trace; d0935109 <[sr_mod]sr_detach+59/90>
Trace; d0936e40 <[sr_mod]sr_template+0/0>
Trace; c01f4bec <scsi_unregister_host+3bc/4f0>
Trace; c011ce8d <printk+11d/180>
Trace; d0938bda <[ide-scsi]idescsi_cleanup+2a/30>
Trace; d0939bc0 <[ide-scsi]template+0/80>
Trace; c01ecb3f <ata_sys_notify+af/d0>
Trace; c01286fd <notifier_call_chain+2d/50>
Trace; c0128ae6 <sys_reboot+116/2d0>
Trace; c012ebd3 <handle_mm_fault+73/b0>
Trace; c0117a5e <do_page_fault+12e/457>
Trace; c014f81d <open_namei+ad/380>
Trace; c0119032 <schedule+1a2/340>
Trace; c0125739 <schedule_timeout+69/c0>
Trace; c01256c0 <process_timeout+0/10>
Trace; c0125879 <sys_nanosleep+d9/170>
Trace; c010917f <syscall_call+7/b>

Code;  c016c396 <get_dentry+16/80>
00000000 <_EIP>:
Code;  c016c396 <get_dentry+16/80>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c016c398 <get_dentry+18/80>
   2:   f7 d1                     not    %ecx
Code;  c016c39a <get_dentry+1a/80>
   4:   49                        dec    %ecx
Code;  c016c39b <get_dentry+1b/80>
   5:   89 4c 24 10               mov    %ecx,0x10(%esp,1)
Code;  c016c39f <get_dentry+1f/80>
   9:   31 db                     xor    %ebx,%ebx
Code;  c016c3a1 <get_dentry+21/80>
   b:   89 d7                     mov    %edx,%edi
Code;  c016c3a3 <get_dentry+23/80>
   d:   49                        dec    %ecx
Code;  c016c3a4 <get_dentry+24/80>
   e:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  c016c3a7 <get_dentry+27/80>
  11:   74 2a                     je     3d <_EIP+0x3d> c016c3d3 <get_dentry+53/80>
Code;  c016c3a9 <get_dentry+29/80>
  13:   8d 00                     lea    (%eax),%eax


1 warning issued.  Results may not be reliable.
###################

Module                  Size  Used by    Not tainted
it87                    7424   0  (unused)
netconsole              4064   0  (unused)
i2c-isa                 1284   0  (unused)
radeon                 81432   0  (unused)
agpgart                14144   1 
sis                    47680   1 
sisfb                 105396   0  [sis]
fbcon-cfb8              3392   0  [sisfb]
fbcon-cfb32             3936   0  [sisfb]
fbcon-cfb16             4032   0  [sisfb]
fbcon-cfb24             4256   0  [sisfb]
softdog                 1764   1 
ide-scsi                8896   1 
sr_mod                 14168   2 
cdrom                  28672   0  [sr_mod]
sg                     29124   0  (unused)
udf                    92256   0  (unused)
sysv                   22304   0  (unused)
smbfs                  39648   0  (unused)
nfs                    74172   1 
msdos                   6012   0  (unused)
isofs                  19712   1 
tulip                  41984   1 
bsd_comp                4448   0  (unused)
slip                   10080   0  (unused)
lp                      6784   0  (unused)
loop                   43596   6  (autoclean)
vfat                   10652   1  (autoclean)
fat                    33176   0  (autoclean) [msdos vfat]
################

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_REAL_MODE_POWER_OFF=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_ATAPI=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_IVB=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=32
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_BRIDGE=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=m
CONFIG_NET_PCI=y
CONFIG_NETCONSOLE=m
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=m
CONFIG_SOUND_GAMEPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_I2C_MAINBOARD=y
CONFIG_I2C_ISA=m
CONFIG_SENSORS=y
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_OTHER=y
CONFIG_SENSORS_EEPROM=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_SONYPI=m
CONFIG_AGP=m
CONFIG_AGP_SIS=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=m
CONFIG_DRM_SIS=m
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZR36120=m
CONFIG_VIDEO_MEYE=m
CONFIG_AUTOFS4_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_CDFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SMB_FS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_MPU401=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
