Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVBCRD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVBCRD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbVBCRDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:03:00 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62699 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263520AbVBCQvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:51:35 -0500
Date: Thu, 3 Feb 2005 17:47:05 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.58.0502031743240.10376@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here is late ide-2.6 update.  Various small fixes (mainly for nasty
corner cases, from Tejun Heo) and few trivial cleanups for which I
see no reason to wait for 2.6.11.  Please apply.

Bartlomiej

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/pci/adma100.c   |   30 -----------------------------
 drivers/ide/pci/adma100.h   |   28 ---------------------------
 drivers/ide/ide-disk.c      |    5 +---
 drivers/ide/ide-dma.c       |   26 ++++++++++---------------
 drivers/ide/ide-floppy.c    |    4 +--
 drivers/ide/ide-io.c        |   34 +++++++++++++++++----------------
 drivers/ide/ide-iops.c      |   45 ++++++++++++++++++++------------------------
 drivers/ide/ide-pnp.c       |    2 -
 drivers/ide/ide-probe.c     |    6 ++++-
 drivers/ide/ide-tape.c      |    2 -
 drivers/ide/ide-taskfile.c  |    4 +--
 drivers/ide/ide.c           |   10 ++++-----
 drivers/ide/legacy/ide-cs.c |    2 -
 drivers/ide/pci/Makefile    |    1
 drivers/ide/pci/it8172.c    |    4 +--
 drivers/ide/pci/it8172.h    |    3 --
 drivers/ide/pci/opti621.c   |    5 ----
 drivers/ide/pci/opti621.h   |    3 --
 drivers/ide/pci/piix.c      |   16 ---------------
 drivers/ide/pci/piix.h      |    3 --
 drivers/ide/pci/sgiioc4.c   |    3 +-
 drivers/ide/pci/siimage.c   |    2 -
 drivers/scsi/ide-scsi.c     |    8 +++----
 include/linux/ide.h         |   24 +++--------------------
 24 files changed, 83 insertions(+), 187 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/02/03 1.2009)
   [ide] fix printk in ide_allocate_dma_engine()

   With Olaf Hering <olh@suse.de>.

   Parameters were interchanged.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<prarit@sgi.com> (05/02/03 1.2008)
   [ide] fix error handling in probe_hwif_init() and sgiioc4 driver

   From: Prarit Bhargava <prarit@sgi.com>

   I discovered an issue where a hwif_init() failure lead to /proc/ide files
   being created for devices that failed probes.  This resulted in
   oops/WARN_ON/BUG_ON executions through the kernel depending on what
   actions were on going.

   slightly changed by me (bart)

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2007)
   [ide] add ide_hwgroup_t.polling

   ide_hwgroup_t.polling field added.  0 in poll_timeout field
   used to indicate inactive polling but because 0 is a valid
   jiffy value, though slim, there's a chance that something
   weird can happen.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2006)
   [ide] add ide_drive_t.sleeping

   ide_drive_t.sleeping field added.  0 in sleep field used to
   indicate inactive sleeping but because 0 is a valid jiffy
   value, though slim, there's a chance that something can go
   weird.  And while at it, explicit jiffy comparisons are
   converted to use time_before() macros.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2005)
   [ide] comment fixes

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2004)
   [ide] remove NULL checking in ide_error()

   In ide_error(), drive cannot be NULL.  ide_dump_status() can't
   handle NULL drive.

   From: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2003)
   [ide] ide-tape: use time_after() macro

   Explicit jiffy comparision converted to time_after() macro.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2002)
   [ide] __ide_do_rw_disk() return value fix

   In __ide_do_rw_disk(), ide_started used to be returned blindly
   after issusing PIO write.  This can cause hang if
   pre_task_out_intr() returns ide_stopped due to failed
   ide_wait_stat() test.  Fixed to pass the return value of
   pre_task_out_intr().

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2001)
   [ide] __ide_do_rw_disk() lba48 dma check fix

   In __ide_do_rw_disk(), the shifted block, instead of the
   original rq->sector, should be used when checking range for
   lba48 dma.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.2000)
   [ide] cleanup piix

   In drivers/ide/pci/piix.[hc], init_setup_piix() is defined and
   used but only one init_setup function is defined and no
   demultiplexing is done using init_setup callback.  As other
   drivers call ide_setup_pci_device() directly in such cases,
   this patch removes init_setup_piix() and makes piix_init_one()
   call ide_setup_pci_device() directly.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.1999)
   [ide] cleanup opti621

   In drivers/ide/pci/opti612.[hc], init_setup_opti621() is
   declared, defined and referenced but never actually used.
   This patch removes the function.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/03 1.1998)
   [ide] fix it8172 build for real

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.1997)
   [ide] cleanup it8172

   In drivers/ide/pci/it8172.h, it8172_ratefilter() and
   init_setup_it8172() are declared and the latter is referenced
   in it8172_chipsets.  Both functions are not defined or used
   anywhere.  This patch removes the prototypes and reference.
   it8172 should be compilable now.

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tj@home-tj.org> (05/02/03 1.1996)
   [ide] remove adma100

   Removes drivers/ide/pci/adma100.[hc].  The driver isn't
   compilable (missing functions) and no Kconfig actually enables
   CONFIG_BLK_DEV_ADMA100.

   On Wed, 02 Feb 2005 03:31:59 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
   > Also, the libata-dev-2.6 tree has an "ata_adma" driver which is
   > complete, but needs some testing (and I have h/w).

   Signed-off-by: Tejun Heo <tj@home-tj.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bunk@stusta.de> (05/02/03 1.1995)
   [ide] possible cleanups

   This patch contains the following possible cleanups:
   - make some needlessly global code static
   - ide-dma.c: remove the unneeded EXPORT_SYMBOL(__ide_dma_test_irq)

   slightly changed by me (bart)

   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<arjan@infradead.org> (05/02/03 1.1994)
   [ide] unexport atapi_*_bytes() and ide_read_24()

   From: Arjan van de Ven <arjan@infradead.org>

   * make atapi_{input,output}_bytes() static, fix users to use drive->hwif
   * remove ide_read_24() export; it's unused since the ide-io.c reorganization
   * add a FIXME comment to the ide_fix_driveid() export

   slightly changed by me (bart)

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bunk@stusta.de> (05/02/02 1.1993)
   [ide] remove WAIT_READY dependency on APM

   On the one hand APM isn't enabled on all laptops.
   On the other hand, this also affects regular PCs with APM support (or
   using a distribution kernel with APM support).

   The time for the !APM case was already increased from 30msec in 2.4 .
   Isn't there a timeout that is suitable for all cases?

   Alan Cox answered:
   > The five seconds should be just fine for all cases. The smaller value
   > with no
   > power manglement should help speed up recovery however. It probably
   > doesn't belong CONFIG_APM now ACPI and friends are involved either.

   Until someone has a real good solution (consider e.g. that most PC users
   might have ACPI support enabled), this patch unconditionally sets
   WAIT_READY to 5 seconds.

   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-03 17:02:35 +01:00
