Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbVJCWPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbVJCWPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVJCWPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:15:36 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:10689 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932722AbVJCWPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:15:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uIvNQv1vA/v7t4aVdZKDBL0OlLULBQjd18f5ylcrT/yetXt+zxNM1d0Ns6l/JFY38aguGcDoc6oDku/lQ02y3qK7sp5Cd6ZPAL1fhZ1zyBEcqcD7MKAF0lcHdQyZ2ErTKCRY8xTHmWSg/Iy8dcRT1mTV2SO92lCKFg8s9JJLUFY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Date: Tue, 4 Oct 2005 00:17:56 +0200
User-Agent: KMail/1.8.2
Cc: linux-ide@vger.kernel.org, andersen@codepoet.org, axboe@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510040017.57168.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup patch for drivers/ide/ide-cd.c

Main changes :
  CodingStyle cleanup.
  Cleanup trailing whitespace (and other whitespace related bits).
  Remove a few pointless casts.

Compile tested. I don't have hardware to do an actual test, but I don't see 
how this could break anything.

As an added bonus; the object file is 40 bytes smaller after this patch, when 
building an allyesconfig kernel, and the source file is 190 bytes smaller.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/ide/ide-cd.c |  674 +++++++++++++++++++++++++--------------------------
 1 files changed, 333 insertions(+), 341 deletions(-)

--- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c	2005-10-03 23:55:40.000000000 +0200
@@ -13,8 +13,8 @@
  *
  * Suggestions are welcome. Patches that work are more welcome though. ;-)
  * For those wishing to work on this driver, please be sure you download
- * and comply with the latest Mt. Fuji (SFF8090 version 4) and ATAPI 
- * (SFF-8020i rev 2.6) standards. These documents can be obtained by 
+ * and comply with the latest Mt. Fuji (SFF8090 version 4) and ATAPI
+ * (SFF-8020i rev 2.6) standards. These documents can be obtained by
  * anonymous ftp from:
  * ftp://fission.dt.wdc.com/pub/standards/SFF_atapi/spec/SFF8020-r2.6/PS/8020r26.ps
  * ftp://ftp.avc-pioneer.com/Mtfuji4/Spec/Fuji4r10.pdf
@@ -129,16 +129,16 @@
  * 3.14  May 29, 1996 -- Add work-around for Vertos 600.
  *                        (From Hennus Bergman <hennus@sky.ow.nl>.)
  * 3.15  July 2, 1996 -- Added support for Sanyo 3 CD changers
- *                        from Ben Galliart <bgallia@luc.edu> with 
- *                        special help from Jeff Lightfoot 
+ *                        from Ben Galliart <bgallia@luc.edu> with
+ *                        special help from Jeff Lightfoot
  *                        <jeffml@pobox.com>
  * 3.15a July 9, 1996 -- Improved Sanyo 3 CD changer identification
  * 3.16  Jul 28, 1996 -- Fix from Gadi to reduce kernel stack usage for ioctl.
  * 3.17  Sep 17, 1996 -- Tweak audio reads for some drives.
  *                       Start changing CDROMLOADFROMSLOT to CDROM_SELECT_DISC.
  * 3.18  Oct 31, 1996 -- Added module and DMA support.
- *                       
- *                       
+ *
+ *
  * 4.00  Nov 5, 1996   -- New ide-cd maintainer,
  *                                 Erik B. Andersen <andersee@debian.org>
  *                     -- Newer Creative drives don't always set the error
@@ -153,8 +153,8 @@
  *                     -- Add some probes of drive capability during setup.
  *
  * 4.01  Nov 11, 1996  -- Split into ide-cd.c and ide-cd.h
- *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTABLE 
- *                          ioctls in favor of a generalized approach 
+ *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTABLE
+ *                          ioctls in favor of a generalized approach
  *                          using the generic cdrom driver.
  *                     -- Fully integrated with the 2.1.X kernel.
  *                     -- Other stuff that I forgot (lots of changes)
@@ -163,7 +163,7 @@
  *                          to fix the drive door locking problems.
  *
  * 4.03  Dec 04, 1996  -- Added DSC overlap support.
- * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch 
+ * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch
  *                          by Ales Makarov (xmakarov@sun.felk.cvut.cz)
  *
  * 4.05  Nov 20, 1997  -- Modified to print more drive info on init
@@ -186,7 +186,7 @@
  *                     -- Cleaned up the global namespace a bit by making more
  *                         functions static that should already have been.
  * 4.11  Mar 12, 1998  -- Added support for the CDROM_SELECT_SPEED ioctl
- *                         based on a patch for 2.0.33 by Jelle Foks 
+ *                         based on a patch for 2.0.33 by Jelle Foks
  *                         <jelle@scintilla.utwente.nl>, a patch for 2.0.33
  *                         by Toni Giorgino <toni@pcape2.pi.infn.it>, the SCSI
  *                         version, and my own efforts.  -erik
@@ -194,8 +194,8 @@
  *                         inform me of where "Illegal mode for this track"
  *                         was never returned due to a comparison on data
  *                         types of limited range.
- * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write speed is 
- *                         now set ionly for CD-R and CD-RW drives.  I had 
+ * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write speed is
+ *                         now set ionly for CD-R and CD-RW drives.  I had
  *                         removed this support because it produced errors.
  *                         It produced errors _only_ for non-writers. duh.
  * 4.13  May 05, 1998  -- Suppress useless "in progress of becoming ready"
@@ -206,7 +206,7 @@
  *                         since the .pdf version doesn't seem to work...
  *                     -- Updated the TODO list to something more current.
  *
- * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect mechine endianess, 
+ * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect mechine endianess,
  *                         patch thanks to "Eddie C. Dost" <ecd@skynet.be>
  *
  * 4.50  Oct 19, 1998  -- New maintainers!
@@ -270,7 +270,7 @@
  *			- Mode sense and mode select moved to the
  *			  Uniform layer.
  *			- Fixed a problem with WPI CDS-32X drive - it
- *			  failed the capabilities 
+ *			  failed the capabilities
  *
  * 4.57  Apr 7, 2000	- Fixed sense reporting.
  *			- Fixed possible oops in ide_cdrom_get_last_session()
@@ -296,10 +296,13 @@
  *			- Odd stuff
  * 4.61  Jan 22, 2004	- support hardware sector sizes other than 2kB,
  *			  Pascal Schmidt <der.eremit@email.de>
+ * 4.62  Okt 03, 2005	- Cleanup some pointless casts, whitespace changes &
+ *			  CodingStyle cleanup.
+ *			  Jesper Juhl
  *
  *************************************************************************/
- 
-#define IDECD_VERSION "4.61"
+
+#define IDECD_VERSION "4.62"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -326,7 +329,7 @@
 
 static DECLARE_MUTEX(idecd_ref_sem);
 
-#define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref) 
+#define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref)
 
 #define ide_cd_g(disk) \
 	container_of((disk)->private_data, struct cdrom_info, driver)
