Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbRLaATX>; Sun, 30 Dec 2001 19:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285783AbRLaATP>; Sun, 30 Dec 2001 19:19:15 -0500
Received: from tourian.nerim.net ([62.4.16.79]:34572 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S285747AbRLaAS5>;
	Sun, 30 Dec 2001 19:18:57 -0500
Message-ID: <3C2FAEEE.7010207@free.fr>
Date: Mon, 31 Dec 2001 01:18:54 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011229
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Fremlin <john@fremlin.de>, Chris Shutters <cshutters@ebiz-tech.com>,
        Mike <maneman@gmx.net>, "Bryan O'Sullivan" <bos@serpentine.com>,
        Daniela Engert <dani@ngrt.de>, Linux <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linuxdiskcert.org>
Subject: [PATCH] SIS IDE ATA100 fixup, please test
In-Reply-To: <86n100x1bu.fsf@notus.ireton.fremlin.de>	<3C2F6DE1.9070402@free.fr> <86u1u8z44l.fsf@notus.ireton.fremlin.de>
Content-Type: multipart/mixed;
 boundary="------------090602020807000901030501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090602020807000901030501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

sis5513.c is finally working here accross several cold/warm reboots. The 
system is now running md5sum over huge files in UDMA 5 transfer mode 
simultaneously on 2 drives without error for the last hour.

If you want (sis ide and ATA/100 -> you want) to test it, apply the 
attached diff (done against 2.4.17, ask me if you want a patch against 
another version) or

copy
http://gyver.homeip.net/sis5513.c
to your [linux-src]/drivers/ide directory

Please report any success/failure. In case of failure, please send me 
your kernel SIS5513 boot messages.

As usual, you should backup your data before using this driver, ...

LB.



--------------090602020807000901030501
Content-Type: text/plain;
 name="sis.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis.patch3"

--- linux-orig/drivers/ide/sis5513.c	Fri Sep  7 18:28:38 2001
+++ linux/drivers/ide/sis5513.c	Mon Dec 31 00:06:45 2001
@@ -37,8 +37,11 @@
 #define SIS5513_FLAG_ATA_16		0x00000001
 #define SIS5513_FLAG_ATA_33		0x00000002
 #define SIS5513_FLAG_ATA_66		0x00000004
+#define SIS5513_FLAG_ATA_100		0x00000008
 #define SIS5513_FLAG_LATENCY		0x00000010
 
+static unsigned int capabilities = 0x00000000;
+
 static const struct {
 	const char *name;
 	unsigned short host_id;
@@ -48,15 +51,15 @@
 	{ "SiS540",	PCI_DEVICE_ID_SI_540,	SIS5513_FLAG_ATA_66, },
 	{ "SiS620",	PCI_DEVICE_ID_SI_620,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
 	{ "SiS630",	PCI_DEVICE_ID_SI_630,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS635",	PCI_DEVICE_ID_SI_635,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS635",	PCI_DEVICE_ID_SI_635,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
 	{ "SiS640",	PCI_DEVICE_ID_SI_640,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS645",	PCI_DEVICE_ID_SI_645,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS650",	PCI_DEVICE_ID_SI_650,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS730",	PCI_DEVICE_ID_SI_730,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS735",	PCI_DEVICE_ID_SI_735,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS740",	PCI_DEVICE_ID_SI_740,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS745",	PCI_DEVICE_ID_SI_745,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS750",	PCI_DEVICE_ID_SI_750,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
+	{ "SiS645",	PCI_DEVICE_ID_SI_645,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
+	{ "SiS650",	PCI_DEVICE_ID_SI_650,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
+	{ "SiS730",	PCI_DEVICE_ID_SI_730,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
+	{ "SiS735",	PCI_DEVICE_ID_SI_735,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
+	{ "SiS740",	PCI_DEVICE_ID_SI_740,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
+	{ "SiS745",	PCI_DEVICE_ID_SI_745,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
+	{ "SiS750",	PCI_DEVICE_ID_SI_750,	SIS5513_FLAG_ATA_100|SIS5513_FLAG_LATENCY, },
 	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	SIS5513_FLAG_ATA_33, },
 	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	SIS5513_FLAG_ATA_33, },
 	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	SIS5513_FLAG_ATA_33, },
@@ -148,6 +151,17 @@
 	"6 PCICLK", "12 PCICLK"
 };
 
+static char* cycle_time_ata100[] = {
+	"Reserved", "2 CLK",
+	"3 CLK", "4 CLK",
+	"5 CLK", "6 CLK",
+	"7 CLK", "8 CLK",
+	"9 CLK", "10 CLK",
+	"11 CLK", "12 CLK",
+	"Reserved", "Reserved",
+	"Reserved", "Reserved"
+};
+
 static int sis_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	int rc;
@@ -189,11 +203,19 @@
 	p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
 		     (reg & 0x80)  ? "Enabled" : "Disabled",
 		     (reg1 & 0x80) ? "Enabled" : "Disabled");
-	p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
-		     cycle_time[(reg & 0x70) >> 4], cycle_time[(reg1 & 0x70) >> 4]);
-	p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
-		     active_time[(reg & 0x07)], active_time[(reg1 &0x07)] ); 
-
+	if (capabilities && SIS5513_FLAG_ATA_100) {
+		p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
+			     cycle_time_ata100[reg & 0x0F], cycle_time_ata100[reg1 & 0x0F]);
+		rc = pci_read_config_byte(bmide_dev, 0x40, &reg);
+		rc = pci_read_config_byte(bmide_dev, 0x44, &reg1);
+		p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
+			    active_time[(reg & 0x70) >> 4], active_time[(reg1 & 0x70) >> 4]);
+	} else {
+		p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
+			     cycle_time[(reg & 0x70) >> 4], cycle_time[(reg1 & 0x70) >> 4]);
+		p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
+			     active_time[(reg & 0x07)], active_time[(reg1 &0x07)] ); 
+	}
 	rc = pci_read_config_byte(bmide_dev, 0x40, &reg);
 	rc = pci_read_config_byte(bmide_dev, 0x44, &reg1);
 	p += sprintf(p, "                Data Recovery Time %s \t Data Recovery Time %s\n",
@@ -213,10 +235,19 @@
 	p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
 		     (reg & 0x80)  ? "Enabled" : "Disabled",
 		     (reg1 & 0x80) ? "Enabled" : "Disabled");
