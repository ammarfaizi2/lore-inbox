Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSECQ7R>; Fri, 3 May 2002 12:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314798AbSECQ7Q>; Fri, 3 May 2002 12:59:16 -0400
Received: from pop.gmx.net ([213.165.64.20]:23698 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314787AbSECQ7M>;
	Fri, 3 May 2002 12:59:12 -0400
Date: Fri, 3 May 2002 18:57:44 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #2
Message-Id: <20020503185744.7f4e192f.sebastian.droege@gmx.de>
In-Reply-To: <20020503164555.GQ839@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="pd/W0naQT=.10Bbw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--pd/W0naQT=.10Bbw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2002 18:45:55 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Fri, May 03 2002, Sebastian Droege wrote:
> > On Fri, 3 May 2002 13:06:52 +0200
> > Jens Axboe <axboe@suse.de> wrote:
> > 
> > > Hi,
> > > 
> > > 2.5.13 now has the generic tag support that I wrote included, here's an
> > > IDE TCQ that uses that. Changes since the version posted for 2.5.12:
> > > 
> > > - Fix the ide_tcq_invalidate_queue() WIN_NOP usage needed to clear the
> > >   internal queue on errors. It was disabled in the last version due to
> > >   the ata_request changes, it should work now.
> > > 
> > > - Remove Promise tcq disable check, it works just fine on Promise as
> > >   long as we handle the two-drives-with-tcq case like we currently do.
> > 
> > Hi,
> > I get following oops after a while... it's not really reproducable but
> > happens a few minutes after bootup
> > With TCQ disabled the kernel is rock-solid ;)
> > I only use TCQ on one harddisk (hda)... hdb doesn't support it.
> > The IDE controller is an Intel Corp. 82371AB PIIX4 IDE (rev 01)
> > hda is a IBM-DTTA-351010
> 
> Hmm strange, please send me your .config so I can see some more facts
> about your setup.

Attached at the bottom...

> 
> > ide_tcq_intr_timeout: timeout waiting for interrupt...
> > ide_tcq_intr_timeout: hwgroup not busy
> 
> We timed out waiting for an interrupt for service or dma completion.
> Damn, I forgot to print which one. Please change that printk in
> drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:
> 
> 	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
> 		hwgroup->rq ? "completion" : "service");
> 
> and reproduce!
Is this printk enough or should I handcopy the oops again? ;)

> 
> > hda: invalidating pending queue (10)
> 
> Ok, so a service check produced nothing for the drive (ok, odds are good
> this is a completion interrupt timeout), so we proceeded to invalidate
> the block tag queue.
> 
> > kernel BUG at ll_rw_blk.c:407!
> 
> And apparently one of the request on the tag queue had no tag assigned,
> very odd. This means someone else ended it, but it didn't get cleared.
> Hmm. This is probably your problem, I'll have to think about this.
> 
> [snip oops]
> 
> At least part of the decode seems bogus (eip should be
> blk_queue_end_tag...) and the last traces should be ide_tcq_intr_timeout
> -> ide_tcq_invalidate_queue -> blk_queue_invalidate_tags
Yes this is possible... the oops is just hand copied...

Bye


CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_TULIP=y
CONFIG_DM9102=y
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_UDF_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_ZISOFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_CS46XX=y
CONFIG_SND_CS46XX_ACCEPT_VALID=y
CONFIG_INPUT_GAMEPORT=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m

--pd/W0naQT=.10Bbw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE80sGLe9FFpVVDScsRAmybAJ9QMe3ptvgc8uzgjgrsZYGSlkp0TgCfaz+O
L5igUhs/0x7kP17xVOVM3as=
=wYvc
-----END PGP SIGNATURE-----

--pd/W0naQT=.10Bbw--

