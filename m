Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265632AbSJXT5Q>; Thu, 24 Oct 2002 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbSJXT5P>; Thu, 24 Oct 2002 15:57:15 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:56586 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265632AbSJXTzq>; Thu, 24 Oct 2002 15:55:46 -0400
Date: Thu, 24 Oct 2002 22:01:33 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44: schedule / flush_to_ldisc / worker_thread oops?
Message-ID: <20021024200133.GA1208@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure this is an oops:

Oct 24 21:55:16 middle kernel: reiserfs: checking transaction log (ide5(57,2)) for (ide5(57,2))
Oct 24 21:55:16 middle kernel: Using r5 hash to sort names
Oct 24 21:55:16 middle kernel: NTFS volume version 3.0.
Oct 24 21:55:16 middle kernel: FAT: Unrecognized mount option mode
Oct 24 21:55:16 middle kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Oct 24 21:55:16 middle kernel:  printing eip:
Oct 24 21:55:16 middle kernel: c01c97c4
Oct 24 21:55:16 middle kernel: Oops: 0002
Oct 24 21:55:16 middle kernel: snd-pcm-oss vfat udf ntfs isofs fat mga agpgart loop 8139too mii crc32 rtc
Oct 24 21:55:16 middle kernel: CPU:    1
Oct 24 21:55:16 middle kernel: EIP:    0060:[n_tty_receive_buf+2380/4456]    Not tainted
Oct 24 21:55:16 middle kernel: EFLAGS: 00010093
Oct 24 21:55:16 middle kernel: EIP is at n_tty_receive_buf+0xa9c/0x1168
Oct 24 21:55:16 middle kernel: eax: 00000000   ebx: 00000246   ecx: c1a52000   edx: f6ccf074
Oct 24 21:55:16 middle kernel: esi: 00000000   edi: f6ccf000   ebp: c1a52000   esp: c1a53ec8
Oct 24 21:55:16 middle kernel: ds: 0068   es: 0068   ss: 0068
Oct 24 21:55:16 middle kernel: Process events/1 (pid: 7, threadinfo=c1a52000 task=c1a557a0)
Oct 24 21:55:16 middle kernel: Stack: f6ccf584 f6ccf184 f6ccf130 c1a52000 c1a52000 c1a52000 c1a67010 74a557a0
Oct 24 21:55:16 middle kernel:        00000001 00000097 f6ccf585 f6ccf184 00000001 c0412174 c1a53f1c 00000000
Oct 24 21:55:16 middle kernel:        00000097 00000082 00000000 c1a557a0 c042be40 c1a557a0 00000000 00013400
Oct 24 21:55:16 middle kernel: Call Trace:
Oct 24 21:55:16 middle kernel:  [schedule+907/1044] schedule+0x38b/0x414
Oct 24 21:55:16 middle kernel:  [__do_SAK+309/424] flush_to_ldisc+0xb1/0xb8
Oct 24 21:55:16 middle kernel:  [__do_SAK+132/424] flush_to_ldisc+0x0/0xb8
Oct 24 21:55:16 middle kernel:  [worker_thread+558/832] worker_thread+0x22e/0x340
Oct 24 21:55:16 middle kernel:  [worker_thread+0/832] worker_thread+0x0/0x340
Oct 24 21:55:16 middle kernel:  [__do_SAK+132/424] flush_to_ldisc+0x0/0xb8
Oct 24 21:55:16 middle kernel:  [default_wake_function+0/52] default_wake_function+0x0/0x34
Oct 24 21:55:16 middle kernel:  [default_wake_function+0/52] default_wake_function+0x0/0x34
Oct 24 21:55:16 middle kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Oct 24 21:55:16 middle kernel:
Oct 24 21:55:16 middle kernel: Code: 88 14 06 8b b4 24 b4 00 00 00 8b 86 1c 0a 00 00 40 25 ff 0f
Oct 24 21:55:16 middle kernel:  <6>note: events/1[7] exited with preempt_count 1
Oct 24 21:55:18 middle xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)

The keyboard was stuck after this boot.

This is 2.5.44, .config:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
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
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
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
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
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
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=m
CONFIG_RAW_DRIVER=y
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
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_EMU10K1=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD_ALT=y
CONFIG_USB_PRINTER=y
CONFIG_USB_SCANNER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y

Kind regards,
Jurriaan
-- 
I expect Woman will be the last thing civilized by Man.
        George Meredith
GNU/Linux 2.5.44 SMP/ReiserFS 2x1380 bogomips load av: 0.01 0.00 0.00
