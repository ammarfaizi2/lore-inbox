Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVBBDmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVBBDmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBBDkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:40:55 -0500
Received: from [211.58.254.17] ([211.58.254.17]:24203 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262268AbVBBDMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:12:40 -0500
Date: Wed, 2 Feb 2005 12:12:38 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 29/29] ide: make data_phase explicit in NO_DATA cases
Message-ID: <20050202031238.GN1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 29_ide_explicit_TASKFILE_NO_DATA.patch
> 
> 	Make data_phase explicit in NO_DATA cases.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:28:07.852771465 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:08.121727827 +0900
@@ -300,6 +300,7 @@ static unsigned long idedisk_read_native
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
@@ -326,6 +327,7 @@ static unsigned long long idedisk_read_n
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);
@@ -362,6 +364,7 @@ static unsigned long idedisk_set_max_add
 	args.tfRegister[IDE_SELECT_OFFSET]	= ((addr_req >> 24) & 0x0f) | 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
@@ -395,6 +398,7 @@ static unsigned long long idedisk_set_ma
 	args.hobRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
@@ -534,6 +538,7 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
+			args.data_phase   = TASKFILE_NO_DATA;
 			args.handler	  = &set_geometry_intr;
 			do_taskfile(drive, &args);
 		}
@@ -545,6 +550,7 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
+			args.data_phase   = TASKFILE_NO_DATA;
 			args.handler	  = &recal_intr;
 			do_taskfile(drive, &args);
 		}
@@ -558,6 +564,7 @@ static ide_startstop_t idedisk_special (
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
+			args.data_phase   = TASKFILE_NO_DATA;
 			args.handler	  = &set_multmode_intr;
 			do_taskfile(drive, &args);
 		}
@@ -597,6 +604,7 @@ static int smart_enable(ide_drive_t *dri
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
 }
@@ -720,6 +728,7 @@ static int idedisk_issue_flush(request_q
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
 
 	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase = TASKFILE_NO_DATA;
 	args.handler = task_no_data_intr;
 
 	rq = blk_get_request(q, WRITE, __GFP_WAIT);
@@ -779,6 +788,7 @@ static int write_cache(ide_drive_t *driv
 			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
 
 	err = ide_raw_taskfile(drive, &args, NULL);
@@ -799,6 +809,7 @@ static int do_idedisk_flushcache (ide_dr
 	else
 		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= &task_no_data_intr;
 	return ide_raw_taskfile(drive, &args, NULL);
 }
@@ -813,6 +824,7 @@ static int set_acoustic (ide_drive_t *dr
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
 	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase   = TASKFILE_NO_DATA;
 	args.handler	  = &task_no_data_intr;
 	ide_raw_taskfile(drive, &args, NULL);
 	drive->acoustic = arg;
@@ -906,19 +918,22 @@ static ide_startstop_t idedisk_start_pow
 		else
 			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->data_phase   = TASKFILE_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_taskfile(drive, args);
 
 	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
+		args->data_phase   = TASKFILE_NO_DATA;
 		args->handler	   = &task_no_data_intr;
 		return do_taskfile(drive, args);
 
 	case idedisk_pm_idle:		/* Resume step 1 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
+		args->data_phase   = TASKFILE_NO_DATA;
+		args->handler      = task_no_data_intr;
 		return do_taskfile(drive, args);
 
 	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
@@ -1195,6 +1210,7 @@ static int idedisk_open(struct inode *in
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.data_phase   = TASKFILE_NO_DATA;
 		args.handler	  = &task_no_data_intr;
 		check_disk_change(inode->i_bdev);
 		/*
@@ -1218,6 +1234,7 @@ static int idedisk_release(struct inode 
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
 		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.data_phase   = TASKFILE_NO_DATA;
 		args.handler	  = &task_no_data_intr;
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
Index: linux-ide-export/drivers/ide/ide.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide.c	2005-02-02 10:28:07.855770979 +0900
+++ linux-ide-export/drivers/ide/ide.c	2005-02-02 10:28:08.122727665 +0900
@@ -1271,6 +1271,7 @@ static int set_xfer_rate (ide_drive_t *d
 	args.tfRegister[IDE_FEATURE_OFFSET]	= SETFEATURES_XFER;
 	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.data_phase				= TASKFILE_NO_DATA;
 	args.handler				= task_no_data_intr;
 
 	err = ide_raw_taskfile(drive, &args, NULL);