@@ -132,7 +132,7 @@
 	nsectors.all		= (u16) rq->nr_sectors;

 	if (hwif->no_lba48_dma && lba48 && dma) {
-		if (rq->sector + rq->nr_sectors > 1ULL << 28)
+		if (block + rq->nr_sectors > 1ULL << 28)
 			dma = 0;
 	}

@@ -253,8 +253,7 @@
 		/* FIXME: ->OUTBSYNC ? */
 		hwif->OUTB(command, IDE_COMMAND_REG);

-		pre_task_out_intr(drive, rq);
-		return ide_started;
+		return pre_task_out_intr(drive, rq);
 	}
 }
 EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-dma.c	2005-02-03 17:02:35 +01:00
@@ -227,7 +227,9 @@
  *	the PRD table that the IDE layer wants to be fed. The code
  *	knows about the 64K wrap bug in the CS5530.
  *
- *	Returns 0 if all went okay, returns 1 otherwise.
+ *	Returns the number of built PRD entries if all went okay,
+ *	returns 0 otherwise.
+ *
  *	May also be invoked from trm290.c
  */

@@ -631,7 +633,7 @@
 EXPORT_SYMBOL(__ide_dma_end);

 /* returns 1 if dma irq issued, 0 otherwise */
-int __ide_dma_test_irq (ide_drive_t *drive)
+static int __ide_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_stat		= hwif->INB(hwif->dma_status);
@@ -650,8 +652,6 @@
 			drive->name, __FUNCTION__);
 	return 0;
 }
-
-EXPORT_SYMBOL(__ide_dma_test_irq);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */

 int __ide_dma_bad_drive (ide_drive_t *drive)
@@ -784,7 +784,7 @@
 /*
  * Needed for allowing full modular support of ide-driver
  */
