Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUKGCfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUKGCfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUKGCfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:35:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16902 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261519AbUKGCeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:34:10 -0500
Date: Sun, 7 Nov 2004 03:33:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small IDE cleanups
Message-ID: <20041107023336.GC14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following small cleanups in the IDE code:
- make some needlessly global code static
- remove two unused functions from pdc202xx_new.c

Please review and apply if it's correct.


diffstat output:
 drivers/ide/ide-cd.c           |    6 +--
 drivers/ide/ide-cd.h           |    6 +--
 drivers/ide/ide-disk.c         |    4 +-
 drivers/ide/ide-probe.c        |    2 -
 drivers/ide/legacy/hd.c        |    8 ++--
 drivers/ide/legacy/qd65xx.c    |    2 -
 drivers/ide/legacy/qd65xx.h    |    2 -
 drivers/ide/pci/aec62xx.h      |    4 +-
 drivers/ide/pci/cs5520.c       |    2 -
 drivers/ide/pci/cy82c693.c     |    2 -
 drivers/ide/pci/hpt366.h       |   38 +++++++++++-----------
 drivers/ide/pci/pdc202xx_new.c |   56 ---------------------------------
 drivers/ide/pci/pdc202xx_old.c |    2 -
 drivers/ide/pci/sc1200.c       |    4 +-
 drivers/ide/pci/serverworks.h  |    2 -
 drivers/ide/pci/trm290.c       |    2 -
 16 files changed, 43 insertions(+), 99 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/ide/ide-cd.h.old	2004-11-07 02:53:22.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/ide-cd.h	2004-11-07 02:53:57.000000000 +0100
@@ -519,7 +519,7 @@
 
  /* The generic packet command opcodes for CD/DVD Logical Units,
  * From Table 57 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */ 
