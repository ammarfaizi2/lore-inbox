Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbRLZU4G>; Wed, 26 Dec 2001 15:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284948AbRLZUzz>; Wed, 26 Dec 2001 15:55:55 -0500
Received: from tourian.nerim.net ([62.4.16.79]:29458 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S284937AbRLZUze>;
	Wed, 26 Dec 2001 15:55:34 -0500
Message-ID: <3C2A3943.9060408@free.fr>
Date: Wed, 26 Dec 2001 21:55:31 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011220
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: [RFC] SIS5513 ATA100 support
In-Reply-To: <3C27B02B.7070804@free.fr> <3C28CFEA.1010808@free.fr>
Content-Type: multipart/mixed;
 boundary="------------070306040304050605020203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306040304050605020203
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Reads better with attachements.

Hello,

I'm back with new code.

This one doesn't work on my sis735 either :-( but after having
triple-checked my code I don't see why :-((. Time to show the code to
others...

If someone familiar with pci-ide code could just take a quick look...

The goal is only working ata-100 inits. There's code in sis5513.c that
could use a little cleanup but I'll wait working ata-100 inits to work
on that.

You have an edited (commented) diff from original sis5513.c and the real
patch attached.

A complete new sis5513.c is available for more conveniance at :
http://gyver.homeip.net/sis5513.c

LB.


--------------070306040304050605020203
Content-Type: text/plain;
 name="sis.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis.diff"

+++ Add a Flag for chips supporting ata-100 +++

 #define SIS5513_FLAG_ATA_16		0x00000001
 #define SIS5513_FLAG_ATA_33		0x00000002
 #define SIS5513_FLAG_ATA_66		0x00000004
+#define SIS5513_FLAG_ATA_100		0x00000008
 #define SIS5513_FLAG_LATENCY		0x00000010


+++ Holds the flags of the detected chip +++

+static unsigned int capabilities = 0x00000000;
+


+++ Changed flags in order to reflect capabilities +++
??? Are there some chips supporting ata-100 I missed ???

 static const struct {
 	const char *name;
 	unsigned short host_id;
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
 

+++ PIO timing register layout is different for ata-100 use the new one +++
 
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


+++ The masks below were wrong from the beginning +++
 
 	 * Do a blanket clear of active and recovery timings.
 	 */

-	test1 &= ~0x07;
-	test2 &= ~0x0F;
+	test1 &= ~0x0F;
+	test2 &= ~0x07;


+++ UDMA mode timing are set on a different base (10ns instead of 1/2 PCI_CLOCK) +++
+++ and the register layout is different too +++
  
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
@@ -407,10 +450,16 @@
 		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
 		case XFER_PIO_0:
 		default:	 return((int) config_chipset_for_pio(drive, 0));
+		}
 	}
 

+++ Adapt the code to the register layout : 0x80 for UDMA enable +++
+++ doesn't have to use a pci_read_config before as we set the whole register +++

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
@@ -583,6 +632,7 @@
 			continue;


+++ Here (pci_init_sis5513) we store the capabilities flags +++
+++ used everywhere else to activate ata-100 specific code +++

 		host_dev = host;
+		capabilities = SiSHostChipInfo[i].flags;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
 		if (SiSHostChipInfo[i].flags & SIS5513_FLAG_LATENCY) {
@@ -592,12 +642,22 @@
 	}
 

+++ The Compatibility mode bit changed from reg52h bit 2 to reg49h bit 0 +++

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

--------------070306040304050605020203
Content-Type: text/plain;
 name="sis.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis.patch2"

--- /usr/src/linux/drivers/ide/sis5513.c	Fri Sep  7 18:28:38 2001
+++ sis5513.c	Wed Dec 26 21:35:10 2001
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
@@ -229,6 +232,7 @@
 byte sis_proc = 0;
 extern char *ide_xfer_verbose (byte xfer_rate);
 
+/* Enables Prefetch and Postwrite on drive */
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -245,6 +249,7 @@
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
 }
 
+/* Set active and recovery time */
 static void config_art_rwp_pio (ide_drive_t *drive, byte pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -291,6 +296,19 @@
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
 
@@ -298,8 +316,8 @@
 	 * Do a blanket clear of active and recovery timings.
 	 */
 
-	test1 &= ~0x07;
-	test2 &= ~0x0F;
+	test1 &= ~0x0F;
+	test2 &= ~0x07;
 
 	switch(timing) {
 		case 4:		test1 |= 0x01; test2 |= 0x03; break;
@@ -379,6 +397,7 @@
 	pci_read_config_byte(dev, drive_pci, &test1);
 	pci_read_config_byte(dev, drive_pci|0x01, &test2);
 
+	/* If not an UDMA mode switch off udma bit */
 	if ((speed <= XFER_MW_DMA_2) && (test2 & 0x80)) {
 		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~0x80);
 		pci_read_config_byte(dev, drive_pci|0x01, &test2);
@@ -386,7 +405,31 @@
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
@@ -407,10 +450,16 @@
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
@@ -583,6 +632,7 @@
 			continue;
 
 		host_dev = host;
+		capabilities = SiSHostChipInfo[i].flags;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
 		if (SiSHostChipInfo[i].flags & SIS5513_FLAG_LATENCY) {
@@ -592,12 +642,22 @@
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

--------------070306040304050605020203--

