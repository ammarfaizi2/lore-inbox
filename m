Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbUKRAkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbUKRAkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUKRAaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:30:55 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:12260 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262619AbUKRAXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:23:46 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [BK PATCHES] ide-2.6 update
Date: Thu, 18 Nov 2004 00:41:05 +0100
User-Agent: KMail/1.7
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411180041.06223.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Bugfixes only except Adrian's cleanup patch
(but it is really obvious and non-intrusive).

Please do a

 bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 Documentation/kernel-parameters.txt |    8 +
 drivers/ide/cris/ide-v10.c          |  173 +++++++++---------------------------
 drivers/ide/ide-cd.c                |    6 -
 drivers/ide/ide-cd.h                |    6 -
 drivers/ide/ide-disk.c              |    4 
 drivers/ide/ide-dma.c               |    1 
 drivers/ide/ide-probe.c             |    2 
 drivers/ide/ide-proc.c              |   20 +++-
 drivers/ide/ide.c                   |    2 
 drivers/ide/legacy/hd.c             |    8 -
 drivers/ide/legacy/qd65xx.c         |    2 
 drivers/ide/legacy/qd65xx.h         |    2 
 drivers/ide/pci/aec62xx.h           |    4 
 drivers/ide/pci/cs5520.c            |    2 
 drivers/ide/pci/cy82c693.c          |    2 
 drivers/ide/pci/hpt366.h            |   38 +++----
 drivers/ide/pci/pdc202xx_new.c      |   56 -----------
 drivers/ide/pci/pdc202xx_old.c      |    2 
 drivers/ide/pci/sc1200.c            |    4 
 drivers/ide/pci/serverworks.h       |    2 
 drivers/ide/pci/trm290.c            |    2 
 21 files changed, 110 insertions(+), 236 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/11/17 1.2274)
   [ide] fix /proc/ide/hd?/settings to not spam logs
   
   On Thu, 11 Nov 2004 17:10:21 +0100, Jens Axboe <axboe@suse.de> wrote:
   > On Thu, Nov 11 2004, Alan Cox wrote:
   > > > +   printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
   > > > +                       "obsolete, and will be removed soon!\n");
   > > > +
   > >
   > > The above should be rate limited or on the write case moved to after
   > > the capable() check. A program polling these settings now makes a nasty
   > > noise and wipes the logs. A user can also do it intentionally.
   > 
   > Or just print it once...
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/17 1.2273)
   [ide] small IDE cleanups
   
   The patch below does the following small cleanups in the IDE code:
   - make some needlessly global code static
   - remove two unused functions from pdc202xx_new.c
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/17 1.2272)
   [ide] remove RICOH CD-R/RW MP7083A from DMA blacklist
   
   From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
   
   I have tested my RICOH CD-R/RW with this patch (on CD reading/writing),
   and it works just fine with DMA enabled.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/17 1.2271)
   [ide] "ide=nodma" printout fix
   
   From: Magnus Damm <magnus.damm@gmail.com>
   
   This simple patch changes the output from this:
   ..
   ide_setup: ide=nodmaIDE: Prevented DMA
   ..
   to this:
   ..
   ide_setup: ide=nodma : Prevented DMA
   ..
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/17 1.2270)
   [ide] update documentation for ide params
   
   From: Magnus Damm <magnus.damm@gmail.com>
   
   This patch removes ide parameters marked as obsolete in the source and
   adds documentation for "ide=". I think I got it right, the important
   part for me is "ide=nodma".
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/17 1.2269)
   [ide] no need to alloc sg_table in CRISv10 IDE driver
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/11/17 1.2268)
   [ide] update CRISv10 IDE driver
   
   Signed-off-by: Mikael Starvik <starvik@axis.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt 2004-11-18 00:15:00 +01:00
+++ b/Documentation/kernel-parameters.txt 2004-11-18 00:15:00 +01:00
@@ -504,10 +504,12 @@
  icn=  [HW,ISDN]
    Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
+ ide=  [HW] (E)IDE subsystem
+   Format: ide=nodma or ide=doubler or ide=reverse
+   See Documentation/ide.txt.
+
  ide?=  [HW] (E)IDE subsystem
-   Config (iomem/irq), tuning or debugging
-   (serialize,reset,no{dma,tune,probe}) or chipset
-   specific parameters.
+   Format: ide?=noprobe or chipset specific parameters.
    See Documentation/ide.txt.
  
  idebus=  [HW] (E)IDE subsystem - VLB/PCI bus speed