@@ -358,17 +361,17 @@ static void ide_cd_put(struct cdrom_info
 
 /* Mark that we've seen a media change, and invalidate our internal
    buffers. */
-static void cdrom_saw_media_change (ide_drive_t *drive)
+static void cdrom_saw_media_change(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
-	
+
 	CDROM_STATE_FLAGS (drive)->media_changed = 1;
 	CDROM_STATE_FLAGS (drive)->toc_valid = 0;
 	info->nsectors_buffered = 0;
 }
 
 static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
-			   struct request_sense *sense)
+		struct request_sense *sense)
 {
 	int log = 0;
 
@@ -376,7 +379,8 @@ static int cdrom_log_sense(ide_drive_t *
 		return 0;
 
 	switch (sense->sense_key) {
-		case NO_SENSE: case RECOVERED_ERROR:
+		case NO_SENSE:
+		case RECOVERED_ERROR:
 			break;
 		case NOT_READY:
 			/*
@@ -411,10 +415,8 @@ static int cdrom_log_sense(ide_drive_t *
 	return log;
 }
 
-static
-void cdrom_analyze_sense_data(ide_drive_t *drive,
-			      struct request *failed_command,
-			      struct request_sense *sense)
+static void cdrom_analyze_sense_data(ide_drive_t *drive,
+		struct request *failed_command, struct request_sense *sense)
 {
 	if (!cdrom_log_sense(drive, failed_command, sense))
 		return;
@@ -456,6 +458,7 @@ void cdrom_analyze_sense_data(ide_drive_
 		} else {
 			int lo = 0, mid, hi = ARY_LEN(sense_data_texts);
 			unsigned long key = (sense->sense_key << 16);
+
 			key |= (sense->asc << 8);
 			if (!(sense->ascq >= 0x80 && sense->ascq <= 0xdd))
 				key |= sense->ascq;
@@ -467,8 +470,7 @@ void cdrom_analyze_sense_data(ide_drive_
 				    sense_data_texts[mid].asc_ascq == (0xff0000|key)) {
 					s = sense_data_texts[mid].text;
 					break;
-				}
-				else if (sense_data_texts[mid].asc_ascq > key)
+				} else if (sense_data_texts[mid].asc_ascq > key)
 					hi = mid;
 				else
 					lo = mid+1;
@@ -486,8 +488,8 @@ void cdrom_analyze_sense_data(ide_drive_
 			s, sense->asc, sense->ascq);
 
 		if (failed_command != NULL) {
-
 			int lo=0, mid, hi= ARY_LEN (packet_command_texts);
+
 			s = NULL;
 
 			while (hi > lo) {
@@ -505,9 +507,9 @@ void cdrom_analyze_sense_data(ide_drive_
 			}
 
 			printk (KERN_ERR "  The failed \"%s\" packet command was: \n  \"", s);
-			for (i=0; i<sizeof (failed_command->cmd); i++)
-				printk ("%02x ", failed_command->cmd[i]);
-			printk ("\"\n");
+			for (i = 0; i < sizeof(failed_command->cmd); i++)
+				printk("%02x ", failed_command->cmd[i]);
+			printk("\"\n");
 		}
 
 		/* The SKSV bit specifies validity of the sense_key_specific
@@ -531,7 +533,7 @@ void cdrom_analyze_sense_data(ide_drive_
 			if ((sense->sks[0] & 0x40) != 0)
 				printk (" bit %d", sense->sks[0] & 0x07);
 
-			printk ("\n");
+			printk("\n");
 		}
 	}
 
@@ -565,10 +567,10 @@ static void cdrom_prepare_request(ide_dr
 }
 
 static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
-				      struct request *failed_command)
+		struct request *failed_command)
 {
-	struct cdrom_info *info		= drive->driver_data;
-	struct request *rq		= &info->request_sense_request;
+	struct cdrom_info *info	= drive->driver_data;
+	struct request *rq	= &info->request_sense_request;
 
 	if (sense == NULL)
 		sense = &info->sense_data;
@@ -583,12 +585,12 @@ static void cdrom_queue_request_sense(id
 	rq->flags = REQ_SENSE;
 
 	/* NOTE! Save the failed command in "rq->buffer" */
-	rq->buffer = (void *) failed_command;
+	rq->buffer = (void *)failed_command;
 
-	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
+	(void)ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
-static void cdrom_end_request (ide_drive_t *drive, int uptodate)
+static void cdrom_end_request(ide_drive_t *drive, int uptodate)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	int nsectors = rq->hard_cur_sectors;
@@ -598,7 +600,7 @@ static void cdrom_end_request (ide_drive
 		 * For REQ_SENSE, "rq->buffer" points to the original failed
 		 * request
 		 */
-		struct request *failed = (struct request *) rq->buffer;
+		struct request *failed = (struct request *)rq->buffer;
 		struct cdrom_info *info = drive->driver_data;
 		void *sense = &info->sense_data;
 		unsigned long flags;
@@ -638,7 +640,7 @@ static int cdrom_decode_status(ide_drive
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	int stat, err, sense_key;
-	
+
 	/* Check for errors. */
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (stat_ret)
@@ -689,7 +691,7 @@ static int cdrom_decode_status(ide_drive
 			/* Otherwise, print an error. */
 			ide_dump_status(drive, "packet command error", stat);
 		}
-		
+
 		rq->flags |= REQ_FAILED;
 
 		/*
@@ -721,7 +723,7 @@ static int cdrom_decode_status(ide_drive
 				cdrom_saw_media_change (drive);
 
 				/* Fail the request. */
-				printk ("%s: tray open\n", drive->name);
+				printk("%s: tray open\n", drive->name);
 				do_end_request = 1;
 			} else {
 				struct cdrom_info *info = drive->driver_data;
@@ -763,7 +765,7 @@ static int cdrom_decode_status(ide_drive
 			ide_dump_status (drive, "command error", stat);
 			do_end_request = 1;
 		} else if (sense_key == MEDIUM_ERROR) {
-			/* No point in re-trying a zillion times on a bad 
+			/* No point in re-trying a zillion times on a bad
 			 * sector...  If we got here the error is not correctable */
 			ide_dump_status (drive, "media error (bad sector)", stat);
 			do_end_request = 1;
@@ -809,18 +811,19 @@ static int cdrom_timer_expiry(ide_drive_
 	 * ide_timer_expiry keep polling us for these.
 	 */
 	switch (rq->cmd[0]) {
-		case GPCMD_BLANK:
-		case GPCMD_FORMAT_UNIT:
-		case GPCMD_RESERVE_RZONE_TRACK:
-		case GPCMD_CLOSE_TRACK:
-		case GPCMD_FLUSH_CACHE:
-			wait = ATAPI_WAIT_PC;
-			break;
-		default:
-			if (!(rq->flags & REQ_QUIET))
-				printk(KERN_INFO "ide-cd: cmd 0x%x timed out\n", rq->cmd[0]);
-			wait = 0;
-			break;
+	case GPCMD_BLANK:
+	case GPCMD_FORMAT_UNIT:
+	case GPCMD_RESERVE_RZONE_TRACK:
+	case GPCMD_CLOSE_TRACK:
+	case GPCMD_FLUSH_CACHE:
+		wait = ATAPI_WAIT_PC;
+		break;
+	default:
+		if (!(rq->flags & REQ_QUIET))
+			printk(KERN_INFO "ide-cd: cmd 0x%x timed out\n",
+				rq->cmd[0]);
+		wait = 0;
+		break;
 	}
 	return wait;
 }
@@ -833,8 +836,7 @@ static int cdrom_timer_expiry(ide_drive_
    will be called immediately after the drive is prepared for the transfer. */
 
 static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
-						  int xferlen,
-						  ide_handler_t *handler)
+		int xferlen, ide_handler_t *handler)
 {
 	ide_startstop_t startstop;
 	struct cdrom_info *info = drive->driver_data;
@@ -855,12 +857,14 @@ static ide_startstop_t cdrom_start_packe
 
 	HWIF(drive)->OUTB(xferlen & 0xff, IDE_BCOUNTL_REG);
 	HWIF(drive)->OUTB(xferlen >> 8  , IDE_BCOUNTH_REG);
+
 	if (IDE_CONTROL_REG)
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
- 
+
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* packet command */
-		ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
+		ide_execute_command(drive, WIN_PACKETCMD, handler,
+			ATAPI_WAIT_PC, cdrom_timer_expiry);
 		return ide_started;
 	} else {
 		unsigned long flags;
@@ -871,7 +875,7 @@ static ide_startstop_t cdrom_start_packe
 		ndelay(400);
 		spin_unlock_irqrestore(&ide_lock, flags);
 
-		return (*handler) (drive);
+		return (*handler)(drive);
 	}
 }
 
@@ -885,9 +889,8 @@ static ide_startstop_t cdrom_start_packe
  * struct packet_command *pc; now packet_command_t *pc;
  */
 #define ATAPI_MIN_CDB_BYTES 12
-static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *drive,
-					  struct request *rq,
-					  ide_handler_t *handler)
+static ide_startstop_t cdrom_transfer_packet_command(ide_drive_t *drive,
+		struct request *rq, ide_handler_t *handler)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	int cmd_len;
@@ -937,8 +940,8 @@ static ide_startstop_t cdrom_transfer_pa
  * sector added, SECTOR is its sector number.  (SECTOR is then ignored until
  * the buffer is cleared.)
  */
-static void cdrom_buffer_sectors (ide_drive_t *drive, unsigned long sector,
-                                  int sectors_to_transfer)
+static void cdrom_buffer_sectors(ide_drive_t *drive, unsigned long sector,
+		int sectors_to_transfer)
 {
 	struct cdrom_info *info = drive->driver_data;
 
@@ -980,24 +983,24 @@ static void cdrom_buffer_sectors (ide_dr
  * and attempt to recover if there are problems.  Returns  0 if everything's
  * ok; nonzero if the request has been terminated.
  */
-static inline
-int cdrom_read_check_ireason (ide_drive_t *drive, int len, int ireason)
+static inline int cdrom_read_check_ireason(ide_drive_t *drive, int len,
+		int ireason)
 {
 	if (ireason == 2)
 		return 0;
 	else if (ireason == 0) {
 		/* Whoops... The drive is expecting to receive data from us! */
-		printk(KERN_ERR "%s: read_intr: Drive wants to transfer data the "
-						"wrong way!\n", drive->name);
+		printk(KERN_ERR "%s: read_intr: Drive wants to transfer data "
+				"the wrong way!\n", drive->name);
 
 		/* Throw some data at the drive so it doesn't hang
 		   and quit this request. */
 		while (len > 0) {
 			int dum = 0;
-			HWIF(drive)->atapi_output_bytes(drive, &dum, sizeof (dum));
-			len -= sizeof (dum);
+			HWIF(drive)->atapi_output_bytes(drive, &dum, sizeof(dum));
+			len -= sizeof(dum);
 		}
-	} else  if (ireason == 1) {
+	} else if (ireason == 1) {
 		/* Some drives (ASUS) seem to tell us that status
 		 * info is available. just get it and ignore.
 		 */
@@ -1005,8 +1008,8 @@ int cdrom_read_check_ireason (ide_drive_
 		return 0;
 	} else {
 		/* Drive wants a command packet, or invalid ireason... */
-		printk(KERN_ERR "%s: read_intr: bad interrupt reason %x\n", drive->name,
-								ireason);
+		printk(KERN_ERR "%s: read_intr: bad interrupt reason %x\n",
+				drive->name, ireason);
 	}
 
 	cdrom_end_request(drive, 0);
@@ -1016,14 +1019,13 @@ int cdrom_read_check_ireason (ide_drive_
 /*
  * Interrupt routine.  Called when a read request has completed.
  */
-static ide_startstop_t cdrom_read_intr (ide_drive_t *drive)
+static ide_startstop_t cdrom_read_intr(ide_drive_t *drive)
 {
 	int stat;
 	int ireason, len, sectors_to_transfer, nskip;
 	struct cdrom_info *info = drive->driver_data;
 	u8 lowcyl = 0, highcyl = 0;
 	int dma = info->dma, dma_error = 0;
-
 	struct request *rq = HWGROUP(drive)->rq;
 
 	/*
@@ -1058,8 +1060,9 @@ static ide_startstop_t cdrom_read_intr (
 		/* If we're not done filling the current buffer, complain.
 		   Otherwise, complete the command normally. */
 		if (rq->current_nr_sectors > 0) {
-			printk (KERN_ERR "%s: cdrom_read_intr: data underrun (%d blocks)\n",
-				drive->name, rq->current_nr_sectors);
+			printk(KERN_ERR "%s: cdrom_read_intr: data underrun "
+					"(%d blocks)\n",
+					drive->name, rq->current_nr_sectors);
 			rq->flags |= REQ_FAILED;
 			cdrom_end_request(drive, 0);
 		} else
@@ -1068,19 +1071,20 @@ static ide_startstop_t cdrom_read_intr (
 	}
 
 	/* Check that the drive is expecting to do the same thing we are. */
-	if (cdrom_read_check_ireason (drive, len, ireason))
+	if (cdrom_read_check_ireason(drive, len, ireason))
 		return ide_stopped;
 
 	/* Assume that the drive will always provide data in multiples
 	   of at least SECTOR_SIZE, as it gets hairy to keep track
 	   of the transfers otherwise. */
 	if ((len % SECTOR_SIZE) != 0) {
-		printk (KERN_ERR "%s: cdrom_read_intr: Bad transfer size %d\n",
+		printk(KERN_ERR "%s: cdrom_read_intr: Bad transfer size %d\n",
 			drive->name, len);
 		if (CDROM_CONFIG_FLAGS(drive)->limit_nframes)
-			printk (KERN_ERR "  This drive is not supported by this version of the driver\n");
+			printk(KERN_ERR "  This drive is not supported by this"
+					" version of the driver\n");
 		else {
-			printk (KERN_ERR "  Trying to limit transfer sizes\n");
+			printk(KERN_ERR "  Trying to limit transfer sizes\n");
 			CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
 		}
 		cdrom_end_request(drive, 0);
@@ -1092,13 +1096,14 @@ static ide_startstop_t cdrom_read_intr (
 
 	/* First, figure out if we need to bit-bucket
 	   any of the leading sectors. */
-	nskip = min_t(int, rq->current_nr_sectors - bio_cur_sectors(rq->bio), sectors_to_transfer);
+	nskip = min_t(int, rq->current_nr_sectors - bio_cur_sectors(rq->bio),
+			sectors_to_transfer);
 
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
 		static char dum[SECTOR_SIZE];
-		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
 
+		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof(dum));
 		--rq->current_nr_sectors;
 		--nskip;
 		--sectors_to_transfer;
@@ -1123,7 +1128,7 @@ static ide_startstop_t cdrom_read_intr (
 			   Figure out how many sectors we can transfer
 			   to the current buffer. */
 			this_transfer = min_t(int, sectors_to_transfer,
-					     rq->current_nr_sectors);
+						rq->current_nr_sectors);
 
 			/* Read this_transfer sectors
 			   into the current buffer. */
@@ -1148,7 +1153,7 @@ static ide_startstop_t cdrom_read_intr (
  * Try to satisfy some of the current read request from our cached data.
  * Returns nonzero if the request has been completed, zero otherwise.
  */
-static int cdrom_read_from_buffer (ide_drive_t *drive)
+static int cdrom_read_from_buffer(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -1157,7 +1162,8 @@ static int cdrom_read_from_buffer (ide_d
 	sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/* Can't do anything if there's no buffer. */
-	if (info->buffer == NULL) return 0;
+	if (info->buffer == NULL)
+		return 0;
 
 	/* Loop while this request needs data and the next block is present
 	   in our cache. */
@@ -1167,7 +1173,7 @@ static int cdrom_read_from_buffer (ide_d
 		if (rq->current_nr_sectors == 0)
 			cdrom_end_request(drive, 1);
 
-		memcpy (rq->buffer,
+		memcpy(rq->buffer,
 			info->buffer +
 			(rq->sector - info->sector_buffered) * SECTOR_SIZE,
 			SECTOR_SIZE);
@@ -1209,7 +1215,7 @@ static int cdrom_read_from_buffer (ide_d
  * However, for drq_interrupt devices, it is called from an interrupt
  * when the drive is ready to accept the command.
  */
-static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
+static ide_startstop_t cdrom_start_read_continuation(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	unsigned short sectors_per_frame;
@@ -1229,8 +1235,9 @@ static ide_startstop_t cdrom_start_read_
 		/* Sanity check... */
 		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
 			(rq->sector & (sectors_per_frame - 1))) {
-			printk(KERN_ERR "%s: cdrom_start_read_continuation: buffer botch (%u)\n",
-				drive->name, rq->current_nr_sectors);
+			printk(KERN_ERR "%s: cdrom_start_read_continuation: "
+					"buffer botch (%u)\n",
+					drive->name, rq->current_nr_sectors);
 			cdrom_end_request(drive, 0);
 			return ide_stopped;
 		}
@@ -1249,7 +1256,7 @@ static ide_startstop_t cdrom_start_read_
 #define IDECD_SEEK_TIMER	(5 * WAIT_MIN_SLEEP)	/* 100 ms */
 #define IDECD_SEEK_TIMEOUT	(2 * WAIT_CMD)		/* 20 sec */
 
-static ide_startstop_t cdrom_seek_intr (ide_drive_t *drive)
+static ide_startstop_t cdrom_seek_intr(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
 	int stat;
@@ -1265,14 +1272,16 @@ static ide_startstop_t cdrom_seek_intr (
 			 * this condition is far too common, to bother
 			 * users about it
 			 */
-			/* printk("%s: disabled DSC seek overlap\n", drive->name);*/ 
+			/* printk("%s: disabled DSC seek overlap\n",
+			 *		drive->name);
+			 */
 			drive->dsc_overlap = 0;
 		}
 	}
 	return ide_stopped;
 }
 
-static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
+static ide_startstop_t cdrom_start_seek_continuation(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	sector_t frame = rq->sector;
@@ -1281,28 +1290,29 @@ static ide_startstop_t cdrom_start_seek_
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
-	put_unaligned(cpu_to_be32(frame), (unsigned int *) &rq->cmd[2]);
+	put_unaligned(cpu_to_be32(frame), (unsigned int *)&rq->cmd[2]);
 
 	rq->timeout = ATAPI_WAIT_PC;
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_seek_intr);
 }
 
-static ide_startstop_t cdrom_start_seek (ide_drive_t *drive, unsigned int block)
+static ide_startstop_t cdrom_start_seek(ide_drive_t *drive, unsigned int block)
 {
 	struct cdrom_info *info = drive->driver_data;
 
 	info->dma = 0;
 	info->cmd = 0;
 	info->start_seek = jiffies;
-	return cdrom_start_packet_command(drive, 0, cdrom_start_seek_continuation);
+	return cdrom_start_packet_command(drive, 0,
+						cdrom_start_seek_continuation);
 }
 
 /* Fix up a possibly partially-processed request so that we can
    start it over entirely, or even put it back on the request queue. */
-static void restore_request (struct request *rq)
+static void restore_request(struct request *rq)
 {
 	if (rq->buffer != bio_data(rq->bio)) {
-		sector_t n = (rq->buffer - (char *) bio_data(rq->bio)) / SECTOR_SIZE;
+		sector_t n = (rq->buffer - (char *)bio_data(rq->bio)) / SECTOR_SIZE;
 
 		rq->buffer = bio_data(rq->bio);
 		rq->nr_sectors += n;
@@ -1317,7 +1327,7 @@ static void restore_request (struct requ
 /*
  * Start a read request from the CD-ROM.
  */
-static ide_startstop_t cdrom_start_read (ide_drive_t *drive, unsigned int block)
+static ide_startstop_t cdrom_start_read(ide_drive_t *drive, unsigned int block)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -1355,7 +1365,7 @@ static ide_startstop_t cdrom_start_read 
  */
 
 /* Interrupt routine for packet command completion. */
-static ide_startstop_t cdrom_pc_intr (ide_drive_t *drive)
+static ide_startstop_t cdrom_pc_intr(ide_drive_t *drive)
 {
 	int ireason, len, thislen;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -1390,8 +1400,8 @@ static ide_startstop_t cdrom_pc_intr (id
 		if (rq->data_len == 0)
 			cdrom_end_request(drive, 1);
 		else {
-			/* Comment this out, because this always happens 
-			   right after a reset occurs, and it is annoying to 
+			/* Comment this out, because this always happens
+			   right after a reset occurs, and it is annoying to
 			   always print expected stuff.  */
 			/*
 			printk ("%s: cdrom_pc_intr: data underrun %d\n",
@@ -1405,7 +1415,8 @@ static ide_startstop_t cdrom_pc_intr (id
 
 	/* Figure out how much data to transfer. */
 	thislen = rq->data_len;
-	if (thislen > len) thislen = len;
+	if (thislen > len)
+		thislen = len;
 
 	/* The drive wants to be written to. */
 	if ((ireason & 3) == 0) {
@@ -1420,6 +1431,7 @@ static ide_startstop_t cdrom_pc_intr (id
 		   add some padding. */
 		while (len > thislen) {
 			int dum = 0;
+
 			HWIF(drive)->atapi_output_bytes(drive, &dum, sizeof(dum));
 			len -= sizeof(dum);
 		}
@@ -1427,10 +1439,7 @@ static ide_startstop_t cdrom_pc_intr (id
 		/* Keep count of how much data we've moved. */
 		rq->data += thislen;
 		rq->data_len -= thislen;
-	}
-
-	/* Same drill for reading. */
-	else if ((ireason & 3) == 2) {
+	} else if ((ireason & 3) == 2) { /* Same drill for reading. */
 		if (!rq->data) {
 			blk_dump_rq_flags(rq, "cdrom_pc_intr, write");
 			goto confused;
@@ -1442,6 +1451,7 @@ static ide_startstop_t cdrom_pc_intr (id
 		   add some padding. */
 		while (len > thislen) {
 			int dum = 0;
+
 			HWIF(drive)->atapi_input_bytes(drive, &dum, sizeof(dum));
 			len -= sizeof(dum);
 		}
@@ -1454,18 +1464,19 @@ static ide_startstop_t cdrom_pc_intr (id
 			rq->sense_len += thislen;
 	} else {
 confused:
-		printk (KERN_ERR "%s: cdrom_pc_intr: The drive "
-			"appears confused (ireason = 0x%02x)\n",
-			drive->name, ireason);
+		printk(KERN_ERR "%s: cdrom_pc_intr: The drive "
+				"appears confused (ireason = 0x%02x)\n",
+				drive->name, ireason);
 		rq->flags |= REQ_FAILED;
 	}
 
 	/* Now we wait for another interrupt. */
-	ide_set_handler(drive, &cdrom_pc_intr, ATAPI_WAIT_PC, cdrom_timer_expiry);
+	ide_set_handler(drive, &cdrom_pc_intr, ATAPI_WAIT_PC,
+			cdrom_timer_expiry);
 	return ide_started;
 }
 
-static ide_startstop_t cdrom_do_pc_continuation (ide_drive_t *drive)
+static ide_startstop_t cdrom_do_pc_continuation(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 
@@ -1477,7 +1488,7 @@ static ide_startstop_t cdrom_do_pc_conti
 }
 
 
-static ide_startstop_t cdrom_do_packet_command (ide_drive_t *drive)
+static ide_startstop_t cdrom_do_packet_command(ide_drive_t *drive)
 {
 	int len;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -1493,8 +1504,7 @@ static ide_startstop_t cdrom_do_packet_c
 }
 
 
-static
-int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
+static int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
 {
 	struct request_sense sense;
 	int retries = 10;
@@ -1507,12 +1517,12 @@ int cdrom_queue_packet_command(ide_drive
 	do {
 		int error;
 		unsigned long time = jiffies;
-		rq->flags = flags;
 
+		rq->flags = flags;
 		error = ide_do_drive_cmd(drive, rq, ide_wait);
 		time = jiffies - time;
 
-		/* FIXME: we should probably abort/retry or something 
+		/* FIXME: we should probably abort/retry or something
 		 * in case of failure */
 		if (rq->flags & REQ_FAILED) {
 			/* The request failed.  Retry if it was due to a unit
@@ -1545,7 +1555,8 @@ int cdrom_queue_packet_command(ide_drive
 /*
  * Write handling
  */
-static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
+static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len,
+		int ireason)
 {
 	/* Two notes about IDE interrupt reason here - 0 means that
 	 * the drive wants to receive data from us, 2 means that
@@ -1556,17 +1567,18 @@ static inline int cdrom_write_check_irea
 	else if (ireason == 2) {
 		/* Whoops... The drive wants to send data. */
 		printk(KERN_ERR "%s: write_intr: wrong transfer direction!\n",
-							drive->name);
+				drive->name);
 
 		while (len > 0) {
 			int dum = 0;
+
 			HWIF(drive)->atapi_input_bytes(drive, &dum, sizeof(dum));
 			len -= sizeof(dum);
 		}
 	} else {
 		/* Drive wants a command packet, or invalid ireason... */
 		printk(KERN_ERR "%s: write_intr: bad interrupt reason %x\n",
-							drive->name, ireason);
+				drive->name, ireason);
 	}
 
 	cdrom_end_request(drive, 0);
@@ -1696,7 +1708,8 @@ static ide_startstop_t cdrom_newpc_intr(
 		}
 
 		if (!ptr) {
-			printk(KERN_ERR "%s: confused, missing data\n", drive->name);
+			printk(KERN_ERR "%s: confused, missing data\n",
+					drive->name);
 			break;
 		}
 
@@ -1791,8 +1804,9 @@ static ide_startstop_t cdrom_write_intr(
 		 */
 		uptodate = 1;
 		if (rq->current_nr_sectors > 0) {
-			printk(KERN_ERR "%s: write_intr: data underrun (%d blocks)\n",
-			drive->name, rq->current_nr_sectors);
+			printk(KERN_ERR "%s: write_intr: data underrun "
+					"(%d blocks)\n",
+					drive->name, rq->current_nr_sectors);
 			uptodate = 0;
 		}
 		cdrom_end_request(drive, uptodate);
@@ -1819,10 +1833,12 @@ static ide_startstop_t cdrom_write_intr(
 		/*
 		 * Figure out how many sectors we can transfer
 		 */
-		this_transfer = min_t(int, sectors_to_transfer, rq->current_nr_sectors);
+		this_transfer = min_t(int, sectors_to_transfer,
+					rq->current_nr_sectors);
 
 		while (this_transfer > 0) {
-			HWIF(drive)->atapi_output_bytes(drive, rq->buffer, SECTOR_SIZE);
+			HWIF(drive)->atapi_output_bytes(drive, rq->buffer,
+							SECTOR_SIZE);
 			rq->buffer += SECTOR_SIZE;
 			--rq->nr_sectors;
 			--rq->current_nr_sectors;
@@ -1859,7 +1875,8 @@ static ide_startstop_t cdrom_start_write
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct gendisk *g = info->disk;
-	unsigned short sectors_per_frame = queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+	unsigned short sectors_per_frame =
+			queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
 	/*
 	 * writes *must* be hardware frame aligned
@@ -1923,7 +1940,8 @@ static ide_startstop_t cdrom_do_block_pc
 	 */
 	if (rq->bio) {
 		int mask = drive->queue->dma_alignment;
-		unsigned long addr = (unsigned long) page_address(bio_page(rq->bio));
+		unsigned long addr =
+				(unsigned long)page_address(bio_page(rq->bio));
 
 		info->cmd = rq_data_dir(rq);
 		info->dma = drive->using_dma;
@@ -1939,14 +1957,15 @@ static ide_startstop_t cdrom_do_block_pc
 	}
 
 	/* Start sending the command to the drive. */
-	return cdrom_start_packet_command(drive, rq->data_len, cdrom_do_newpc_cont);
+	return cdrom_start_packet_command(drive, rq->data_len,
+						cdrom_do_newpc_cont);
 }
 
 /****************************************************************************
  * cdrom driver request routine.
  */
-static ide_startstop_t
-ide_do_rw_cdrom (ide_drive_t *drive, struct request *rq, sector_t block)
+static ide_startstop_t ide_do_rw_cdrom(ide_drive_t *drive, struct request *rq,
+		sector_t block)
 {
 	ide_startstop_t action;
 	struct cdrom_info *info = drive->driver_data;
@@ -1958,14 +1977,18 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
 
 			if ((stat & SEEK_STAT) != SEEK_STAT) {
 				if (elapsed < IDECD_SEEK_TIMEOUT) {
-					ide_stall_queue(drive, IDECD_SEEK_TIMER);
+					ide_stall_queue(drive,
+							IDECD_SEEK_TIMER);
 					return ide_stopped;
 				}
-				printk (KERN_ERR "%s: DSC timeout\n", drive->name);
+				printk(KERN_ERR "%s: DSC timeout\n",
+						drive->name);
 			}
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
-		if ((rq_data_dir(rq) == READ) && IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
+		if ((rq_data_dir(rq) == READ) &&
+				IDE_LARGE_SEEK(info->last_block, block,
+				IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			action = cdrom_start_seek(drive, block);
 		} else {
 			if (rq_data_dir(rq) == READ)
@@ -1992,8 +2015,6 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
 	return ide_stopped;
 }
 
-
-
 /****************************************************************************
  * Ioctl handling.
  *
@@ -2005,21 +2026,17 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
  */
 
 #if ! STANDARD_ATAPI
-static inline
-int bin2bcd (int x)
+static inline int bin2bcd(int x)
 {
 	return (x%10) | ((x/10) << 4);
 }
 
-
-static inline
-int bcd2bin (int x)
+static inline int bcd2bin(int x)
 {
 	return (x >> 4) * 10 + (x & 0x0f);
 }
 
-static
-void msf_from_bcd (struct atapi_msf *msf)
+static void msf_from_bcd(struct atapi_msf *msf)
 {
 	msf->minute = bcd2bin (msf->minute);
 	msf->second = bcd2bin (msf->second);
@@ -2028,9 +2045,7 @@ void msf_from_bcd (struct atapi_msf *msf
 
 #endif /* not STANDARD_ATAPI */
 
-
-static inline
-void lba_to_msf (int lba, byte *m, byte *s, byte *f)
+static inline void lba_to_msf(int lba, byte *m, byte *s, byte *f)
 {
 	lba += CD_MSF_OFFSET;
 	lba &= 0xffffff;  /* negative lbas use only 24 bits */
@@ -2041,8 +2056,7 @@ void lba_to_msf (int lba, byte *m, byte 
 }
 
 
-static inline
-int msf_to_lba (byte m, byte s, byte f)
+static inline int msf_to_lba(byte m, byte s, byte f)
 {
 	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
 }
@@ -2060,7 +2074,7 @@ static int cdrom_check_status(ide_drive_
 	req.flags |= REQ_QUIET;
 
 #if ! STANDARD_ATAPI
-        /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to 
+        /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to
            switch CDs instead of supporting the LOAD_UNLOAD opcode   */
 
 	req.cmd[7] = cdi->sanyo_slot % 3;
@@ -2071,8 +2085,8 @@ static int cdrom_check_status(ide_drive_
 
 
 /* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
-static int
-cdrom_lockdoor(ide_drive_t *drive, int lockflag, struct request_sense *sense)
+static int cdrom_lockdoor(ide_drive_t *drive, int lockflag,
+		struct request_sense *sense)
 {
 	struct request_sense my_sense;
 	struct request req;
@@ -2097,12 +2111,12 @@ cdrom_lockdoor(ide_drive_t *drive, int l
 	if (stat != 0 &&
 	    sense->sense_key == ILLEGAL_REQUEST &&
 	    (sense->asc == 0x24 || sense->asc == 0x20)) {
-		printk (KERN_ERR "%s: door locking not supported\n",
-			drive->name);
+		printk(KERN_ERR "%s: door locking not supported\n",
+				drive->name);
 		CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
 		stat = 0;
 	}
-	
+
 	/* no medium, that's alright. */
 	if (stat != 0 && sense->sense_key == NOT_READY && sense->asc == 0x3a)
 		stat = 0;
@@ -2113,18 +2127,17 @@ cdrom_lockdoor(ide_drive_t *drive, int l
 	return stat;
 }
 
-
 /* Eject the disk if EJECTFLAG is 0.
    If EJECTFLAG is 1, try to reload the disk. */
 static int cdrom_eject(ide_drive_t *drive, int ejectflag,
-		       struct request_sense *sense)
+		struct request_sense *sense)
 {
 	struct request req;
 	char loej = 0x02;
 
 	if (CDROM_CONFIG_FLAGS(drive)->no_eject && !ejectflag)
 		return -EDRIVE_CANT_DO_THIS;
-	
+
 	/* reload fails on some drives, if the tray is locked */
 	if (CDROM_STATE_FLAGS(drive)->door_locked && ejectflag)
 		return 0;
@@ -2142,17 +2155,15 @@ static int cdrom_eject(ide_drive_t *driv
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
-			       unsigned long *sectors_per_frame,
-			       struct request_sense *sense)
+		unsigned long *sectors_per_frame, struct request_sense *sense)
 {
+	int stat;
+	struct request req;
 	struct {
 		__u32 lba;
 		__u32 blocklen;
 	} capbuf;
 
-	int stat;
-	struct request req;
-
 	cdrom_prepare_request(drive, &req);
 
 	req.sense = sense;
@@ -2171,8 +2182,7 @@ static int cdrom_read_capacity(ide_drive
 }
 
 static int cdrom_read_tocentry(ide_drive_t *drive, int trackno, int msf_flag,
-				int format, char *buf, int buflen,
-				struct request_sense *sense)
+		int format, char *buf, int buflen, struct request_sense *sense)
 {
 	struct request req;
 
@@ -2211,25 +2221,25 @@ static int cdrom_read_toc(ide_drive_t *d
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
-		toc = (struct atapi_toc *) kmalloc (sizeof (struct atapi_toc),
-						    GFP_KERNEL);
+		toc = kmalloc(sizeof(struct atapi_toc), GFP_KERNEL);
 		info->toc = toc;
 		if (toc == NULL) {
-			printk (KERN_ERR "%s: No cdrom TOC buffer!\n", drive->name);
+			printk(KERN_ERR "%s: No cdrom TOC buffer!\n",
+					drive->name);
 			return -ENOMEM;
 		}
 	}
 
 	/* Check to see if the existing data is still valid.
 	   If it is, just return. */
-	(void) cdrom_check_status(drive, sense);
+	(void)cdrom_check_status(drive, sense);
 
 	if (CDROM_STATE_FLAGS(drive)->toc_valid)
 		return 0;
 
 	/* Try to get the total cdrom capacity and sector size. */
 	stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
-				   sense);
+				sense);
 	if (stat)
 		toc->capacity = 0x1fffff;
 
@@ -2238,9 +2248,10 @@ static int cdrom_read_toc(ide_drive_t *d
 				sectors_per_frame << SECTOR_BITS);
 
 	/* First read just the header, so we know how long the TOC is. */
-	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
-				    sizeof(struct atapi_toc_header), sense);
-	if (stat) return stat;
+	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *)&toc->hdr,
+				sizeof(struct atapi_toc_header), sense);
+	if (stat)
+		return stat;
 
 #if ! STANDARD_ATAPI
 	if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd) {
@@ -2257,10 +2268,10 @@ static int cdrom_read_toc(ide_drive_t *d
 
 	/* Now read the whole schmeer. */
 	stat = cdrom_read_tocentry(drive, toc->hdr.first_track, 1, 0,
-				  (char *)&toc->hdr,
-				   sizeof(struct atapi_toc_header) +
-				   (ntracks + 1) *
-				   sizeof(struct atapi_toc_entry), sense);
+				(char *)&toc->hdr,
+				sizeof(struct atapi_toc_header) +
+				(ntracks + 1) *
+				sizeof(struct atapi_toc_entry), sense);
 
 	if (stat && toc->hdr.first_track > 1) {
 		/* Cds with CDI tracks only don't have any TOC entries,
@@ -2279,9 +2290,10 @@ static int cdrom_read_toc(ide_drive_t *d
 					   (ntracks + 1) *
 					   sizeof(struct atapi_toc_entry),
 					   sense);
-		if (stat) {
+
+ 		if (stat)
 			return stat;
-		}
+
 #if ! STANDARD_ATAPI
 		if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd) {
 			toc->hdr.first_track = bin2bcd(CDROM_LEADOUT);
@@ -2306,7 +2318,7 @@ static int cdrom_read_toc(ide_drive_t *d
 	}
 #endif  /* not STANDARD_ATAPI */
 
-	for (i=0; i<=ntracks; i++) {
+	for (i = 0; i <= ntracks; i++) {
 #if ! STANDARD_ATAPI
 		if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd) {
 			if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd)
@@ -2314,17 +2326,18 @@ static int cdrom_read_toc(ide_drive_t *d
 			msf_from_bcd(&toc->ent[i].addr.msf);
 		}
 #endif  /* not STANDARD_ATAPI */
-		toc->ent[i].addr.lba = msf_to_lba (toc->ent[i].addr.msf.minute,
-						   toc->ent[i].addr.msf.second,
-						   toc->ent[i].addr.msf.frame);
+		toc->ent[i].addr.lba = msf_to_lba(toc->ent[i].addr.msf.minute,
+						toc->ent[i].addr.msf.second,
+						toc->ent[i].addr.msf.frame);
 	}
 
 	/* Read the multisession information. */
 	if (toc->hdr.first_track != CDROM_LEADOUT) {
 		/* Read the multisession information. */
 		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
-					   sizeof(ms_tmp), sense);
-		if (stat) return stat;
+					sizeof(ms_tmp), sense);
+		if (stat)
+			return stat;
 
 		toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
 	} else {
@@ -2336,14 +2349,14 @@ static int cdrom_read_toc(ide_drive_t *d
 	if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd) {
 		/* Re-read multisession information using MSF format */
 		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
-					   sizeof(ms_tmp), sense);
+					sizeof(ms_tmp), sense);
 		if (stat)
 			return stat;
 
 		msf_from_bcd (&ms_tmp.ent.addr.msf);
 		toc->last_session_lba = msf_to_lba(ms_tmp.ent.addr.msf.minute,
-					  	   ms_tmp.ent.addr.msf.second,
-						   ms_tmp.ent.addr.msf.frame);
+					  	ms_tmp.ent.addr.msf.second,
+						ms_tmp.ent.addr.msf.frame);
 	}
 #endif  /* not STANDARD_ATAPI */
 
@@ -2364,7 +2377,7 @@ static int cdrom_read_toc(ide_drive_t *d
 
 
 static int cdrom_read_subchannel(ide_drive_t *drive, int format, char *buf,
-				 int buflen, struct request_sense *sense)
+		int buflen, struct request_sense *sense)
 {
 	struct request req;
 
@@ -2385,7 +2398,7 @@ static int cdrom_read_subchannel(ide_dri
 /* ATAPI cdrom drives are free to select the speed you request or any slower
    rate :-( Requesting too fast a speed will _not_ produce an error. */
 static int cdrom_select_speed(ide_drive_t *drive, int speed,
-			      struct request_sense *sense)
+		struct request_sense *sense)
 {
 	struct request req;
 	cdrom_prepare_request(drive, &req);
@@ -2398,7 +2411,7 @@ static int cdrom_select_speed(ide_drive_
 
 	req.cmd[0] = GPCMD_SET_SPEED;
 	/* Read Drive speed in kbytes/second MSB */
-	req.cmd[2] = (speed >> 8) & 0xff;	
+	req.cmd[2] = (speed >> 8) & 0xff;
 	/* Read Drive speed in kbytes/second LSB */
 	req.cmd[3] = speed & 0xff;
 	if (CDROM_CONFIG_FLAGS(drive)->cd_r ||
@@ -2429,7 +2442,7 @@ static int cdrom_play_audio(ide_drive_t 
 }
 
 static int cdrom_get_toc_entry(ide_drive_t *drive, int track,
-				struct atapi_toc_entry **ent)
+		struct atapi_toc_entry **ent)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct atapi_toc *toc = info->toc;
@@ -2457,10 +2470,11 @@ static int cdrom_get_toc_entry(ide_drive
 
 /* the generic packet interface to cdrom.c */
 static int ide_cdrom_packet(struct cdrom_device_info *cdi,
-			    struct packet_command *cgc)
+		struct packet_command *cgc)
 {
 	struct request req;
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+
+	ide_drive_t *drive = cdi->handle;
 
 	if (cgc->timeout <= 0)
 		cgc->timeout = ATAPI_WAIT_PC;
@@ -2486,9 +2500,8 @@ static int ide_cdrom_packet(struct cdrom
 	return cgc->stat;
 }
 
-static
-int ide_cdrom_dev_ioctl (struct cdrom_device_info *cdi,
-			 unsigned int cmd, unsigned long arg)
+static int ide_cdrom_dev_ioctl(struct cdrom_device_info *cdi,
+		unsigned int cmd, unsigned long arg)
 {
 	struct packet_command cgc;
 	char buffer[16];
@@ -2500,44 +2513,40 @@ int ide_cdrom_dev_ioctl (struct cdrom_de
 	switch (cmd) {
  	case CDROMSETSPINDOWN: {
  		char spindown;
- 
- 		if (copy_from_user(&spindown, (void __user *) arg, sizeof(char)))
+
+ 		if (copy_from_user(&spindown, (void __user *)arg, sizeof(char)))
 			return -EFAULT;
- 
+
                 if ((stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0)))
 			return stat;
 
  		buffer[11] = (buffer[11] & 0xf0) | (spindown & 0x0f);
 
  		return cdrom_mode_select(cdi, &cgc);
- 	} 
- 
- 	case CDROMGETSPINDOWN: {
+ 	}
+  	case CDROMGETSPINDOWN: {
  		char spindown;
- 
+
                 if ((stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CDROM_PAGE, 0)))
 			return stat;
- 
+
  		spindown = buffer[11] & 0x0f;
- 
-		if (copy_to_user((void __user *) arg, &spindown, sizeof (char)))
+
+		if (copy_to_user((void __user *)arg, &spindown, sizeof (char)))
 			return -EFAULT;
- 
+
  		return 0;
  	}
-  
-	default:
+ 	default:
 		return -EINVAL;
 	}
 
 }
 
-static
-int ide_cdrom_audio_ioctl (struct cdrom_device_info *cdi,
-			   unsigned int cmd, void *arg)
-			   
+static int ide_cdrom_audio_ioctl(struct cdrom_device_info *cdi,
+		unsigned int cmd, void *arg)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *info = drive->driver_data;
 	int stat;
 
@@ -2548,7 +2557,7 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 	 */
 	case CDROMPLAYTRKIND: {
 		unsigned long lba_start, lba_end;
-		struct cdrom_ti *ti = (struct cdrom_ti *)arg;
+		struct cdrom_ti *ti = arg;
 		struct atapi_toc_entry *first_toc, *last_toc;
 
 		stat = cdrom_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
@@ -2569,9 +2578,8 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 
 		return cdrom_play_audio(drive, lba_start, lba_end);
 	}
-
 	case CDROMREADTOCHDR: {
-		struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
+		struct cdrom_tochdr *tochdr = arg;
 		struct atapi_toc *toc;
 
 		/* Make sure our saved TOC is valid. */
@@ -2584,9 +2592,8 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 
 		return 0;
 	}
-
 	case CDROMREADTOCENTRY: {
-		struct cdrom_tocentry *tocentry = (struct cdrom_tocentry*) arg;
+		struct cdrom_tocentry *tocentry = arg;
 		struct atapi_toc_entry *toce;
 
 		stat = cdrom_get_toc_entry(drive, tocentry->cdte_track, &toce);
@@ -2595,7 +2602,7 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 		tocentry->cdte_ctrl = toce->control;
 		tocentry->cdte_adr  = toce->adr;
 		if (tocentry->cdte_format == CDROM_MSF) {
-			lba_to_msf (toce->addr.lba,
+			lba_to_msf(toce->addr.lba,
 				   &tocentry->cdte_addr.msf.minute,
 				   &tocentry->cdte_addr.msf.second,
 				   &tocentry->cdte_addr.msf.frame);
@@ -2604,16 +2611,14 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 
 		return 0;
 	}
-
 	default:
 		return -EINVAL;
 	}
 }
 
-static
-int ide_cdrom_reset (struct cdrom_device_info *cdi)
+static int ide_cdrom_reset (struct cdrom_device_info *cdi)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
 	struct request req;
 	int ret;
@@ -2627,35 +2632,34 @@ int ide_cdrom_reset (struct cdrom_device
 	 * lock it again.
 	 */
 	if (CDROM_STATE_FLAGS(drive)->door_locked)
-		(void) cdrom_lockdoor(drive, 1, &sense);
+		(void)cdrom_lockdoor(drive, 1, &sense);
 
 	return ret;
 }
 
 
-static
-int ide_cdrom_tray_move (struct cdrom_device_info *cdi, int position)
+static int ide_cdrom_tray_move(struct cdrom_device_info *cdi, int position)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
 
 	if (position) {
 		int stat = cdrom_lockdoor(drive, 0, &sense);
-		if (stat) return stat;
+		if (stat)
+			return stat;
 	}
 
 	return cdrom_eject(drive, !position, &sense);
 }
 
-static
-int ide_cdrom_lock_door (struct cdrom_device_info *cdi, int lock)
+static int ide_cdrom_lock_door(struct cdrom_device_info *cdi, int lock)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	return cdrom_lockdoor(drive, lock, NULL);
 }
 
-static
-int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabilities_page *cap)
+static int ide_cdrom_get_capabilities(ide_drive_t *drive,
+		struct atapi_capabilities_page *cap)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
@@ -2671,7 +2675,7 @@ int ide_cdrom_get_capabilities(ide_drive
 		size -= sizeof(cap->pad);
 
 	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
-	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
+	do { /* we seem to get stat==0x01, err==0x00 the first time (??) */
 		stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
 		if (!stat)
 			break;
@@ -2679,8 +2683,8 @@ int ide_cdrom_get_capabilities(ide_drive
 	return stat;
 }
 
-static
-void ide_cdrom_update_speed (ide_drive_t *drive, struct atapi_capabilities_page *cap)
+static void ide_cdrom_update_speed(ide_drive_t *drive,
+		struct atapi_capabilities_page *cap)
 {
 	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
 	if (!drive->id->model[0] &&
@@ -2697,10 +2701,9 @@ void ide_cdrom_update_speed (ide_drive_t
 	}
 }
 
-static
-int ide_cdrom_select_speed (struct cdrom_device_info *cdi, int speed)
+static int ide_cdrom_select_speed (struct cdrom_device_info *cdi, int speed)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
 	struct atapi_capabilities_page cap;
 	int stat;
@@ -2720,10 +2723,9 @@ int ide_cdrom_select_speed (struct cdrom
  * status. this should be supported by newer cd-r/w and all DVD etc
  * drives
  */
-static
-int ide_cdrom_drive_status (struct cdrom_device_info *cdi, int slot_nr)
+static int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct media_event_desc med;
 	struct request_sense sense;
 	int stat;
@@ -2744,7 +2746,8 @@ int ide_cdrom_drive_status (struct cdrom
 			return CDS_NO_DISC;
 	}
 
-	if (sense.sense_key == NOT_READY && sense.asc == 0x04 && sense.ascq == 0x04)
+	if (sense.sense_key == NOT_READY && sense.asc == 0x04 &&
+			sense.ascq == 0x04)
 		return CDS_DISC_OK;
 
 	/*
@@ -2764,12 +2767,11 @@ int ide_cdrom_drive_status (struct cdrom
 	return CDS_DRIVE_NOT_READY;
 }
 
-static
-int ide_cdrom_get_last_session (struct cdrom_device_info *cdi,
-				struct cdrom_multisession *ms_info)
+static int ide_cdrom_get_last_session(struct cdrom_device_info *cdi,
+		struct cdrom_multisession *ms_info)
 {
 	struct atapi_toc *toc;
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *info = drive->driver_data;
 	struct request_sense sense;
 	int ret;
@@ -2785,52 +2787,51 @@ int ide_cdrom_get_last_session (struct c
 	return 0;
 }
 
-static
-int ide_cdrom_get_mcn (struct cdrom_device_info *cdi,
-		       struct cdrom_mcn *mcn_info)
+static int ide_cdrom_get_mcn (struct cdrom_device_info *cdi,
+		struct cdrom_mcn *mcn_info)
 {
 	int stat;
 	char mcnbuf[24];
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 
 /* get MCN */
-	if ((stat = cdrom_read_subchannel(drive, 2, mcnbuf, sizeof (mcnbuf), NULL)))
+	if ((stat = cdrom_read_subchannel(drive, 2, mcnbuf, sizeof(mcnbuf),
+			NULL)))
 		return stat;
 
-	memcpy (mcn_info->medium_catalog_number, mcnbuf+9,
-		sizeof (mcn_info->medium_catalog_number)-1);
-	mcn_info->medium_catalog_number[sizeof (mcn_info->medium_catalog_number)-1]
-		= '\0';
+	memcpy(mcn_info->medium_catalog_number, mcnbuf + 9,
+		sizeof(mcn_info->medium_catalog_number) - 1);
+	/* Reusing the "stat" variable here purely to avoid making the source
+	 * line longer than 80 chars, but gcc doesn't seem to generate worse
+	 * code. Could break up the line without this, but this just seemed
+	 * nicer some-how.
+	 */
+	stat = sizeof(mcn_info->medium_catalog_number);
+	mcn_info->medium_catalog_number[stat - 1] = '\0';
 
 	return 0;
 }
 
-
-
 /****************************************************************************
  * Other driver requests (open, close, check media change).
  */
 
-static
-int ide_cdrom_check_media_change_real (struct cdrom_device_info *cdi,
-				       int slot_nr)
+static int ide_cdrom_check_media_change_real(struct cdrom_device_info *cdi,
+		int slot_nr)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	int retval;
-	
+
 	if (slot_nr == CDSL_CURRENT) {
 		(void) cdrom_check_status(drive, NULL);
 		retval = CDROM_STATE_FLAGS(drive)->media_changed;
 		CDROM_STATE_FLAGS(drive)->media_changed = 0;
 		return retval;
-	} else {
+	} else
 		return -EINVAL;
-	}
 }
 
-
-static
-int ide_cdrom_open_real (struct cdrom_device_info *cdi, int purpose)
+static int ide_cdrom_open_real(struct cdrom_device_info *cdi, int purpose)
 {
 	return 0;
 }
@@ -2839,8 +2840,7 @@ int ide_cdrom_open_real (struct cdrom_de
  * Close down the device.  Invalidate all cached blocks.
  */
 
-static
-void ide_cdrom_release_real (struct cdrom_device_info *cdi)
+static void ide_cdrom_release_real (struct cdrom_device_info *cdi)
 {
 	ide_drive_t *drive = cdi->handle;
 
@@ -2848,8 +2848,6 @@ void ide_cdrom_release_real (struct cdro
 		CDROM_STATE_FLAGS(drive)->toc_valid = 0;
 }
 
-
-
 /****************************************************************************
  * Device initialization.
  */
@@ -2877,7 +2875,7 @@ static struct cdrom_device_ops ide_cdrom
 	.generic_packet		= ide_cdrom_packet,
 };
 
-static int ide_cdrom_register (ide_drive_t *drive, int nslots)
+static int ide_cdrom_register(ide_drive_t *drive, int nslots)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *devinfo = &info->devinfo;
@@ -2886,9 +2884,9 @@ static int ide_cdrom_register (ide_drive
 	devinfo->mask = 0;
 	devinfo->speed = CDROM_STATE_FLAGS(drive)->current_speed;
 	devinfo->capacity = nslots;
-	devinfo->handle = (void *) drive;
+	devinfo->handle = drive;
 	strcpy(devinfo->name, drive->name);
-	
+
 	/* set capability mask to match the probe. */
 	if (!CDROM_CONFIG_FLAGS(drive)->cd_r)
 		devinfo->mask |= CDC_CD_R;
@@ -2913,8 +2911,7 @@ static int ide_cdrom_register (ide_drive
 	return register_cdrom(devinfo);
 }
 
-static
-int ide_cdrom_probe_capabilities (ide_drive_t *drive)
+static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
@@ -2924,7 +2921,8 @@ int ide_cdrom_probe_capabilities (ide_dr
 	if (drive->media == ide_optical) {
 		CDROM_CONFIG_FLAGS(drive)->mo_drive = 1;
 		CDROM_CONFIG_FLAGS(drive)->ram = 1;
-		printk(KERN_ERR "%s: ATAPI magneto-optical drive\n", drive->name);
+		printk(KERN_ERR "%s: ATAPI magneto-optical drive\n",
+				drive->name);
 		return nslots;
 	}
 
@@ -2942,7 +2940,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 	 * registered with the Uniform layer yet, it can't do this.
 	 * Same goes for cdi->ops.
 	 */
-	cdi->handle = (ide_drive_t *) drive;
+	cdi->handle = drive;
 	cdi->ops = &ide_cdrom_dops;
 
 	if (ide_cdrom_get_capabilities(drive, &cap))
@@ -2986,9 +2984,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 	if (cdi->sanyo_slot > 0) {
 		CDROM_CONFIG_FLAGS(drive)->is_changer = 1;
 		nslots = 3;
-	}
-
-	else
+	} else
 #endif /* not STANDARD_ATAPI */
 	if (cap.mechtype == mechtype_individual_changer ||
 	    cap.mechtype == mechtype_cartridge_changer) {
@@ -3007,18 +3003,18 @@ int ide_cdrom_probe_capabilities (ide_dr
 	printk(" %s", CDROM_CONFIG_FLAGS(drive)->dvd ? "DVD-ROM" : "CD-ROM");
 
 	if (CDROM_CONFIG_FLAGS(drive)->dvd_r|CDROM_CONFIG_FLAGS(drive)->dvd_ram)
-        	printk(" DVD%s%s", 
-        	(CDROM_CONFIG_FLAGS(drive)->dvd_r)? "-R" : "", 
+        	printk(" DVD%s%s",
+        	(CDROM_CONFIG_FLAGS(drive)->dvd_r)? "-R" : "",
         	(CDROM_CONFIG_FLAGS(drive)->dvd_ram)? "-RAM" : "");
 
-        if (CDROM_CONFIG_FLAGS(drive)->cd_r|CDROM_CONFIG_FLAGS(drive)->cd_rw) 
-        	printk(" CD%s%s", 
-        	(CDROM_CONFIG_FLAGS(drive)->cd_r)? "-R" : "", 
+        if (CDROM_CONFIG_FLAGS(drive)->cd_r|CDROM_CONFIG_FLAGS(drive)->cd_rw)
+        	printk(" CD%s%s",
+        	(CDROM_CONFIG_FLAGS(drive)->cd_r)? "-R" : "",
         	(CDROM_CONFIG_FLAGS(drive)->cd_rw)? "/RW" : "");
 
-        if (CDROM_CONFIG_FLAGS(drive)->is_changer) 
+        if (CDROM_CONFIG_FLAGS(drive)->is_changer)
         	printk(" changer w/%d slots", nslots);
-        else 	
+        else
         	printk(" drive");
 
 	printk(", %dkB Cache", be16_to_cpu(cap.buffer_size));
@@ -3033,7 +3029,8 @@ int ide_cdrom_probe_capabilities (ide_dr
 
 static void ide_cdrom_add_settings(ide_drive_t *drive)
 {
-	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
+	ide_add_setting(drive, "dsc_overlap", SETTING_RW, -1, -1, TYPE_BYTE, 0,
+			1, 1, 1, &drive->dsc_overlap, NULL);
 }
 
 /*
@@ -3101,7 +3098,7 @@ static int ide_cdrom_prep_pc(struct requ
 		rq->errors = ILLEGAL_REQUEST;
 		return BLKPREP_KILL;
 	}
-	
+
 	return BLKPREP_OK;
 }
 
@@ -3115,8 +3112,7 @@ static int ide_cdrom_prep_fn(request_que
 	return 0;
 }
 
-static
-int ide_cdrom_setup (ide_drive_t *drive)
+static int ide_cdrom_setup(ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
@@ -3128,31 +3124,32 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	if (!drive->queue->unplug_delay)
 		drive->queue->unplug_delay = 1;
 
-	drive->special.all	= 0;
+	drive->special.all = 0;
 
-	CDROM_STATE_FLAGS(drive)->media_changed = 1;
-	CDROM_STATE_FLAGS(drive)->toc_valid     = 0;
-	CDROM_STATE_FLAGS(drive)->door_locked   = 0;
+	CDROM_STATE_FLAGS(drive)->media_changed	= 1;
+	CDROM_STATE_FLAGS(drive)->toc_valid	= 0;
+	CDROM_STATE_FLAGS(drive)->door_locked	= 0;
 
 #if NO_DOOR_LOCKING
-	CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
+	CDROM_CONFIG_FLAGS(drive)->no_doorlock	= 1;
 #else
-	CDROM_CONFIG_FLAGS(drive)->no_doorlock = 0;
+	CDROM_CONFIG_FLAGS(drive)->no_doorlock	= 0;
 #endif
 
-	CDROM_CONFIG_FLAGS(drive)->drq_interrupt = ((drive->id->config & 0x0060) == 0x20);
-	CDROM_CONFIG_FLAGS(drive)->is_changer = 0;
-	CDROM_CONFIG_FLAGS(drive)->cd_r = 0;
-	CDROM_CONFIG_FLAGS(drive)->cd_rw = 0;
-	CDROM_CONFIG_FLAGS(drive)->test_write = 0;
-	CDROM_CONFIG_FLAGS(drive)->dvd = 0;
-	CDROM_CONFIG_FLAGS(drive)->dvd_r = 0;
-	CDROM_CONFIG_FLAGS(drive)->dvd_ram = 0;
-	CDROM_CONFIG_FLAGS(drive)->no_eject = 1;
+	CDROM_CONFIG_FLAGS(drive)->drq_interrupt =
+			((drive->id->config & 0x0060) == 0x20);
+	CDROM_CONFIG_FLAGS(drive)->is_changer	= 0;
+	CDROM_CONFIG_FLAGS(drive)->cd_r		= 0;
+	CDROM_CONFIG_FLAGS(drive)->cd_rw	= 0;
+	CDROM_CONFIG_FLAGS(drive)->test_write	= 0;
+	CDROM_CONFIG_FLAGS(drive)->dvd		= 0;
+	CDROM_CONFIG_FLAGS(drive)->dvd_r	= 0;
+	CDROM_CONFIG_FLAGS(drive)->dvd_ram	= 0;
+	CDROM_CONFIG_FLAGS(drive)->no_eject	= 1;
 	CDROM_CONFIG_FLAGS(drive)->supp_disc_present = 0;
-	CDROM_CONFIG_FLAGS(drive)->audio_play = 0;
-	CDROM_CONFIG_FLAGS(drive)->close_tray = 1;
-	
+	CDROM_CONFIG_FLAGS(drive)->audio_play	= 0;
+	CDROM_CONFIG_FLAGS(drive)->close_tray	= 1;
+
 	/* limit transfer size per interrupt. */
 	CDROM_CONFIG_FLAGS(drive)->limit_nframes = 0;
 	/* a testament to the nice quality of Samsung drives... */
@@ -3186,7 +3183,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
 	}
 
-	else if (strcmp (drive->id->model, "V006E0DS") == 0 &&
+	else if (strcmp(drive->id->model, "V006E0DS") == 0 &&
 	    drive->id->fw_rev[4] == '1' &&
 	    drive->id->fw_rev[6] <= '2') {
 		/* Vertos 600 ESD. */
@@ -3200,7 +3197,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 		CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd = 1;
 		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
 		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
-		CDROM_CONFIG_FLAGS(drive)->nec260         = 1;
+		CDROM_CONFIG_FLAGS(drive)->nec260	  = 1;
 	}
 	else if (strcmp(drive->id->model, "WEARNES CDD-120") == 0 &&
 		 strncmp(drive->id->fw_rev, "A1.1", 4) == 0) { /* FIXME */
@@ -3226,7 +3223,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	info->last_block	= 0;
 	info->start_seek	= 0;
 
-	nslots = ide_cdrom_probe_capabilities (drive);
+	nslots = ide_cdrom_probe_capabilities(drive);
 
 	/*
 	 * set correct block size
@@ -3240,13 +3237,13 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	drive->dsc_overlap = (HWIF(drive)->no_dsc) ? 0 : 1;
 	if (HWIF(drive)->no_dsc) {
 		printk(KERN_INFO "ide-cd: %s: disabling DSC overlap\n",
-			drive->name);
+				drive->name);
 		drive->dsc_overlap = 0;
 	}
 #endif
-
 	if (ide_cdrom_register(drive, nslots)) {
-		printk (KERN_ERR "%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);
+		printk(KERN_ERR "%s: ide_cdrom_setup failed to register device"
+				" with the cdrom driver.\n", drive->name);
 		info->devinfo.handle = NULL;
 		return 1;
 	}
@@ -3254,8 +3251,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	return 0;
 }
 
-static
-sector_t ide_cdrom_capacity (ide_drive_t *drive)
+static sector_t ide_cdrom_capacity(ide_drive_t *drive)
 {
 	unsigned long capacity, sectors_per_frame;
 
@@ -3271,11 +3267,8 @@ static int ide_cd_remove(struct device *
 	struct cdrom_info *info = drive->driver_data;
 
 	ide_unregister_subdriver(drive, info->driver);
-
 	del_gendisk(info->disk);
-
 	ide_cd_put(info);
-
 	return 0;
 }
 
@@ -3293,8 +3286,8 @@ static void ide_cd_release(struct kref *
 	if (info->changer_info != NULL)
 		kfree(info->changer_info);
 	if (devinfo->handle == drive && unregister_cdrom(devinfo))
-		printk(KERN_ERR "%s: %s failed to unregister device from the cdrom "
-				"driver.\n", __FUNCTION__, drive->name);
+		printk(KERN_ERR "%s: %s failed to unregister device from the "
+				"cdrom driver.\n", __FUNCTION__, drive->name);
 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
 	blk_queue_prep_rq(drive->queue, NULL);
@@ -3306,10 +3299,10 @@ static void ide_cd_release(struct kref *
 static int ide_cd_probe(struct device *);
 
 #ifdef CONFIG_PROC_FS
-static int proc_idecd_read_capacity
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
+static int proc_idecd_read_capacity(char *page, char **start, off_t off,
+		int count, int *eof, void *data)
 {
-	ide_drive_t*drive = (ide_drive_t *)data;
+	ide_drive_t *drive = data;
 	int len;
 
 	len = sprintf(page,"%llu\n", (long long)ide_cdrom_capacity(drive));
@@ -3342,7 +3335,7 @@ static ide_driver_t ide_cdrom_driver = {
 	.proc			= idecd_proc,
 };
 
-static int idecd_open(struct inode * inode, struct file * file)
+static int idecd_open(struct inode *inode, struct file *file)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct cdrom_info *info;
@@ -3368,7 +3361,7 @@ static int idecd_open(struct inode * ino
 	return rc;
 }
 
-static int idecd_release(struct inode * inode, struct file * file)
+static int idecd_release(struct inode *inode, struct file *file)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct cdrom_info *info = ide_cd_g(disk);
@@ -3382,8 +3375,8 @@ static int idecd_release(struct inode * 
 	return 0;
 }
 
-static int idecd_ioctl (struct inode *inode, struct file *file,
-			unsigned int cmd, unsigned long arg)
+static int idecd_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
 	struct cdrom_info *info = ide_cd_g(bdev->bd_disk);
@@ -3422,9 +3415,6 @@ static struct block_device_operations id
 /* options */
 static char *ignore = NULL;
 
-module_param(ignore, charp, 0400);
-MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
-
 static int ide_cd_probe(struct device *dev)
 {
 	ide_drive_t *drive = to_ide_device(dev);
@@ -3449,7 +3439,7 @@ static int ide_cd_probe(struct device *d
 		printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
 		goto failed;
 	}
-	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
+	info = kmalloc(sizeof(struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
 		goto failed;
@@ -3460,13 +3450,10 @@ static int ide_cd_probe(struct device *d
 		goto out_free_cd;
 
 	ide_init_disk(g, drive);
-
 	ide_register_subdriver(drive, &ide_cdrom_driver);
 
 	memset(info, 0, sizeof (struct cdrom_info));
-
 	kref_init(&info->kref);
-
 	info->drive = drive;
 	info->driver = &ide_cdrom_driver;
 	info->disk = g;
@@ -3482,6 +3469,7 @@ static int ide_cd_probe(struct device *d
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
 		struct cdrom_device_info *devinfo = &info->devinfo;
+
 		ide_unregister_subdriver(drive, &ide_cdrom_driver);
 		if (info->buffer != NULL)
 			kfree(info->buffer);
@@ -3490,7 +3478,9 @@ static int ide_cd_probe(struct device *d
 		if (info->changer_info != NULL)
 			kfree(info->changer_info);
 		if (devinfo->handle == drive && unregister_cdrom(devinfo))
-			printk (KERN_ERR "%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
+			printk(KERN_ERR "%s: ide_cdrom_cleanup failed to "
+					"unregister device from the cdrom"
+					" driver.\n", drive->name);
 		kfree(info);
 		drive->driver_data = NULL;
 		goto failed;
@@ -3512,12 +3502,14 @@ static void __exit ide_cdrom_exit(void)
 {
 	driver_unregister(&ide_cdrom_driver.gen_driver);
 }
- 
+
 static int ide_cdrom_init(void)
 {
 	return driver_register(&ide_cdrom_driver.gen_driver);
 }
 
+module_param(ignore, charp, 0400);
 module_init(ide_cdrom_init);
 module_exit(ide_cdrom_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
