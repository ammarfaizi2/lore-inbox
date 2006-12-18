Return-Path: <linux-kernel-owner+w=401wt.eu-S1754141AbWLRPZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbWLRPZT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbWLRPZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:25:19 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:40792 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbWLRPZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:25:15 -0500
Subject: Re: [panic] aacraid on 2.4.33.4 w/ PERC 3/Di
From: Mark Drago <markdrago@mail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20061215230324.GA26733@1wt.eu>
References: <1166127624.9531.2.camel@mdrago.bascom.com>
	 <20061215230324.GA26733@1wt.eu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zuFZ2caqmZN5/7FIuTgD"
Date: Mon, 18 Dec 2006 10:24:08 -0500
Message-Id: <1166455448.470.6.camel@mdrago.bascom.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zuFZ2caqmZN5/7FIuTgD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Willy,

I'm forwarding this over to linux-scsi@vger.kernel.org because it seems
that linux-aacraid-devel@dell.com was discontinued a few years ago.
Maybe the folks over there will be able to shed some light on this bug.

Mark.

On Sat, 2006-12-16 at 00:03 +0100, Willy Tarreau wrote:
> Hello Mark,
>=20
> On Thu, Dec 14, 2006 at 03:20:24PM -0500, Mark Drago wrote:
> > Hello,
> >=20
> > I have been seeing some kernel panics on a Dell PowerEdge 2650 with a
> > PERC 3/Di raid controller doing RAID 1.  I have now seen the panics
> > occur on multiple PE2650s.  The panic seems to occur during periods of
> > high disk activity.  I am able to reliably reproduce the crashes by
> > running Bonnie in a loop.
> >=20
> > I originally saw the panics with a 2.4.32 kernel which had a few patche=
s
> > in it, none directly related to scsi or aacraid.  The patches were a fe=
w
> > from netfilter's patch-o-matic-ng, jgarzik's libata for 2.4.32, ebtable=
s
> > and an updated Tigon3 driver from Broadcom.  In order to verify that
> > none of these patches were causing any problems I checked that the pani=
c
> > still happened with a stock 2.4.33.4 kernel.
> >=20
> > I have included below the oops output converted by ksymoops for the
> > panic that occurred on the stock 2.4.33.4 kernel.  I have seen the
> > problem when running both an SMP and non-SMP kernel.  Also included
> > below are relevant sections from my .config, lspci and /proc/scsi/scsi.
> > I have also included 3 other oopses that were seen with the patched
> > 2.4.32 kernel at the very bottom of this email.  If there is any other
> > information I can provide to aid debugging please let me know.
> >=20
> > All of the kernels were compiled with gcc-3.3.6.  I have not yet seen
> > the panic occur on 2.6 kernels.  I am however currently running the
> > Bonnie test on 2.6.18.2.
> >=20
> > Any information regarding this panic, how best to avoid it, or what to
> > do to further debug the problem is greatly appreciated.
>=20
> I'm a bit embarrassed with your bug. sched.c:564 is "Schedule in interrup=
t".
> I've followed the interupt path from aac_queue_command() to aac_queue_get=
()
> and aac_get_entry(), but I still fail to see where this damn code would b=
e
> able to directly or indirectly schedule :-/
>=20
> Most probably I have missed something. Unfortunately, I've just checked
> 2.6 driver, and it's quite different, so it's not possible right now to
> guess what change fixed the problem upstream.
>=20
> I'd like people at Dell to tell us if they already encountered this bug a=
nd
> why not, if there's a known workaround/bug pending.
>=20
> > Thank you,
> > Mark Drago
>=20
> Regards,
> Willy
>=20
> >=20
> > Script used to cause panic (just run and wait for a bit):
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > #!/bin/bash
> > filesize=3D2000
> > while /bin/true; do
> > 	Bonnie -d /tmp -s $filesize &> /dev/null
> > done
> >=20
> > Oops output from panic on stock 2.4.33.4:
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ksymoops 2.4.9 on i686 2.4.32-20060810.  Options used
> >      -V (specified)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.33-20061213-smp (specified)
> >      -m /boot/System.map-2.4.33.4-20061213-smp (specified)
> >=20
> > kernel BUG a sched.c:564!
> > CPU:    0
> > EIP:    0010:[<c01155c2>]  Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010282
> > eax: 00000018   ebx: f7b901ec     ecx: c042e000       edx: 00000001
> > esi: c042e000   edi: 00000000     ebp: c042fd50       esp: c042fd2c
> > ds: 0018  es: 0018  ss: 0018
> > Process swapper (pid: 0, stackpage=3Dc044f000)
> > Stack:  c03590be c042e000 00000002 c042e000 c042fd58 c024d909 f7b901ec
> > c042e000
> >         f7b901f4 c042fd58 c01074bb 00000001 c042e000 f7b901f8 f7b901f8
> > f7bf40c0
> >         00000001 f7b901e0 f7bf447c c0107648 f7b901ec fffffff5 00000000
> > c024e37a
> > Call Trace:    [<c024d909>] [<c01074bb>] [<c0107648>] [<c024e37a>]
> > [<c024ab4c>]
> >   [<c024b68e>] [<c024a6a8>] [<c0240973>] [<c0240f6c>] [<c0247017>]
> > [<c02466cd>]
> >   [<c0246914>] [<c0246ba8>] [<c02b92f4>] [<c0241209>] [<c02410b6>]
> > [<c011d05e>]
> >   [<c011cf40>] [<c011cd17>] [<c010a172>] [<c0106ca8>] [<c010c70c>]
> > [<c0106ca8>]
> >   [<c0160cd4>] [<c0106d42>] [<c0105000>]
> > Code: 0f 0b 34 02 b6 90 35 c0 58 e9 45 fb ff ff 0f 0b 2d 02 b6 90
> >=20
> >=20
> > >>EIP; c01155c2 <schedule+4f2/514>   <=3D=3D=3D=3D=3D
> >=20
> > >>ecx; c042e000 <init_task_union+0/2000>
> > >>esi; c042e000 <init_task_union+0/2000>
> > >>ebp; c042fd50 <init_task_union+1d50/2000>
> > >>esp; c042fd2c <init_task_union+1d2c/2000>
> >=20
> > Trace; c024d909 <aac_queue_get+95/c8>
> > Trace; c01074bb <__down+6b/bc>
> > Trace; c0107648 <__down_failed+8/c>
> > Trace; c024e37a <.text.lock.commsup+38/6e>
> > Trace; c024ab4c <aac_get_container_name+6c/f4>
> > Trace; c024b68e <aac_scsi_cmd+fe/36c>
> > Trace; c024a6a8 <aac_queuecommand+14/18>
> > Trace; c0240973 <scsi_dispatch_cmd+e7/260>
> > Trace; c0240f6c <scsi_done+0/9c>
> > Trace; c0247017 <scsi_request_fn+1bf/368>
> > Trace; c02466cd <scsi_queue_next_request+45/10c>
> > Trace; c0246914 <__scsi_end_request+180/1f8>
> > Trace; c0246ba8 <scsi_io_completion+144/3ac>
> > Trace; c02b92f4 <rw_intr+48/198>
> > Trace; c0241209 <scsi_finish_command+a5/ac>
> > Trace; c02410b6 <scsi_bottom_half_handler+ae/d8>
> > Trace; c011d05e <bh_action+46/70>
> > Trace; c011cf40 <tasklet_hi_action+60/98>
> > Trace; c011cd17 <do_softirq+c3/c8>
> > Trace; c010a172 <do_IRQ+ca/cc>
> > Trace; c0106ca8 <default_idle+0/38>
> > Trace; c010c70c <call_do_IRQ+5/d>
> > Trace; c0106ca8 <default_idle+0/38>
> > Trace; c0160cd4 <ext3_free_branches+9c/1dc>
> > Trace; c0106d42 <cpu_idle+42/5c>
> > Trace; c0105000 <_stext+0/0>
> >=20
> > Code;  c01155c2 <schedule+4f2/514>
> > 00000000 <_EIP>:
> > Code;  c01155c2 <schedule+4f2/514>   <=3D=3D=3D=3D=3D
> >    0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
> > Code;  c01155c4 <schedule+4f4/514>
> >    2:   34 02                     xor    $0x2,%al
> > Code;  c01155c6 <schedule+4f6/514>
> >    4:   b6 90                     mov    $0x90,%dh
> > Code;  c01155c8 <schedule+4f8/514>
> >    6:   35 c0 58 e9 45            xor    $0x45e958c0,%eax
> > Code;  c01155cd <schedule+4fd/514>
> >    b:   fb                        sti   =20
> > Code;  c01155ce <schedule+4fe/514>
> >    c:   ff                        (bad) =20
> > Code;  c01155cf <schedule+4ff/514>
> >    d:   ff 0f                     decl   (%edi)
> > Code;  c01155d1 <schedule+501/514>
> >    f:   0b 2d 02 b6 90 00         or     0x90b602,%ebp
> >=20
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> >=20
> > Contents of /proc/scsi/scsi:
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Attached devices:
> > Host: scsi2 Channel: 00 Id: 00 Lun: 00
> >   Vendor: DELL     Model: BASCOM_MIRROR    Rev: V1.0
> >   Type:   Direct-Access                    ANSI SCSI revision: 02
> >=20
> > Relevant Sections from .config:
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > #
> > # Block devices
> > #
> > CONFIG_BLK_DEV_FD=3Dy
> > # CONFIG_BLK_DEV_XD is not set
> > # CONFIG_PARIDE is not set
> > CONFIG_BLK_CPQ_DA=3Dy
> > CONFIG_BLK_CPQ_CISS_DA=3Dy
> > # CONFIG_CISS_SCSI_TAPE is not set
> > # CONFIG_CISS_MONITOR_THREAD is not set
> > # CONFIG_BLK_DEV_DAC960 is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > CONFIG_BLK_DEV_SX8=3Dy
> > # CONFIG_BLK_DEV_LOOP is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > CONFIG_BLK_DEV_RAM=3Dy
> > CONFIG_BLK_DEV_RAM_SIZE=3D4096
> > CONFIG_BLK_DEV_INITRD=3Dy
> > # CONFIG_BLK_STATS is not set
> >=20
> > #
> > # Multi-device support (RAID and LVM)
> > #
> > # CONFIG_MD is not set
> > # CONFIG_BLK_DEV_MD is not set
> > # CONFIG_MD_LINEAR is not set
> > # CONFIG_MD_RAID0 is not set
> > # CONFIG_MD_RAID1 is not set
> > # CONFIG_MD_RAID5 is not set
> > # CONFIG_MD_MULTIPATH is not set
> > # CONFIG_BLK_DEV_LVM is not set
> >=20
> > #
> > # ATA/IDE/MFM/RLL support
> > #
> > CONFIG_IDE=3Dy
> >=20
> > #
> > # IDE, ATA and ATAPI Block devices
> > #
> > CONFIG_BLK_DEV_IDE=3Dy
> > # CONFIG_BLK_DEV_HD_IDE is not set
> > # CONFIG_BLK_DEV_HD is not set
> > # CONFIG_BLK_DEV_IDE_SATA is not set
> > CONFIG_BLK_DEV_IDEDISK=3Dy
> > CONFIG_IDEDISK_MULTI_MODE=3Dy
> > # CONFIG_IDEDISK_STROKE is not set
> > # CONFIG_BLK_DEV_IDECS is not set
> > # CONFIG_BLK_DEV_DELKIN is not set
> > CONFIG_BLK_DEV_IDECD=3Dy
> > # CONFIG_BLK_DEV_IDETAPE is not set
> > # CONFIG_BLK_DEV_IDEFLOPPY is not set
> > CONFIG_BLK_DEV_IDESCSI=3Dy
> > CONFIG_IDE_TASK_IOCTL=3Dy
> > CONFIG_BLK_DEV_CMD640=3Dy
> > # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> > # CONFIG_BLK_DEV_ISAPNP is not set
> > CONFIG_BLK_DEV_IDEPCI=3Dy
> > # CONFIG_BLK_DEV_GENERIC is not set
> > CONFIG_IDEPCI_SHARE_IRQ=3Dy
> > CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> > CONFIG_IDEDMA_PCI_AUTO=3Dy
> > CONFIG_IDEDMA_ONLYDISK=3Dy
> > CONFIG_BLK_DEV_IDEDMA=3Dy
> > # CONFIG_IDEDMA_PCI_WIP is not set
> > # CONFIG_BLK_DEV_ADMA100 is not set
> > CONFIG_BLK_DEV_AEC62XX=3Dy
> > CONFIG_BLK_DEV_ALI15X3=3Dy
> > # CONFIG_WDC_ALI15X3 is not set
> > CONFIG_BLK_DEV_AMD74XX=3Dy
> > # CONFIG_AMD74XX_OVERRIDE is not set
> > # CONFIG_BLK_DEV_ATIIXP is not set
> > CONFIG_BLK_DEV_CMD64X=3Dy
> > # CONFIG_BLK_DEV_TRIFLEX is not set
> > CONFIG_BLK_DEV_CY82C693=3Dy
> > CONFIG_BLK_DEV_CS5530=3Dy
> > CONFIG_BLK_DEV_HPT34X=3Dy
> > # CONFIG_HPT34X_AUTODMA is not set
> > CONFIG_BLK_DEV_HPT366=3Dy
> > CONFIG_BLK_DEV_PIIX=3Dy
> > # CONFIG_BLK_DEV_NS87415 is not set
> > CONFIG_BLK_DEV_OPTI621=3Dy
> > CONFIG_BLK_DEV_PDC202XX_OLD=3Dy
> > # CONFIG_PDC202XX_BURST is not set
> > CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
> > # CONFIG_PDC202XX_FORCE is not set
> > CONFIG_BLK_DEV_RZ1000=3Dy
> > # CONFIG_BLK_DEV_SC1200 is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > CONFIG_BLK_DEV_SIS5513=3Dy
> > CONFIG_BLK_DEV_SLC90E66=3Dy
> > # CONFIG_BLK_DEV_TRM290 is not set
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > # CONFIG_IDE_CHIPSETS is not set
> > CONFIG_IDEDMA_AUTO=3Dy
> > # CONFIG_IDEDMA_IVB is not set
> > # CONFIG_DMA_NONPCI is not set
> > CONFIG_BLK_DEV_PDC202XX=3Dy
> > # CONFIG_BLK_DEV_ATARAID is not set
> > # CONFIG_BLK_DEV_ATARAID_PDC is not set
> > # CONFIG_BLK_DEV_ATARAID_HPT is not set
> > # CONFIG_BLK_DEV_ATARAID_MEDLEY is not set
> > # CONFIG_BLK_DEV_ATARAID_SII is not set
> >=20
> > #
> > # SCSI support
> > #
> > CONFIG_SCSI=3Dy
> > CONFIG_BLK_DEV_SD=3Dy
> > CONFIG_SD_EXTRA_DEVS=3D40
> > # CONFIG_CHR_DEV_ST is not set
> > # CONFIG_CHR_DEV_OSST is not set
> > CONFIG_BLK_DEV_SR=3Dy
> > # CONFIG_BLK_DEV_SR_VENDOR is not set
> > CONFIG_SR_EXTRA_DEVS=3D2
> > CONFIG_CHR_DEV_SG=3Dy
> > # CONFIG_SCSI_DEBUG_QUEUES is not set
> > # CONFIG_SCSI_MULTI_LUN is not set
> > # CONFIG_SCSI_CONSTANTS is not set
> > # CONFIG_SCSI_LOGGING is not set
> >=20
> > #
> > # SCSI low-level drivers
> > #
> > # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> > # CONFIG_SCSI_7000FASST is not set
> > # CONFIG_SCSI_ACARD is not set
> > # CONFIG_SCSI_AHA152X is not set
> > # CONFIG_SCSI_AHA1542 is not set
> > # CONFIG_SCSI_AHA1740 is not set
> > CONFIG_SCSI_AACRAID=3Dy
> > CONFIG_SCSI_AIC7XXX=3Dy
> > CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253
> > CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
> > # CONFIG_AIC7XXX_PROBE_EISA_VL is not set
> > # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
> > # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> > CONFIG_AIC7XXX_DEBUG_MASK=3D0
> > # CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
> > CONFIG_SCSI_AIC79XX=3Dy
> > CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
> > CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
> > # CONFIG_AIC79XX_BUILD_FIRMWARE is not set
> > # CONFIG_AIC79XX_ENABLE_RD_STRM is not set
> > # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> > CONFIG_AIC79XX_DEBUG_MASK=3D0
> > # CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
> > # CONFIG_SCSI_DPT_I2O is not set
> > # CONFIG_SCSI_ADVANSYS is not set
> > # CONFIG_SCSI_IN2000 is not set
> > # CONFIG_SCSI_AM53C974 is not set
> > # CONFIG_SCSI_MEGARAID is not set
> > CONFIG_SCSI_MEGARAID2=3Dy
> > CONFIG_SCSI_SATA=3Dy
> > CONFIG_SCSI_SATA_AHCI=3Dy
> > CONFIG_SCSI_SATA_SVW=3Dy
> > CONFIG_SCSI_ATA_PIIX=3Dy
> > CONFIG_SCSI_SATA_NV=3Dy
> > # CONFIG_SCSI_SATA_QSTOR is not set
> > CONFIG_SCSI_SATA_PROMISE=3Dy
> > CONFIG_SCSI_SATA_SX4=3Dy
> > CONFIG_SCSI_SATA_SIL=3Dy
> > CONFIG_SCSI_SATA_SIS=3Dy
> > CONFIG_SCSI_SATA_ULI=3Dy
> > CONFIG_SCSI_SATA_VIA=3Dy
> > CONFIG_SCSI_SATA_VITESSE=3Dy
> > # CONFIG_SCSI_BUSLOGIC is not set
> > CONFIG_SCSI_CPQFCTS=3Dy
> > # CONFIG_SCSI_DMX3191D is not set
> > # CONFIG_SCSI_DTC3280 is not set
> > # CONFIG_SCSI_EATA is not set
> > # CONFIG_SCSI_EATA_DMA is not set
> > # CONFIG_SCSI_EATA_PIO is not set
> > # CONFIG_SCSI_FUTURE_DOMAIN is not set
> > CONFIG_SCSI_GDTH=3Dy
> > # CONFIG_SCSI_GENERIC_NCR5380 is not set
> > CONFIG_SCSI_IPS=3Dy
> > # CONFIG_SCSI_INITIO is not set
> > # CONFIG_SCSI_INIA100 is not set
> > # CONFIG_SCSI_PPA is not set
> > # CONFIG_SCSI_IMM is not set
> > # CONFIG_SCSI_NCR53C406A is not set
> > # CONFIG_SCSI_NCR53C7xx is not set
> > CONFIG_SCSI_SYM53C8XX_2=3Dy
> > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
> > CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
> > CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
> > # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
> > # CONFIG_SCSI_PAS16 is not set
> > # CONFIG_SCSI_PCI2000 is not set
> > # CONFIG_SCSI_PCI2220I is not set
> > # CONFIG_SCSI_PSI240I is not set
> > # CONFIG_SCSI_QLOGIC_FAS is not set
> > # CONFIG_SCSI_QLOGIC_ISP is not set
> > # CONFIG_SCSI_QLOGIC_FC is not set
> > # CONFIG_SCSI_QLOGIC_1280 is not set
> > # CONFIG_SCSI_SEAGATE is not set
> > # CONFIG_SCSI_SIM710 is not set
> > # CONFIG_SCSI_SYM53C416 is not set
> > # CONFIG_SCSI_DC390T is not set
> > # CONFIG_SCSI_T128 is not set
> > # CONFIG_SCSI_U14_34F is not set
> > # CONFIG_SCSI_ULTRASTOR is not set
> > # CONFIG_SCSI_NSP32 is not set
> > # CONFIG_SCSI_DEBUG is not set
> >=20
> > #
> > # Fusion MPT device support
> > #
> > CONFIG_FUSION=3Dy
> > CONFIG_FUSION_BOOT=3Dy
> > CONFIG_FUSION_MAX_SGE=3D40
> > CONFIG_FUSION_ISENSE=3Dm
> > # CONFIG_FUSION_CTL is not set
> > # CONFIG_FUSION_LAN is not set
> >=20
> > #
> > # Partition Types
> > #
> > CONFIG_PARTITION_ADVANCED=3Dy
> > # CONFIG_ACORN_PARTITION is not set
> > # CONFIG_OSF_PARTITION is not set
> > # CONFIG_AMIGA_PARTITION is not set
> > # CONFIG_ATARI_PARTITION is not set
> > # CONFIG_MAC_PARTITION is not set
> > CONFIG_MSDOS_PARTITION=3Dy
> > # CONFIG_BSD_DISKLABEL is not set
> > # CONFIG_MINIX_SUBPARTITION is not set
> > # CONFIG_SOLARIS_X86_PARTITION is not set
> > # CONFIG_UNIXWARE_DISKLABEL is not set
> > # CONFIG_LDM_PARTITION is not set
> > # CONFIG_SGI_PARTITION is not set
> > # CONFIG_ULTRIX_PARTITION is not set
> > # CONFIG_SUN_PARTITION is not set
> > # CONFIG_EFI_PARTITION is not set
> > # CONFIG_SMB_NLS is not set
> > CONFIG_NLS=3Dy
> >=20
> > Relevant Sections from 'lspci -vvv':
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 00:04.0 Class ff00: Dell Computer Corporation: Unknown device 000c
> >         Subsystem: Dell Computer Corporation: Unknown device 000c
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 10
> >         Interrupt: pin A routed to IRQ 19
> >         Region 0: Memory at feb80000 (32-bit, prefetchable) [size=3D4K]
> >         Region 1: I/O ports at ecf8 [size=3D8]
> >         Region 2: I/O ports at ece8 [size=3D8]
> >         Expansion ROM at fe000000 [disabled] [size=3D64K]
> >         Capabilities: [48] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> >=20
> > 00:04.1 Class ff00: Dell Computer Corporation PowerEdge Expandable RAID
> > Controller 3/Di
> >         Subsystem: Dell Computer Corporation PowerEdge Expandable RAID
> > Controller 3/Di
> >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Interrupt: pin B routed to IRQ 23
> >         Region 0: Memory at fe102000 (32-bit, non-prefetchable)
> > [size=3D4K]
> >         Region 1: I/O ports at ec80 [size=3D64]
> >         Region 2: Memory at feb00000 (32-bit, prefetchable) [size=3D512=
K]
> >         Capabilities: [48] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> >                =20
> > 00:04.2 Class ff00: Dell Computer Corporation: Unknown device 000d
> >         Subsystem: Dell Computer Corporation: Unknown device 000d
> >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Interrupt: pin C routed to IRQ 27
> >         Region 0: I/O ports at ecf4 [size=3D4]
> >         Capabilities: [48] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> >=20
> > 04:08.0 PCI bridge: Intel Corporation: Unknown device 0309 (rev 01)
> > (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort=
-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 10
> >         Bus: primary=3D04, secondary=3D05, subordinate=3D05, sec-latenc=
y=3D32
> >         I/O behind bridge: 0000f000-00000fff
> >         Memory behind bridge: fff00000-000fffff
> >         Prefetchable memory behind bridge: fff00000-000fffff
> >         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> >         Capabilities: [68] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> >=20
> > 04:08.1 RAID bus controller: Dell Computer Corporation: Unknown device
> > 000a (rev 01)
> >         Subsystem: Dell Computer Corporation: Unknown device 0121
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dslow >TAbort=
-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 10
> >         Interrupt: pin A routed to IRQ 30
> >         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128=
M]
> >         Expansion ROM at fcb00000 [disabled] [size=3D64K]
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> >                =20
> > Other oopses seen while running 2.4.32 w/ some patches:
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ksymoops 2.4.9 on i686 2.4.32-20060810.  Options used
> >      -V (specified)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.32-20060810/ (default)
> >      -m /boot/System.map-2.4.32-20060810 (specified)
> >=20
> > kernel BUG at sched.c:564!
> > invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c01155aa>]  Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010282
> > eax: 00000018   ebx: f7b9000c     ecx: c0438000       edx: 00000001
> > esi: c0438000   edi: 00000000     ebp: c0439d50       esp: c0439d2c
> > ds: 0018        es: 0018       ss: 0018
> > Process swapper (pid: 0, stackpage=3Dc0439000)
> > Stack: c036009e c0438000 00000002 c0438000 c0439d58 c024d6b9 f7b9000c
> > c0438000
> >        f7b90014 c0439d58 c01074bb 00000001 c0438000 f7b90018 f7b90018
> > f7bf70c0
> >        00000001 f7b90000 f7bf747c c0107648 f7b9000c fffffff5 00000000
> > c024e12a
> > Call Trace:    [<c024d6b9>] [<c01074bb>] [<c0107648>] [<c024e12a>]
> > [<c024a8fc>]
> >   [<c024b43e>] [<c024a458>] [<c0240723>] [<c0240d1c>] [<c0246dc7>]
> > [<c024647d>]
> >   [<c02466c4>] [<c0246958>] [<c02b9140>] [<c0240fb9>] [<c0240e66>]
> > [<c011d046>]
> >   [<c011cf28>] [<c011ccff>] [<c010a172>] [<c0106ca8>] [<c010c70c>]
> > [<c0106ca8>]
> >   [<c0106cd4>] [<c0106d42>] [<c0105000>]
> > Code: 0f 0b 34 02 96 00 36 c0 58 e9 45 fb ff ff 0f 0b 2d 02 96 00
> > Error (pclose_local): Oops_decode_part pclose failed 0x7f00
> > Error (Oops_decode_part): no objdump lines read for /tmp/ksymoops.gktAN=
P
> >=20
> >=20
> > >>EIP; c01155aa <qm_refs+1aa/1c8>   <=3D=3D=3D=3D=3D
> >=20
> > >>ebx; f7b9000c <_end+376fa294/384302e8>
> > >>ecx; c0438000 <tigonFwText+118c0/18020>
> > >>esi; c0438000 <tigonFwText+118c0/18020>
> > >>ebp; c0439d50 <tigonFwText+13610/18020>
> > >>esp; c0439d2c <tigonFwText+135ec/18020>
> >=20
> > Trace; c024d6b9 <check_extport+2a1/424>
> > Trace; c01074bb <__down_failed_trylock+7/c>
> > Trace; c0107648 <sys_rt_sigsuspend+28/100>
> > Trace; c024e12a <configure_termination+5de/614>
> > Trace; c024a8fc <ahc_dump_card_state+10b4/112c>
> > Trace; c024b43e <ahc_write_seeprom+2fe/5dc>
> > Trace; c024a458 <ahc_dump_card_state+c10/112c>
> > Trace; c0240723 <ahc_handle_scsiint+35b/d18>
> > Trace; c0240d1c <ahc_handle_scsiint+954/d18>
> > Trace; c0246dc7 <ahc_init+613/62c>
> > Trace; c024647d <ahc_chip_init+751/a88>
> > Trace; c02466c4 <ahc_chip_init+998/a88>
> > Trace; c0246958 <ahc_init+1a4/62c>
> > Trace; c02b9140 <pci_scan_bridge+4c/180>
> > Trace; c0240fb9 <ahc_handle_scsiint+bf1/d18>
> > Trace; c0240e66 <ahc_handle_scsiint+a9e/d18>
> > Trace; c011d046 <sys_getpriority+46/60>
> > Trace; c011cf28 <proc_sel+78/84>
> > Trace; c011ccff <sys_ssetmask+47/48>
> > Trace; c010a172 <sys_vm86old+fa/108>
> > Trace; c0106ca8 <cpu_idle+2c/5c>
> > Trace; c010c70c <show_cpuinfo+1cc/240>
> > Trace; c0106ca8 <cpu_idle+2c/5c>
> > Trace; c0106cd4 <cpu_idle+58/5c>
> > Trace; c0106d42 <machine_real_restart+6a/a0>
> > Trace; c0105000 <_stext+0/0>
> >=20
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> >=20
> > ----------------------------------------------------------------
> >=20
> > ksymoops 2.4.9 on i686 2.4.32-20060810-smp.  Options used
> >      -V (specified)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.32-20060810-smp/ (default)
> >      -m /boot/System.map-2.4.32-20060810-smp (specified)
> >=20
> > kernel BUG at sched.c:564!
> > invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c01118af>]  Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010286
> > eax: 00000018   ebx: f7bc01bc     ecx: f535c000       edx: f6e693f0
> > esi: f535c000   edi: f7bc01c4     ebp: f535da44       esp: f535da24
> > ds: 0018   es: 0018   ss: 0018
> > Process Bonnie (pid: 2853, stackpage=3Df535d000)
> > Stack: c0337c3e 00000002 f535c000 00000000 c0236795 f7bc01bc f535c000
> > f7bc01c4
> >        f535da4c c010736a 00000001 f535c000 f7bc01c4 f7bc01c4 f7b00c00
> > 00000001
> >        f7bc01b0 00000002 c01074a4 f7bc01bc fffffff5 00000000 c0237195
> > 00000002
> > Call Trace:    [<c0236795>] [<c010736a>] [<c01074a4>] [<c0237195>]
> > [<c0233b28>]
> >   [<c0234652>] [<c0233694>] [<c022a10e>] [<c022a69c>] [<c023015b>]
> > [<c022f860>]
> >   [<c022fa71>] [<c022fd04>] [<c02a002c>] [<c022a8f4>] [<c022a7b6>]
> > [<c0117e5e>]
> >   [<c0117d9b>] [<c0117c13>] [<c010990d>] [<c010bb44>] [<c015a09f>]
> > [<c014f9a2>]
> >   [<c01540ca>] [<c01540f0>] [<c0159b2b>] [<c01545bc>] [<c0151945>]
> > [<c0151c64>]
> >   [<c0131fc3>] [<c01321c8>] [<c0151ab8>] [<c0152194>] [<c0132385>]
> > [<c01522f8>]
> >   [<c01328e4>] [<c015eea7>] [<c01330a6>] [<c01522c8>] [<c0152752>]
> > [<c01522c8>]
> >   [<c01259be>] [<c0125e97>] [<c01504a7>] [<c0130886>] [<c010857f>]
> > Code: 0f 0b 34 02 36 7c 33 c0 58 e9 3c fd ff ff 0f 0b 2d 02 36 7c
> > Error (pclose_local): Oops_decode_part pclose failed 0x7f00
> > Error (Oops_decode_part): no objdump lines read for /tmp/ksymoops.EOhEe=
w
> >=20
> >=20
> > >>EIP; c01118af <pirq_get_info+1b/64>   <=3D=3D=3D=3D=3D
> >=20
> > >>ebx; f7bc01bc <_end+376c0144/383e7fe8>
> > >>ecx; f535c000 <_end+34e5bf88/383e7fe8>
> > >>edx; f6e693f0 <_end+36969378/383e7fe8>
> > >>esi; f535c000 <_end+34e5bf88/383e7fe8>
> > >>edi; f7bc01c4 <_end+376c014c/383e7fe8>
> > >>ebp; f535da44 <_end+34e5d9cc/383e7fe8>
> > >>esp; f535da24 <_end+34e5d9ac/383e7fe8>
> >=20
> > Trace; c0236795 <ide_xlate_1024+1b5/1e9>
> > Trace; c010736a <sys_execve+2/54>
> > Trace; c01074a4 <__down+54/bc>
> > Trace; c0237195 <proc_ide_read_settings+a5/168>
> > Trace; c0233b28 <ide_cmd+50/70>
> > Trace; c0234652 <unexpected_intr+56/98>
> > Trace; c0233694 <ide_end_drive_cmd+f0/2dc>
> > Trace; c022a10e <get_drives_info+362/458>
> > Trace; c022a69c <config_art_rwp_pio+bc/304>
> > Trace; c023015b <hwif_unregister+1b/b4>
> > Trace; c022f860 <init_hwif_data+13c/214>
> > Trace; c022fa71 <ide_dump_status+b5/444>
> > Trace; c022fd04 <ide_dump_status+348/444>
> > Trace; c02a002c <gdth_sync_event+ec/558>
> > Trace; c022a8f4 <config_chipset_for_pio+10/58>
> > Trace; c022a7b6 <config_art_rwp_pio+1d6/304>
> > Trace; c0117e5e <__set_personality+66/b8>
> > Trace; c0117d9b <unregister_exec_domain+3/60>
> > Trace; c0117c13 <default_handler+7/60>
> > Trace; c010990d <set_tss_desc+1/38>
> > Trace; c010bb44 <handle_vm86_fault+8f0/8f4>
> > Trace; c015a09f <locks_read_proc+3b/74>
> > Trace; c014f9a2 <free_kiobuf_bhs+4e/64>
> > Trace; c01540ca <set_brk+5e/78>
> > Trace; c01540f0 <padzero+c/24>
> > Trace; c0159b2b <meminfo_read_proc+d7/174>
> > Trace; c01545bc <load_elf_interp+19c/308>
> > Trace; c0151945 <sys_pivot_root+19d/30c>
> > Trace; c0151c64 <.text.lock.namespace+1b0/1c8>
> > Trace; c0131fc3 <balance_classzone+1cf/1f0>
> > Trace; c01321c8 <__alloc_pages+1e4/258>
> > Trace; c0151ab8 <.text.lock.namespace+4/1c8>
> > Trace; c0152194 <seq_lseek+b8/f8>
> > Trace; c0132385 <nr_free_highpages+9/20>
> > Trace; c01522f8 <seq_path+18/180>
> > Trace; c01328e4 <get_swap_page+c0/248>
> > Trace; c015eea7 <ext3_alloc_branch+19b/294>
> > Trace; c01330a6 <try_to_unuse+aa/36c>
> > Trace; c01522c8 <seq_printf+2c/44>
> > Trace; c0152752 <setxattr+146/180>
> > Trace; c01522c8 <seq_printf+2c/44>
> > Trace; c01259be <copy_page_range+15a/1d8>
> > Trace; c0125e97 <get_user_pages+ab/200>
> > Trace; c01504a7 <show_vfsmnt+20f/380>
> > Trace; c0130886 <swap_out+76/498>
> > Trace; c010857f <do_signal+a3/264>
> >=20
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> >=20
> > ----------------------------------------------------------------
> >=20
> > ksymoops 2.4.9 on i686 2.4.32-20060810-smp.  Options used
> >      -V (specified)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.32-20060810-smp/ (default)
> >      -m /boot/System.map-2.4.32-20060810-smp (specified)
> >=20
> > kernel BUG at sched.c:564!
> > invalid operand: 0000
> > CPU:    0
> > EIP:    0010:[<c01155aa>]  Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 0110286
> > eax: 00000018   ebx: f7bb00fc     ecx: 00000000       edx: 00000001
> > esi: e6a4a000   edi: 00000000     ebp: e6a4bd6c       esp: e6a4bd48
> > ds: 0018   es: 0018   ss: 0018
> > Process Bonnie (pid: 2802, stackpage=3De6a4b000)
> > Stack: c036009e e6a4a000 00000002 e6a4a000 e6a4bd74 c024d6b9 f7bb00fc
> > e6a4a000
> >        f7bb0104 e6a4bd74 c01074bb 00000001 e6a2a000 f7bb0108 f7bb0108
> > f7bf44c0
> >        00000001 f7bb00f0 f7bf487c c0107648 f7bb00fc fffffff5 00000000
> > c024e12a
> > Call Trace:    [<c024d6b9>] [<c01074bb>] [<c0107648>] [<c024e12a>]
> > [<c024a8fc>]
> >   [<c024b43e>] [<c024a458>] [<c0240723>] [<c0240d1c>] [<c0246dc7>]
> > [<c024647d>]
> >   [<c02466c4>] [<c0246958>] [<c02b9140>] [<c0240fb9>] [<c0240e66>]
> > [<c011d046>]
> >   [<c011cf28>] [<c011ccff>] [<c010a172>] [<c010c70c>]
> > Code: 0f 0b 34 02 96 00 36 c0 58 e9 45 fb ff ff 0f 0b 2d 02 96 00
> > Error (pclose_local): Oops_decode_part pclose failed 0x7f00
> > Error (Oops_decode_part): no objdump lines read for /tmp/ksymoops.trYJR=
B
> >=20
> >=20
> > >>EIP; c01155aa <schedule+4f2/514>   <=3D=3D=3D=3D=3D
> >=20
> > >>ebx; f7bb00fc <_end+376b0084/383e7fe8>
> > >>esi; e6a4a000 <_end+26549f88/383e7fe8>
> > >>ebp; e6a4bd6c <_end+2654bcf4/383e7fe8>
> > >>esp; e6a4bd48 <_end+2654bcd0/383e7fe8>
> >=20
> > Trace; c024d6b9 <aac_queue_get+95/c8>
> > Trace; c01074bb <__down+6b/bc>
> > Trace; c0107648 <__down_failed+8/c>
> > Trace; c024e12a <.text.lock.commsup+38/6e>
> > Trace; c024a8fc <aac_get_container_name+6c/f4>
> > Trace; c024b43e <aac_scsi_cmd+fe/36c>
> > Trace; c024a458 <aac_queuecommand+14/18>
> > Trace; c0240723 <scsi_dispatch_cmd+e7/260>
> > Trace; c0240d1c <scsi_done+0/9c>
> > Trace; c0246dc7 <scsi_request_fn+1bf/368>
> > Trace; c024647d <scsi_queue_next_request+45/10c>
> > Trace; c02466c4 <__scsi_end_request+180/1f8>
> > Trace; c0246958 <scsi_io_completion+144/3ac>
> > Trace; c02b9140 <rw_intr+48/198>
> > Trace; c0240fb9 <scsi_finish_command+a5/ac>
> > Trace; c0240e66 <scsi_bottom_half_handler+ae/d8>
> > Trace; c011d046 <bh_action+46/70>
> > Trace; c011cf28 <tasklet_hi_action+60/98>
> > Trace; c011ccff <do_softirq+c3/c8>
> > Trace; c010a172 <do_IRQ+ca/cc>
> > Trace; c010c70c <call_do_IRQ+5/d>
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-zuFZ2caqmZN5/7FIuTgD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFhrKY2ovBrIOxiiARAqBMAJ462yYI/EMQ3EGpp+NuTsCQbP/wzgCfeCLb
heiYBkmyxG1EbodBZidxKS4=
=ff0X
-----END PGP SIGNATURE-----

--=-zuFZ2caqmZN5/7FIuTgD--