-const struct {
+static const struct {
 	unsigned short packet_command;
 	const char * const text;
 } packet_command_texts[] = {
@@ -577,7 +577,7 @@
 
 
 /* From Table 303 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
-const char * const sense_key_texts[16] = {
+static const char * const sense_key_texts[16] = {
 	"No sense data",
 	"Recovered error",
 	"Not ready",
@@ -597,7 +597,7 @@
 };
 
 /* From Table 304 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
-const struct {
+static const struct {
 	unsigned long asc_ascq;
 	const char * const text;
 } sense_data_texts[] = {
--- linux-2.6.10-rc1-mm3-full/drivers/ide/ide-cd.c.old	2004-11-07 02:54:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/ide-cd.c	2004-11-07 02:54:41.000000000 +0100
@@ -562,7 +562,7 @@
 /*
  * ide_error() takes action based on the error returned by the drive.
  */
-ide_startstop_t ide_cdrom_error (ide_drive_t *drive, const char *msg, byte stat)
+static ide_startstop_t ide_cdrom_error (ide_drive_t *drive, const char *msg, byte stat)
 {
 	struct request *rq;
 	byte err;
@@ -598,7 +598,7 @@
 	return ide_stopped;
 }
 
-ide_startstop_t ide_cdrom_abort (ide_drive_t *drive, const char *msg)
+static ide_startstop_t ide_cdrom_abort (ide_drive_t *drive, const char *msg)
 {
 	struct request *rq;
 
@@ -3430,7 +3430,7 @@
 };
 
 /* options */
-char *ignore = NULL;
+static char *ignore = NULL;
 
 module_param(ignore, charp, 0400);
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
--- linux-2.6.10-rc1-mm3-full/drivers/ide/ide-disk.c.old	2004-11-07 02:55:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/ide-disk.c	2004-11-07 02:55:34.000000000 +0100
@@ -394,7 +394,7 @@
 	return err;
 }
 
-ide_startstop_t idedisk_error (ide_drive_t *drive, const char *msg, u8 stat)
+static ide_startstop_t idedisk_error (ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif;
 	struct request *rq;
@@ -454,7 +454,7 @@
 	return ide_stopped;
 }
 
-ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
+static ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
 {
 	ide_hwif_t *hwif;
 	struct request *rq;
--- linux-2.6.10-rc1-mm3-full/drivers/ide/ide-probe.c.old	2004-11-07 02:57:13.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/ide-probe.c	2004-11-07 02:57:27.000000000 +0100
@@ -1116,7 +1116,7 @@
 
 extern ide_driver_t idedefault_driver;
 
-struct kobject *ata_probe(dev_t dev, int *part, void *data)
+static struct kobject *ata_probe(dev_t dev, int *part, void *data)
 {
 	ide_hwif_t *hwif = data;
 	int unit = *part >> PARTN_BITS;
--- linux-2.6.10-rc1-mm3-full/drivers/ide/legacy/hd.c.old	2004-11-07 02:59:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/legacy/hd.c	2004-11-07 03:00:37.000000000 +0100
@@ -174,7 +174,7 @@
 }
 #endif
 
-void __init hd_setup(char *str, int *ints)
+static void __init hd_setup(char *str, int *ints)
 {
 	int hdind = 0;
 
@@ -239,7 +239,7 @@
 #endif
 }
 
-void check_status(void)
+static void check_status(void)
 {
 	int i = inb_p(HD_STATUS);
 
@@ -386,7 +386,7 @@
  * drive enters "idle", "standby", or "sleep" mode, so if the status looks
  * "good", we just ignore the interrupt completely.
  */
-void unexpected_hd_interrupt(void)
+static void unexpected_hd_interrupt(void)
 {
 	unsigned int stat = inb_p(HD_STATUS);
 
@@ -551,7 +551,7 @@
 	enable_irq(HD_IRQ);
 }
 
-int do_special_op(struct hd_i_struct *disk, struct request *req)
+static int do_special_op(struct hd_i_struct *disk, struct request *req)
 {
 	if (disk->recalibrate) {
 		disk->recalibrate = 0;
--- linux-2.6.10-rc1-mm3-full/drivers/ide/legacy/qd65xx.h.old	2004-11-07 03:01:27.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/legacy/qd65xx.h	2004-11-07 03:01:40.000000000 +0100
@@ -46,7 +46,7 @@
 
 /* Drive specific timing taken from DOS driver v3.7 */
 
-struct qd65xx_timing_s {
+static struct qd65xx_timing_s {
 	s8	offset;   /* ofset from the beginning of Model Number" */
 	char	model[4];    /* 4 chars from Model number, no conversion */
 	s16	active;   /* active time */
--- linux-2.6.10-rc1-mm3-full/drivers/ide/legacy/qd65xx.c.old	2004-11-07 03:01:32.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/legacy/qd65xx.c	2004-11-07 03:01:54.000000000 +0100
@@ -101,7 +101,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-u8 __init qd_read_reg (unsigned long reg)
+static u8 __init qd_read_reg (unsigned long reg)
 {
 	unsigned long flags;
 	u8 read;
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/aec62xx.h.old	2004-11-07 03:02:22.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/aec62xx.h	2004-11-07 03:02:40.000000000 +0100
@@ -11,7 +11,7 @@
 	byte		ultra_settings;
 };
 
-struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
+static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
 	{	XFER_UDMA_6,	0x31,	0x07	},
 	{	XFER_UDMA_5,	0x31,	0x06	},
 	{	XFER_UDMA_4,	0x31,	0x05	},
@@ -31,7 +31,7 @@
 	{	0,		0x00,	0x00	}
 };
 
-struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
+static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
 	{	XFER_UDMA_6,	0x41,	0x06	},
 	{	XFER_UDMA_5,	0x41,	0x05	},
 	{	XFER_UDMA_4,	0x41,	0x04	},
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/cs5520.c.old	2004-11-07 03:02:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/cs5520.c	2004-11-07 03:03:08.000000000 +0100
@@ -58,7 +58,7 @@
 	int recovery;
 };
 
-struct pio_clocks cs5520_pio_clocks[]={
+static struct pio_clocks cs5520_pio_clocks[]={
 	{3, 6, 11},
 	{2, 5, 6},
 	{1, 4, 3},
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/cy82c693.c.old	2004-11-07 03:06:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/cy82c693.c	2004-11-07 03:06:16.000000000 +0100
@@ -183,7 +183,7 @@
 /* 
  * used to set DMA mode for CY82C693 (single and multi modes)
  */
-int cy82c693_ide_dma_on (ide_drive_t *drive)
+static int cy82c693_ide_dma_on (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/hpt366.h.old	2004-11-07 03:07:14.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/hpt366.h	2004-11-07 03:10:09.000000000 +0100
@@ -10,7 +10,7 @@
 #undef HPT_DELAY_INTERRUPT
 #undef HPT_SERIALIZE_IO
 
-const char *quirk_drives[] = {
+static const char *quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
 	"QUANTUM FIREBALLP KA6.4",
 	"QUANTUM FIREBALLP LM20.4",
@@ -18,7 +18,7 @@
         NULL
 };
 
-const char *bad_ata100_5[] = {
+static const char *bad_ata100_5[] = {
 	"IBM-DTLA-307075",
 	"IBM-DTLA-307060",
 	"IBM-DTLA-307045",
@@ -37,7 +37,7 @@
 	NULL
 };
 
-const char *bad_ata66_4[] = {
+static const char *bad_ata66_4[] = {
 	"IBM-DTLA-307075",
 	"IBM-DTLA-307060",
 	"IBM-DTLA-307045",
@@ -56,12 +56,12 @@
 	NULL
 };
 
-const char *bad_ata66_3[] = {
+static const char *bad_ata66_3[] = {
 	"WDC AC310200R",
 	NULL
 };
 
-const char *bad_ata33[] = {
+static const char *bad_ata33[] = {
 	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3", "Maxtor 90845U3", "Maxtor 90650U2",
 	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5", "Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
 	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6", "Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
@@ -99,7 +99,7 @@
  *        PIO.
  * 31     FIFO enable.
  */
-struct chipset_bus_clock_list_entry forty_base_hpt366[] = {
+static struct chipset_bus_clock_list_entry forty_base_hpt366[] = {
 	{	XFER_UDMA_4,	0x900fd943	},
 	{	XFER_UDMA_3,	0x900ad943	},
 	{	XFER_UDMA_2,	0x900bd943	},
@@ -118,7 +118,7 @@
 	{	0,		0x0120d9d9	}
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
 	{	XFER_UDMA_4,	0x90c9a731	},
 	{	XFER_UDMA_3,	0x90cfa731	},
 	{	XFER_UDMA_2,	0x90caa731	},
@@ -137,7 +137,7 @@
 	{	0,		0x0120a7a7	}
 };
 
-struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
+static struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
 
 	{	XFER_UDMA_4,	0x90c98521	},
 	{	XFER_UDMA_3,	0x90cf8521	},
@@ -158,7 +158,7 @@
 };
 
 /* from highpoint documentation. these are old values */
-struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
 /*	{	XFER_UDMA_5,	0x1A85F442,	0x16454e31	}, */
 	{	XFER_UDMA_5,	0x16454e31	},
 	{	XFER_UDMA_4,	0x16454e31	},
@@ -179,7 +179,7 @@
 	{	0,		0x06514e57	}
 };
 
-struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
 	{       XFER_UDMA_5,    0x14846231      },
 	{       XFER_UDMA_4,    0x14886231      },
 	{       XFER_UDMA_3,    0x148c6231      },
@@ -200,7 +200,7 @@
 };
 
 /* these are the current (4 sep 2001) timings from highpoint */
-struct chipset_bus_clock_list_entry thirty_three_base_hpt370a[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt370a[] = {
         {       XFER_UDMA_5,    0x12446231      },
         {       XFER_UDMA_4,    0x12446231      },
         {       XFER_UDMA_3,    0x126c6231      },
@@ -221,7 +221,7 @@
 };
 
 /* 2x 33MHz timings */
-struct chipset_bus_clock_list_entry sixty_six_base_hpt370a[] = {
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt370a[] = {
 	{       XFER_UDMA_5,    0x1488e673       },
 	{       XFER_UDMA_4,    0x1488e673       },
 	{       XFER_UDMA_3,    0x1498e673       },
@@ -241,7 +241,7 @@
 	{       0,              0x0d02bf5f       }
 };
 
-struct chipset_bus_clock_list_entry fifty_base_hpt370a[] = {
+static struct chipset_bus_clock_list_entry fifty_base_hpt370a[] = {
 	{       XFER_UDMA_5,    0x12848242      },
 	{       XFER_UDMA_4,    0x12ac8242      },
 	{       XFER_UDMA_3,    0x128c8242      },
@@ -261,7 +261,7 @@
 	{       0,              0x0ac1f48a      }
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
 	{	XFER_UDMA_6,	0x1c81dc62	},
 	{	XFER_UDMA_5,	0x1c6ddc62	},
 	{	XFER_UDMA_4,	0x1c8ddc62	},
@@ -282,7 +282,7 @@
 	{	0,		0x0d029d5e	}
 };
 
-struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
+static struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
 	{	XFER_UDMA_5,	0x12848242	},
 	{	XFER_UDMA_4,	0x12ac8242	},
 	{	XFER_UDMA_3,	0x128c8242	},
@@ -302,7 +302,7 @@
 	{	0,		0x0a81f443	}
 };
 
-struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
 	{	XFER_UDMA_6,	0x1c869c62	},
 	{	XFER_UDMA_5,	0x1cae9c62	},
 	{	XFER_UDMA_4,	0x1c8a9c62	},
@@ -323,7 +323,7 @@
 	{	0,		0x0d029d26	}
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
 	{	XFER_UDMA_6,	0x12808242	},
 	{	XFER_UDMA_5,	0x12848242	},
 	{	XFER_UDMA_4,	0x12ac8242	},
@@ -345,7 +345,7 @@
 };
 
 #if 0
-struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
+static struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
 	{	XFER_UDMA_6,	},
 	{	XFER_UDMA_5,	},
 	{	XFER_UDMA_4,	},
@@ -365,7 +365,7 @@
 };
 #endif
 #if 0
-struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
 	{	XFER_UDMA_6,	0x12406231	},	/* checkme */
 	{	XFER_UDMA_5,	0x12446231	},
 				0x14846231
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/pdc202xx_new.c.old	2004-11-07 03:13:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/pdc202xx_new.c	2004-11-07 03:13:37.000000000 +0100
@@ -234,62 +234,6 @@
 		HWIF(drive)->channel ? "Secondary" : "Primary");
 }
 
-static void pdcnew_reset_host (ide_hwif_t *hwif)
-{
-//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
-	unsigned long high_16	= hwif->dma_master;
-	u8 udma_speed_flag	= hwif->INB(high_16|0x001f);
-
-	hwif->OUTB((udma_speed_flag | 0x10), (high_16|0x001f));
-	mdelay(100);
-	hwif->OUTB((udma_speed_flag & ~0x10), (high_16|0x001f));
-	mdelay(2000);	/* 2 seconds ?! */
-
-	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
-		hwif->channel ? "Secondary" : "Primary");
-}
-
-void pdcnew_reset (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	ide_hwif_t *mate	= hwif->mate;
-	
-	pdcnew_reset_host(hwif);
-	pdcnew_reset_host(mate);
-#if 0
-	/*
-	 * FIXME: Have to kick all the drives again :-/
-	 * What a pain in the ACE!
-	 */
-	if (hwif->present) {
-		u16 hunit = 0;
-		for (hunit = 0; hunit < MAX_DRIVES; ++hunit) {
-			ide_drive_t *hdrive = &hwif->drives[hunit];
-			if (hdrive->present) {
-				if (hwif->ide_dma_check)
-					hwif->ide_dma_check(hdrive);
-				else
-					hwif->tuneproc(hdrive, 5);
-			}
-		}
-	}
-	if (mate->present) {
-		u16 munit = 0;
-		for (munit = 0; munit < MAX_DRIVES; ++munit) {
-			ide_drive_t *mdrive = &mate->drives[munit];
-			if (mdrive->present) {
-				if (mate->ide_dma_check) 
-					mate->ide_dma_check(mdrive);
-				else
-					mate->tuneproc(mdrive, 5);
-			}
-		}
-	}
-#else
-	hwif->tuneproc(drive, 5);
-#endif
-}
-
 #ifdef CONFIG_PPC_PMAC
 static void __devinit apple_kiwi_init(struct pci_dev *pdev)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/pdc202xx_old.c.old	2004-11-07 03:13:53.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/pdc202xx_old.c	2004-11-07 03:14:09.000000000 +0100
@@ -457,7 +457,7 @@
 		hwif->channel ? "Secondary" : "Primary");
 }
 
-void pdc202xx_reset (ide_drive_t *drive)
+static void pdc202xx_reset (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	ide_hwif_t *mate	= hwif->mate;
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/sc1200.c.old	2004-11-07 03:14:32.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/sc1200.c	2004-11-07 03:14:47.000000000 +0100
@@ -72,7 +72,7 @@
 /*
  * Set a new transfer mode at the drive
  */
-int sc1200_set_xfer_mode (ide_drive_t *drive, byte mode)
+static int sc1200_set_xfer_mode (ide_drive_t *drive, byte mode)
 {
 	printk("%s: sc1200_set_xfer_mode(%s)\n", drive->name, ide_xfer_verbose(mode));
 	return ide_config_drive_speed(drive, mode);
@@ -263,7 +263,7 @@
  *
  *  returns 1 on error, 0 otherwise
  */
-int sc1200_ide_dma_end (ide_drive_t *drive)
+static int sc1200_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long dma_base = hwif->dma_base;
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/serverworks.h.old	2004-11-07 03:15:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/serverworks.h	2004-11-07 03:15:16.000000000 +0100
@@ -13,7 +13,7 @@
 
 /* Seagate Barracuda ATA IV Family drives in UDMA mode 5
  * can overrun their FIFOs when used with the CSB5 */
-const char *svwks_bad_ata100[] = {
+static const char *svwks_bad_ata100[] = {
 	"ST320011A",
 	"ST340016A",
 	"ST360021A",
--- linux-2.6.10-rc1-mm3-full/drivers/ide/pci/trm290.c.old	2004-11-07 03:15:34.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/ide/pci/trm290.c	2004-11-07 03:15:43.000000000 +0100
@@ -249,7 +249,7 @@
 /*
  * Invoked from ide-dma.c at boot time.
  */
-void __devinit init_hwif_trm290(ide_hwif_t *hwif)
+static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
 	unsigned int cfgbase = 0;
 	unsigned long flags;

