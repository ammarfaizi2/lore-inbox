Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUK1QWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUK1QWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUK1QWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:22:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:10903 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261503AbUK1QVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:21:16 -0500
Date: Sun, 28 Nov 2004 17:30:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: PATCH][1/2] ide-tape: small cleanups - cosmetic; unneeded return
 parentheses and needles spaces in function declarations
Message-ID: <Pine.LNX.4.61.0411281729111.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch removes a bunch of unnessesary parantheses from return
statements. There are tons of return statements that look like this: 
return (-EIO);   return (fn());  etc. 
The patch removes these unneeded parentheses.
The patch also removes a lot of spaces from function declarations. There 
is some inconsistency in the file, some functions are declared as  
  void fn() { }
and some as
  void fn () { }
So, the patch changes them to all use a common style. I picked the 
  void fn() { }
form, since (a) it seems to be the most common form used in the kernel as 
a whole, (b) it is the form used in Documentation/CodingStyle, and (c) it 
is the form that reduces the filesize a bit :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk11-orig/drivers/ide/ide-tape.c linux-2.6.10-rc2-bk11/drivers/ide/ide-tape.c
--- linux-2.6.10-rc2-bk11-orig/drivers/ide/ide-tape.c	2004-11-17 01:19:39.000000000 +0100
+++ linux-2.6.10-rc2-bk11/drivers/ide/ide-tape.c	2004-11-28 16:33:30.000000000 +0100
@@ -1263,20 +1263,20 @@ static idetape_chrdev_t idetape_chrdevs[
  *      Function declarations
  *
  */
-static int idetape_chrdev_release (struct inode *inode, struct file *filp);
-static void idetape_write_release (ide_drive_t *drive, unsigned int minor);
+static int idetape_chrdev_release(struct inode *inode, struct file *filp);
+static void idetape_write_release(ide_drive_t *drive, unsigned int minor);
 
 /*
  * Too bad. The drive wants to send us data which we are not ready to accept.
  * Just throw it away.
  */
-static void idetape_discard_data (ide_drive_t *drive, unsigned int bcount)
+static void idetape_discard_data(ide_drive_t *drive, unsigned int bcount)
 {
 	while (bcount--)
 		(void) HWIF(drive)->INB(IDE_DATA_REG);
 }
 
-static void idetape_input_buffers (ide_drive_t *drive, idetape_pc_t *pc, unsigned int bcount)
+static void idetape_input_buffers(ide_drive_t *drive, idetape_pc_t *pc, unsigned int bcount)
 {
 	struct idetape_bh *bh = pc->bh;
 	int count;
@@ -1303,7 +1303,7 @@ static void idetape_input_buffers (ide_d
 	pc->bh = bh;
 }
 
-static void idetape_output_buffers (ide_drive_t *drive, idetape_pc_t *pc, unsigned int bcount)
+static void idetape_output_buffers(ide_drive_t *drive, idetape_pc_t *pc, unsigned int bcount)
 {
 	struct idetape_bh *bh = pc->bh;
 	int count;
@@ -1331,7 +1331,7 @@ static void idetape_output_buffers (ide_
 	}
 }
 
-static void idetape_update_buffers (idetape_pc_t *pc)
+static void idetape_update_buffers(idetape_pc_t *pc)
 {
 	struct idetape_bh *bh = pc->bh;
 	int count;
@@ -1362,7 +1362,7 @@ static void idetape_update_buffers (idet
  *	driver. A storage space for a maximum of IDETAPE_PC_STACK packet
  *	commands is allocated at initialization time.
  */
-static idetape_pc_t *idetape_next_pc_storage (ide_drive_t *drive)
+static idetape_pc_t *idetape_next_pc_storage(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -1389,7 +1389,7 @@ static idetape_pc_t *idetape_next_pc_sto
  *                                                            *
  **************************************************************/
  
-static struct request *idetape_next_rq_storage (ide_drive_t *drive)
+static struct request *idetape_next_rq_storage(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -1406,7 +1406,7 @@ static struct request *idetape_next_rq_s
 /*
  *	idetape_init_pc initializes a packet command.
  */
-static void idetape_init_pc (idetape_pc_t *pc)
+static void idetape_init_pc(idetape_pc_t *pc)
 {
 	memset(pc->c, 0, 12);
 	pc->retries = 0;
@@ -1423,7 +1423,7 @@ static void idetape_init_pc (idetape_pc_
  *	to analyze the request sense. We currently do not utilize this
  *	information.
  */
-static void idetape_analyze_error (ide_drive_t *drive, idetape_request_sense_result_t *result)
+static void idetape_analyze_error(ide_drive_t *drive, idetape_request_sense_result_t *result)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = tape->failed_pc;
@@ -1492,7 +1492,7 @@ static void idetape_analyze_error (ide_d
 /*
  * idetape_active_next_stage will declare the next stage as "active".
  */
-static void idetape_active_next_stage (ide_drive_t *drive)
+static void idetape_active_next_stage(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_stage_t *stage = tape->next_stage;
@@ -1523,7 +1523,7 @@ static void idetape_active_next_stage (i
  *	stages, and if we sense that the pipeline is empty, we try to
  *	increase it, until we reach the user compile time memory limit.
  */
-static void idetape_increase_max_pipeline_stages (ide_drive_t *drive)
+static void idetape_increase_max_pipeline_stages(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int increase = (tape->max_pipeline - tape->min_pipeline) / 10;
@@ -1542,7 +1542,7 @@ static void idetape_increase_max_pipelin
  *	idetape_kfree_stage calls kfree to completely free a stage, along with
  *	its related buffers.
  */
-static void __idetape_kfree_stage (idetape_stage_t *stage)
+static void __idetape_kfree_stage(idetape_stage_t *stage)
 {
 	struct idetape_bh *prev_bh, *bh = stage->bh;
 	int size;
@@ -1563,7 +1563,7 @@ static void __idetape_kfree_stage (ideta
 	kfree(stage);
 }
 
-static void idetape_kfree_stage (idetape_tape_t *tape, idetape_stage_t *stage)
+static void idetape_kfree_stage(idetape_tape_t *tape, idetape_stage_t *stage)
 {
 	__idetape_kfree_stage(stage);
 }
@@ -1572,7 +1572,7 @@ static void idetape_kfree_stage (idetape
  *	idetape_remove_stage_head removes tape->first_stage from the pipeline.
  *	The caller should avoid race conditions.
  */
-static void idetape_remove_stage_head (ide_drive_t *drive)
+static void idetape_remove_stage_head(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_stage_t *stage;
@@ -1706,7 +1706,7 @@ static int idetape_end_request(ide_drive
 	return 0;
 }
 
-static ide_startstop_t idetape_request_sense_callback (ide_drive_t *drive)
+static ide_startstop_t idetape_request_sense_callback(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -1724,7 +1724,7 @@ static ide_startstop_t idetape_request_s
 	return ide_stopped;
 }
 
-static void idetape_create_request_sense_cmd (idetape_pc_t *pc)
+static void idetape_create_request_sense_cmd(idetape_pc_t *pc)
 {
 	idetape_init_pc(pc);	
 	pc->c[0] = IDETAPE_REQUEST_SENSE_CMD;
@@ -1759,7 +1759,7 @@ static void idetape_init_rq(struct reque
  *	and wait for their completion using idetape_queue_pc_tail or
  *	idetape_queue_rw_tail.
  */
-static void idetape_queue_pc_head (ide_drive_t *drive, idetape_pc_t *pc,struct request *rq)
+static void idetape_queue_pc_head(ide_drive_t *drive, idetape_pc_t *pc,struct request *rq)
 {
 	idetape_init_rq(rq, REQ_IDETAPE_PC1);
 	rq->buffer = (char *) pc;
@@ -1771,7 +1771,7 @@ static void idetape_queue_pc_head (ide_d
  *	last packet command. We queue a request sense packet command in
  *	the head of the request list.
  */
-static ide_startstop_t idetape_retry_pc (ide_drive_t *drive)
+static ide_startstop_t idetape_retry_pc(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc;
@@ -1792,7 +1792,7 @@ static ide_startstop_t idetape_retry_pc 
  *	ide.c will be able to service requests from another device on
  *	the same hwgroup while we are polling for DSC.
  */
-static void idetape_postpone_request (ide_drive_t *drive)
+static void idetape_postpone_request(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -1812,7 +1812,7 @@ static void idetape_postpone_request (id
  *	algorithm described before idetape_issue_packet_command.
  *
  */
-static ide_startstop_t idetape_pc_intr (ide_drive_t *drive)
+static ide_startstop_t idetape_pc_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
@@ -2074,7 +2074,7 @@ static ide_startstop_t idetape_transfer_
 	return ide_started;
 }
 
-static ide_startstop_t idetape_issue_packet_command (ide_drive_t *drive, idetape_pc_t *pc)
+static ide_startstop_t idetape_issue_packet_command(ide_drive_t *drive, idetape_pc_t *pc)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	idetape_tape_t *tape = drive->driver_data;
@@ -2159,7 +2159,7 @@ static ide_startstop_t idetape_issue_pac
 /*
  *	General packet command callback function.
  */
-static ide_startstop_t idetape_pc_callback (ide_drive_t *drive)
+static ide_startstop_t idetape_pc_callback(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	
@@ -2175,7 +2175,7 @@ static ide_startstop_t idetape_pc_callba
 /*
  *	A mode sense command is used to "sense" tape parameters.
  */
-static void idetape_create_mode_sense_cmd (idetape_pc_t *pc, u8 page_code)
+static void idetape_create_mode_sense_cmd(idetape_pc_t *pc, u8 page_code)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_MODE_SENSE_CMD;
@@ -2249,7 +2249,7 @@ static void calculate_speeds(ide_drive_t
 	tape->max_insert_speed = max(tape->max_insert_speed, 500);
 }
 
-static ide_startstop_t idetape_media_access_finished (ide_drive_t *drive)
+static ide_startstop_t idetape_media_access_finished(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t *pc = tape->pc;
@@ -2275,7 +2275,7 @@ static ide_startstop_t idetape_media_acc
 	return pc->callback(drive);
 }
 
-static ide_startstop_t idetape_rw_callback (ide_drive_t *drive)
+static ide_startstop_t idetape_rw_callback(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct request *rq = HWGROUP(drive)->rq;
@@ -2497,7 +2497,7 @@ out:
 /*
  *	Pipeline related functions
  */
-static inline int idetape_pipeline_active (idetape_tape_t *tape)
+static inline int idetape_pipeline_active(idetape_tape_t *tape)
 {
 	int rc1, rc2;
 
@@ -2518,7 +2518,7 @@ static inline int idetape_pipeline_activ
  *	Pipeline stages are optional and are used to increase performance.
  *	If we can't allocate them, we'll manage without them.
  */
-static idetape_stage_t *__idetape_kmalloc_stage (idetape_tape_t *tape, int full, int clear)
+static idetape_stage_t *__idetape_kmalloc_stage(idetape_tape_t *tape, int full, int clear)
 {
 	idetape_stage_t *stage;
 	struct idetape_bh *prev_bh, *bh;
@@ -2578,7 +2578,7 @@ abort:
 	return NULL;
 }
 
-static idetape_stage_t *idetape_kmalloc_stage (idetape_tape_t *tape)
+static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
 {
 	idetape_stage_t *cache_stage = tape->cache_stage;
 
@@ -2596,7 +2596,7 @@ static idetape_stage_t *idetape_kmalloc_
 	return __idetape_kmalloc_stage(tape, 0, 0);
 }
 
-static void idetape_copy_stage_from_user (idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
+static void idetape_copy_stage_from_user(idetape_tape_t *tape, idetape_stage_t *stage, const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2623,7 +2623,7 @@ static void idetape_copy_stage_from_user
 	tape->bh = bh;
 }
 
-static void idetape_copy_stage_to_user (idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
+static void idetape_copy_stage_to_user(idetape_tape_t *tape, char __user *buf, idetape_stage_t *stage, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2652,7 +2652,7 @@ static void idetape_copy_stage_to_user (
 	}
 }
 
-static void idetape_init_merge_stage (idetape_tape_t *tape)
+static void idetape_init_merge_stage(idetape_tape_t *tape)
 {
 	struct idetape_bh *bh = tape->merge_stage->bh;
 	
@@ -2665,7 +2665,7 @@ static void idetape_init_merge_stage (id
 	}
 }
 
-static void idetape_switch_buffers (idetape_tape_t *tape, idetape_stage_t *stage)
+static void idetape_switch_buffers(idetape_tape_t *tape, idetape_stage_t *stage)
 {
 	struct idetape_bh *tmp;
 
@@ -2678,7 +2678,7 @@ static void idetape_switch_buffers (idet
 /*
  *	idetape_add_stage_tail adds a new stage at the end of the pipeline.
  */
-static void idetape_add_stage_tail (ide_drive_t *drive,idetape_stage_t *stage)
+static void idetape_add_stage_tail(ide_drive_t *drive,idetape_stage_t *stage)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
@@ -2708,7 +2708,7 @@ static void idetape_add_stage_tail (ide_
  *	The caller should ensure that the request will not be serviced
  *	before we install the completion (usually by disabling interrupts).
  */
-static void idetape_wait_for_request (ide_drive_t *drive, struct request *rq)
+static void idetape_wait_for_request(ide_drive_t *drive, struct request *rq)
 {
 	DECLARE_COMPLETION(wait);
 	idetape_tape_t *tape = drive->driver_data;
@@ -2726,7 +2726,7 @@ static void idetape_wait_for_request (id
 	spin_lock_irq(&tape->spinlock);
 }
 
-static ide_startstop_t idetape_read_position_callback (ide_drive_t *drive)
+static ide_startstop_t idetape_read_position_callback(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_read_position_result_t *result;
@@ -2774,7 +2774,7 @@ static ide_startstop_t idetape_read_posi
  *			if write_filemark=0.
  *
  */
-static void idetape_create_write_filemark_cmd (ide_drive_t *drive, idetape_pc_t *pc,int write_filemark)
+static void idetape_create_write_filemark_cmd(ide_drive_t *drive, idetape_pc_t *pc,int write_filemark)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_WRITE_FILEMARK_CMD;
@@ -2810,7 +2810,7 @@ static void idetape_create_test_unit_rea
  *	the request to the request list without waiting for it to be serviced !
  *	In that case, we usually use idetape_queue_pc_head.
  */
-static int __idetape_queue_pc_tail (ide_drive_t *drive, idetape_pc_t *pc)
+static int __idetape_queue_pc_tail(ide_drive_t *drive, idetape_pc_t *pc)
 {
 	struct request rq;
 
@@ -2819,7 +2819,7 @@ static int __idetape_queue_pc_tail (ide_
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
-static void idetape_create_load_unload_cmd (ide_drive_t *drive, idetape_pc_t *pc,int cmd)
+static void idetape_create_load_unload_cmd(ide_drive_t *drive, idetape_pc_t *pc,int cmd)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_LOAD_UNLOAD_CMD;
@@ -2860,12 +2860,12 @@ static int idetape_wait_ready(ide_drive_
 	return -EIO;
 }
 
-static int idetape_queue_pc_tail (ide_drive_t *drive,idetape_pc_t *pc)
+static int idetape_queue_pc_tail(ide_drive_t *drive,idetape_pc_t *pc)
 {
 	return __idetape_queue_pc_tail(drive, pc);
 }
 
-static int idetape_flush_tape_buffers (ide_drive_t *drive)
+static int idetape_flush_tape_buffers(ide_drive_t *drive)
 {
 	idetape_pc_t pc;
 	int rc;
@@ -2877,7 +2877,7 @@ static int idetape_flush_tape_buffers (i
 	return 0;
 }
 
-static void idetape_create_read_position_cmd (idetape_pc_t *pc)
+static void idetape_create_read_position_cmd(idetape_pc_t *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_READ_POSITION_CMD;
@@ -2885,7 +2885,7 @@ static void idetape_create_read_position
 	pc->callback = &idetape_read_position_callback;
 }
 
-static int idetape_read_position (ide_drive_t *drive)
+static int idetape_read_position(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
@@ -2903,7 +2903,7 @@ static int idetape_read_position (ide_dr
 	return position;
 }
 
-static void idetape_create_locate_cmd (ide_drive_t *drive, idetape_pc_t *pc, unsigned int block, u8 partition, int skip)
+static void idetape_create_locate_cmd(ide_drive_t *drive, idetape_pc_t *pc, unsigned int block, u8 partition, int skip)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_LOCATE_CMD;
@@ -2914,7 +2914,7 @@ static void idetape_create_locate_cmd (i
 	pc->callback = &idetape_pc_callback;
 }
 
-static int idetape_create_prevent_cmd (ide_drive_t *drive, idetape_pc_t *pc, int prevent)
+static int idetape_create_prevent_cmd(ide_drive_t *drive, idetape_pc_t *pc, int prevent)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -2928,7 +2928,7 @@ static int idetape_create_prevent_cmd (i
 	return 1;
 }
 
-static int __idetape_discard_read_pipeline (ide_drive_t *drive)
+static int __idetape_discard_read_pipeline(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
@@ -2983,7 +2983,7 @@ static int __idetape_discard_read_pipeli
  *	of the request queue and wait for their completion.
  *	
  */
-static int idetape_position_tape (ide_drive_t *drive, unsigned int block, u8 partition, int skip)
+static int idetape_position_tape(ide_drive_t *drive, unsigned int block, u8 partition, int skip)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int retval;
@@ -2995,13 +2995,13 @@ static int idetape_position_tape (ide_dr
 	idetape_create_locate_cmd(drive, &pc, block, partition, skip);
 	retval = idetape_queue_pc_tail(drive, &pc);
 	if (retval)
-		return (retval);
+		return retval;
 
 	idetape_create_read_position_cmd(&pc);
-	return (idetape_queue_pc_tail(drive, &pc));
+	return idetape_queue_pc_tail(drive, &pc);
 }
 
-static void idetape_discard_read_pipeline (ide_drive_t *drive, int restore_position)
+static void idetape_discard_read_pipeline(ide_drive_t *drive, int restore_position)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int cnt;
@@ -3034,7 +3034,7 @@ static int idetape_queue_rw_tail(ide_dri
 #if IDETAPE_DEBUG_BUGS
 	if (idetape_pipeline_active(tape)) {
 		printk(KERN_ERR "ide-tape: bug: the pipeline is active in idetape_queue_rw_tail\n");
-		return (0);
+		return 0;
 	}
 #endif /* IDETAPE_DEBUG_BUGS */	
 
@@ -3058,7 +3058,7 @@ static int idetape_queue_rw_tail(ide_dri
  *	idetape_insert_pipeline_into_queue is used to start servicing the
  *	pipeline stages, starting from tape->next_stage.
  */
-static void idetape_insert_pipeline_into_queue (ide_drive_t *drive)
+static void idetape_insert_pipeline_into_queue(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -3071,7 +3071,7 @@ static void idetape_insert_pipeline_into
 	}
 }
 
-static void idetape_create_inquiry_cmd (idetape_pc_t *pc)
+static void idetape_create_inquiry_cmd(idetape_pc_t *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_INQUIRY_CMD;
@@ -3079,7 +3079,7 @@ static void idetape_create_inquiry_cmd (
 	pc->callback = &idetape_pc_callback;
 }
 
-static void idetape_create_rewind_cmd (ide_drive_t *drive, idetape_pc_t *pc)
+static void idetape_create_rewind_cmd(ide_drive_t *drive, idetape_pc_t *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_REWIND_CMD;
@@ -3088,7 +3088,7 @@ static void idetape_create_rewind_cmd (i
 }
 
 #if 0
-static void idetape_create_mode_select_cmd (idetape_pc_t *pc, int length)
+static void idetape_create_mode_select_cmd(idetape_pc_t *pc, int length)
 {
 	idetape_init_pc(pc);
 	set_bit(PC_WRITING, &pc->flags);
@@ -3100,7 +3100,7 @@ static void idetape_create_mode_select_c
 }
 #endif
 
-static void idetape_create_erase_cmd (idetape_pc_t *pc)
+static void idetape_create_erase_cmd(idetape_pc_t *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_ERASE_CMD;
@@ -3109,7 +3109,7 @@ static void idetape_create_erase_cmd (id
 	pc->callback = &idetape_pc_callback;
 }
 
-static void idetape_create_space_cmd (idetape_pc_t *pc,int count, u8 cmd)
+static void idetape_create_space_cmd(idetape_pc_t *pc,int count, u8 cmd)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = IDETAPE_SPACE_CMD;
@@ -3119,7 +3119,7 @@ static void idetape_create_space_cmd (id
 	pc->callback = &idetape_pc_callback;
 }
 
-static void idetape_wait_first_stage (ide_drive_t *drive)
+static void idetape_wait_first_stage(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
@@ -3143,7 +3143,7 @@ static void idetape_wait_first_stage (id
  *	3.	If we still can't allocate a stage, fallback to
  *		non-pipelined operation mode for this request.
  */
-static int idetape_add_chrdev_write_request (ide_drive_t *drive, int blocks)
+static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_stage_t *new_stage;
@@ -3217,7 +3217,7 @@ static int idetape_add_chrdev_write_requ
  *	idetape_wait_for_pipeline will wait until all pending pipeline
  *	requests are serviced. Typically called on device close.
  */
-static void idetape_wait_for_pipeline (ide_drive_t *drive)
+static void idetape_wait_for_pipeline(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
@@ -3231,7 +3231,7 @@ static void idetape_wait_for_pipeline (i
 	}
 }
 
-static void idetape_empty_write_pipeline (ide_drive_t *drive)
+static void idetape_empty_write_pipeline(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int blocks, min;
@@ -3305,7 +3305,7 @@ static void idetape_empty_write_pipeline
 #endif /* IDETAPE_DEBUG_BUGS */
 }
 
-static void idetape_restart_speed_control (ide_drive_t *drive)
+static void idetape_restart_speed_control(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -3319,7 +3319,7 @@ static void idetape_restart_speed_contro
 	tape->controlled_previous_head_time = tape->uncontrolled_previous_head_time = jiffies;
 }
 
-static int idetape_initiate_read (ide_drive_t *drive, int max_stages)
+static int idetape_initiate_read(ide_drive_t *drive, int max_stages)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_stage_t *new_stage;
@@ -3393,7 +3393,7 @@ static int idetape_initiate_read (ide_dr
  *	to service a character device read request and add read-ahead
  *	requests to our pipeline.
  */
-static int idetape_add_chrdev_read_request (ide_drive_t *drive,int blocks)
+static int idetape_add_chrdev_read_request(ide_drive_t *drive,int blocks)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
@@ -3448,10 +3448,10 @@ static int idetape_add_chrdev_read_reque
 		bytes_read = blocks * tape->tape_block_size;
 	}
 #endif /* IDETAPE_DEBUG_BUGS */
-	return (bytes_read);
+	return bytes_read;
 }
 
-static void idetape_pad_zeros (ide_drive_t *drive, int bcount)
+static void idetape_pad_zeros(ide_drive_t *drive, int bcount)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct idetape_bh *bh;
@@ -3474,7 +3474,7 @@ static void idetape_pad_zeros (ide_drive
 	}
 }
 
-static int idetape_pipeline_size (ide_drive_t *drive)
+static int idetape_pipeline_size(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_stage_t *stage;
@@ -3499,7 +3499,7 @@ static int idetape_pipeline_size (ide_dr
  *
  *	We currently support only one partition.
  */ 
-static int idetape_rewind_tape (ide_drive_t *drive)
+static int idetape_rewind_tape(ide_drive_t *drive)
 {
 	int retval;
 	idetape_pc_t pc;
@@ -3560,7 +3560,7 @@ static int idetape_blkdev_ioctl(ide_driv
 /*
  *	idetape_pre_reset is called before an ATAPI/ATA software reset.
  */
-static void idetape_pre_reset (ide_drive_t *drive)
+static void idetape_pre_reset(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	if (tape != NULL)
@@ -3576,7 +3576,7 @@ static void idetape_pre_reset (ide_drive
  *	the filemark is in our internal pipeline even if the tape doesn't
  *	support spacing over filemarks in the reverse direction.
  */
-static int idetape_space_over_filemarks (ide_drive_t *drive,short mt_op,int mt_count)
+static int idetape_space_over_filemarks(ide_drive_t *drive,short mt_op,int mt_count)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
@@ -3637,18 +3637,19 @@ static int idetape_space_over_filemarks 
 		case MTFSF:
 		case MTBSF:
 			idetape_create_space_cmd(&pc,mt_count-count,IDETAPE_SPACE_OVER_FILEMARK);
-			return (idetape_queue_pc_tail(drive, &pc));
+			return idetape_queue_pc_tail(drive, &pc);
 		case MTFSFM:
 		case MTBSFM:
 			if (!tape->capabilities.sprev)
-				return (-EIO);
+				return -EIO;
 			retval = idetape_space_over_filemarks(drive, MTFSF, mt_count-count);
-			if (retval) return (retval);
+			if (retval)
+				return retval;
 			count = (MTBSFM == mt_op ? 1 : -1);
-			return (idetape_space_over_filemarks(drive, MTFSF, count));
+			return idetape_space_over_filemarks(drive, MTFSF, count);
 		default:
 			printk(KERN_ERR "ide-tape: MTIO operation %d not supported\n",mt_op);
-			return (-EIO);
+			return -EIO;
 	}
 }
 
@@ -3670,7 +3671,7 @@ static int idetape_space_over_filemarks 
  *	will no longer hit performance.
  *      This is not applicable to Onstream.
  */
-static ssize_t idetape_chrdev_read (struct file *file, char __user *buf,
+static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 				    size_t count, loff_t *ppos)
 {
 	ide_drive_t *drive = file->private_data;
@@ -3691,7 +3692,7 @@ static ssize_t idetape_chrdev_read (stru
 	if ((rc = idetape_initiate_read(drive, tape->max_stages)) < 0)
 		return rc;
 	if (count == 0)
-		return (0);
+		return 0;
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size), (unsigned int)count);
 		idetape_copy_stage_to_user(tape, buf, tape->merge_stage, actually_read);
@@ -3729,7 +3730,7 @@ finish:
 	return actually_read;
 }
 
-static ssize_t idetape_chrdev_write (struct file *file, const char __user *buf,
+static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 				     size_t count, loff_t *ppos)
 {
 	ide_drive_t *drive = file->private_data;
@@ -3780,7 +3781,7 @@ static ssize_t idetape_chrdev_write (str
 		}
 	}
 	if (count == 0)
-		return (0);
+		return 0;
 	if (tape->restart_speed_control_req)
 		idetape_restart_speed_control(drive);
 	if (tape->merge_stage_size) {
@@ -3800,7 +3801,7 @@ static ssize_t idetape_chrdev_write (str
 			tape->merge_stage_size = 0;
 			retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
 			if (retval <= 0)
-				return (retval);
+				return retval;
 		}
 	}
 	while (count >= tape->stage_size) {
@@ -3810,17 +3811,17 @@ static ssize_t idetape_chrdev_write (str
 		retval = idetape_add_chrdev_write_request(drive, tape->capabilities.ctl);
 		actually_written += tape->stage_size;
 		if (retval <= 0)
-			return (retval);
+			return retval;
 	}
 	if (count) {
 		actually_written += count;
 		idetape_copy_stage_from_user(tape, tape->merge_stage, buf, count);
 		tape->merge_stage_size += count;
 	}
-	return (actually_written);
+	return actually_written;
 }
 
-static int idetape_write_filemark (ide_drive_t *drive)
+static int idetape_write_filemark(ide_drive_t *drive)
 {
 	idetape_pc_t pc;
 
@@ -3896,7 +3897,7 @@ static int idetape_write_filemark (ide_d
  *	MTFSS, MTBSS, MTWSM, MTSETDENSITY,
  *	MTSETDRVBUFFER, MT_ST_BOOLEANS, MT_ST_WRITE_THRESHOLD.
  */
-static int idetape_mtioctop (ide_drive_t *drive,short mt_op,int mt_count)
+static int idetape_mtioctop(ide_drive_t *drive,short mt_op,int mt_count)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
@@ -3916,8 +3917,8 @@ static int idetape_mtioctop (ide_drive_t
 		case MTBSF:
 		case MTBSFM:
 			if (!mt_count)
-				return (0);
-			return (idetape_space_over_filemarks(drive,mt_op,mt_count));
+				return 0;
+			return idetape_space_over_filemarks(drive,mt_op,mt_count);
 		default:
 			break;
 	}
@@ -3931,7 +3932,7 @@ static int idetape_mtioctop (ide_drive_t
 				if (retval)
 					return retval;
 			}
-			return (0);
+			return 0;
 		case MTREW:
 			idetape_discard_read_pipeline(drive, 0);
 			if (idetape_rewind_tape(drive))
@@ -3940,7 +3941,7 @@ static int idetape_mtioctop (ide_drive_t
 		case MTLOAD:
 			idetape_discard_read_pipeline(drive, 0);
 			idetape_create_load_unload_cmd(drive, &pc, IDETAPE_LU_LOAD_MASK);
-			return (idetape_queue_pc_tail(drive, &pc));
+			return idetape_queue_pc_tail(drive, &pc);
 		case MTUNLOAD:
 		case MTOFFL:
 			/*
@@ -3960,18 +3961,18 @@ static int idetape_mtioctop (ide_drive_t
 			return retval;
 		case MTNOP:
 			idetape_discard_read_pipeline(drive, 0);
-			return (idetape_flush_tape_buffers(drive));
+			return idetape_flush_tape_buffers(drive);
 		case MTRETEN:
 			idetape_discard_read_pipeline(drive, 0);
 			idetape_create_load_unload_cmd(drive, &pc,IDETAPE_LU_RETENSION_MASK | IDETAPE_LU_LOAD_MASK);
-			return (idetape_queue_pc_tail(drive, &pc));
+			return idetape_queue_pc_tail(drive, &pc);
 		case MTEOM:
 			idetape_create_space_cmd(&pc, 0, IDETAPE_SPACE_TO_EOD);
-			return (idetape_queue_pc_tail(drive, &pc));
+			return idetape_queue_pc_tail(drive, &pc);
 		case MTERASE:
 			(void) idetape_rewind_tape(drive);
 			idetape_create_erase_cmd(&pc);
-			return (idetape_queue_pc_tail(drive, &pc));
+			return idetape_queue_pc_tail(drive, &pc);
 		case MTSETBLK:
 			if (mt_count) {
 				if (mt_count < tape->tape_block_size || mt_count % tape->tape_block_size)
@@ -3986,27 +3987,29 @@ static int idetape_mtioctop (ide_drive_t
 			return idetape_position_tape(drive, mt_count * tape->user_bs_factor, tape->partition, 0);
 		case MTSETPART:
 			idetape_discard_read_pipeline(drive, 0);
-			return (idetape_position_tape(drive, 0, mt_count, 0));
+			return idetape_position_tape(drive, 0, mt_count, 0);
 		case MTFSR:
 		case MTBSR:
 		case MTLOCK:
 			if (!idetape_create_prevent_cmd(drive, &pc, 1))
 				return 0;
 			retval = idetape_queue_pc_tail(drive, &pc);
-			if (retval) return retval;
+			if (retval)
+				return retval;
 			tape->door_locked = DOOR_EXPLICITLY_LOCKED;
 			return 0;
 		case MTUNLOCK:
 			if (!idetape_create_prevent_cmd(drive, &pc, 0))
 				return 0;
 			retval = idetape_queue_pc_tail(drive, &pc);
-			if (retval) return retval;
+			if (retval)
+				return retval;
 			tape->door_locked = DOOR_UNLOCKED;
 			return 0;
 		default:
 			printk(KERN_ERR "ide-tape: MTIO operation %d not "
 				"supported\n", mt_op);
-			return (-EIO);
+			return -EIO;
 	}
 }
 
@@ -4033,7 +4036,7 @@ static int idetape_mtioctop (ide_drive_t
  *
  *	Our own ide-tape ioctls are supported on both interfaces.
  */
-static int idetape_chrdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int idetape_chrdev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	ide_drive_t *drive = file->private_data;
 	idetape_tape_t *tape = drive->driver_data;
@@ -4063,7 +4066,7 @@ static int idetape_chrdev_ioctl (struct 
 		case MTIOCTOP:
 			if (copy_from_user(&mtop, argp, sizeof (struct mtop)))
 				return -EFAULT;
-			return (idetape_mtioctop(drive,mtop.mt_op,mtop.mt_count));
+			return idetape_mtioctop(drive,mtop.mt_op,mtop.mt_count);
 		case MTIOCGET:
 			memset(&mtget, 0, sizeof (struct mtget));
 			mtget.mt_type = MT_ISSCSI2;
@@ -4092,7 +4095,7 @@ static void idetape_get_blocksize_from_b
 /*
  *	Our character device open function.
  */
-static int idetape_chrdev_open (struct inode *inode, struct file *filp)
+static int idetape_chrdev_open(struct inode *inode, struct file *filp)
 {
 	unsigned int minor = iminor(inode), i = minor & ~0xc0;
 	ide_drive_t *drive;
@@ -4161,7 +4164,7 @@ static int idetape_chrdev_open (struct i
 	return 0;
 }
 
-static void idetape_write_release (ide_drive_t *drive, unsigned int minor)
+static void idetape_write_release(ide_drive_t *drive, unsigned int minor)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -4180,7 +4183,7 @@ static void idetape_write_release (ide_d
 /*
  *	Our character device release function.
  */
-static int idetape_chrdev_release (struct inode *inode, struct file *filp)
+static int idetape_chrdev_release(struct inode *inode, struct file *filp)
 {
 	ide_drive_t *drive = filp->private_data;
 	idetape_tape_t *tape;
@@ -4230,7 +4233,7 @@ static int idetape_chrdev_release (struc
  *
  *	0 	If this tape driver is not currently supported by us.
  */
-static int idetape_identify_device (ide_drive_t *drive)
+static int idetape_identify_device(ide_drive_t *drive)
 {
 	struct idetape_id_gcw gcw;
 	struct hd_driveid *id = drive->id;
@@ -4354,7 +4357,7 @@ static int idetape_identify_device (ide_
 /*
  * Use INQUIRY to get the firmware revision
  */
-static void idetape_get_inquiry_results (ide_drive_t *drive)
+static void idetape_get_inquiry_results(ide_drive_t *drive)
 {
 	char *r;
 	idetape_tape_t *tape = drive->driver_data;
@@ -4384,7 +4387,7 @@ static void idetape_get_inquiry_results 
  *	parameters. In particular, we will adjust our data transfer buffer
  *	size to the recommended value as returned by the tape.
  */
-static void idetape_get_mode_sense_results (ide_drive_t *drive)
+static void idetape_get_mode_sense_results(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
@@ -4484,7 +4487,8 @@ static void idetape_get_blocksize_from_b
 	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
 #endif /* IDETAPE_DEBUG_INFO */
 }
-static void idetape_add_settings (ide_drive_t *drive)
+
+static void idetape_add_settings(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
@@ -4519,7 +4523,7 @@ static void idetape_add_settings (ide_dr
  *	Note that at this point ide.c already assigned us an irq, so that
  *	we can queue requests here and wait for their completion.
  */
-static void idetape_setup (ide_drive_t *drive, idetape_tape_t *tape, int minor)
+static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
 {
 	unsigned long t1, tmid, tn, t;
 	int speed;
@@ -4627,7 +4631,7 @@ static void idetape_setup (ide_drive_t *
 	idetape_add_settings(drive);
 }
 
-static int idetape_cleanup (ide_drive_t *drive)
+static int idetape_cleanup(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	int minor = tape->minor;
@@ -4742,7 +4746,7 @@ static struct block_device_operations id
 	.ioctl		= idetape_ioctl,
 };
 
-static int idetape_attach (ide_drive_t *drive)
+static int idetape_attach(ide_drive_t *drive)
 {
 	idetape_tape_t *tape;
 	int minor;
@@ -4797,7 +4801,7 @@ failed:
 MODULE_DESCRIPTION("ATAPI Streaming TAPE Driver");
 MODULE_LICENSE("GPL");
 
-static void __exit idetape_exit (void)
+static void __exit idetape_exit(void)
 {
 	ide_unregister_driver(&idetape_driver);
 	unregister_chrdev(IDETAPE_MAJOR, "ht");
@@ -4806,7 +4810,7 @@ static void __exit idetape_exit (void)
 /*
  *	idetape_init will register the driver for each tape.
  */
-static int idetape_init (void)
+static int idetape_init(void)
 {
 	if (register_chrdev(IDETAPE_MAJOR, "ht", &idetape_fops)) {
 		printk(KERN_ERR "ide-tape: Failed to register character device interface\n");