-	p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
-		     cycle_time[(reg & 0x70) >> 4], cycle_time[(reg1 & 0x70) >> 4]);
-	p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
-		     active_time[(reg & 0x07)], active_time[(reg1 &0x07)] ); 
+	if (capabilities && SIS5513_FLAG_ATA_100) {
+		p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
+			     cycle_time_ata100[reg & 0x0F], cycle_time_ata100[reg1 & 0x0F]);
+		rc = pci_read_config_byte(bmide_dev, 0x42, &reg);
+		rc = pci_read_config_byte(bmide_dev, 0x46, &reg1);
+		p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
+			    active_time[(reg & 0x70) >> 4], active_time[(reg1 & 0x70) >> 4]);
+	} else {
+		p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
+			     cycle_time[(reg & 0x70) >> 4], cycle_time[(reg1 & 0x70) >> 4]);
+		p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
+			     active_time[(reg & 0x07)], active_time[(reg1 &0x07)] );
+	}
 
 	rc = pci_read_config_byte(bmide_dev, 0x42, &reg);
 	rc = pci_read_config_byte(bmide_dev, 0x46, &reg1);
@@ -229,6 +260,7 @@
 byte sis_proc = 0;
 extern char *ide_xfer_verbose (byte xfer_rate);
 
+/* Enables Prefetch and Postwrite on drive */
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -243,8 +275,10 @@
 	
 	if ((reg4bh & rw_prefetch) != rw_prefetch)
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
+	printk("SIS5513: config_drive_art_rwp, drive %d\n", drive->dn);
 }
 
+/* Set active and recovery time */
 static void config_art_rwp_pio (ide_drive_t *drive, byte pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -274,6 +308,8 @@
 
 	timing = (xfer_pio >= pio) ? xfer_pio : pio;
 
+	printk("SIS5513: config_drive_art_rwp_pio, drive %d, pio %d, timing %d\n",
+	       drive->dn, pio, timing);
 /*
  *               Mode 0       Mode 1     Mode 2     Mode 3     Mode 4
  * Active time    8T (240ns)  6T (180ns) 4T (120ns) 3T  (90ns) 3T  (90ns)
@@ -291,6 +327,19 @@
 		default:	return;
 	}
 
+	if (capabilities && SIS5513_FLAG_ATA_100) {
+		switch(timing) { /*   active  recovery
+					  v     v */
+		case 4:		test1 = 0x30|0x01; break;
+		case 3:		test1 = 0x30|0x03; break;
+		case 2:		test1 = 0x40|0x04; break;
+		case 1:		test1 = 0x60|0x07; break;
+		default:	break;
+		}
+		pci_write_config_byte(dev, drive_pci, test1);
+		return; /* temporary hack for tests */
+	}
+
 	pci_read_config_byte(dev, drive_pci, &test1);
 	pci_read_config_byte(dev, drive_pci|0x01, &test2);
 
@@ -298,8 +347,8 @@
 	 * Do a blanket clear of active and recovery timings.
 	 */
 
