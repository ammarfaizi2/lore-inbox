Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbTDIUNM (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTDIUNM (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:13:12 -0400
Received: from smtp03.web.de ([217.72.192.158]:11527 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263770AbTDIUNE (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:13:04 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Subject: Re: Process falls into uninterruptible sleep
Date: Wed, 9 Apr 2003 22:23:03 +0200
User-Agent: KMail/1.5
References: <A46BBDB345A7D5118EC90002A5072C780BEBA43A@orsmsx116.jf.intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBA43A@orsmsx116.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304092223.03170.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 April 2003 21:39, Perez-Gonzalez, Inaky wrote:
> uniterruptible processes cannot be killed :)
I know. :)
But it shouldn't fall into this sleep.

> Can you give more information? Like what machine do you have,
Intel Pentium 4 1.6Ghz Northwood
256MB Apacer DDR Ram CL2
MSI 845 Ultra ARU Board with latest BIOS
GeForce 4 Ti 4400
BT878-TV
SoundBlaster 128
FritzCard PCI v2
NE2k compatible NW

mb@lfs:/proc> cat devices 
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  6 lp
  7 vcs
 10 misc
 14 sound
 21 sg
 43 ttyI
 44 cui
 45 isdn
 68 capi20
 81 video_capture
 89 i2c
 99 ppdev
108 ppp
128 ptm
136 pts
162 raw

Block devices:
  2 fd
  3 ide0
  7 loop
  9 md
 11 sr
 22 ide1
 80 i2o_block

mb@lfs:/proc> cat cmdline 
root=/dev/md0 hdd=ide-scsi hdb=ide-scsi es1371=0x200 js=2btn mce vga=779 mem=262080K

mb@lfs:/proc> cat filesystems 
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   pipefs
        ext3
        ext2
nodev   ramfs
        msdos
        vfat
        iso9660
nodev   nfs
        reiserfs
nodev   devpts

mb@lfs:/proc> cat /etc/fstab 
/dev/md0        /                       reiserfs        auto                0 1
/dev/hdc1       /boot                   ext2            auto                0 0
/dev/cdrecorder /mnt/cdrecorder         auto            ro,noauto,user,exec,nodev,nosuid 0 0
/dev/cdrom      /mnt/dvd                auto            ro,noauto,user,exec,nodev,nosuid 0 0
/dev/dvd        /mnt/dvd                auto            ro,noauto,user,exec,nodev,nosuid 0 0
/dev/fd0        /mnt/floppy             auto            noauto,user,sync,nodev,nosuid    0 0
proc            /proc                   proc            defaults            0 0
/dev/hda1       /mnt/win                vfat            noauto,user         0 0
/dev/hdc6       /mnt/suse               reiserfs        noauto,user         0 0
#/dev/hdc5      /mnt/suse/boot          ext2            noauto,user         0 0
/dev/hda2       swap                    swap            pri=42              0 0
/dev/hdc2       swap                    swap            pri=42              0 0
#usbdevfs       /proc/bus/usb           usbdevfs        defaults,noauto     0 0
192.168.0.50:/mnt/nfs_1 /mnt/nfs_1      nfs             rw,hard,intr,user,nodev,nosuid,exec         0 0

mb@lfs:/proc> cat cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping        : 4
cpu MHz         : 2240.055
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4469.55


> what hard disks type,
two IBM IC35L040 (I know, these disks are not the best :)
with software RAID 0 on reiserfs

mb@lfs:/proc> cat mdstat 
Personalities : [raid0] 
read_ahead 1024 sectors
md0 : active raid0 hdc5[1] hda5[0]
      39065792 blocks 4k chunks
      
unused devices: <none>


mb@lfs:/proc> cat partitions 
major minor  #blocks  name

   9     0   39065792 md0
  22     0   40209120 hdc
  22     1       9544 hdc1
  22     2     292824 hdc2
  22     3          1 hdc3
  22     5   19530976 hdc5
  22     6    9765472 hdc6
  22     7   10610176 hdc7
   3     0   40209120 hda
   3     1    3903763 hda1
   3     2     289170 hda2
   3     3          1 hda3
   3     5   19535008 hda5
   3     6   16474626 hda6


>what was kmail doing when it got stuck.
I only clicked "save as..." to save a message to disk. Just after clicking
(the save-dialog didn't open) it freezed.
There were some other apps in the past, that freezed and felt into
uninterruptible sleep. There never seemed to be a reason for it.

> Memory, swap space, 
(This is mem-status *now* after rebooting to kill kmail)
mb@lfs:~> cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  261718016 157396992 104321024        0  9895936 56741888
Swap: 595943424 41193472 554749952
MemTotal:       255584 kB
MemFree:        101876 kB
MemShared:           0 kB
Buffers:          9664 kB
Cached:          49892 kB
SwapCached:       5520 kB
Active:          26460 kB
Inactive:       103076 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255584 kB
LowFree:        101876 kB
SwapTotal:      581976 kB
SwapFree:       541748 kB

mb@lfs:/proc> cat swaps 
Filename                        Type            Size    Used    Priority
/dev/hda2                       partition       289160  20120   42
/dev/hdc2                       partition       292816  20108   42


> attached devices, 
There's no external device connected. (no printer, scanner, etc...)

> distro, 
LinuxFromScratch

> configuration of the kernel ... etc?
grep "=[y|m]" .config
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
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
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET_IPGRE=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_I2O=y
CONFIG_I2O_PCI=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_LAN=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_EQUALIZER=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=y
CONFIG_PPP=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_PPPOATM=y
CONFIG_SLIP=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_ISDN=y
CONFIG_ISDN_BOOL=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_PPP_BSDCOMP=y
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
CONFIG_ISDN_DIVERSION=y
CONFIG_ISDN_DRV_HISAX=y
CONFIG_ISDN_HISAX=y
CONFIG_HISAX_EURO=y
CONFIG_HISAX_FRITZ_PCIPNP=y
CONFIG_ISDN_CAPI=y
CONFIG_ISDN_CAPI_CAPI20=y
CONFIG_ISDN_CAPI_CAPIDRV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_PPDEV=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_INTEL_RNG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_BT878=y
CONFIG_SOUND_ES1371=y
CONFIG_SOUND_TVMIXER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

mb@lfs:/proc> cat version 
Linux version 2.4.21-pre6 (root@lfs) (gcc version 3.2.2) #3 Sam Apr 5 20:23:37 CEST 2003

> It looks like the process is getting really stuck while reading/writing
> from/to disk. You want to check the kernel messages, to see if there
> is something there.
Nothing unusual in syslog.


Thank you for your help.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