diff -Nru a/drivers/ide/cris/ide-v10.c b/drivers/ide/cris/ide-v10.c
--- a/drivers/ide/cris/ide-v10.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/cris/ide-v10.c 2004-11-18 00:15:00 +01:00
@@ -30,6 +30,7 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/init.h>
+#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/arch/svinto.h>
@@ -50,6 +51,9 @@
 #define LOWDB(x)
 #define D(x)
 
+static int e100_ide_build_dmatable (ide_drive_t *drive);
+static ide_startstop_t etrax_dma_intr (ide_drive_t *drive);
+
 void
 etrax100_ide_outw(unsigned short data, unsigned long reg) {
  int timeleft;
@@ -202,16 +206,13 @@
 #define ATA_PIO0_HOLD    4
 
 static int e100_dma_check (ide_drive_t *drive);
-static int e100_dma_begin (ide_drive_t *drive);
+static void e100_dma_start(ide_drive_t *drive);
 static int e100_dma_end (ide_drive_t *drive);
-static int e100_dma_read (ide_drive_t *drive);
-static int e100_dma_write (ide_drive_t *drive);
 static void e100_ide_input_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_ide_output_data (ide_drive_t *drive, void *, unsigned int);
 static void e100_atapi_input_bytes(ide_drive_t *drive, void *, unsigned int);
 static void e100_atapi_output_bytes(ide_drive_t *drive, void *, unsigned int);
 static int e100_dma_off (ide_drive_t *drive);
-static int e100_dma_verbose (ide_drive_t *drive);
 
 
 /*
@@ -276,6 +277,40 @@
  }
 }
 
+static int e100_dma_setup(ide_drive_t *drive)
+{
+ struct request *rq = drive->hwif->hwgroup->rq;
+
+ if (rq_data_dir(rq)) {
+  e100_read_command = 0;
+
+  RESET_DMA(ATA_TX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
+  WAIT_DMA(ATA_TX_DMA_NBR);
+ } else {
+  e100_read_command = 1;
+
+  RESET_DMA(ATA_RX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
+  WAIT_DMA(ATA_RX_DMA_NBR);
+ }
+
+ /* set up the Etrax DMA descriptors */
+ if (e100_ide_build_dmatable(drive)) {
+  ide_map_sg(drive, rq);
+  return 1;
+ }
+
+ return 0;
+}
+
+static void e100_dma_exec_cmd(ide_drive_t *drive, u8 command)
+{
+ /* set the irq handler which will finish the request when DMA is done */
+ ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
+
+ /* issue cmd to drive */
+ etrax100_ide_outb(command, IDE_COMMAND_REG);
+}
+
 void __init
 init_e100_ide (void)
 {
@@ -297,18 +332,15 @@
                 hwif->atapi_output_bytes = &e100_atapi_output_bytes;
                 hwif->ide_dma_check = &e100_dma_check;
                 hwif->ide_dma_end = &e100_dma_end;
-  hwif->ide_dma_write = &e100_dma_write;
-  hwif->ide_dma_read = &e100_dma_read;
-  hwif->ide_dma_begin = &e100_dma_begin;
+  hwif->dma_setup = &e100_dma_setup;
+  hwif->dma_exec_cmd = &e100_dma_exec_cmd;
+  hwif->dma_start = &e100_dma_start;
   hwif->OUTB = &etrax100_ide_outb;
   hwif->OUTW = &etrax100_ide_outw;
   hwif->OUTBSYNC = &etrax100_ide_outbsync;
   hwif->INB = &etrax100_ide_inb;
   hwif->INW = &etrax100_ide_inw;
   hwif->ide_dma_off_quietly = &e100_dma_off;
-  hwif->ide_dma_verbose = &e100_dma_verbose;
-  hwif->sg_table =
-    kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES, GFP_KERNEL);
  }
 
  /* actually reset and configure the etrax100 ide/ata interface */
@@ -401,12 +433,6 @@
  return 0;
 }
 