-int ide_release_dma_engine (ide_hwif_t *hwif)
+static int ide_release_dma_engine(ide_hwif_t *hwif)
 {
 	if (hwif->dmatable_cpu) {
 		pci_free_consistent(hwif->pci_dev,
@@ -796,7 +796,7 @@
 	return 1;
 }

-int ide_release_iomio_dma (ide_hwif_t *hwif)
+static int ide_release_iomio_dma(ide_hwif_t *hwif)
 {
 	if ((hwif->dma_extra) && (hwif->channel == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
@@ -820,7 +820,7 @@
 	return ide_release_iomio_dma(hwif);
 }

-int ide_allocate_dma_engine (ide_hwif_t *hwif)
+static int ide_allocate_dma_engine(ide_hwif_t *hwif)
 {
 	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
 						  PRD_ENTRIES * PRD_BYTES,
@@ -830,14 +830,13 @@
 		return 0;

 	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
-		(hwif->dmatable_cpu == NULL) ? " CPU" : "",
-		hwif->cds->name);
+			hwif->cds->name, !hwif->dmatable_cpu ? " CPU" : "");

 	ide_release_dma_engine(hwif);
 	return 1;
 }

-int ide_mapped_mmio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);

@@ -852,7 +851,7 @@
 	return 0;
 }

-int ide_iomio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
 		hwif->name, base, base + ports - 1);
@@ -881,10 +880,7 @@
 	return 0;
 }

