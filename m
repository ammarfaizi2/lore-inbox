Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbUJ0NRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUJ0NRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0NRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:17:06 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:37256 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262429AbUJ0NHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:07:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=FQdV3bcZzirCyRGbA1X6UP3w0zIUtFH+EeODPUvOtCaScGKfOahRWfiZeDtRfwPNh80FauRpU5bUG6ksYhPuRv9FXsGPBS5Rplz6DEJJRbE2/cb4MRipDSGof/PYbFhAd3oI2ugKzVItmkYtTmCmpD9q9MoM0M2MuE2vAyxQTsM=
Message-ID: <58cb370e04102706074c20d6d7@mail.gmail.com>
Date: Wed, 27 Oct 2004 15:07:14 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: torvalds@osdl.org
Subject: [BK PATCHES] ide-2.6 update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/ide-disk.c         |    1 +
 drivers/ide/ide-dma.c          |   32 ++++++++++++++++++++++++++++++++
 drivers/ide/ide-iops.c         |   12 ------------
 drivers/ide/ide-probe.c        |    2 ++
 drivers/ide/ide-taskfile.c     |   33 ++++-----------------------------
 drivers/ide/pci/aec62xx.c      |   34 +++++++---------------------------
 drivers/ide/pci/amd74xx.c      |    4 ++--
 drivers/ide/pci/atiixp.c       |   34 +++++++---------------------------
 drivers/ide/pci/cmd64x.c       |   34 +++++++---------------------------
 drivers/ide/pci/hpt34x.c       |   38 +++++++++-----------------------------
 drivers/ide/pci/hpt366.c       |   33 +++++++--------------------------
 drivers/ide/pci/it8172.c       |   34 +++++++---------------------------
 drivers/ide/pci/pdc202xx_new.c |   35 +++++++----------------------------
 drivers/ide/pci/pdc202xx_old.c |   38 +++++++++-----------------------------
 drivers/ide/pci/piix.c         |   16 +---------------
 drivers/ide/pci/serverworks.c  |   36 +++++++-----------------------------
 drivers/ide/pci/siimage.c      |   33 ++++++---------------------------
 drivers/ide/pci/sis5513.c      |   34 +++++++---------------------------
 drivers/ide/pci/slc90e66.c     |   33 ++++++---------------------------
 drivers/ide/pci/triflex.c      |   25 ++++++++-----------------
 include/asm-generic/pci.h      |    7 +++++++
 include/asm-ppc64/machdep.h    |    3 +++
 include/asm-ppc64/pci.h        |   11 ++++++++++-
 include/linux/ide.h            |    7 ++-----
 24 files changed, 158 insertions(+), 411 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/26 1.2196)
   [ide] remove needless exports from ide-taskfile.c
   
   Also remove unused MAX_DMA define.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/26 1.2195)
   [ide] add ide_use_dma()
   
   Should prevent bugs like the recent piix one in the future.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/26 1.2194)
   [ide] add pci_get_legacy_ide_irq()
   
   This patch adds pci_get_legacy_ide_irq() to the PCI layer for dealing
   with PCI IDE chipsets that use the "legacy mode" IRQ routing, thus
   violating the normal PCI routing.  The generic implementation provides
   IRQ numbers 14 and 15, and it adds a ppc64 specific one with platform
   callbacks so that a plaform can provide different IRQ numbers for "legacy"
   IDE.  I only fixed the amd7xxx.c driver for now, I expect people using
   this interface will slowly fix their drivers (I will fix via soon as I'll
   need it too, and maybe a few others).
   
   Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/26 1.2193)
   [ide] remove unused internal exports from ide core
   
   From: Arjan van de Ven <arjan@fenrus.demon.nl>
   
   ide-iops.c exports a few functions that either have no users or have no
   users AND shouldn't be used by drivers; the patch below unexports them.
   
   -EXPORT_SYMBOL(SELECT_INTERRUPT);
   -EXPORT_SYMBOL(SELECT_MASK);
   -EXPORT_SYMBOL(QUIRK_LIST);
   -EXPORT_SYMBOL(ata_vlb_sync);
   
   only used in the core ide code
   
   -EXPORT_SYMBOL(ata_input_data);
   -EXPORT_SYMBOL(ata_output_data);
   
   drivers should (and do) use the hwif-> function pointer variant of these,
   these functions are internal and used for setting the default hwif->
   function pointers only. No need to export, in fact exporting is only asking
   for accidents
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/26 1.2192)
   [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265
   
   From: Krzysztof Chmielewski <k.chmielewski@neostrada.pl>
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/26 1.2191)
   [ide] ide-probe: undecoded slave fixup
   
   Undecoded slave fixup is a oneliner patch to ide-probe to
   recognize both of my Maxtor drives that appear to have the same
   serial number, D3000000.
   
   Signed-off-by: tabris@tabris.net
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/26 1.2190)
   [ide] ide-disk: fix /proc/ide/hd?/smart_thresholds
   
   Add missing ->data_phase assignment.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/ide-disk.c	2004-10-26 23:09:56 +02:00