-static int e100_dma_verbose (ide_drive_t *drive)
-{
- printk(", DMA(mode 2)");
- return 0;
-}
-
 static etrax_dma_descr mydescr;
 
 /*
@@ -618,20 +644,9 @@
 
  ata_tot_size = 0;
 
- if (HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) {
-  u8 *virt_addr = rq->buffer;
-  int sector_count = rq->nr_sectors;
-  memset(&sg[0], 0, sizeof(*sg));
-  sg[0].page = virt_to_page(virt_addr);
-  sg[0].offset = offset_in_page(virt_addr);
-  sg[0].length =  sector_count  * SECTOR_SIZE;
-  hwif->sg_nents = i = 1;
- }
- else
- {
-  hwif->sg_nents = i = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
- }
+ ide_map_sg(drive, rq);
 
+ i = hwif->sg_nents;
 
  while(i) {
   /*
@@ -768,10 +783,6 @@
  * sector address using CHS or LBA.  All that remains is to prepare for DMA
  * and then issue the actual read/write DMA/PIO command to the drive.
  *
- * For ATAPI devices, we just prepare for DMA and return. The caller should
- * then issue the packet command to the drive and call us again with
- * ide_dma_begin afterwards.
- *
  * Returns 0 if all went well.
  * Returns 1 if DMA read/write could not be started, in which case
  * the caller should revert to PIO for the current request.
@@ -788,35 +799,9 @@
  return 0;
 }
 
-static int e100_start_dma(ide_drive_t *drive, int atapi, int reading)
+static void e100_dma_start(ide_drive_t *drive)
 {
- if(reading) {
-
-  RESET_DMA(ATA_RX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
-  WAIT_DMA(ATA_RX_DMA_NBR);
-
-  /* set up the Etrax DMA descriptors */
-
-  if(e100_ide_build_dmatable (drive))
-   return 1;
-
-  if(!atapi) {
-   /* set the irq handler which will finish the request when DMA is done */
-
-   ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-
-   /* issue cmd to drive */
-                        if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
-       (drive->addressing == 1)) {
-    ide_task_t *args = HWGROUP(drive)->rq->special;
-    etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
-   } else if (drive->addressing) {
-    etrax100_ide_outb(WIN_READDMA_EXT, IDE_COMMAND_REG);
-   } else {
-    etrax100_ide_outb(WIN_READDMA, IDE_COMMAND_REG);
-   }
-  }
-
+ if (e100_read_command) {
   /* begin DMA */
 
   /* need to do this before RX DMA due to a chip bug
@@ -849,32 +834,6 @@
 
  } else {
   /* writing */
-
-  RESET_DMA(ATA_TX_DMA_NBR); /* sometimes the DMA channel get stuck so we need to do this */
-  WAIT_DMA(ATA_TX_DMA_NBR);
-
-  /* set up the Etrax DMA descriptors */
-
-  if(e100_ide_build_dmatable (drive))
-   return 1;
-
-  if(!atapi) {
-   /* set the irq handler which will finish the request when DMA is done */
-
-   ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-
-   /* issue cmd to drive */
-   if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
-       (drive->addressing == 1)) {
-    ide_task_t *args = HWGROUP(drive)->rq->special;
-    etrax100_ide_outb(args->tfRegister[IDE_COMMAND_OFFSET], IDE_COMMAND_REG);
-   } else if (drive->addressing) {
-    etrax100_ide_outb(WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
-   } else {
-    etrax100_ide_outb(WIN_WRITEDMA, IDE_COMMAND_REG);
-   }
-  }
-
   /* begin DMA */
 
   *R_DMA_CH2_FIRST = virt_to_phys(ata_descrs);
@@ -897,44 +856,4 @@
 
   D(printk("dma write of %d bytes.\n", ata_tot_size));
  }
- return 0;
-}
-
-static int e100_dma_write(ide_drive_t *drive)
-{
- e100_read_command = 0;
- /* ATAPI-devices (not disks) first call ide_dma_read/write to set the direction
-  * then they call ide_dma_begin after they have issued the appropriate drive command
-  * themselves to actually start the chipset DMA. so we just return here if we're
-  * not a diskdrive.
-  */
- if (drive->media != ide_disk)
-                return 0;
- return e100_start_dma(drive, 0, 0);
-}
-
-static int e100_dma_read(ide_drive_t *drive)
-{
- e100_read_command = 1;
- /* ATAPI-devices (not disks) first call ide_dma_read/write to set the direction
-  * then they call ide_dma_begin after they have issued the appropriate drive command
-  * themselves to actually start the chipset DMA. so we just return here if we're
-  * not a diskdrive.
-  */
- if (drive->media != ide_disk)
-                return 0;
- return e100_start_dma(drive, 0, 1);
-}
-
-static int e100_dma_begin(ide_drive_t *drive)
-{
- /* begin DMA, used by ATAPI devices which want to issue the
-  * appropriate IDE command themselves.
-  *
-  * they have already called ide_dma_read/write to set the
-  * static reading flag, now they call ide_dma_begin to do
-  * the real stuff. we tell our code below not to issue
-  * any IDE commands itself and jump into it.
-  */
-  return e100_start_dma(drive, 1, e100_read_command);
 }
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide-cd.c 2004-11-18 00:15:00 +01:00
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
diff -Nru a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
--- a/drivers/ide/ide-cd.h 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide-cd.h 2004-11-18 00:15:00 +01:00
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
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide-disk.c 2004-11-18 00:15:00 +01:00
@@ -390,7 +390,7 @@
  return err;
 }
 
