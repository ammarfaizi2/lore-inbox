Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTDIVBL (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDIVBK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:01:10 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:17092 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S263825AbTDIVAd (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:00:33 -0400
Subject: Re: 2.5.67, 2.5-bk lock up with RH 9 and graphical log out.
From: Steven Cole <elenstev@mesatop.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <1049921014.592.0.camel@teapot.felipe-alfaro.com>
References: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
	 <1049921014.592.0.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049922707.24466.41.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 09 Apr 2003 15:11:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 14:43, Felipe Alfaro Solana wrote:
> On Wed, 2003-04-09 at 18:04, Steven Cole wrote:
> > With kernel 2.5.67 or 2.5-bk-current and Red Hat 9, if I try to do a
> > graphical log out from either KDE or Gnome, the test machine locks up
> > hard, not responding to pings, or alt-sysrq-anything. (and yes,
> > /proc/sys/kernel/sysrq is 1 and I "fixed" /etc/sysctl.conf, line 13)
> > 
> > The same lockup happens with ctrl-alt-backspace from KDE or Gnome.
> > 
> > Doing an /sbin/init 3 works fine.  Harsh way to log out however.
> > Subsequent cycles of startx and graphical "Log Out" do _not_ lock up
> > the box, but work just fine.
> > 
> > Needless to say, with the vendor kernel, everything works perfectly. 
> > Alt-sysrq-various behaves as expected. Ctrl-alt-backspace does not
> > lock up the box.
> > 
> > If I get time, I'll try some older 2.5.x kernels to see if this is a
> > recently introduced behavior.
> 
> .config? Are you using Framebuffer console support?

No. CONFIG_FB is set, but none of the CONFIG_FB_X are set.

Output of grep ^CONFIG .config at end of message.

I also tried 2.5.67-ac1 which behaves the same as above, and
2.5.67-mm1 which does not hang, but reboots.  Adding akpm to
the cc-list since -mm1 behaves a little differently than the rest.

I replaced id:5:initdefault: with id:3:initdefault: in /etc/inittab
and that made the lockups go away with 2.5.67-[bk,ac1,mm1].  

I usually have that setup (initial runlevel 3) anyway, so it was only an
accident that I chose "Start X Window System at Boot" during the RH9
install.  Otherwise, I would have never seen this problem.

FWIW, here is the .config for 2.5-bk:

Steven

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_JFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_FB=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_USB=y
CONFIG_USB_STORAGE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIOS_REBOOT=y



