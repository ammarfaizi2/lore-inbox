Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVBAL7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVBAL7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVBAL7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:59:05 -0500
Received: from kokytos.rz.informatik.uni-muenchen.de ([141.84.214.13]:24810
	"EHLO kokytos.rz.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261999AbVBAL5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:57:44 -0500
From: Michael Brade <brade@informatik.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: Linux hangs during IDE initialization at boot for 30 sec
Date: Tue, 1 Feb 2005 12:57:33 +0100
User-Agent: KMail/1.7.91
Organization: =?iso-8859-1?q?Universit=E4t?= =?iso-8859-1?q?_M=FCnchen?=, Institut =?iso-8859-1?q?f=FCr?= Informatik
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7747590.LGp65siGX5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502011257.40059.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7747590.LGp65siGX5
Content-Type: multipart/mixed;
  boundary="Boundary-01=_v62/BpFRunKfewl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_v62/BpFRunKfewl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

since at least kernel 2.6.9 I'm having a problem booting linux - it hangs=20
after this

Probing IDE interface ide0...
hda: HITACHI_DK23DA-30, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15

After about 30 seconds everything continues fine with

hda: max request size: 128KiB

I found additional lines in the log just before the line above:

Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...

But I only have ide0 and ide1. This problem persists even with 2.6.11-rc2. =
=46or=20
the last test I removed every option from the kernel that is not needed, bu=
t=20
the problem stays. So I'm sure it's not because of ACPI or PNP or the like.

With 2.6.11-rc2 I get in my syslog:

=46eb  1 11:30:02 newton kernel: ICH3M: chipset revision 2
=46eb  1 11:30:02 newton kernel: ICH3M: not 100%% native mode: will probe i=
rqs=20
later
=46eb  1 11:30:02 newton kernel:     ide0: BM-DMA at 0xcfa0-0xcfa7, BIOS=20
settings: hda:DMA, hdb:pio
=46eb  1 11:30:02 newton kernel:     ide1: BM-DMA at 0xcfa8-0xcfaf, BIOS=20
settings: hdc:DMA, hdd:pio
=46eb  1 11:30:02 newton kernel: Probing IDE interface ide0...
=46eb  1 11:30:02 newton kernel: hda: HITACHI_DK23DA-30, ATA DISK drive
=46eb  1 11:30:02 newton kernel: DEV: registering device: ID =3D 'ide0'
=46eb  1 11:30:02 newton kernel: PM: Adding info for No Bus:ide0
=46eb  1 11:30:02 newton kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
=46eb  1 11:30:02 newton kernel: DEV: registering device: ID =3D '0.0'
=46eb  1 11:30:02 newton kernel: PM: Adding info for ide:0.0
=46eb  1 11:30:02 newton kernel: bus ide: add device 0.0
=46eb  1 11:30:02 newton kernel: Probing IDE interface ide1...
=46eb  1 11:30:02 newton kernel: hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DV=
D-ROM=20
drive
=46eb  1 11:30:02 newton kernel: DEV: registering device: ID =3D 'ide1'
=46eb  1 11:30:02 newton kernel: PM: Adding info for No Bus:ide1
=46eb  1 11:30:02 newton kernel: ide1 at 0x170-0x177,0x376 on irq 15
=46eb  1 11:30:02 newton kernel: DEV: registering device: ID =3D '1.0'
=46eb  1 11:30:02 newton kernel: PM: Adding info for ide:1.0
=46eb  1 11:30:02 newton kernel: bus ide: add device 1.0
=46eb  1 11:30:02 newton kernel: bus pci: add driver PIIX_IDE
=46eb  1 11:30:02 newton kernel: bound device '0000:00:1f.1' to driver=20
'PIIX_IDE'
=46eb  1 11:30:02 newton kernel: bus pci: add driver PCI_IDE
=46eb  1 11:30:02 newton kernel: Probing IDE interface ide2...
=46eb  1 11:30:02 newton kernel: Probing IDE interface ide3...
=46eb  1 11:30:02 newton kernel: Probing IDE interface ide4...
=46eb  1 11:30:02 newton kernel: ide4: Wait for ready failed before probe !
=2D--> I guess the line above is the reason for the wait <---
=46eb  1 11:30:02 newton kernel: Probing IDE interface ide5...
=46eb  1 11:30:02 newton kernel: hda: max request size: 128KiB

Userspace is debian sid, my computer is a Toshiba Laptop (Satellite 2410-40=
4),=20
you can find some information including an lspci on=20
http://www.thorstenhaas.de/toshiba2410/. Attached's my kernel config.

Please CC me, I'm not subscribed, thanks.

Cheers,
=2D-=20
Michael Brade;                 KDE Developer, Student of Computer Science
  |-mail: echo brade !#|tr -d "c oh"|s\e\d 's/e/\@/2;s/$/.org/;s/bra/k/2'
  =B0--web: http://www.kde.org/people/michaelb.html

KDE 3: The Next Generation in Desktop Experience

--Boundary-01=_v62/BpFRunKfewl
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_TOSHIBA=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_QLA2XXX=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_TCPDIAG=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_EVDEV=m
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_DRM=y
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PIIX4=m
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_AUDIO=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_EXT2_FS=m
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=m
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_EARLY_PRINTK=y
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-01=_v62/BpFRunKfewl--

--nextPart7747590.LGp65siGX5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB/26zdK2tAWD5bo0RAqt/AKCyJegQe4M27IGdhVCS6UWUDftm6gCeLaRo
iDWeOi7mYp1RVr4ZvSBfHDQ=
=3N4s
-----END PGP SIGNATURE-----

--nextPart7747590.LGp65siGX5--
