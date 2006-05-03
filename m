Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWECNuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWECNuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWECNuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:50:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:48632 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030210AbWECNuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:50:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=PeT1Pk/yL9tZsLaZ0M777dW8lYLtQ95MqkIeLteBy0QXcPhPsoSjd93r7ciQCaBwUGrqkidUvsQjABa8fGgdtBRJfFWKwo4rOZS9FQUgZLwni+KeJLYJeuM4kCgCCA9p8JYRRhdgLIPXsRFiTUVtlV6Nd6Y0AcwRtjtifendxkY=
Date: Wed, 3 May 2006 17:48:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Eric Sesterhenn <snakebyte@gmx.de>
Subject: [PATCH] More BUG_ON conversion
Message-ID: <20060503134836.GA7170@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/frv/kernel/setup.c        |    2 +-
 drivers/ide/ide-cd.c           |    3 +--
 drivers/ide/ide-dma.c          |    6 ++----
 drivers/ide/ide-floppy.c       |   12 ++++--------
 drivers/ide/ide-iops.c         |   12 ++++--------
 drivers/ide/ide-lib.c          |    3 +--
 drivers/ide/ide-taskfile.c     |    3 +--
 drivers/ide/ide.c              |    3 +--
 drivers/ide/pci/trm290.c       |    3 +--
 drivers/scsi/53c700.h          |    6 ++----
 drivers/scsi/aacraid/aachba.c  |   15 +++++----------
 drivers/scsi/aacraid/commsup.c |    6 ++----
 drivers/scsi/arm/queue.c       |    6 ++----
 drivers/scsi/ibmmca.c          |    3 +--
 drivers/scsi/ide-scsi.c        |    6 ++----
 drivers/scsi/megaraid.c        |    2 +-
 kernel/exit.c                  |    5 ++---
 mm/pdflush.c                   |    3 +--
 18 files changed, 34 insertions(+), 65 deletions(-)

--- a/arch/frv/kernel/setup.c
+++ b/arch/frv/kernel/setup.c
@@ -814,7 +814,7 @@ void __init setup_arch(char **cmdline_p)
 	 * - by now the stack is part of the init task */
 	printk("Memory %08lx-%08lx\n", memory_start, memory_end);
 
-	if (memory_start == memory_end) BUG();
+	BUG_ON(memory_start == memory_end);
 
 	init_mm.start_code = (unsigned long) &_stext;
 	init_mm.end_code = (unsigned long) &_etext;
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1722,8 +1722,7 @@ static ide_startstop_t cdrom_newpc_intr(
 		}
 	}
 
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);
 
 	ide_set_handler(drive, cdrom_newpc_intr, rq->timeout, NULL);
 	return ide_started;
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -206,8 +206,7 @@ int ide_build_sglist(ide_drive_t *drive,
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
 
-	if ((rq->flags & REQ_DRIVE_TASKFILE) && rq->nr_sectors > 256)
-		BUG();
+	BUG_ON((rq->flags & REQ_DRIVE_TASKFILE) && rq->nr_sectors > 256);
 
 	ide_map_sg(drive, rq);
 
@@ -947,8 +946,7 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 	}
 	printk("\n");
 
-	if (!(hwif->dma_master))
-		BUG();
+	BUG_ON(!hwif->dma_master);
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -898,8 +898,7 @@ static ide_startstop_t idefloppy_pc_intr
 					"to send us more data than expected "
 					"- discarding data\n");
 				idefloppy_discard_data(drive,bcount.all);
-				if (HWGROUP(drive)->handler != NULL)
-					BUG();
+				BUG_ON(HWGROUP(drive)->handler != NULL);
 				ide_set_handler(drive,
 						&idefloppy_pc_intr,
 						IDEFLOPPY_WAIT_CMD,
@@ -932,8 +931,7 @@ static ide_startstop_t idefloppy_pc_intr
 	pc->actually_transferred += bcount.all;
 	pc->current_position += bcount.all;
 
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
 	return ide_started;
 }