-/*
- *
- */
-int ide_dma_iobase (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	if (hwif->mmio == 2)
 		return ide_mapped_mmio_dma(hwif, base,ports);
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-02-03 17:02:35 +01:00
@@ -585,7 +585,7 @@
 			count = min(bvec->bv_len, bcount);

 			data = bvec_kmap_irq(bvec, &flags);
-			atapi_input_bytes(drive, data, count);
+			drive->hwif->atapi_input_bytes(drive, data, count);
 			bvec_kunmap_irq(data, &flags);

 			bcount -= count;
@@ -619,7 +619,7 @@
 			count = min(bvec->bv_len, bcount);

 			data = bvec_kmap_irq(bvec, &flags);
-			atapi_output_bytes(drive, data, count);
+			drive->hwif->atapi_output_bytes(drive, data, count);
 			bvec_kunmap_irq(data, &flags);

 			bcount -= count;
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-03 17:02:35 +01:00
@@ -555,7 +555,7 @@

 	err = ide_dump_status(drive, msg, stat);

-	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+	if ((rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;

 	/* retry only "normal" I/O: */
@@ -933,6 +933,7 @@
 	if (timeout > WAIT_WORSTCASE)
 		timeout = WAIT_WORSTCASE;
 	drive->sleep = timeout + jiffies;
+	drive->sleeping = 1;
 }

 EXPORT_SYMBOL(ide_stall_queue);
@@ -972,18 +973,18 @@
 	}

 	do {
-		if ((!drive->sleep || time_after_eq(jiffies, drive->sleep))
+		if ((!drive->sleeping || time_after_eq(jiffies, drive->sleep))
 		    && !elv_queue_empty(drive->queue)) {
 			if (!best
-			 || (drive->sleep && (!best->sleep || 0 < (signed long)(best->sleep - drive->sleep)))
-			 || (!best->sleep && 0 < (signed long)(WAKEUP(best) - WAKEUP(drive))))
+			 || (drive->sleeping && (!best->sleeping || time_before(drive->sleep, best->sleep)))
+			 || (!best->sleeping && time_before(WAKEUP(drive), WAKEUP(best))))
 			{
 				if (!blk_queue_plugged(drive->queue))
 					best = drive;
 			}
 		}
 	} while ((drive = drive->next) != hwgroup->drive);
-	if (best && best->nice1 && !best->sleep && best != hwgroup->drive && best->service_time > WAIT_MIN_SLEEP) {
+	if (best && best->nice1 && !best->sleeping && best != hwgroup->drive && best->service_time > WAIT_MIN_SLEEP) {
 		long t = (signed long)(WAKEUP(best) - jiffies);
 		if (t >= WAIT_MIN_SLEEP) {
 		/*
@@ -992,10 +993,9 @@
 		 */
 			drive = best->next;
 			do {
-				if (!drive->sleep
-				/* FIXME: use time_before */
-				 && 0 < (signed long)(WAKEUP(drive) - (jiffies - best->service_time))
-				 && 0 < (signed long)((jiffies + t) - WAKEUP(drive)))
+				if (!drive->sleeping
+				 && time_before(jiffies - best->service_time, WAKEUP(drive))
+				 && time_before(WAKEUP(drive), jiffies + t))
 				{
 					ide_stall_queue(best, min_t(long, t, 10 * WAIT_MIN_SLEEP));
 					goto repeat;
@@ -1058,14 +1058,17 @@
 		hwgroup->busy = 1;
 		drive = choose_drive(hwgroup);
 		if (drive == NULL) {
-			unsigned long sleep = 0;
+			int sleeping = 0;
+			unsigned long sleep = 0; /* shut up, gcc */
 			hwgroup->rq = NULL;
 			drive = hwgroup->drive;
 			do {
-				if (drive->sleep && (!sleep || 0 < (signed long)(sleep - drive->sleep)))
+				if (drive->sleeping && (!sleeping || time_before(drive->sleep, sleep))) {
+					sleeping = 1;
 					sleep = drive->sleep;
+				}
 			} while ((drive = drive->next) != hwgroup->drive);
-			if (sleep) {
+			if (sleeping) {
 		/*
 		 * Take a short snooze, and then wake up this hwgroup again.
 		 * This gives other hwgroups on the same a chance to
@@ -1105,7 +1108,7 @@
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
-		drive->sleep = 0;
+		drive->sleeping = 0;
 		drive->service_start = jiffies;

 		if (blk_queue_plugged(drive->queue)) {
@@ -1311,7 +1314,7 @@
 			/* local CPU only,
 			 * as if we were handling an interrupt */
 			local_irq_disable();
-			if (hwgroup->poll_timeout != 0) {
+			if (hwgroup->polling) {
 				startstop = handler(drive);
 			} else if (drive_is_ready(drive)) {
 				if (drive->waiting_for_dma)
@@ -1439,8 +1442,7 @@
 		return IRQ_NONE;
 	}

-	if ((handler = hwgroup->handler) == NULL ||
-	    hwgroup->poll_timeout != 0) {
+	if ((handler = hwgroup->handler) == NULL || hwgroup->polling) {
 		/*
 		 * Not expecting an interrupt from this drive.
 		 * That means this could be:
diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-iops.c	2005-02-03 17:02:35 +01:00
@@ -184,16 +184,6 @@

 EXPORT_SYMBOL(default_hwif_mmiops);

-void default_hwif_transport (ide_hwif_t *hwif)
-{
-	hwif->ata_input_data		= ata_input_data;
-	hwif->ata_output_data		= ata_output_data;
-	hwif->atapi_input_bytes		= atapi_input_bytes;
-	hwif->atapi_output_bytes	= atapi_output_bytes;
-}
-
-EXPORT_SYMBOL(default_hwif_transport);
-
 u32 ide_read_24 (ide_drive_t *drive)
 {
 	u8 hcyl = HWIF(drive)->INB(IDE_HCYL_REG);
@@ -202,8 +192,6 @@
 	return (hcyl<<16)|(lcyl<<8)|sect;
 }

-EXPORT_SYMBOL(ide_read_24);
-
 void SELECT_DRIVE (ide_drive_t *drive)
 {
 	if (HWIF(drive)->selectproc)
@@ -240,7 +228,7 @@
  * of the sector count register location, with interrupts disabled
  * to ensure that the reads all happen together.
  */
-void ata_vlb_sync (ide_drive_t *drive, unsigned long port)
+static void ata_vlb_sync(ide_drive_t *drive, unsigned long port)
 {
 	(void) HWIF(drive)->INB(port);
 	(void) HWIF(drive)->INB(port);
@@ -250,7 +238,7 @@
 /*
  * This is used for most PIO data transfers *from* the IDE interface
  */
-void ata_input_data (ide_drive_t *drive, void *buffer, u32 wcount)
+static void ata_input_data(ide_drive_t *drive, void *buffer, u32 wcount)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 io_32bit		= drive->io_32bit;
@@ -272,7 +260,7 @@
 /*
  * This is used for most PIO data transfers *to* the IDE interface
  */
-void ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
+static void ata_output_data(ide_drive_t *drive, void *buffer, u32 wcount)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 io_32bit		= drive->io_32bit;
@@ -299,7 +287,7 @@
  * extra byte allocated for the buffer.
  */

-void atapi_input_bytes (ide_drive_t *drive, void *buffer, u32 bytecount)
+static void atapi_input_bytes(ide_drive_t *drive, void *buffer, u32 bytecount)
 {
 	ide_hwif_t *hwif = HWIF(drive);

@@ -316,9 +304,7 @@
 		hwif->INSW(IDE_DATA_REG, ((u8 *)buffer)+(bytecount & ~0x03), 1);
 }

-EXPORT_SYMBOL(atapi_input_bytes);
-
-void atapi_output_bytes (ide_drive_t *drive, void *buffer, u32 bytecount)
+static void atapi_output_bytes(ide_drive_t *drive, void *buffer, u32 bytecount)
 {
 	ide_hwif_t *hwif = HWIF(drive);

@@ -335,7 +321,15 @@
 		hwif->OUTSW(IDE_DATA_REG, ((u8*)buffer)+(bytecount & ~0x03), 1);
 }

-EXPORT_SYMBOL(atapi_output_bytes);
+void default_hwif_transport(ide_hwif_t *hwif)
+{
+	hwif->ata_input_data		= ata_input_data;
+	hwif->ata_output_data		= ata_output_data;
+	hwif->atapi_input_bytes		= atapi_input_bytes;
+	hwif->atapi_output_bytes	= atapi_output_bytes;
+}
+
+EXPORT_SYMBOL(default_hwif_transport);

 /*
  * Beginning of Taskfile OPCODE Library and feature sets.
@@ -437,6 +431,7 @@
 #endif
 }

+/* FIXME: exported for use by the USB storage (isd200.c) code only */
 EXPORT_SYMBOL(ide_fix_driveid);

 void ide_fixstring (u8 *s, const int bytecount, const int byteswap)
@@ -1028,14 +1023,14 @@
 			return ide_started;
 		}
 		/* end of polling */
-		hwgroup->poll_timeout = 0;
+		hwgroup->polling = 0;
 		printk("%s: ATAPI reset timed-out, status=0x%02x\n",
 				drive->name, stat);
 		/* do it the old fashioned way */
 		return do_reset1(drive, 1);
 	}
 	/* done polling */
-	hwgroup->poll_timeout = 0;
+	hwgroup->polling = 0;
 	return ide_stopped;
 }

@@ -1095,7 +1090,7 @@
 			printk("\n");
 		}
 	}
-	hwgroup->poll_timeout = 0;	/* done polling */
+	hwgroup->polling = 0;	/* done polling */
 	return ide_stopped;
 }

@@ -1112,7 +1107,7 @@
 #endif
 }

-void pre_reset (ide_drive_t *drive)
+static void pre_reset(ide_drive_t *drive)
 {
 	DRIVER(drive)->pre_reset(drive);

@@ -1170,6 +1165,7 @@
 		udelay (20);
 		hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+		hwgroup->polling = 1;
 		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return ide_started;
@@ -1210,6 +1206,7 @@
 	/* more than enough time */
 	udelay(10);
 	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
+	hwgroup->polling = 1;
 	__ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);

 	/*
diff -Nru a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
--- a/drivers/ide/ide-pnp.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-pnp.c	2005-02-03 17:02:35 +01:00
@@ -21,7 +21,7 @@
 #include <linux/ide.h>

 /* Add your devices here :)) */
-struct pnp_device_id idepnp_devices[] = {
+static struct pnp_device_id idepnp_devices[] = {
   	/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	{.id = "PNP0600", .driver_data = 0},
 	{.id = ""}
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/ide-probe.c	2005-02-03 17:02:35 +01:00
@@ -841,7 +841,11 @@
 	if (fixup)
 		fixup(hwif);

-	hwif_init(hwif);
+	if (!hwif_init(hwif)) {
+		printk(KERN_INFO "%s: failed to initialize IDE interface\n",
+				 hwif->name);
+		return -1;
+	}

 	if (hwif->present) {
 		u16 unit = 0;
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-02-03 17:02:34 +01:00
+++ b/drivers/ide/ide-tape.c	2005-02-03 17:02:35 +01:00
@@ -2439,7 +2439,7 @@
 			tape->dsc_polling_start = jiffies;
 			tape->dsc_polling_frequency = tape->best_dsc_rw_frequency;
 			tape->dsc_timeout = jiffies + IDETAPE_DSC_RW_TIMEOUT;
-		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
+		} else if (time_after(jiffies, tape->dsc_timeout)) {
 			printk(KERN_ERR "ide-tape: %s: DSC timeout\n",
 				tape->name);
 			if (rq->cmd[0] & REQ_IDETAPE_PC2) {
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-02-03 17:02:34 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-02-03 17:02:34 +01:00
@@ -851,8 +851,8 @@
 		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);

         /*
-	 * (ks) In the flagged taskfile approch, we will used all specified
-	 * registers and the register value will not be changed. Except the
+	 * (ks) In the flagged taskfile approch, we will use all specified
+	 * registers and the register value will not be changed, except the
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-03 17:02:34 +01:00
+++ b/drivers/ide/ide.c	2005-02-03 17:02:34 +01:00
@@ -333,7 +333,7 @@
  *	Returns a guessed speed in MHz.
  */

-int ide_system_bus_speed (void)
+static int ide_system_bus_speed(void)
 {
 	static struct pci_device_id pci_default[] = {
 		{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
@@ -414,7 +414,7 @@
 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *proc_ide_root;

-ide_proc_entry_t generic_subdriver_entries[] = {
+static ide_proc_entry_t generic_subdriver_entries[] = {
 	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
@@ -1675,7 +1675,7 @@
  *
  * Remember to update Documentation/ide.txt if you change something here.
  */
-int __init ide_setup (char *s)
+static int __init ide_setup(char *s)
 {
 	int i, vals[3];
 	ide_hwif_t *hwif;
@@ -2261,7 +2261,7 @@
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
-int __init ide_init (void)
+static int __init ide_init(void)
 {
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 	devfs_mk_dir("ide");
@@ -2308,7 +2308,7 @@
 }

 #ifdef MODULE
-char *options = NULL;
+static char *options = NULL;
 module_param(options, charp, 0);
 MODULE_LICENSE("GPL");

diff -Nru a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/legacy/ide-cs.c	2005-02-03 17:02:35 +01:00
@@ -209,7 +209,7 @@
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)

-void ide_config(dev_link_t *link)
+static void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
     ide_info_t *info = link->priv;
diff -Nru a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile	2005-02-03 17:02:34 +01:00
+++ b/drivers/ide/pci/Makefile	2005-02-03 17:02:34 +01:00
@@ -1,5 +1,4 @@

-obj-$(CONFIG_BLK_DEV_ADMA100)		+= adma100.o
 obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
diff -Nru a/drivers/ide/pci/adma100.c b/drivers/ide/pci/adma100.c
--- a/drivers/ide/pci/adma100.c	2005-02-03 17:02:35 +01:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,30 +0,0 @@
-/*
- *  linux/drivers/ide/pci/adma100.c -- basic support for Pacific Digital ADMA-100 boards
- *
- *     Created 09 Apr 2002 by Mark Lord
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive for
- *  more details.
- */
-
-#include <linux/mm.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/io.h>
-
-void __init ide_init_adma100 (ide_hwif_t *hwif)
-{
-	unsigned long  phy_admctl = pci_resource_start(hwif->pci_dev, 4) + 0x80 + (hwif->channel * 0x20);
-	void *v_admctl;
-
-	hwif->autodma = 0;		// not compatible with normal IDE DMA transfers
-	hwif->dma_base = 0;		// disable DMA completely
-	hwif->io_ports[IDE_CONTROL_OFFSET] += 4;	// chip needs offset of 6 instead of 2
-	v_admctl = ioremap_nocache(phy_admctl, 1024);	// map config regs, so we can turn on drive IRQs
-	*((unsigned short *)v_admctl) &= 3;		// enable aIEN; preserve PIO mode
-	iounmap(v_admctl);				// all done; unmap config regs
-}
diff -Nru a/drivers/ide/pci/adma100.h b/drivers/ide/pci/adma100.h
--- a/drivers/ide/pci/adma100.h	2005-02-03 17:02:35 +01:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,28 +0,0 @@
-#ifndef ADMA_100_H
-#define ADMA_100_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-extern void init_setup_pdcadma(struct pci_dev *, ide_pci_device_t *);
-extern unsigned int init_chipset_pdcadma(struct pci_dev *, const char *);
-extern void init_hwif_pdcadma(ide_hwif_t *);
-extern void init_dma_pdcadma(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t pdcadma_chipsets[] __devinitdata = {
-	{
-		.vendor		= PCI_VENDOR_ID_PDC,
-		.device		= PCI_DEVICE_ID_PDC_1841,
-		.name		= "ADMA100",
-		.init_setup	= init_setup_pdcadma,
-		.init_chipset	= init_chipset_pdcadma,
-		.init_hwif	= init_hwif_pdcadma,
-		.init_dma	= init_dma_pdcadma,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= OFF_BOARD,
-	}
-}
-
-#endif /* ADMA_100_H */
diff -Nru a/drivers/ide/pci/it8172.c b/drivers/ide/pci/it8172.c
--- a/drivers/ide/pci/it8172.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/pci/it8172.c	2005-02-03 17:02:35 +01:00
@@ -56,7 +56,7 @@
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	int is_slave		= (hwif->drives[1] == drive);
+	int is_slave		= (&hwif->drives[1] == drive);
 	unsigned long flags;
 	u16 drive_enables;
 	u32 drive_timing;
@@ -94,7 +94,7 @@
 	}

 	pci_write_config_word(dev, 0x40, drive_enables);
-	spin_unlock_irqrestore(&ide_lock, flags)
+	spin_unlock_irqrestore(&ide_lock, flags);
 }

 static u8 it8172_dma_2_pio (u8 xfer_rate)
diff -Nru a/drivers/ide/pci/it8172.h b/drivers/ide/pci/it8172.h
--- a/drivers/ide/pci/it8172.h	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/pci/it8172.h	2005-02-03 17:02:35 +01:00
@@ -6,7 +6,6 @@
 #include <linux/ide.h>

 static u8 it8172_ratemask(ide_drive_t *drive);
-static u8 it8172_ratefilter(ide_drive_t *drive, u8 speed);
 static void it8172_tune_drive(ide_drive_t *drive, u8 pio);
 static u8 it8172_dma_2_pio(u8 xfer_rate);
 static int it8172_tune_chipset(ide_drive_t *drive, u8 xferspeed);
@@ -14,14 +13,12 @@
 static int it8172_config_chipset_for_dma(ide_drive_t *drive);
 #endif

-static void init_setup_it8172(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_it8172(struct pci_dev *, const char *);
 static void init_hwif_it8172(ide_hwif_t *);

 static ide_pci_device_t it8172_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "IT8172G",
-		.init_setup	= init_setup_it8172,
 		.init_chipset	= init_chipset_it8172,
 		.init_hwif	= init_hwif_it8172,
 		.channels	= 2,
diff -Nru a/drivers/ide/pci/opti621.c b/drivers/ide/pci/opti621.c
--- a/drivers/ide/pci/opti621.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/pci/opti621.c	2005-02-03 17:02:35 +01:00
@@ -348,11 +348,6 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }

-static int __init init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
diff -Nru a/drivers/ide/pci/opti621.h b/drivers/ide/pci/opti621.h
--- a/drivers/ide/pci/opti621.h	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/pci/opti621.h	2005-02-03 17:02:35 +01:00
@@ -5,13 +5,11 @@
 #include <linux/pci.h>
 #include <linux/ide.h>

-static int init_setup_opti621(struct pci_dev *, ide_pci_device_t *);
 static void init_hwif_opti621(ide_hwif_t *);

 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "OPTI621",
-		.init_setup	= init_setup_opti621,
 		.init_hwif	= init_hwif_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
@@ -19,7 +17,6 @@
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
 		.name		= "OPTI621X",
-		.init_setup	= init_setup_opti621,
 		.init_hwif	= init_hwif_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2005-02-03 17:02:34 +01:00
+++ b/drivers/ide/pci/piix.c	2005-02-03 17:02:34 +01:00
@@ -531,20 +531,6 @@
 }

 /**
- *	init_setup_piix		-	callback for IDE initialize
- *	@dev: PIIX PCI device
- *	@d: IDE pci info
- *
- *	Enable the xp fixup for the PIIX controller and then perform
- *	a standard ide PCI setup
- */
-
-static int __devinit init_setup_piix(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
-/**
  *	piix_init_one	-	called when a PIIX is found
  *	@dev: the piix device
  *	@id: the matching pci id
@@ -557,7 +543,7 @@
 {
 	ide_pci_device_t *d = &piix_pci_info[id->driver_data];

-	return d->init_setup(dev, d);
+	return ide_setup_pci_device(dev, d);
 }

 /**
diff -Nru a/drivers/ide/pci/piix.h b/drivers/ide/pci/piix.h
--- a/drivers/ide/pci/piix.h	2005-02-03 17:02:34 +01:00
+++ b/drivers/ide/pci/piix.h	2005-02-03 17:02:34 +01:00
@@ -5,14 +5,12 @@
 #include <linux/pci.h>
 #include <linux/ide.h>

-static int init_setup_piix(struct pci_dev *, ide_pci_device_t *);
 static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
 static void init_hwif_piix(ide_hwif_t *);

 #define DECLARE_PIIX_DEV(name_str) \
 	{						\
 		.name		= name_str,		\
-		.init_setup	= init_setup_piix,	\
 		.init_chipset	= init_chipset_piix,	\
 		.init_hwif	= init_hwif_piix,	\
 		.channels	= 2,			\
@@ -32,7 +30,6 @@

 	{	/* 2 */
 		.name		= "MPIIX",
-		.init_setup	= init_setup_piix,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= NODMA,
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/pci/sgiioc4.c	2005-02-03 17:02:35 +01:00
@@ -669,7 +669,8 @@
 		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
 		       hwif->name, d->name);

-	probe_hwif_init(hwif);
+	if (probe_hwif_init(hwif))
+		return -EIO;

 	/* Create /proc/ide entries */
 	create_proc_ide_interfaces();
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/ide/pci/siimage.c	2005-02-03 17:02:35 +01:00
@@ -590,7 +590,7 @@
 		if ((hwif->INL(SATA_STATUS_REG) & 0x03) != 0x03) {
 			printk(KERN_WARNING "%s: reset phy dead, status=0x%08x\n",
 				hwif->name, hwif->INL(SATA_STATUS_REG));
-			HWGROUP(drive)->poll_timeout = 0;
+			HWGROUP(drive)->polling = 0;
 			return ide_started;
 		}
 		return 0;
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-02-03 17:02:35 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-02-03 17:02:35 +01:00
@@ -152,7 +152,7 @@
 		}
 		count = min(pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
-		atapi_input_bytes (drive, buf + pc->b_count, count);
+		drive->hwif->atapi_input_bytes(drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -174,7 +174,7 @@
 		}
 		count = min(pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
-		atapi_output_bytes (drive, buf + pc->b_count, count);
+		drive->hwif->atapi_output_bytes(drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
 		if (pc->b_count == pc->sg->length) {
 			pc->sg++;
@@ -481,7 +481,7 @@
 					if (pc->sg)
 						idescsi_input_buffers(drive, pc, temp);
 					else
-						atapi_input_bytes(drive, pc->current_position, temp);
+						drive->hwif->atapi_input_bytes(drive, pc->current_position, temp);
 					printk(KERN_ERR "ide-scsi: transferred %d of %d bytes\n", temp, bcount.all);
 				}
 				pc->actually_transferred += temp;
@@ -541,7 +541,7 @@
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	/* Send the actual packet */
-	atapi_output_bytes(drive, scsi->pc->c, 12);
+	drive->hwif->atapi_output_bytes(drive, scsi->pc->c, 12);
 	if (test_bit (PC_DMA_OK, &pc->flags)) {
 		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
 		hwif->dma_start(drive);
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-03 17:02:35 +01:00
+++ b/include/linux/ide.h	2005-02-03 17:02:35 +01:00
@@ -187,11 +187,7 @@
  * Timeouts for various operations:
  */
 #define WAIT_DRQ	(HZ/10)		/* 100msec - spec allows up to 20ms */
-#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 #define WAIT_READY	(5*HZ)		/* 5sec - some laptops are very slow */
-#else
-#define WAIT_READY	(HZ/10)		/* 100msec - should be instantaneous */
-#endif /* CONFIG_APM || CONFIG_APM_MODULE */
 #define WAIT_PIDENTIFY	(10*HZ)	/* 10sec  - should be less than 3ms (?), if all ATAPI CD is closed at boot */
 #define WAIT_WORSTCASE	(30*HZ)	/* 30sec  - worst case when spinning up */
 #define WAIT_CMD	(10*HZ)	/* 10sec  - maximum wait for an IRQ to happen */
@@ -721,6 +717,7 @@
 					 *  3=64-bit
 					 */
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
+	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */

         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
@@ -937,7 +934,9 @@
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
-	int sleeping;
+	int sleeping	: 1;
+		/* BOOL: polling active & poll_timeout field valid */
+	int polling	: 1;
 		/* current drive */
 	ide_drive_t *drive;
 		/* ptr to current hwif in linked-list */
@@ -1297,11 +1296,6 @@
 extern void SELECT_MASK(ide_drive_t *, int);
 extern void QUIRK_LIST(ide_drive_t *);

-extern void ata_input_data(ide_drive_t *, void *, u32);
-extern void ata_output_data(ide_drive_t *, void *, u32);
-extern void atapi_input_bytes(ide_drive_t *, void *, u32);
-extern void atapi_output_bytes(ide_drive_t *, void *, u32);
-
 extern int drive_is_ready(ide_drive_t *);
 extern int wait_for_ready(ide_drive_t *, int /* timeout */);

@@ -1341,14 +1335,6 @@
 ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block);

 /*
- * ide_system_bus_speed() returns what we think is the system VESA/PCI
- * bus speed (in MHz).  This is used for calculating interface PIO timings.
- * The default is 40 for known PCI systems, 50 otherwise.
- * The "idebus=xx" parameter can be used to override this value.
- */
-extern int ide_system_bus_speed(void);
-
-/*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
  * to the hwgroup by sleeping for timeout jiffies.
  */
@@ -1361,7 +1347,6 @@
 extern void ide_init_subdrivers(void);

 extern struct block_device_operations ide_fops[];
-extern ide_proc_entry_t generic_subdriver_entries[];

 extern int ata_attach(ide_drive_t *);

@@ -1458,7 +1443,6 @@
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
-extern int __ide_dma_test_irq(ide_drive_t *);
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
