Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTDURZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTDURZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:25:15 -0400
Received: from dsl254-126-114.nyc1.dsl.speakeasy.net ([216.254.126.114]:53951
	"EHLO Chumak.ny.ranok.com") by vger.kernel.org with ESMTP
	id S261764AbTDURZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:25:06 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.5.68] no console messages after switch to FB (matrox)
MIME-Version: 1.0 (mime-construct 1.8)
Content-Transfer-Encoding: quoted-printable
Message-Id: <E197fGV-0000Ed-00@Maya.ny.ranok.com>
From: Vagn Scott <vagn@ranok.com>
Date: Mon, 21 Apr 2003 13:39:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

config is below
Sun Apr 20 18:20:24 EDT 2003
2.5.68
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-2.5.68.gz
(please CC: me, as I'm not on the list)
--------------------------------

1. While booting things look normal
until the lovely little Tux logo appears,
then no more console messages are written to the screen.
The box still boots, however.

Turned off logo, same thing: as soon as it switches
to the FB no more boot messages appear.

2. Turned off Frame Buffer Console support and got errors.
It looks like there is a dependency that gconfig does not know about.
The errors were:

   ld -m elf_i386  -r -o drivers/video/console/built-in.o drivers/video/con=
sole/dummycon.o drivers/video/console/vgacon.o drivers/video/console/mdacon=
.o
   make -f scripts/Makefile.build obj=3Ddrivers/video/matrox
     gcc -Wp,-MD,drivers/video/.fbmem.o.d -D__KERNEL__ -Iinclude -Wall -Wst=
rict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -=
mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-defau=
lt -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Dfbmem -DKBUILD_MOD=
NAME=3Dfbmem -c -o drivers/video/.tmp_fbmem.o drivers/video/fbmem.c
     drivers/video/fbmem.c: In function `fb_pan_display':
     drivers/video/fbmem.c:901: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:904: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:904: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:905: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:905: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:920: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:921: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:923: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:925: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c: In function `fb_set_var':
     drivers/video/fbmem.c:944: invalid use of undefined type `struct displ=
ay'
     drivers/video/fbmem.c:945: `vc_cons' undeclared (first use in this fun=
ction)
     drivers/video/fbmem.c:945: (Each undeclared identifier is reported onl=
y once
     drivers/video/fbmem.c:945: for each function it appears in.)
     drivers/video/fbmem.c:957: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:958: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:959: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:960: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:961: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:962: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:963: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:964: dereferencing pointer to incomplete type
     drivers/video/fbmem.c:968: dereferencing pointer to incomplete type
     drivers/video/fbmem.c: In function `fbcon_vt_ioctl':
     drivers/video/fbmem.c:1025: `con2fb_map' undeclared (first use in this=
 function)
     drivers/video/fbmem.c:1037: invalid use of undefined type `struct disp=
lay'
     drivers/video/fbmem.c:1045: warning: implicit declaration of function =
`PROC_CONSOLE'
     drivers/video/fbmem.c: In function `fb_ioctl':
     drivers/video/fbmem.c:1104: warning: implicit declaration of function =
`set_all_vcs'
     drivers/video/fbmem.c: In function `register_framebuffer':
     drivers/video/fbmem.c:1375: `con2fb_map' undeclared (first use in this=
 function)
     drivers/video/fbmem.c: In function `unregister_framebuffer':
     drivers/video/fbmem.c:1412: `con2fb_map' undeclared (first use in this=
 function)
     drivers/video/fbmem.c: In function `video_setup':
     drivers/video/fbmem.c:1505: `con2fb_map' undeclared (first use in this=
 function)
     make[3]: *** [drivers/video/fbmem.o] Error 1


Turned Frame Buffer Console support on, and also built in fonts
8x8 and 8x16, and got the usual result: No console messages after
switch to FB. (This is the config included below)

3. Without the mga patch, no FB, no logo, and no X.
Just curious, why isn't the mga patch suitable for mainline?

--------------------------------
grep -v '^#' linux/.config | uniq
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

CONFIG_EXPERIMENTAL=3Dy

CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14

CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

CONFIG_X86_PC=3Dy
CONFIG_MK7=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_EDD=3Dy
CONFIG_HIGHMEM4G=3Dy
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy

CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy

CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy

CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
CONFIG_HOTPLUG=3Dy

CONFIG_PCMCIA_PROBE=3Dy

CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy

CONFIG_PARPORT=3Dy
CONFIG_PARPORT_PC=3Dy
CONFIG_PARPORT_PC_CML1=3Dy
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
CONFIG_PARPORT_OTHER=3Dy
CONFIG_PARPORT_1284=3Dy

CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_PNP_DEBUG=3Dy

CONFIG_PNPBIOS=3Dy

CONFIG_BLK_DEV_FD=3Dy
CONFIG_BLK_CPQ_DA=3Dy
CONFIG_BLK_CPQ_CISS_DA=3Dy
CONFIG_CISS_SCSI_TAPE=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_NBD=3Dy
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D40960
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_LBD=3Dy

CONFIG_IDE=3Dy

CONFIG_BLK_DEV_IDE=3Dy

CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_IDEDISK_STROKE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_BLK_DEV_IDESCSI=3Dy
CONFIG_IDE_TASK_IOCTL=3Dy

CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_IDE_TCQ=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=3D8
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_AMD74XX=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_BLK_DEV_PDC202XX_OLD=3Dy
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
CONFIG_PDC202XX_FORCE=3Dy
CONFIG_BLK_DEV_VIA82CXXX=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_BLK_DEV_PDC202XX=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy

CONFIG_SCSI=3Dy

CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dy
CONFIG_BLK_DEV_SR=3Dy
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dy

CONFIG_SCSI_REPORT_LUNS=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy

CONFIG_SCSI_SYM53C8XX_2=3Dy
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64

CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_LINEAR=3Dy
CONFIG_MD_RAID0=3Dy
CONFIG_MD_RAID1=3Dy
CONFIG_MD_RAID5=3Dy
CONFIG_MD_MULTIPATH=3Dy
CONFIG_BLK_DEV_DM=3Dy

CONFIG_NET=3Dy

CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_IPCOMP=3Dy

CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dy
CONFIG_IP_NF_MATCH_MAC=3Dy
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
CONFIG_IP_NF_MATCH_MARK=3Dy
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP_NF_MATCH_TOS=3Dy
CONFIG_IP_NF_MATCH_ECN=3Dy
CONFIG_IP_NF_MATCH_DSCP=3Dy
CONFIG_IP_NF_MATCH_AH_ESP=3Dy
CONFIG_IP_NF_MATCH_LENGTH=3Dy
CONFIG_IP_NF_MATCH_TTL=3Dy
CONFIG_IP_NF_MATCH_TCPMSS=3Dy
CONFIG_IP_NF_MATCH_UNCLEAN=3Dy
CONFIG_IP_NF_MATCH_OWNER=3Dy
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_TARGET_MIRROR=3Dy

CONFIG_IPV6_SCTP__=3Dy

CONFIG_NETDEVICES=3Dy

CONFIG_DUMMY=3Dy

CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_EL3=3Dy
CONFIG_VORTEX=3Dy
CONFIG_TYPHOON=3Dy
CONFIG_LANCE=3Dy

CONFIG_NET_TULIP=3Dy
CONFIG_NET_ISA=3Dy
CONFIG_EEXPRESS_PRO=3Dy
CONFIG_NET_PCI=3Dy
CONFIG_AMD8111_ETH=3Dy
CONFIG_EEPRO100=3Dy
CONFIG_8139CP=3Dy
CONFIG_8139TOO=3Dy
CONFIG_8139TOO_8129=3Dy
CONFIG_SIS900=3Dy

CONFIG_PLIP=3Dy
CONFIG_PPP=3Dy
CONFIG_PPP_ASYNC=3Dy
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPP_BSDCOMP=3Dy
CONFIG_PPPOE=3Dy
CONFIG_SLIP=3Dy
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

CONFIG_INPUT=3Dy

CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_EVDEV=3Dy

CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy

CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_KEYBOARD_XTKBD=3Dy
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_SERIAL=3Dy

CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy

CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy

CONFIG_SERIAL_CORE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dy

CONFIG_AGP=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_AGP_AMD=3Dy
CONFIG_AGP_AMD_8151=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_MGA=3Dy

CONFIG_EXT2_FS=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_JBD=3Dy
CONFIG_JBD_DEBUG=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dy
CONFIG_REISERFS_PROC_INFO=3Dy
CONFIG_JFS_FS=3Dy
CONFIG_JFS_STATISTICS=3Dy
CONFIG_XFS_FS=3Dy
CONFIG_MINIX_FS=3Dy
CONFIG_ROMFS_FS=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTACTL=3Dy

CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy

CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy

CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy

CONFIG_CRAMFS=3Dy

CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dy
CONFIG_SMB_FS=3Dy
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
CONFIG_CIFS=3Dy
CONFIG_CODA_FS=3Dy
CONFIG_INTERMEZZO_FS=3Dy

CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_LDM_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_CODEPAGE_855=3Dy
CONFIG_NLS_CODEPAGE_865=3Dy
CONFIG_NLS_CODEPAGE_866=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dy
CONFIG_NLS_ISO8859_5=3Dy
CONFIG_NLS_ISO8859_14=3Dy
CONFIG_NLS_ISO8859_15=3Dy
CONFIG_NLS_KOI8_R=3Dy
CONFIG_NLS_KOI8_U=3Dy
CONFIG_NLS_UTF8=3Dy

CONFIG_FB=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FB_MATROX=3Dy
CONFIG_FB_MATROX_MILLENIUM=3Dy
CONFIG_FB_MATROX_MYSTIQUE=3Dy
CONFIG_FB_MATROX_G450=3Dy
CONFIG_FB_MATROX_G100=3Dy
CONFIG_FB_MATROX_PROC=3Dy

CONFIG_VGA_CONSOLE=3Dy
CONFIG_MDA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

CONFIG_PROFILING=3Dy
CONFIG_OPROFILE=3Dy

CONFIG_KALLSYMS=3Dy
CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
CONFIG_FRAME_POINTER=3Dy

CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_MD4=3Dy
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dy
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_SERPENT=3Dy
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_TEST=3Dy

CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy

--=20
         _~|__
   >@   (vagn(     /
    \`-ooooooooo-'/
  ^^^^^^^^^^^^^^^^^^^^