@@ -815,6 +815,7 @@
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
+	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf);
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/ide-dma.c	2004-10-26 23:09:56 +02:00
@@ -681,6 +681,38 @@
 
 EXPORT_SYMBOL(__ide_dma_good_drive);
 
+int ide_use_dma(ide_drive_t *drive)
+{
+	struct hd_driveid *id = drive->id;
+	ide_hwif_t *hwif = drive->hwif;
+
+	/* consult the list of known "bad" drives */
+	if (__ide_dma_bad_drive(drive))
+		return 0;
+
+	/* capable of UltraDMA modes */
+	if (id->field_valid & 4) {
+		if (hwif->ultra_mask & id->dma_ultra)
+			return 1;
+	}
+
+	/* capable of regular DMA modes */
+	if (id->field_valid & 2) {
+		if (hwif->mwdma_mask & id->dma_mword)
+			return 1;
+		if (hwif->swdma_mask & id->dma_1word)
+			return 1;
+	}
+
+	/* consult the list of known "good" drives */
+	if (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)
+		return 1;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ide_use_dma);
+
 void ide_dma_verbose(ide_drive_t *drive)
 {
 	struct hd_driveid *id	= drive->id;
diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/ide-iops.c	2004-10-26 23:09:56 +02:00
@@ -221,24 +221,18 @@
 		HWIF(drive)->OUTB(drive->ctl|2, IDE_CONTROL_REG);
 }
 
-EXPORT_SYMBOL(SELECT_INTERRUPT);
-
 void SELECT_MASK (ide_drive_t *drive, int mask)
 {
 	if (HWIF(drive)->maskproc)
 		HWIF(drive)->maskproc(drive, mask);
 }
 
-EXPORT_SYMBOL(SELECT_MASK);
-
 void QUIRK_LIST (ide_drive_t *drive)
 {
 	if (HWIF(drive)->quirkproc)
 		drive->quirk_list = HWIF(drive)->quirkproc(drive);
 }
 
-EXPORT_SYMBOL(QUIRK_LIST);
-
 /*
  * Some localbus EIDE interfaces require a special access sequence
  * when using 32-bit I/O instructions to transfer data.  We call this
@@ -253,8 +247,6 @@
 	(void) HWIF(drive)->INB(port);
 }
 
-EXPORT_SYMBOL(ata_vlb_sync);
-
 /*
  * This is used for most PIO data transfers *from* the IDE interface
  */
@@ -277,8 +269,6 @@
 	}
 }
 
-EXPORT_SYMBOL(ata_input_data);
-
 /*
  * This is used for most PIO data transfers *to* the IDE interface
  */
@@ -300,8 +290,6 @@
 		hwif->OUTSW(IDE_DATA_REG, buffer, wcount<<1);
 	}
 }
-
-EXPORT_SYMBOL(ata_output_data);
 
 /*
  * The following routines are mainly used by the ATAPI drivers.
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/ide-probe.c	2004-10-26 23:09:56 +02:00
@@ -730,6 +730,8 @@
 			    /* And beware of confused Maxtor drives that go "M0000000000"
 			      "The SN# is garbage in the ID block..." [Eric] */
 			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&
+			    /* Same goes for another set of Maxtor drives that say "D3000000" */
+			    strncmp(drive->id->serial_no, "D3000000", 8) &&
 			    strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0) {
 				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
 				drive->present = 0;
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/ide-taskfile.c	2004-10-26 23:09:56 +02:00
@@ -63,17 +63,14 @@
 	}
 }
 
-
-void taskfile_input_data (ide_drive_t *drive, void *buffer, u32 wcount)
+static void taskfile_input_data(ide_drive_t *drive, void *buffer, u32 wcount)
 {
 	HWIF(drive)->ata_input_data(drive, buffer, wcount);
 	if (drive->bswap)
 		ata_bswap_data(buffer, wcount);
 }
 
-EXPORT_SYMBOL(taskfile_input_data);
-
-void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
+static void taskfile_output_data(ide_drive_t *drive, void *buffer, u32 wcount)
 {
 	if (drive->bswap) {
 		ata_bswap_data(buffer, wcount);
@@ -84,8 +81,6 @@
 	}
 }
 