@@ -960,8 +958,7 @@ static ide_startstop_t idefloppy_transfe
 				"issuing a packet command\n");
 		return ide_do_reset(drive);
 	}
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	/* Send the actual packet */
@@ -1017,8 +1014,7 @@ static ide_startstop_t idefloppy_transfe
 	 * 40 and 50msec work well. idefloppy_pc_intr will not be actually
 	 * used until after the packet is moved in about 50 msec.
 	 */
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);
 	ide_set_handler(drive, 
 	  &idefloppy_pc_intr, 		/* service routine for packet command */
 	  floppy->ticks,		/* wait this long before "failing" */
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -939,8 +939,7 @@ void ide_execute_command(ide_drive_t *dr
 	
 	spin_lock_irqsave(&ide_lock, flags);
 	
-	if(hwgroup->handler)
-		BUG();
+	BUG_ON(hwgroup->handler);
 	hwgroup->handler	= handler;
 	hwgroup->expiry		= expiry;
 	hwgroup->timer.expires	= jiffies + timeout;
@@ -981,8 +980,7 @@ static ide_startstop_t atapi_reset_pollf
 		printk("%s: ATAPI reset complete\n", drive->name);
 	} else {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
-			if (HWGROUP(drive)->handler != NULL)
-				BUG();
+			BUG_ON(HWGROUP(drive)->handler != NULL);
 			ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
 			/* continue polling */
 			return ide_started;
@@ -1021,8 +1019,7 @@ static ide_startstop_t reset_pollfunc (i
 
 	if (!OK_STAT(tmp = hwif->INB(IDE_STATUS_REG), 0, BUSY_STAT)) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
-			if (HWGROUP(drive)->handler != NULL)
-				BUG();
+			BUG_ON(HWGROUP(drive)->handler != NULL);
 			ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);
 			/* continue polling */
 			return ide_started;
@@ -1138,8 +1135,7 @@ static ide_startstop_t do_reset1 (ide_dr
 	hwgroup = HWGROUP(drive);
 
 	/* We must not reset with running handlers */
-	if(hwgroup->handler != NULL)
-		BUG();
+	BUG_ON(hwgroup->handler != NULL);
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->media != ide_disk && !do_not_try_atapi) {
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -164,8 +164,7 @@ u8 ide_rate_filter (u8 mode, u8 speed) 
 //	printk("%s: mode 0x%02x, speed 0x%02x\n", __FUNCTION__, mode, speed);
 
 	/* So that we remember to update this if new modes appear */
-	if (mode > 4)
-		BUG();
+	BUG_ON(mode > 4);
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
 	return min(speed, (u8)XFER_PIO_4);
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -196,8 +196,7 @@ ide_startstop_t set_geometry_intr (ide_d
 	if (stat & (ERR_STAT|DRQ_STAT))
 		return ide_error(drive, "set_geometry_intr", stat);
 
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);
 	ide_set_handler(drive, &set_geometry_intr, WAIT_WORSTCASE, NULL);
 	return ide_started;
 }
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1366,8 +1366,7 @@ int generic_ide_ioctl(ide_drive_t *drive
 
 			ide_abort(drive, "drive reset");
 
-			if(HWGROUP(drive)->handler)
-				BUG();
+			BUG_ON(HWGROUP(drive)->handler);
 				
 			/* Ensure nothing gets queued after we
 			   drop the lock. Reset will clear the busy */
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -183,8 +183,7 @@ static void trm290_ide_dma_exec_cmd(ide_
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);	/* paranoia check */
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
 	/* issue cmd to drive */
 	hwif->OUTB(command, IDE_COMMAND_REG);
--- a/drivers/scsi/53c700.h
+++ b/drivers/scsi/53c700.h
@@ -472,8 +472,7 @@ NCR_700_readl(struct Scsi_Host *host, __
 		ioread32(hostdata->base + reg);
 #if 1
 	/* sanity check the register */
-	if((reg & 0x3) != 0)
-		BUG();
+	BUG_ON((reg & 0x3) != 0);
 #endif
 
 	return value;
@@ -496,8 +495,7 @@ NCR_700_writel(__u32 value, struct Scsi_
 
 #if 1
 	/* sanity check the register */
-	if((reg & 0x3) != 0)
-		BUG();
+	BUG_ON((reg & 0x3) != 0);
 #endif
 
 	bEBus ? iowrite32be(value, hostdata->base + reg): 
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -390,8 +390,7 @@ static void get_container_name_callback(
 	scsicmd->SCp.phase = AAC_OWNER_MIDLEVEL;
 
 	dprintk((KERN_DEBUG "get_container_name_callback[cpu %d]: t = %ld.\n", smp_processor_id(), jiffies));
-	if (fibptr == NULL)
-		BUG();
+	BUG_ON(fibptr == NULL);
 
 	get_name_reply = (struct aac_get_name_resp *) fib_data(fibptr);
 	/* Failure is irrelevant, using default value instead */
@@ -950,8 +949,7 @@ static void io_callback(void *context, s
 		  smp_processor_id(), (unsigned long long)lba, jiffies);
 	}
 
-	if (fibptr == NULL)
-		BUG();
+	BUG_ON(fibptr == NULL);
 		
 	if(scsicmd->use_sg)
 		pci_unmap_sg(dev->pdev, 
@@ -1086,8 +1084,7 @@ static int aac_read(struct scsi_cmnd * s
 		
 		aac_build_sgraw(scsicmd, &readcmd->sg);
 		fibsize = sizeof(struct aac_raw_io) + ((le32_to_cpu(readcmd->sg.count) - 1) * sizeof (struct sgentryraw));
-		if (fibsize > (dev->max_fib_size - sizeof(struct aac_fibhdr)))
-			BUG();
+		BUG_ON(fibsize > (dev->max_fib_size - sizeof(struct aac_fibhdr)));
 		/*
 		 *	Now send the Fib to the adapter
 		 */
@@ -1255,8 +1252,7 @@ static int aac_write(struct scsi_cmnd * 
 		
 		aac_build_sgraw(scsicmd, &writecmd->sg);
 		fibsize = sizeof(struct aac_raw_io) + ((le32_to_cpu(writecmd->sg.count) - 1) * sizeof (struct sgentryraw));
-		if (fibsize > (dev->max_fib_size - sizeof(struct aac_fibhdr)))
-			BUG();
+		BUG_ON(fibsize > (dev->max_fib_size - sizeof(struct aac_fibhdr)));
 		/*
 		 *	Now send the Fib to the adapter
 		 */
@@ -1898,8 +1894,7 @@ static void aac_srb_callback(void *conte
 	scsicmd->SCp.phase = AAC_OWNER_MIDLEVEL;
 	dev = (struct aac_dev *)scsicmd->device->host->hostdata;
 
-	if (fibptr == NULL)
-		BUG();
+	BUG_ON(fibptr == NULL);
 
 	srbreply = (struct aac_srb_reply *) fib_data(fibptr);
 
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -229,8 +229,7 @@ void aac_fib_init(struct fib *fibptr)
 static void fib_dealloc(struct fib * fibptr)
 {
 	struct hw_fib *hw_fib = fibptr->hw_fib;
-	if(hw_fib->header.StructType != FIB_MAGIC) 
-		BUG();
+	BUG_ON(hw_fib->header.StructType != FIB_MAGIC);
 	hw_fib->header.XferState = 0;        
 }
 
@@ -534,8 +533,7 @@ int aac_fib_send(u16 command, struct fib
 			}
 		} else
 			down(&fibptr->event_wait);
-		if(fibptr->done == 0)
-			BUG();
+		BUG_ON(fibptr->done == 0);
 			
 		if((fibptr->flags & FIB_CONTEXT_FLAG_TIMED_OUT)){
 			return -ETIMEDOUT;
--- a/drivers/scsi/arm/queue.c
+++ b/drivers/scsi/arm/queue.c
@@ -118,8 +118,7 @@ int __queue_add(Queue_t *queue, Scsi_Cmn
 	list_del(l);
 
 	q = list_entry(l, QE_t, list);
-	if (BAD_MAGIC(q, QUEUE_MAGIC_FREE))
-		BUG();
+	BUG_ON(BAD_MAGIC(q, QUEUE_MAGIC_FREE));
 
 	SET_MAGIC(q, QUEUE_MAGIC_USED);
 	q->SCpnt = SCpnt;
@@ -144,8 +143,7 @@ static Scsi_Cmnd *__queue_remove(Queue_t
 	 */
 	list_del(ent);
 	q = list_entry(ent, QE_t, list);
-	if (BAD_MAGIC(q, QUEUE_MAGIC_USED))
-		BUG();
+	BUG_ON(BAD_MAGIC(q, QUEUE_MAGIC_USED));
 
 	SET_MAGIC(q, QUEUE_MAGIC_FREE);
 	list_add(ent, &queue->free);
--- a/drivers/scsi/ibmmca.c
+++ b/drivers/scsi/ibmmca.c
@@ -2243,8 +2243,7 @@ static int __ibmmca_host_reset(Scsi_Cmnd
 	int host_index;
 	unsigned long imm_command;
 
-	if (cmd == NULL)
-		BUG();
+	BUG_ON(cmd == NULL);
 
 	ticks = IM_RESET_DELAY * HZ;
 	shpnt = cmd->device->host;
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -600,8 +600,7 @@ static ide_startstop_t idescsi_transfer_
 				"issuing a packet command\n");
 		return ide_do_reset (drive);
 	}
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
+	BUG_ON(HWGROUP(drive)->handler != NULL);
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	/* Send the actual packet */
@@ -691,8 +690,7 @@ static ide_startstop_t idescsi_issue_pc 
 		set_bit(PC_DMA_OK, &pc->flags);
 
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
+		BUG_ON(HWGROUP(drive)->handler != NULL);
 		ide_set_handler(drive, &idescsi_transfer_pc,
 				get_timeout(pc), idescsi_expiry);
 		/* Issue the packet command */
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1828,7 +1828,7 @@ mega_build_sglist(adapter_t *adapter, sc
 
 	scb->dma_type = MEGA_SGLIST;
 
-	if( sgcnt > adapter->sglen ) BUG();
+	BUG_ON(sgcnt > adapter->sglen);
 
 	*len = 0;
 
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -578,7 +578,7 @@ static void exit_mm(struct task_struct *
 		down_read(&mm->mmap_sem);
 	}
 	atomic_inc(&mm->mm_count);
-	if (mm != tsk->active_mm) BUG();
+	BUG_ON(mm != tsk->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(tsk);
 	tsk->mm = NULL;
@@ -1535,8 +1535,7 @@ check_continued:
 		if (options & __WNOTHREAD)
 			break;
 		tsk = next_thread(tsk);
-		if (tsk->signal != current->signal)
-			BUG();
+		BUG_ON(tsk->signal != current->signal);
 	} while (tsk != current);
 
 	read_unlock(&tasklist_lock);
--- a/mm/pdflush.c
+++ b/mm/pdflush.c
@@ -202,8 +202,7 @@ int pdflush_operation(void (*fn)(unsigne
 	unsigned long flags;
 	int ret = 0;
 
-	if (fn == NULL)
-		BUG();		/* Hard to diagnose if it's deferred */
+	BUG_ON(fn == NULL);	/* Hard to diagnose if it's deferred */
 
 	spin_lock_irqsave(&pdflush_lock, flags);
 	if (list_empty(&pdflush_list)) {

