Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTFPIWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTFPIWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:22:44 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:40847 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263558AbTFPIWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:22:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [Roland Mas] Still [OOPS] ide-scsi panic, now in 2.4.21 too
Mail-Copies-To: never
From: Roland Mas <roland.mas@free.fr>
References: <87smqt4mbx.fsf@free.fr>
In-Reply-To: <87smqt4mbx.fsf@free.fr> (Roland Mas's message of "Sun, 01 Jun
 2003 21:41:38 +0200")
Date: Mon, 16 Jun 2003 10:36:22 +0200
Message-ID: <877k7m7721.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

It seems a comma broke my Cc: line.  Reposting to the list.


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

X-From-Line: nobody Sun Jun 15 17:45:21 2003
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, Andre Hedrick
 <andre@linux-ide.org>,  Alan Cox <alan@lxorguk.ukuu.org.uk>,
Cc: 
Subject: Still [OOPS] ide-scsi panic, now in 2.4.21 too
Mail-Copies-To: never
X-Draft-From: ("nnimap+Imap:INBOX.lkml" 1947)
References: <87smqt4mbx.fsf@free.fr>
From: Roland Mas <roland.mas@free.fr>
Date: Sun, 15 Jun 2003 17:45:19 +0200
In-Reply-To: <87smqt4mbx.fsf@free.fr> (Roland Mas's message of "Sun, 01 Jun
 2003 21:41:38 +0200")
Message-ID: <87smqbe44w.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
Lines: 495
Xref: mirexpress sent.e-mail:639
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

Roland Mas, 2003-06-01 21:41:38 +0200 :

Time passes, 2.4.21-rc* kernels go by, and 2.4.21 final comes out.  I
finally find some time to investigate again.

  New info I have on that bug:

- 2.4.21 final seems to make that bug less frequent.  I mean, it's
  still crashing for blank=all, but blank=fast only crashes like half
  of the times, for no good reason and in no particular set of
  circumstances that I've been able to find.  I've tried different
  loads, different IDE activity levels (RAID reconstructing vs. idle,
  for instance) and haven't found a pattern.

- I've straced the CD player applet to see what it does on the drive.
  Here's a sample:
,----
| $ strace -p $(pidof cdplayer_applet2)
| Process 3059 attached - interrupt to quit
| gettimeofday({1055688214, 857779}, NULL) = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688214, 858003}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 228) = 0
| gettimeofday({1055688215, 96139}, NULL) = 0
| open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 24
| ioctl(24, 0x5326, 0x7fffffff)           = 2
| close(24)                               = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688215, 126494}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 469) = 0
| gettimeofday({1055688215, 606028}, NULL) = 0
| open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 24
| ioctl(24, 0x5326, 0x7fffffff)           = 2
| close(24)                               = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688215, 636451}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 470) = 0
| gettimeofday({1055688216, 115926}, NULL) = 0
| open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 24
| ioctl(24, 0x5326, 0x7fffffff)           = 2
| close(24)                               = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688216, 146245}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 469) = 0
| gettimeofday({1055688216, 625854}, NULL) = 0
| open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 24
| ioctl(24, 0x5326, 0x7fffffff)           = 2
| close(24)                               = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688216, 656261}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN, revents=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 470) = 1ioctl(3, FIONREAD, [32])                = 0
| read(3, "n\2\n_\257\36F\0\1\4\4\0\0\0\0\0\0\0\0\4\4\4\4\4\0\0\3"..., 32) = 32
| gettimeofday({1055688216, 774827}, NULL) = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688216, 775023}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 351) = 0
| gettimeofday({1055688217, 135796}, NULL) = 0
| open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 24
| ioctl(24, 0x5326, 0x7fffffff)           = 2
| close(24)                               = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688217, 166217}, NULL) = 0
| poll([{fd=10, events=POLLIN}, {fd=3, events=POLLIN}, {fd=15, events=POLLIN}, {fd=17, events=POLLIN|POLLPRI}, {fd=18, events=POLLIN|POLLPRI}, {fd=19, events=POLLIN|POLLPRI}, {fd=21, events=POLLIN|POLLPRI}, {fd=20, events=POLLIN|POLLPRI}, {fd=22, events=POLLIN|POLLPRI}, {fd=23, events=POLLIN|POLLPRI}], 10, 469) = 0
| gettimeofday({1055688217, 645686}, NULL) = 0
| open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 24
| ioctl(24, 0x5326, 0x7fffffff)           = 2
| close(24)                               = 0
| ioctl(3, FIONREAD, [0])                 = 0
| gettimeofday({1055688217, 676087}, NULL) = 0
| poll( <unfinished ...>
| Process 3059 detached
`----
  In other words, the applet frequently (more than once per second)
  does the ioctl call for CDROM_DRIVE_STATUS, and gets a CDS_TRAY_OPEN
  answer when the drive is open and/or empty (sounds strange that the
  answer is not CDS_NO_DISC, but that's probably another problem) and
  and CDS_DISC_OK when there is a disc in the drive.  I assume the
  applet still tries this kind of operation when cdrecord is running,
  and that causes the crash.

  Both these new pieces of information give me a gut feeling that
there is a race condition somewhere, but I'm probably awfully wrong
and I've never dived inside the kernel code.  Don't hesitate to laugh
at me, I was just looking to make a fool of myself on LKML anyway.

>   I have a reproduceable kernel panic here.  It happens when I try to
> burn (or even simply blank) a CD-RW while a CD player applet is
> running.
>
>   The setup:
>
> - Kernel is 2.4.21-rc2 or rc3 or rc6 or rc6-ac1 (haven't tried earlier
>   or intermediate kernels); rc2 and rc3 were compiled with gcc-3.3, I
>   compiled rc6 and rc6-ac1 with 2.95.4 and the bug still exists;
>
> - Motherboard is MSI KT3 Ultra2, with a VIA KT333 Chipset; one single
>   processor (an Athlon 2200+), one gigabyte of RAM;
>
> - Boot options: "auto BOOT_IMAGE=Linux ro root=900 hdb=scsi";
>
> - IDE setup:
> ,----
> | hda: Maxtor 6Y080L0, ATA DISK drive
> | hdb: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
> | hdc: Maxtor 6Y080L0, ATA DISK drive
> `----
>
> - RAID setup (not sure it's relevant):
> ,----[ /etc/raidtab excerpt ]
> | raiddev /dev/md0
> |         raid-level 1
> |         nr-raid-disks 2
> |         persistent-superblock 1
> |         chunk-size 8
> |         device /dev/hda1
> |         raid-disk 0
> |         device /dev/hdc1
> |         raid-disk 1
> |
> | [...]
> `----
>   I have md0 to md7, all being on identical partitions on hda and
>   hdc.
>
> - Kernel configuration:
> ,----[ Kernel configuration ]
> | CONFIG_X86=y
> | CONFIG_UID16=y
> | CONFIG_EXPERIMENTAL=y
> | CONFIG_MODULES=y
> | CONFIG_MODVERSIONS=y
> | CONFIG_KMOD=y
> | CONFIG_MK7=y
> | CONFIG_X86_WP_WORKS_OK=y
> | CONFIG_X86_INVLPG=y
> | CONFIG_X86_CMPXCHG=y
> | CONFIG_X86_XADD=y
> | CONFIG_X86_BSWAP=y
> | CONFIG_X86_POPAD_OK=y
> | CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> | CONFIG_X86_L1_CACHE_SHIFT=6
> | CONFIG_X86_HAS_TSC=y
> | CONFIG_X86_GOOD_APIC=y
> | CONFIG_X86_USE_3DNOW=y
> | CONFIG_X86_PGE=y
> | CONFIG_X86_USE_PPRO_CHECKSUM=y
> | CONFIG_X86_F00F_WORKS_OK=y
> | CONFIG_X86_MCE=y
> | CONFIG_HIGHMEM4G=y
> | CONFIG_HIGHMEM=y
> | CONFIG_X86_TSC=y
> | CONFIG_NET=y
> | CONFIG_PCI=y
> | CONFIG_PCI_GOANY=y
> | CONFIG_PCI_BIOS=y
> | CONFIG_PCI_DIRECT=y
> | CONFIG_ISA=y
> | CONFIG_PCI_NAMES=y
> | CONFIG_HOTPLUG=y
> | CONFIG_SYSVIPC=y
> | CONFIG_SYSCTL=y
> | CONFIG_KCORE_ELF=y
> | CONFIG_BINFMT_AOUT=m
> | CONFIG_BINFMT_ELF=y
> | CONFIG_BINFMT_MISC=m
> | CONFIG_PM=y
> | CONFIG_ACPI=y
> | CONFIG_ACPI_BUSMGR=y
> | CONFIG_ACPI_SYS=y
> | CONFIG_ACPI_CPU=y
> | CONFIG_ACPI_BUTTON=y
> | CONFIG_PARPORT=m
> | CONFIG_PARPORT_PC=m
> | CONFIG_PARPORT_PC_CML1=m
> | CONFIG_PARPORT_PC_FIFO=y
> | CONFIG_PNP=y
> | CONFIG_ISAPNP=y
> | CONFIG_BLK_DEV_FD=m
> | CONFIG_BLK_DEV_LOOP=m
> | CONFIG_BLK_DEV_RAM=m
> | CONFIG_BLK_DEV_RAM_SIZE=4096
> | CONFIG_MD=y
> | CONFIG_BLK_DEV_MD=y
> | CONFIG_MD_LINEAR=m
> | CONFIG_MD_RAID0=m
> | CONFIG_MD_RAID1=y
> | CONFIG_MD_RAID5=m
> | CONFIG_BLK_DEV_LVM=m
> | CONFIG_PACKET=m
> | CONFIG_NETFILTER=y
> | CONFIG_FILTER=y
> | CONFIG_UNIX=m
> | CONFIG_INET=y
> | CONFIG_INET_ECN=y
> | CONFIG_IP_NF_CONNTRACK=m
> | CONFIG_IP_NF_FTP=m
> | CONFIG_IP_NF_IRC=m
> | CONFIG_IP_NF_QUEUE=m
> | CONFIG_IP_NF_IPTABLES=m
> | CONFIG_IP_NF_MATCH_LIMIT=m
> | CONFIG_IP_NF_MATCH_MAC=m
> | CONFIG_IP_NF_MATCH_MARK=m
> | CONFIG_IP_NF_MATCH_MULTIPORT=m
> | CONFIG_IP_NF_MATCH_TOS=m
> | CONFIG_IP_NF_MATCH_LENGTH=m
> | CONFIG_IP_NF_MATCH_TTL=m
> | CONFIG_IP_NF_MATCH_TCPMSS=m
> | CONFIG_IP_NF_MATCH_STATE=m
> | CONFIG_IP_NF_MATCH_UNCLEAN=m
> | CONFIG_IP_NF_MATCH_OWNER=m
> | CONFIG_IP_NF_FILTER=m
> | CONFIG_IP_NF_TARGET_REJECT=m
> | CONFIG_IP_NF_TARGET_MIRROR=m
> | CONFIG_IP_NF_NAT=m
> | CONFIG_IP_NF_NAT_NEEDED=y
> | CONFIG_IP_NF_TARGET_MASQUERADE=m
> | CONFIG_IP_NF_TARGET_REDIRECT=m
> | CONFIG_IP_NF_NAT_IRC=m
> | CONFIG_IP_NF_NAT_FTP=m
> | CONFIG_IP_NF_MANGLE=m
> | CONFIG_IP_NF_TARGET_TOS=m
> | CONFIG_IP_NF_TARGET_MARK=m
> | CONFIG_IP_NF_TARGET_LOG=m
> | CONFIG_IP_NF_TARGET_TCPMSS=m
> | CONFIG_IPV6=m
> | CONFIG_IP6_NF_IPTABLES=m
> | CONFIG_IP6_NF_MATCH_LIMIT=m
> | CONFIG_IP6_NF_FILTER=m
> | CONFIG_IP6_NF_TARGET_LOG=m
> | CONFIG_IP6_NF_MANGLE=m
> | CONFIG_IP6_NF_TARGET_MARK=m
> | CONFIG_ATM=y
> | CONFIG_IDE=y
> | CONFIG_BLK_DEV_IDE=y
> | CONFIG_BLK_DEV_IDEDISK=y
> | CONFIG_BLK_DEV_IDECD=m
> | CONFIG_BLK_DEV_IDESCSI=m
> | CONFIG_BLK_DEV_IDEPCI=y
> | CONFIG_BLK_DEV_IDEDMA_PCI=y
> | CONFIG_IDEDMA_PCI_AUTO=y
> | CONFIG_BLK_DEV_IDEDMA=y
> | CONFIG_BLK_DEV_VIA82CXXX=y
> | CONFIG_IDEDMA_AUTO=y
> | CONFIG_BLK_DEV_IDE_MODES=y
> | CONFIG_SCSI=m
> | CONFIG_BLK_DEV_SD=m
> | CONFIG_SD_EXTRA_DEVS=40
> | CONFIG_BLK_DEV_SR=m
> | CONFIG_SR_EXTRA_DEVS=2
> | CONFIG_CHR_DEV_SG=m
> | CONFIG_SCSI_PPA=m
> | CONFIG_NETDEVICES=y
> | CONFIG_DUMMY=m
> | CONFIG_NET_ETHERNET=y
> | CONFIG_NET_PCI=y
> | CONFIG_8139TOO=m
> | CONFIG_PPP=m
> | CONFIG_PPP_FILTER=y
> | CONFIG_PPP_ASYNC=m
> | CONFIG_PPP_SYNC_TTY=m
> | CONFIG_PPP_DEFLATE=m
> | CONFIG_PPP_BSDCOMP=m
> | CONFIG_PPPOE=m
> | CONFIG_PPPOATM=m
> | CONFIG_SLIP=m
> | CONFIG_SLIP_COMPRESSED=y
> | CONFIG_INPUT=m
> | CONFIG_INPUT_KEYBDEV=m
> | CONFIG_INPUT_MOUSEDEV=m
> | CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> | CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> | CONFIG_INPUT_JOYDEV=m
> | CONFIG_VT=y
> | CONFIG_VT_CONSOLE=y
> | CONFIG_SERIAL=m
> | CONFIG_UNIX98_PTYS=y
> | CONFIG_UNIX98_PTY_COUNT=256
> | CONFIG_PRINTER=m
> | CONFIG_MOUSE=m
> | CONFIG_PSMOUSE=y
> | CONFIG_RTC=m
> | CONFIG_AGP=m
> | CONFIG_AGP_VIA=y
> | CONFIG_DRM=y
> | CONFIG_DRM_NEW=y
> | CONFIG_AUTOFS4_FS=m
> | CONFIG_EXT3_FS=y
> | CONFIG_JBD=y
> | CONFIG_FAT_FS=m
> | CONFIG_MSDOS_FS=m
> | CONFIG_UMSDOS_FS=m
> | CONFIG_VFAT_FS=m
> | CONFIG_TMPFS=y
> | CONFIG_RAMFS=y
> | CONFIG_ISO9660_FS=m
> | CONFIG_JOLIET=y
> | CONFIG_MINIX_FS=m
> | CONFIG_PROC_FS=y
> | CONFIG_DEVFS_FS=y
> | CONFIG_DEVFS_MOUNT=y
> | CONFIG_DEVPTS_FS=y
> | CONFIG_EXT2_FS=m
> | CONFIG_UDF_FS=m
> | CONFIG_NFS_FS=m
> | CONFIG_NFS_V3=y
> | CONFIG_NFSD=m
> | CONFIG_NFSD_V3=y
> | CONFIG_SUNRPC=m
> | CONFIG_LOCKD=m
> | CONFIG_LOCKD_V4=y
> | CONFIG_SMB_FS=m
> | CONFIG_MSDOS_PARTITION=y
> | CONFIG_SMB_NLS=y
> | CONFIG_NLS=y
> | CONFIG_NLS_DEFAULT="iso8859-1"
> | CONFIG_VGA_CONSOLE=y
> | CONFIG_VIDEO_SELECT=y
> | CONFIG_FB=y
> | CONFIG_DUMMY_CONSOLE=y
> | CONFIG_FB_VESA=y
> | CONFIG_VIDEO_SELECT=y
> | CONFIG_FB_RADEON=m
> | CONFIG_FBCON_ADVANCED=y
> | CONFIG_FBCON_CFB8=y
> | CONFIG_FBCON_CFB16=y
> | CONFIG_FBCON_CFB24=y
> | CONFIG_FBCON_CFB32=y
> | CONFIG_FONT_8x8=y
> | CONFIG_FONT_8x16=y
> | CONFIG_SOUND=m
> | CONFIG_SOUND_VIA82CXXX=m
> | CONFIG_SOUND_OSS=m
> | CONFIG_SOUND_TRACEINIT=y
> | CONFIG_SOUND_SB=m
> | CONFIG_USB=m
> | CONFIG_USB_DEVICEFS=y
> | CONFIG_USB_UHCI=m
> | CONFIG_USB_STORAGE=m
> | CONFIG_USB_ACM=m
> | CONFIG_USB_HID=m
> | CONFIG_USB_HIDINPUT=y
> | CONFIG_USB_HIDDEV=y
> | CONFIG_USB_KBD=m
> | CONFIG_USB_MOUSE=m
> | CONFIG_DEBUG_KERNEL=y
> | CONFIG_DEBUG_STACKOVERFLOW=y
> | CONFIG_DEBUG_HIGHMEM=y
> | CONFIG_DEBUG_SLAB=y
> | CONFIG_DEBUG_IOVIRT=y
> | CONFIG_MAGIC_SYSRQ=y
> | CONFIG_ZLIB_INFLATE=m
> | CONFIG_ZLIB_DEFLATE=m
> `----
>
> - Panic message follows.  I lack the hardware for a serial console
>   setup (I assume it's just what used to be called a null-modem
>   cable?), so this panic message is the one I hand-copied in
>   2.4.21-rc3 and not in rc6.
> ,----[ ksymoopsed panic message ]
> | ksymoops 2.4.8 on i686 2.4.21-rc3.  Options used
> |      -V (specified)
> |      -k /proc/ksyms (default)
> |      -l /proc/modules (default)
> |      -o /lib/modules/2.4.21-rc3/ (default)
> |      -m /boot/System.map-2.4.21-rc3 (default)
> | 
> | kernel BUG at ide-iops: 1262!
> | invalid operand: 0000
> | CPU:    0
> | EIP:    0010: [<c01af154>] not tainted
> | Using defaults from ksymoops -t elf32-i386 -a i386
> | EFLAGS: 00210086
> | eax: f8931630 ebx: 00000000 ecx: 00000032 edx: f6968a54
> | esi: f6148e00 edi: c02cac0c ebp: c02caa20 esp: c028de90
> | ds: 0018 es: 0018 ss: 0018
> | Process swapper (pid: 0, stackpage=c028d000)
> | Stack: 00200046 0000002e 00200082 f6147e00 f7eeb7bc 00200086 00000000 f6148e00
> |        00000000 00000002 c01af347 c02cac0c 00000000 f8932869 c02cac0c f8929a13
> |        f6148e00 00000002 00000000 f6968a54 f6148e00 00200282 fffffffe 00200046
> | Call Trace:   [<c01af347>] [<f8932869>] [<f8928a13>] [<f8927eb8>] [<f8927e40>]
> |  [<c011d050>] [<c0119482>] [<c0119396>] [<c01191d1>] [<c0108a0b>] [<c010ae98>]
> |  [<c0191404>] [<c01912e0>] [<c01912e0>] [<c0105472>] [<c0105000>]
> | Code: 0f 0b ee 04 7c b4 23 c0 80 bf f9 00 00 00 20 74 0c 8b 74 24
> | 
> | 
> | >>EIP; c01af154 <do_reset1+24/200>   <=====
> | 
> | >>eax; f8931630 <[ide-scsi]idescsi_pc_intr+0/320>
> | >>edx; f6968a54 <_end+36691344/38531970>
> | >>esi; f6148e00 <_end+35e716f0/38531970>
> | >>edi; c02cac0c <ide_hwifs+1ec/2b48>
> | >>ebp; c02caa20 <ide_hwifs+0/2b48>
> | >>esp; c028de90 <init_task_union+1e90/2000>
> | 
> | Trace; c01af347 <ide_do_reset+17/20>
> | Trace; f8932869 <[ide-scsi]idescsi_reset+19/30>
> | Trace; f8928a13 <[scsi_mod]scsi_reset+f3/350>
> | Trace; f8927eb8 <[scsi_mod]scsi_old_times_out+78/150>
> | Trace; f8927e40 <[scsi_mod]scsi_old_times_out+0/150>
> | Trace; c011d050 <run_timer_list+f0/160>
> | Trace; c0119482 <bh_action+22/40>
> | Trace; c0119396 <tasklet_hi_action+46/70>
> | Trace; c01191d1 <do_softirq+91/a0>
> | Trace; c0108a0b <do_IRQ+ab/e0>
> | Trace; c010ae98 <call_do_IRQ+5/d>
> | Trace; c0191404 <pr_power_idle+124/2d0>
> | Trace; c01912e0 <pr_power_idle+0/2d0>
> | Trace; c01912e0 <pr_power_idle+0/2d0>
> | Trace; c0105472 <cpu_idle+42/60>
> | Trace; c0105000 <_stext+0/0>
> | 
> | Code;  c01af154 <do_reset1+24/200>
> | 00000000 <_EIP>:
> | Code;  c01af154 <do_reset1+24/200>   <=====
> |    0:   0f 0b                     ud2a      <=====
> | Code;  c01af156 <do_reset1+26/200>
> |    2:   ee                        out    %al,(%dx)
> | Code;  c01af157 <do_reset1+27/200>
> |    3:   04 7c                     add    $0x7c,%al
> | Code;  c01af159 <do_reset1+29/200>
> |    5:   b4 23                     mov    $0x23,%ah
> | Code;  c01af15b <do_reset1+2b/200>
> |    7:   c0 80 bf f9 00 00 00      rolb   $0x0,0xf9bf(%eax)
> | Code;  c01af162 <do_reset1+32/200>
> |    e:   20 74 0c 8b               and    %dh,0xffffff8b(%esp,%ecx,1)
> | Code;  c01af166 <do_reset1+36/200>
> |   12:   74 24                     je     38 <_EIP+0x38>
> | 
> | <O> Kernel panic: Aiee, killing interrupt handler!
> `----
>
> - Other software: up-to-date Debian unstable;
>
> - Trigger command: "cdrecord dev=0,0,0 blank=fast", or
>   "cdrecord dev=0,0,0 sarge-i386-netinst.iso" (the latter being an 86
>   MB ISO9660 file); note the bug occurs only when the Gnome CD playing
>   applet is running.  Remove it from the panel, the blanking goes
>   fine.  Restart it, blank a CD, panic.  While I can agree it doesn't
>   make much sense to try and access an audio CD while burning a CD-RW
>   on the same drive, that shouldn't give a kernel panic.
>
> Roland.
>
> PS: And on a "related" note, my numerous panics while I was
> reproducing this bug allowed me to witness a few RAID synchronisation
> cycles.  2.4.21-rc6 does that at about 35 MB/s, 2.4.21-rc6-ac1 seems
> to be stuck at about 10.5 MB/s.  No change in setup, only the kernel
> is different.  But maybe there's something I should have done.

  On that particular point, I'm glad to see that 2.4.21 final has gone
back to 35 MB/s, without me doing anything to change that.  Stuff
happens.

Roland.
-- 
Roland Mas

Qu'est-ce qui est jaune, qui pèse deux cents kilos et qui chante ?
Un sumotori qui a bu trop de saké.

--=-=-=



-- 
Roland Mas

Time passed, which, basically, is its job.
  -- in Equal Rites (Terry Pratchett)

--=-=-=--