-ide_startstop_t idedisk_error (ide_drive_t *drive, const char *msg, u8 stat)
+static ide_startstop_t idedisk_error (ide_drive_t *drive, const char *msg, u8 stat)
 {
  ide_hwif_t *hwif;
  struct request *rq;
@@ -450,7 +450,7 @@
  return ide_stopped;
 }
 
-ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
+static ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
 {
  ide_hwif_t *hwif;
  struct request *rq;
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide-dma.c 2004-11-18 00:15:00 +01:00
@@ -129,7 +129,6 @@
  { "CD-532E-A"  , "ALL"  },
  { "E-IDE CD-ROM CR-840", "ALL"  },
  { "CD-ROM Drive/F5A", "ALL"  },
- { "RICOH CD-R/RW MP7083A", "ALL"  },
  { "WPI CDD-820",  "ALL"  },
  { "SAMSUNG CD-ROM SC-148C", "ALL"  },
  { "SAMSUNG CD-ROM SC-148F", "ALL"  },
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide-probe.c 2004-11-18 00:15:00 +01:00
@@ -1149,7 +1149,7 @@
 
 extern ide_driver_t idedefault_driver;
 
-struct kobject *ata_probe(dev_t dev, int *part, void *data)
+static struct kobject *ata_probe(dev_t dev, int *part, void *data)
 {
  ide_hwif_t *hwif = data;
  int unit = *part >> PARTN_BITS;
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide-proc.c 2004-11-18 00:15:00 +01:00
@@ -124,6 +124,18 @@
  PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+static void proc_ide_settings_warn(void)
+{
+ static int warned = 0;
+
+ if (warned)
+  return;
+
+ printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
+       "obsolete, and will be removed soon!\n");
+ warned = 1;
+}
+
 static int proc_ide_read_settings
  (char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -132,8 +144,7 @@
  char  *out = page;
  int  len, rc, mul_factor, div_factor;
 
- printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
-       "obsolete, and will be removed soon!\n");
+ proc_ide_settings_warn();
 
  down(&ide_setting_sem);
  out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
@@ -171,11 +182,10 @@
  ide_settings_t *setting;
  char *buf, *s;
 
- printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
-       "obsolete, and will be removed soon!\n");
-
  if (!capable(CAP_SYS_ADMIN))
   return -EACCES;
+
+ proc_ide_settings_warn();
 
  if (count >= PAGE_SIZE)
   return -EINVAL;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/ide.c 2004-11-18 00:15:00 +01:00
@@ -1846,7 +1846,7 @@
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
 
  if (!strcmp(s, "ide=nodma")) {
-  printk("IDE: Prevented DMA\n");
+  printk(" : Prevented DMA\n");
   noautodma = 1;
   return 1;
  }
diff -Nru a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/legacy/hd.c 2004-11-18 00:15:00 +01:00
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
diff -Nru a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c
--- a/drivers/ide/legacy/qd65xx.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/legacy/qd65xx.c 2004-11-18 00:15:00 +01:00
@@ -101,7 +101,7 @@
  spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-u8 __init qd_read_reg (unsigned long reg)
