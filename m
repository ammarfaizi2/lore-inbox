Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSEaMSZ>; Fri, 31 May 2002 08:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSEaMSY>; Fri, 31 May 2002 08:18:24 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:51717 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S314451AbSEaMST>;
	Fri, 31 May 2002 08:18:19 -0400
Date: Fri, 31 May 2002 16:23:18 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hpt366.c cosmetic cleanups
Message-ID: <20020531122318.GA305@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

attached patch contains some cosmetic cleanups for hpt366.c driver:
	- remove lots of unneeded initializations of local vars;
	- get rid of byte type usage, we have kernelwide u8 type;
	- s/unsigned int/u32/ where needed (args to pci_read_dword());

Patch against 2.5.19, applies (with some offsets) on top IDE 76.=20
Compiles and seems working (for me). Please take a look at it.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hpt366
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/hpt366.c linux/d=
rivers/ide/hpt366.c
--- linux.vanilla/drivers/ide/hpt366.c	Fri May 31 03:38:52 2002
+++ linux/drivers/ide/hpt366.c	Fri May 31 04:03:00 2002
@@ -598,7 +598,7 @@
=20
 static unsigned int hpt_revision(struct pci_dev *dev)
 {
-	unsigned int class_rev;
+	u32 class_rev;
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &=3D 0xff;
=20
@@ -654,7 +654,7 @@
 }
=20
=20
-static unsigned int pci_bus_clock_list(byte speed, struct chipset_bus_cloc=
k_list_entry * chipset_table)
+static unsigned int pci_bus_clock_list(u8 speed, struct chipset_bus_clock_=
list_entry * chipset_table)
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed =3D=3D speed) {
@@ -663,18 +663,17 @@
 	return chipset_table->chipset_settings;
 }
