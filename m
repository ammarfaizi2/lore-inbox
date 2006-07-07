Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWGGE2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWGGE2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWGGE2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:28:11 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53410 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750769AbWGGE2K (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:28:10 -0400
Message-Id: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm6 libata stupid question...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152246488_3190P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 00:28:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152246488_3190P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <5192.1152246480.1@turing-police.cc.vt.edu>

I decided to be brave, and see if I could get libata instead of the old
ide driver working on my laptop, and I got (mostly) success:

CONFIG_SCSI_SATA=y
CONFIG_SCSI_ATA_PIIX=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
(and turn off CONFIG_IDE - that bit me for a while ;)

[   34.409542] libata version 2.00 loaded.
[   34.409781] ata_piix 0000:00:1f.1: version 2.00tj1ac5
[   34.409804] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   34.411282] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   34.411809] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[   34.412676] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   34.412761] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[   34.413426] scsi0 : ata_piix
[   34.720915] ata1.00: configured for UDMA/33
[   34.872966] ata1.01: configured for UDMA/33
[   34.873476]   Vendor: ATA       Model: FUJITSU MHV2060A  Rev: 0000
[   34.874589]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   34.878297]   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
[   34.879429]   Type:   CD-ROM                             ANSI SCSI revision: 05
[   34.880725] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
[   34.881385] scsi1 : ata_piix
[   35.032798] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   35.033432] sda: Write Protect is off
[   35.033768] sda: Mode Sense: 00 3a 00 00
[   35.033792] SCSI device sda: drive cache: write back
[   35.034329] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   35.034945] sda: Write Protect is off
[   35.060944] sda: Mode Sense: 00 3a 00 00
[   35.060967] SCSI device sda: drive cache: write back
[   35.086940]  sda: sda1 sda2
[   35.149760] sd 0:0:0:0: Attached scsi disk sda
[   35.185542] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[   35.211369] Uniform CD-ROM driver Revision: 3.20
[   35.237311] sr 0:0:1:0: Attached scsi CD-ROM sr0

There's only one minor detail - although the CD is (AFAIK) a UDMA/33 device,
the hard drive and the controller are both able to do UDMA/100.

Now admittedly, the ide driver wasn't able to figure that out *either*, so
in a /etc/rc script I had:   '/sbin/hdparm -X udma5'.  But alas, that doesn't
work:

# hdparm -X udma5 /dev/sda 

/dev/sda:
 setting xfermode to 69 (UltraDMA mode5)
 HDIO_DRIVE_CMD(setxfermode) failed: Input/output error


1) How do I do the equivalent for a libata device?  Googling seems to hint
that hdparm can do it with a mythical patch by Jeff Garzik..

2) Should the kernel be able to autodetect it, and if so, what can I do
to help the code figure it out?

--==_Exmh_1152246488_3190P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEreLYcC3lWbTT17ARAseqAKDXP1FBmcjZaP7U/lHbsxk1271SaACfawIp
EiN5BYQIbu2AJUvwyGjpV0U=
=m/iG
-----END PGP SIGNATURE-----

--==_Exmh_1152246488_3190P--