+static u8 __init qd_read_reg (unsigned long reg)
 {
  unsigned long flags;
  u8 read;
diff -Nru a/drivers/ide/legacy/qd65xx.h b/drivers/ide/legacy/qd65xx.h
--- a/drivers/ide/legacy/qd65xx.h 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/legacy/qd65xx.h 2004-11-18 00:15:00 +01:00
@@ -46,7 +46,7 @@
 
 /* Drive specific timing taken from DOS driver v3.7 */
 
-struct qd65xx_timing_s {
+static struct qd65xx_timing_s {
  s8 offset;   /* ofset from the beginning of Model Number" */
  char model[4];    /* 4 chars from Model number, no conversion */
  s16 active;   /* active time */
diff -Nru a/drivers/ide/pci/aec62xx.h b/drivers/ide/pci/aec62xx.h
--- a/drivers/ide/pci/aec62xx.h 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/aec62xx.h 2004-11-18 00:15:00 +01:00
@@ -11,7 +11,7 @@
  byte  ultra_settings;
 };
 
-struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
+static struct chipset_bus_clock_list_entry aec6xxx_33_base [] = {
  { XFER_UDMA_6, 0x31, 0x07 },
  { XFER_UDMA_5, 0x31, 0x06 },
  { XFER_UDMA_4, 0x31, 0x05 },
@@ -31,7 +31,7 @@
  { 0,  0x00, 0x00 }
 };
 
-struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
+static struct chipset_bus_clock_list_entry aec6xxx_34_base [] = {
  { XFER_UDMA_6, 0x41, 0x06 },
  { XFER_UDMA_5, 0x41, 0x05 },
  { XFER_UDMA_4, 0x41, 0x04 },
diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/cs5520.c 2004-11-18 00:15:00 +01:00
@@ -58,7 +58,7 @@
  int recovery;
 };
 
-struct pio_clocks cs5520_pio_clocks[]={
+static struct pio_clocks cs5520_pio_clocks[]={
  {3, 6, 11},
  {2, 5, 6},
  {1, 4, 3},
diff -Nru a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
--- a/drivers/ide/pci/cy82c693.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/cy82c693.c 2004-11-18 00:15:00 +01:00
@@ -183,7 +183,7 @@
 /* 
  * used to set DMA mode for CY82C693 (single and multi modes)
  */
-int cy82c693_ide_dma_on (ide_drive_t *drive)
+static int cy82c693_ide_dma_on (ide_drive_t *drive)
 {
  struct hd_driveid *id = drive->id;
 
diff -Nru a/drivers/ide/pci/hpt366.h b/drivers/ide/pci/hpt366.h
--- a/drivers/ide/pci/hpt366.h 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/hpt366.h 2004-11-18 00:15:00 +01:00
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
  { XFER_UDMA_4, 0x900fd943 },
  { XFER_UDMA_3, 0x900ad943 },
  { XFER_UDMA_2, 0x900bd943 },
@@ -118,7 +118,7 @@
  { 0,  0x0120d9d9 }
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
  { XFER_UDMA_4, 0x90c9a731 },
  { XFER_UDMA_3, 0x90cfa731 },
  { XFER_UDMA_2, 0x90caa731 },
@@ -137,7 +137,7 @@
  { 0,  0x0120a7a7 }
 };
 
-struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
+static struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
 
  { XFER_UDMA_4, 0x90c98521 },
  { XFER_UDMA_3, 0x90cf8521 },
@@ -158,7 +158,7 @@
 };
 
 /* from highpoint documentation. these are old values */
-struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
 /* { XFER_UDMA_5, 0x1A85F442, 0x16454e31 }, */
  { XFER_UDMA_5, 0x16454e31 },
  { XFER_UDMA_4, 0x16454e31 },
@@ -179,7 +179,7 @@
  { 0,  0x06514e57 }
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
  { XFER_UDMA_6, 0x1c81dc62 },
  { XFER_UDMA_5, 0x1c6ddc62 },
  { XFER_UDMA_4, 0x1c8ddc62 },
@@ -282,7 +282,7 @@
  { 0,  0x0d029d5e }
 };
 
-struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
+static struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
  { XFER_UDMA_5, 0x12848242 },
  { XFER_UDMA_4, 0x12ac8242 },
  { XFER_UDMA_3, 0x128c8242 },
@@ -302,7 +302,7 @@
  { 0,  0x0a81f443 }
 };
 
-struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
  { XFER_UDMA_6, 0x1c869c62 },
  { XFER_UDMA_5, 0x1cae9c62 },
  { XFER_UDMA_4, 0x1c8a9c62 },
@@ -323,7 +323,7 @@
  { 0,  0x0d029d26 }
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
+static struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
  { XFER_UDMA_6, 0x12808242 },
  { XFER_UDMA_5, 0x12848242 },
  { XFER_UDMA_4, 0x12ac8242 },
@@ -345,7 +345,7 @@
 };
 
 #if 0
-struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
+static struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
  { XFER_UDMA_6, },
  { XFER_UDMA_5, },
  { XFER_UDMA_4, },
@@ -365,7 +365,7 @@
 };
 #endif
 #if 0
-struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
+static struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
  { XFER_UDMA_6, 0x12406231 }, /* checkme */
  { XFER_UDMA_5, 0x12446231 },
     0x14846231
diff -Nru a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
--- a/drivers/ide/pci/pdc202xx_new.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/pdc202xx_new.c 2004-11-18 00:15:00 +01:00
@@ -234,62 +234,6 @@
   HWIF(drive)->channel ? "Secondary" : "Primary");
 }
 
-static void pdcnew_reset_host (ide_hwif_t *hwif)
-{
-// unsigned long high_16 = hwif->dma_base - (8*(hwif->channel));
- unsigned long high_16 = hwif->dma_master;
- u8 udma_speed_flag = hwif->INB(high_16|0x001f);
-
- hwif->OUTB((udma_speed_flag | 0x10), (high_16|0x001f));
- mdelay(100);
- hwif->OUTB((udma_speed_flag & ~0x10), (high_16|0x001f));
- mdelay(2000); /* 2 seconds ?! */
-
- printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
-  hwif->channel ? "Secondary" : "Primary");
-}
-
-void pdcnew_reset (ide_drive_t *drive)
-{
- ide_hwif_t *hwif = HWIF(drive);
- ide_hwif_t *mate = hwif->mate;
- 
- pdcnew_reset_host(hwif);
- pdcnew_reset_host(mate);
-#if 0
- /*
-  * FIXME: Have to kick all the drives again :-/
-  * What a pain in the ACE!
-  */
- if (hwif->present) {
-  u16 hunit = 0;
-  for (hunit = 0; hunit < MAX_DRIVES; ++hunit) {
-   ide_drive_t *hdrive = &hwif->drives[hunit];
-   if (hdrive->present) {
-    if (hwif->ide_dma_check)
-     hwif->ide_dma_check(hdrive);
-    else
-     hwif->tuneproc(hdrive, 5);
-   }
-  }
- }
- if (mate->present) {
-  u16 munit = 0;
-  for (munit = 0; munit < MAX_DRIVES; ++munit) {
-   ide_drive_t *mdrive = &mate->drives[munit];
-   if (mdrive->present) {
-    if (mate->ide_dma_check) 
-     mate->ide_dma_check(mdrive);
-    else
-     mate->tuneproc(mdrive, 5);
-   }
-  }
- }
-#else
- hwif->tuneproc(drive, 5);
-#endif
-}
-
 #ifdef CONFIG_PPC_PMAC
 static void __devinit apple_kiwi_init(struct pci_dev *pdev)
 {
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/pdc202xx_old.c 2004-11-18 00:15:00 +01:00
@@ -457,7 +457,7 @@
   hwif->channel ? "Secondary" : "Primary");
 }
 
-void pdc202xx_reset (ide_drive_t *drive)
+static void pdc202xx_reset (ide_drive_t *drive)
 {
  ide_hwif_t *hwif = HWIF(drive);
  ide_hwif_t *mate = hwif->mate;
diff -Nru a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/sc1200.c 2004-11-18 00:15:00 +01:00
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
diff -Nru a/drivers/ide/pci/serverworks.h b/drivers/ide/pci/serverworks.h
--- a/drivers/ide/pci/serverworks.h 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/serverworks.h 2004-11-18 00:15:00 +01:00
@@ -13,7 +13,7 @@
 
 /* Seagate Barracuda ATA IV Family drives in UDMA mode 5
  * can overrun their FIFOs when used with the CSB5 */
-const char *svwks_bad_ata100[] = {
+static const char *svwks_bad_ata100[] = {
  "ST320011A",
  "ST340016A",
  "ST360021A",
diff -Nru a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
--- a/drivers/ide/pci/trm290.c 2004-11-18 00:15:00 +01:00
+++ b/drivers/ide/pci/trm290.c 2004-11-18 00:15:00 +01:00
@@ -249,7 +249,7 @@
 /*
  * Invoked from ide-dma.c at boot time.
  */
-void __devinit init_hwif_trm290(ide_hwif_t *hwif)
+static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
  unsigned int cfgbase = 0;
  unsigned long flags;