-	test1 &= ~0x07;
-	test2 &= ~0x0F;
+	test1 &= ~0x0F;
+	test2 &= ~0x07;
 
 	switch(timing) {
 		case 4:		test1 |= 0x01; test2 |= 0x03; break;
@@ -340,6 +389,9 @@
 	byte			drive_pci, test1, test2;
 	byte			unmask, four_two, mask = 0;
 
+	printk("SIS5513: sis5513_tune_chipset, drive %d, speed %d\n",
+	       drive->dn, speed);
+
 	if (host_dev) {
 		switch(host_dev->device) {
 			case PCI_DEVICE_ID_SI_530:
@@ -379,6 +431,7 @@
 	pci_read_config_byte(dev, drive_pci, &test1);
 	pci_read_config_byte(dev, drive_pci|0x01, &test2);
 
+	/* If not an UDMA mode switch off udma bit */
 	if ((speed <= XFER_MW_DMA_2) && (test2 & 0x80)) {
 		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~0x80);
 		pci_read_config_byte(dev, drive_pci|0x01, &test2);
@@ -386,7 +439,31 @@
 		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~unmask);
 	}
 
-	switch(speed) {
+	if (capabilities & SIS5513_FLAG_ATA_100) {
+		switch(speed) {
+#ifdef CONFIG_BLK_DEV_IDEDMA
+		case XFER_UDMA_5: mask = 0x01; break;
+		case XFER_UDMA_4: mask = 0x02; break;
+		case XFER_UDMA_3: mask = 0x04; break;
+		case XFER_UDMA_2: mask = 0x05; break;
+		case XFER_UDMA_1: mask = 0x07; break;
+		case XFER_UDMA_0: mask = 0x0B; break;
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:
+		case XFER_MW_DMA_0:
+		case XFER_SW_DMA_2:
+		case XFER_SW_DMA_1:
+		case XFER_SW_DMA_0: break;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+		case XFER_PIO_4: return((int) config_chipset_for_pio(drive, 4));
+		case XFER_PIO_3: return((int) config_chipset_for_pio(drive, 3));
+		case XFER_PIO_2: return((int) config_chipset_for_pio(drive, 2));
+		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
+		case XFER_PIO_0:
+		default:	 return((int) config_chipset_for_pio(drive, 0));
+		}
+	} else {
+		switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 		case XFER_UDMA_5: mask = 0x80; break;
 		case XFER_UDMA_4: mask = 0x90; break;
@@ -407,10 +484,16 @@
 		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
 		case XFER_PIO_0:
 		default:	 return((int) config_chipset_for_pio(drive, 0));
+		}
 	}
 
-	if (speed > XFER_MW_DMA_2)
-		pci_write_config_byte(dev, drive_pci|0x01, test2|mask);
+	if (speed > XFER_MW_DMA_2) {
+		if (capabilities & SIS5513_FLAG_ATA_100) {
+			pci_write_config_byte(dev, drive_pci|0x01, 0x80|mask);
+		} else {
+			pci_write_config_byte(dev, drive_pci|0x01, test2|mask);
+		}
+	}
 
 	drive->current_speed = speed;
 	return ((int) ide_config_drive_speed(drive, speed));
@@ -437,6 +520,9 @@
 	byte udma_66		= eighty_ninty_three(drive);
 	byte ultra_100		= 0;
 
+	printk("SIS5513: config_chipset_for_dma, drive %d, ultra %d\n",
+	       drive->dn, ultra);
+
 	if (host_dev) {
 		switch(host_dev->device) {
 			case PCI_DEVICE_ID_SI_635:
@@ -583,6 +669,7 @@
 			continue;
 
 		host_dev = host;
+		capabilities = SiSHostChipInfo[i].flags;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
 		if (SiSHostChipInfo[i].flags & SIS5513_FLAG_LATENCY) {
@@ -592,12 +679,22 @@
 	}
 
 	if (host_dev) {
-		byte reg52h = 0;
+		if (capabilities & SIS5513_FLAG_ATA_100) {
+			byte reg49h = 0;
 
-		pci_read_config_byte(dev, 0x52, &reg52h);
-		if (!(reg52h & 0x04)) {
-			/* set IDE controller to operate in Compabitility mode only */
-			pci_write_config_byte(dev, 0x52, reg52h|0x04);
+			pci_read_config_byte(dev, 0x49, &reg49h);
+			if (!(reg49h & 0x01)) {
+				/* set IDE controller to operate in Compabitility mode only */
+				pci_write_config_byte(dev, 0x49, reg49h|0x01);
+			}
+		} else {
+			byte reg52h = 0;
+
+			pci_read_config_byte(dev, 0x52, &reg52h);
+			if (!(reg52h & 0x04)) {
+				/* set IDE controller to operate in Compabitility mode only */
+				pci_write_config_byte(dev, 0x52, reg52h|0x04);
+			}
 		}
 #if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
 		if (!sis_proc) {

--------------090602020807000901030501--