-EXPORT_SYMBOL(taskfile_output_data);
-
 int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
 {
 	ide_task_t args;
@@ -101,8 +96,6 @@
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
-EXPORT_SYMBOL(taskfile_lib_get_identify);
-
 ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -470,7 +463,7 @@
 }
 EXPORT_SYMBOL(pre_task_out_intr);
 
-int ide_diag_taskfile (ide_drive_t *drive, ide_task_t *args, unsigned
long data_size, u8 *buf)
+static int ide_diag_taskfile(ide_drive_t *drive, ide_task_t *args,
unsigned long data_size, u8 *buf)
 {
 	struct request rq;
 
@@ -507,8 +500,6 @@
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-EXPORT_SYMBOL(ide_diag_taskfile);
-
 int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
 {
 	return ide_diag_taskfile(drive, args, 0, buf);
@@ -516,10 +507,6 @@
 
 EXPORT_SYMBOL(ide_raw_taskfile);
 
-#define MAX_DMA		(256*SECTOR_WORDS)
-
-ide_startstop_t flagged_taskfile(ide_drive_t *, ide_task_t *);
-
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd,
unsigned long arg)
 {
 	ide_task_request_t	*req_task;
@@ -670,8 +657,6 @@
 	return err;
 }
 
-EXPORT_SYMBOL(ide_taskfile_ioctl);
-
 int ide_wait_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, u8 feature,
u8 sectors, u8 *buf)
 {
 	struct request rq;
@@ -689,8 +674,6 @@
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-EXPORT_SYMBOL(ide_wait_cmd);
-
 /*
  * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
  */
@@ -748,9 +731,7 @@
 	return err;
 }
 
-EXPORT_SYMBOL(ide_cmd_ioctl);
-
-int ide_wait_cmd_task (ide_drive_t *drive, u8 *buf)
+static int ide_wait_cmd_task(ide_drive_t *drive, u8 *buf)
 {
 	struct request rq;
 
@@ -760,8 +741,6 @@
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-EXPORT_SYMBOL(ide_wait_cmd_task);
-
 /*
  * FIXME : this needs to map into at taskfile. <andre@linux-ide.org>
  */
@@ -780,8 +759,6 @@
 	return err;
 }
 
-EXPORT_SYMBOL(ide_task_ioctl);
-
 /*
  * NOTICE: This is additions from IBM to provide a discrete interface,
  * for selective taskregister access operations.  Nice JOB Klaus!!!
@@ -902,5 +879,3 @@
 
 	return ide_started;
 }
-
-EXPORT_SYMBOL(flagged_taskfile);
diff -Nru a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/aec62xx.c	2004-10-26 23:09:56 +02:00
@@ -189,36 +189,16 @@
 	struct hd_driveid *id	= drive->id;
 
 	if ((id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		aec62xx_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/amd74xx.c	2004-10-26 23:09:56 +02:00
@@ -416,8 +416,8 @@
 {
 	int i;
 
-	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+	if (hwif->irq == 0) /* 0 is bogus but will do for now */
+		hwif->irq = pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
 
 	hwif->autodma = 0;
 