=20
-static void hpt366_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt366_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	struct pci_dev *dev	=3D drive->channel->pci_dev;
-	byte regtime		=3D (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
-	byte regfast		=3D (drive->channel->unit) ? 0x55 : 0x51;
+	u8 regtime =3D (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
+	u8 regfast =3D (drive->channel->unit) ? 0x55 : 0x51;
 			/*
 			 * since the channel is always 0 it does not matter.
 			 */
=20
-	unsigned int reg1	=3D 0;
-	unsigned int reg2	=3D 0;
-	byte drive_fast		=3D 0;
+	u32 reg1, reg2;
+	u8 drive_fast;
=20
 	/*
 	 * Disable the "fast interrupt" prediction.
@@ -699,19 +698,18 @@
 	pci_write_config_dword(dev, regtime, reg2);
 }
=20
-static void hpt368_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt368_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	hpt366_tune_chipset(drive, speed);
 }
=20
-static void hpt370_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt370_tune_chipset(struct ata_device *drive, u8 speed)
 {
-	byte regfast		=3D (drive->channel->unit) ? 0x55 : 0x51;
-	unsigned int list_conf	=3D 0;
-	unsigned int drive_conf =3D 0;
-	unsigned int conf_mask	=3D (speed >=3D XFER_MW_DMA_0) ? 0xc0000000 : 0x30=
070000;
-	byte drive_pci		=3D 0x40 + (drive->dn * 4);
-	byte new_fast, drive_fast		=3D 0;
+	u8 regfast =3D (drive->channel->unit) ? 0x55 : 0x51;
+	u32 list_conf, drive_conf;
+	u32 conf_mask =3D (speed >=3D XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	u8 drive_pci =3D 0x40 + (drive->dn * 4);
+	u8 new_fast, drive_fast;
 	struct pci_dev *dev	=3D drive->channel->pci_dev;
=20
 	/*
@@ -747,14 +745,13 @@
 	pci_write_config_dword(dev, drive_pci, list_conf);
 }
=20
-static void hpt372_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt372_tune_chipset(struct ata_device *drive, u8 speed)
 {
-	byte regfast		=3D (drive->channel->unit) ? 0x55 : 0x51;
-	unsigned int list_conf	=3D 0;
-	unsigned int drive_conf	=3D 0;
-	unsigned int conf_mask	=3D (speed >=3D XFER_MW_DMA_0) ? 0xc0000000 : 0x30=
070000;
-	byte drive_pci		=3D 0x40 + (drive->dn * 4);
-	byte drive_fast		=3D 0;
+	u8 regfast =3D (drive->channel->unit) ? 0x55 : 0x51;
+	u32 list_conf, drive_conf;
+	u32 conf_mask =3D (speed >=3D XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	u8 drive_pci =3D 0x40 + (drive->dn * 4);
+	u8 drive_fast;
 	struct pci_dev *dev	=3D drive->channel->pci_dev;
=20
 	/*
@@ -775,12 +772,12 @@
 	pci_write_config_dword(dev, drive_pci, list_conf);
 }
=20
-static void hpt374_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt374_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	hpt372_tune_chipset(drive, speed);
 }
=20
-static int hpt3xx_tune_chipset(struct ata_device *drive, byte speed)
+static int hpt3xx_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	struct pci_dev *dev =3D drive->channel->pci_dev;
=20
@@ -804,9 +801,9 @@
=20
 static void config_chipset_for_pio(struct ata_device *drive)
 {
-	unsigned short eide_pio_timing[6] =3D {960, 480, 240, 180, 120, 90};
+	static unsigned short eide_pio_timing[6] =3D {960, 480, 240, 180, 120, 90=
};
 	unsigned short xfer_pio =3D drive->id->eide_pio_modes;
-	byte	timing, speed, pio;
+	u8 timing, speed, pio;
=20
 	pio =3D ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
=20
@@ -837,12 +834,12 @@
 			speed =3D (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
 			break;
 	}
-	(void) hpt3xx_tune_chipset(drive, speed);
+	hpt3xx_tune_chipset(drive, speed);
 }
=20
-static void hpt3xx_tune_drive(struct ata_device *drive, byte pio)
+static void hpt3xx_tune_drive(struct ata_device *drive, u8 pio)
 {
-	byte speed;
+	u8 speed;
 	switch(pio) {
 		case 4:		speed =3D XFER_PIO_4;break;
 		case 3:		speed =3D XFER_PIO_3;break;
@@ -858,7 +855,7 @@
 {
 	struct pci_dev *dev =3D drive->channel->pci_dev;
 	int map;
-	byte mode;
+	u8 mode;
=20
 	if (drive->type !=3D ATA_DISK)
 		return 0;
@@ -924,7 +921,7 @@
=20
 	if (drive->quirk_list) {
 		if (hpt_min_rev(dev, 3)) {
-			byte reg5a =3D 0;
+			u8 reg5a;
 			pci_read_config_byte(dev, 0x5a, &reg5a);
 			if (((reg5a & 0x10) >> 4) !=3D mask)
 				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x1=
0));
@@ -997,7 +994,7 @@
=20
 static void hpt366_udma_irq_lost(struct ata_device *drive)
 {
-	u8 reg50h =3D 0, reg52h =3D 0, reg5ah =3D 0;
+	u8 reg50h, reg52h, reg5ah;
=20
 	pci_read_config_byte(drive->channel->pci_dev, 0x50, &reg50h);
 	pci_read_config_byte(drive->channel->pci_dev, 0x52, &reg52h);
@@ -1140,8 +1137,8 @@
 {
 #if 0
 	unsigned long high_16	=3D pci_resource_start(drive->channel->pci_dev, 4);
-	byte reset		=3D (drive->channel->unit) ? 0x80 : 0x40;
-	byte reg59h		=3D 0;
+	u8 reset		=3D (drive->channel->unit) ? 0x80 : 0x40;
+	u8 reg59h;
=20
 	pci_read_config_byte(drive->channel->pci_dev, 0x59, &reg59h);
 	pci_write_config_byte(drive->channel->pci_dev, 0x59, reg59h|reset);
@@ -1154,10 +1151,9 @@
 {
 	struct ata_channel *ch	=3D drive->channel;
 	struct pci_dev *dev	=3D ch->pci_dev;
-	byte reset		=3D (ch->unit) ? 0x80 : 0x40;
-	byte state_reg		=3D (ch->unit) ? 0x57 : 0x53;
-	byte reg59h		=3D 0;
-	byte regXXh		=3D 0;
+	u8 reset =3D (ch->unit) ? 0x80 : 0x40;
+	u8 state_reg =3D (ch->unit) ? 0x57 : 0x53;
+	u8 reg59h, regXXh;
=20
 	if (!ch)
 		return -EINVAL;
@@ -1366,8 +1362,8 @@
=20
 static void __init hpt366_init(struct pci_dev *dev)
 {
-	unsigned int reg1	=3D 0;
-	u8 drive_fast		=3D 0;
+	u32 reg1;
+	u8 drive_fast;
=20
 	/*
 	 * Disable the "fast interrupt" prediction.
@@ -1394,7 +1390,7 @@
=20
 static unsigned int __init hpt366_init_chipset(struct pci_dev *dev)
 {
-	u8 test =3D 0;
+	u8 test;
=20
 	if (dev->resource[PCI_ROM_RESOURCE].start)
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOUR=
CE].start | PCI_ROM_ADDRESS_ENABLE);
@@ -1435,8 +1431,8 @@
=20
 static unsigned int __init hpt366_ata66_check(struct ata_channel *ch)
 {
-	u8 ata66	=3D 0;
-	u8 regmask	=3D (ch->unit) ? 0x01 : 0x02;
+	u8 ata66;
+	u8 regmask =3D (ch->unit) ? 0x01 : 0x02;
=20
 	pci_read_config_byte(ch->pci_dev, 0x5a, &ata66);
 #ifdef DEBUG
@@ -1466,7 +1462,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (ch->dma_base) {
 		if (hpt_min_rev(dev, 3)) {
-			byte reg5ah =3D 0;
+			u8 reg5ah;
 			pci_read_config_byte(dev, 0x5a, &reg5ah);
 			if (reg5ah & 0x10)	/* interrupt force enable */
 				pci_write_config_byte(dev, 0x5a, reg5ah & ~0x10);
@@ -1521,14 +1517,12 @@
=20
 static void __init hpt366_init_dma(struct ata_channel *ch, unsigned long d=
mabase)
 {
-	u8 masterdma =3D 0;
-	u8 slavedma =3D 0;
-	u8 dma_new =3D 0;
-	u8 dma_old =3D inb(dmabase+2);
-	u8 primary	=3D ch->unit ? 0x4b : 0x43;
-	u8 secondary	=3D ch->unit ? 0x4f : 0x47;
+	u8 masterdma, slavedma;
+	u8 dma_old =3D inb(dmabase + 2);
+	u8 dma_new =3D dma_old;
+	u8 primary =3D ch->unit ? 0x4b : 0x43;
+	u8 secondary =3D primary + 4;
=20
-	dma_new =3D dma_old;
 	pci_read_config_byte(ch->pci_dev, primary, &masterdma);
 	pci_read_config_byte(ch->pci_dev, secondary, &slavedma);
=20
@@ -1588,5 +1582,5 @@
 		ata_register_chipset(&chipsets[i]);
 	}
=20
-    return 0;
+	return 0;
 }

--h31gzZEtNLTqOjlF--

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE892s2Bm4rlNOo3YgRAgiEAJ9W795VfFwuvYlfBoWy/aNdy2iC0ACfduXZ
MAqWs7aZtprlin+3RCXjl7A=
=8bDc
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