diff -Nru a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/atiixp.c	2004-10-26 23:09:56 +02:00
@@ -261,36 +261,16 @@
 	drive->init_speed = 0;
 
 	if ((id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				if ((id->field_valid & 2) &&
-				    (!atiixp_config_drive_for_dma(drive)))
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!atiixp_config_drive_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!atiixp_config_drive_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (atiixp_config_drive_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
 		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
 		hwif->speedproc(drive, speed);
diff -Nru a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
--- a/drivers/ide/pci/cmd64x.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/cmd64x.c	2004-10-26 23:09:56 +02:00
@@ -441,36 +441,16 @@
 	struct hd_driveid *id	= drive->id;
 
 	if ((id != NULL) && ((id->capability & 1) != 0) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if ((id->field_valid & 4) && cmd64x_ratemask(drive)) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		config_chipset_for_pio(drive, 1);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
--- a/drivers/ide/pci/hpt34x.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/hpt34x.c	2004-10-26 23:09:56 +02:00
@@ -130,40 +130,20 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
-		}
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
 #ifndef CONFIG_HPT34X_AUTODMA
-		return hwif->ide_dma_off_quietly(drive);
+				return hwif->ide_dma_off_quietly(drive);
 #else
-		return hwif->ide_dma_on(drive);
+				return hwif->ide_dma_on(drive);
 #endif
+		}
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		hpt34x_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/hpt366.c	2004-10-26 23:09:56 +02:00
@@ -460,35 +460,16 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if (id->dma_mword & hwif->mwdma_mask) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		hpt3xx_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/it8172.c b/drivers/ide/pci/it8172.c
--- a/drivers/ide/pci/it8172.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/it8172.c	2004-10-26 23:09:56 +02:00
@@ -201,36 +201,16 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = it8172_config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!it8172_config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!it8172_config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (it8172_config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		it8172_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
--- a/drivers/ide/pci/pdc202xx_new.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/pdc202xx_new.c	2004-10-26 23:09:56 +02:00
@@ -189,37 +189,16 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			    (id->eide_dma_time < 150)) {
-				goto no_dma_set;
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/pdc202xx_old.c	2004-10-26 23:09:56 +02:00
@@ -334,37 +334,16 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			    (id->eide_dma_time < 150)) {
-				goto no_dma_set;
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
@@ -585,7 +564,8 @@
 	struct pci_dev *dev = hwif->pci_dev;
 
 	/* PDC20265 has problems with large LBA48 requests */
-	if (dev->device == PCI_DEVICE_ID_PROMISE_20265)
+	if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
+	    (dev->device == PCI_DEVICE_ID_PROMISE_20265))
 		hwif->rqsize = 256;
 
 	hwif->autodma = 0;
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/piix.c	2004-10-26 23:09:56 +02:00
@@ -403,25 +403,11 @@
 
 	if ((id->capability & 1) && drive->autodma) {
 
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-
-		/**
-		 * Try to turn DMA on if:
-		 *  - UDMA or EIDE modes are supported or
-		 *  - drive is a known "good" drive
-		 *
-		 * Checks for best mode supported are down later by
-		 * piix_config_drive_for_dma() -> ide_dma_speed()
-		 */
-		if ((id->field_valid & (4 | 2)) ||
-		    (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)) {
+		if (ide_use_dma(drive)) {
 			if (piix_config_drive_for_dma(drive))
 				return hwif->ide_dma_on(drive);
 		}
 
-		/* For some reason DMA wasn't turned on, so try PIO. */
 		goto fast_ata_pio;
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/serverworks.c	2004-10-26 23:09:56 +02:00
@@ -305,38 +305,16 @@
 	drive->init_speed = 0;
 
 	if ((id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			} else
-				/* UDMA disabled by mask, try other DMA modes */
-				goto try_dma_modes;
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto no_dma_set;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		config_chipset_for_pio(drive);
 		//	hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/siimage.c	2004-10-26 23:09:56 +02:00
@@ -420,37 +420,16 @@
 	struct hd_driveid *id	= drive->id;
 
 	if ((id->capability & 1) != 0 && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
 
-		if ((id->field_valid & 4) && siimage_ratemask(drive)) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		config_chipset_for_pio(drive, 1);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/sis5513.c	2004-10-26 23:09:56 +02:00
@@ -671,36 +671,16 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = config_chipset_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!config_chipset_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!config_chipset_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+
+		if (ide_use_dma(drive)) {
+			if (config_chipset_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		sis5513_tune_drive(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
--- a/drivers/ide/pci/slc90e66.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/slc90e66.c	2004-10-26 23:09:56 +02:00
@@ -178,37 +178,16 @@
 	drive->init_speed = 0;
 
 	if (id && (id->capability & 1) && drive->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			goto fast_ata_pio;
 
-		if (id->field_valid & 4) {
-			if (id->dma_ultra & hwif->ultra_mask) {
-				/* Force if Capable UltraDMA */
-				int dma = slc90e66_config_drive_for_dma(drive);
-				if ((id->field_valid & 2) && !dma)
-					goto try_dma_modes;
-			}
-		} else if (id->field_valid & 2) {
-try_dma_modes:
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask)) {
-				/* Force if Capable regular DMA modes */
-				if (!slc90e66_config_drive_for_dma(drive))
-					goto no_dma_set;
-			}
-		} else if (__ide_dma_good_drive(drive) &&
-			   (id->eide_dma_time < 150)) {
-			/* Consult the list of known "good" drives */
-			if (!slc90e66_config_drive_for_dma(drive))
-				goto no_dma_set;
-		} else {
-			goto fast_ata_pio;
+		if (ide_use_dma(drive)) {
+			if (slc90e66_config_drive_for_dma(drive))
+				return hwif->ide_dma_on(drive);
 		}
-		return hwif->ide_dma_on(drive);
+
+		goto fast_ata_pio;
+
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-no_dma_set:
 		hwif->tuneproc(drive, 5);
 		return hwif->ide_dma_off_quietly(drive);
 	}
diff -Nru a/drivers/ide/pci/triflex.c b/drivers/ide/pci/triflex.c
--- a/drivers/ide/pci/triflex.c	2004-10-26 23:09:56 +02:00
+++ b/drivers/ide/pci/triflex.c	2004-10-26 23:09:56 +02:00
@@ -118,25 +118,16 @@
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
-	
-	if (id && (id->capability & 1) && drive->autodma) {
-		if (__ide_dma_bad_drive(drive))
-			goto tune_pio;
-		if (id->field_valid & 2) {
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-				(id->dma_1word & hwif->swdma_mask)) {
-				if (!triflex_config_drive_for_dma(drive))
-					goto tune_pio;
-			}
-		} else 
-			goto tune_pio;
-	} else {
-tune_pio:
-		hwif->tuneproc(drive, 255);
-		return hwif->ide_dma_off_quietly(drive);
+
+	if ((id->capability & 1) && drive->autodma) {
+		if (ide_use_dma(drive)) {
+			if (triflex_config_drive_for_dma(drive))
+				return hwif->ide_dma_on(drive);
+		}
 	}
 
-	return hwif->ide_dma_on(drive);
+	hwif->tuneproc(drive, 255);
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 static void __init init_hwif_triflex(ide_hwif_t *hwif)
diff -Nru a/include/asm-generic/pci.h b/include/asm-generic/pci.h
--- a/include/asm-generic/pci.h	2004-10-26 23:09:56 +02:00
+++ b/include/asm-generic/pci.h	2004-10-26 23:09:56 +02:00
@@ -24,4 +24,11 @@
 
 #define pcibios_scan_all_fns(a, b)	0
 
+#ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return channel ? 15 : 14;
+}
+#endif /* HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ */
+
 #endif
diff -Nru a/include/asm-ppc64/machdep.h b/include/asm-ppc64/machdep.h
--- a/include/asm-ppc64/machdep.h	2004-10-26 23:09:56 +02:00
+++ b/include/asm-ppc64/machdep.h	2004-10-26 23:09:56 +02:00
@@ -119,6 +119,9 @@
 	/* Check availability of legacy devices like i8042 */
 	int 		(*check_legacy_ioport)(unsigned int baseport);
 
+	/* Get legacy PCI/IDE interrupt mapping */ 
+	int		(*pci_get_legacy_ide_irq)(struct pci_dev *dev, int channel);
+	
 };
 
 extern struct machdep_calls ppc_md;
diff -Nru a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h	2004-10-26 23:09:56 +02:00
+++ b/include/asm-ppc64/pci.h	2004-10-26 23:09:56 +02:00
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
+#include <asm/machdep.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -20,6 +21,8 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+struct pci_dev;
+
 #ifdef CONFIG_PPC_ISERIES
 #define pcibios_scan_all_fns(a, b)	0
 #else
@@ -36,7 +39,13 @@
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
-struct pci_dev;
+#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	if (ppc_md.pci_get_legacy_ide_irq)
+		return ppc_md.pci_get_legacy_ide_irq(dev, channel);
+	return channel ? 15 : 14;
+}
 
 #define HAVE_ARCH_PCI_MWI 1
 static inline int pcibios_prep_mwi(struct pci_dev *dev)
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-26 23:09:56 +02:00
+++ b/include/linux/ide.h	2004-10-26 23:09:56 +02:00
@@ -1302,9 +1302,6 @@
  */
 extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
 
-/* (ide_drive_t *drive, u8 *buf) */
-extern int ide_wait_cmd_task(ide_drive_t *, u8 *);
-
 typedef struct ide_task_s {
 /*
  *	struct hd_drive_task_hdr	tf;
@@ -1349,8 +1346,6 @@
 extern void ata_output_data(ide_drive_t *, void *, u32);
 extern void atapi_input_bytes(ide_drive_t *, void *, u32);
 extern void atapi_output_bytes(ide_drive_t *, void *, u32);
-extern void taskfile_input_data(ide_drive_t *, void *, u32);
-extern void taskfile_output_data(ide_drive_t *, void *, u32);
 
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);
@@ -1491,6 +1486,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
+int ide_use_dma(ide_drive_t *);
 int __ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 
@@ -1516,6 +1512,7 @@
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 #else
+static inline int ide_use_dma(ide_drive_t *drive) { return 0; }
 static inline int __ide_dma_off(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
