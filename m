Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTHVMdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTHVMcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:32:33 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:6747 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263094AbTHVLdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:33:19 -0400
Date: Fri, 22 Aug 2003 04:15:22 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Subject: [PATCH][resend] 6/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/scsi/pcmcia
Message-Id: <20030822041522.0daf7ff6.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 nsp_cs.c      |   92 +++++++++++++++++++++++++++++-----------------------------
 nsp_message.c |    2 -
 2 files changed, 47 insertions(+), 47 deletions(-)

--- linux-2.4.22-rc2/drivers/scsi/pcmcia/nsp_cs.c	2003-08-21 00:05:11.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/scsi/pcmcia/nsp_cs.c	2003-08-21 00:08:28.000000000 -0300
@@ -168,12 +168,12 @@
 #endif
 	nsp_hw_data *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ "() SCpnt=0x%p target=%d lun=%d buff=0x%p bufflen=%d use_sg=%d\n",
-	      SCpnt, target, SCpnt->lun, SCpnt->request_buffer, SCpnt->request_bufflen, SCpnt->use_sg);
+	DEBUG(0, "%s() SCpnt=0x%p target=%d lun=%d buff=0x%p bufflen=%d use_sg=%d\n",
+	      __FUNCTION__, SCpnt, target, SCpnt->lun, SCpnt->request_buffer, SCpnt->request_bufflen, SCpnt->use_sg);
 	//DEBUG(0, " before CurrentSC=0x%p\n", data->CurrentSC);
 
 	if(data->CurrentSC != NULL) {
-		printk(KERN_DEBUG " " __FUNCTION__ "() CurrentSC!=NULL this can't be happen\n");
+		printk(KERN_DEBUG " %s() CurrentSC!=NULL this can't be happen\n", __FUNCTION__);
 		data->CurrentSC = NULL;
 		SCpnt->result   = DID_BAD_TARGET << 16;
 		done(SCpnt);
@@ -219,7 +219,7 @@
 	}
 
 
-	//DEBUG(0, __FUNCTION__ "() out\n");
+	//DEBUG(0, "%s() out\n", __FUNCTION__);
 	return 0;
 }
 
@@ -231,7 +231,7 @@
 	unsigned int  base = data->BaseAddress;
 	unsigned char transfer_mode_reg;
 
-	//DEBUG(0, __FUNCTION__ "() enabled=%d\n", enabled);
+	//DEBUG(0, "%s() enabled=%d\n", __FUNCTION__, enabled);
 
 	if (enabled != FALSE) {
 		transfer_mode_reg = TRANSFER_GO | BRAIND;
@@ -256,7 +256,7 @@
 				  SyncOffset:	   0
 	};
 
-	DEBUG(0, __FUNCTION__ "() in base=0x%x\n", base);
+	DEBUG(0, "%s() in base=0x%x\n", __FUNCTION__, base);
 
 	data->ScsiClockDiv = CLOCK_40M;
 	data->CurrentSC    = NULL;
@@ -324,7 +324,7 @@
 	int	      wait_count;
 	unsigned char phase, arbit;
 
-	//DEBUG(0, __FUNCTION__ "()in\n");
+	//DEBUG(0, "%s()in\n", __FUNCTION__);
 
 	phase = nsp_index_read(base, SCSIBUSMON);
 	if(phase != BUSMON_BUS_FREE) {
@@ -406,7 +406,7 @@
 	int		       i;
 
 
-	DEBUG(0, __FUNCTION__ "()\n");
+	DEBUG(0, "%s()\n", __FUNCTION__);
 
 /**!**/
 
@@ -461,7 +461,7 @@
 {
 	unsigned int base = SCpnt->host->io_port;
 
-	//DEBUG(0, __FUNCTION__ "() in SCpnt=0x%p, time=%d\n", SCpnt, time);
+	//DEBUG(0, "%s() in SCpnt=0x%p, time=%d\n", __FUNCTION__, SCpnt, time);
 	data->TimerCount = time;
 	nsp_index_write(base, TIMERCOUNT, time);
 }
@@ -475,7 +475,7 @@
 	unsigned char reg;
 	int	      count, i = TRUE;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__);
 
 	count = jiffies + HZ;
 
@@ -487,7 +487,7 @@
 	} while ((i = time_before(jiffies, count)) && (reg & mask) != 0);
 
 	if (!i) {
-		printk(KERN_DEBUG __FUNCTION__ " %s signal off timeut\n", str);
+		printk(KERN_DEBUG "%s %s signal off timeut\n", __FUNCTION__, str);
 	}
 
 	return 0;
@@ -504,7 +504,7 @@
 	int	      wait_count;
 	unsigned char phase, i_src;
 
-	//DEBUG(0, __FUNCTION__ "() current_phase=0x%x, mask=0x%x\n", current_phase, mask);
+	//DEBUG(0, "%s() current_phase=0x%x, mask=0x%x\n", __FUNCTION__, current_phase, mask);
 
 	wait_count = jiffies + HZ;
 	do {
@@ -524,7 +524,7 @@
 		}
 	} while(time_before(jiffies, wait_count));
 
-	//DEBUG(0, __FUNCTION__ " : " __FUNCTION__ " timeout\n");
+	//DEBUG(0, "%s: timeout\n", __FUNCTION__);
 	return -1;
 }
 
@@ -539,7 +539,7 @@
 	int	      ptr;
 	int	      ret;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__);
 	for (ptr = 0; len > 0; len --, ptr ++) {
 
 		ret = nsp_expect_signal(SCpnt, phase, BUSMON_REQ);
@@ -574,7 +574,7 @@
 {
 	unsigned int count;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__);
 
 	if (SCpnt->SCp.have_data_in != IO_IN) {
 		return 0;
@@ -606,7 +606,7 @@
 	unsigned int  base = SCpnt->host->io_port;
 	unsigned char reg;
 
-	//DEBUG(0, __FUNCTION__ "()\n");
+	//DEBUG(0, "%s()\n", __FUNCTION__);
 
 	nsp_negate_signal(SCpnt, BUSMON_SEL, "reselect<SEL>");
 
@@ -635,7 +635,7 @@
 
 	count = (h << 16) | (m << 8) | (l << 0);
 
-	//DEBUG(0, __FUNCTION__ "() =0x%x\n", count);
+	//DEBUG(0, "%s() =0x%x\n", __FUNCTION__, count);
 
 	return count;
 }
@@ -656,7 +656,7 @@
 
 	ocount = data->FifoCount;
 
-	DEBUG(0, __FUNCTION__ "() in SCpnt=0x%p resid=%d ocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d\n", SCpnt, RESID, ocount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual, SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual);
+	DEBUG(0, "%s() in SCpnt=0x%p resid=%d ocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d\n", __FUNCTION__, SCpnt, RESID, ocount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual, SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual);
 
 	time_out = jiffies + 10 * HZ;
 
@@ -722,7 +722,7 @@
 	data->FifoCount = ocount;
 
 	if (!i) {
-		printk(KERN_DEBUG __FUNCTION__ "() pio read timeout resid=%d this_residual=%d buffers_residual=%d\n", RESID, SCpnt->SCp.this_residual, SCpnt->SCp.buffers_residual);
+		printk(KERN_DEBUG "%s() pio read timeout resid=%d this_residual=%d buffers_residual=%d\n", __FUNCTION__, RESID, SCpnt->SCp.this_residual, SCpnt->SCp.buffers_residual);
 	}
 	DEBUG(0, " read ocount=0x%x\n", ocount);
 }
@@ -739,7 +739,7 @@
 
 	ocount	 = data->FifoCount;
 
-	DEBUG(0, __FUNCTION__ "() in fifocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d resid=0x%x\n", data->FifoCount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual, SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual, RESID);
+	DEBUG(0, "%s() in fifocount=%d ptr=0x%p this_residual=%d buffers=0x%p nbuf=%d resid=0x%x\n", __FUNCTION__, data->FifoCount, SCpnt->SCp.ptr, SCpnt->SCp.this_residual, SCpnt->SCp.buffer, SCpnt->SCp.buffers_residual, RESID);
 
 	time_out = jiffies + 10 * HZ;
 
@@ -795,7 +795,7 @@
 	data->FifoCount = ocount;
 
 	if (!i) {
-		printk(KERN_DEBUG __FUNCTION__ "() pio write timeout resid=%d\n", RESID);
+		printk(KERN_DEBUG "%s() pio write timeout resid=%d\n", __FUNCTION__, RESID);
 	}
 	//DEBUG(0, " write ocount=%d\n", ocount);
 }
@@ -813,7 +813,7 @@
 	unsigned char  lun    = SCpnt->lun;
 	sync_data     *sync   = &(data->Sync[target][lun]);
 
-	//DEBUG(0, __FUNCTION__ "() in SCpnt=0x%p\n", SCpnt);
+	//DEBUG(0, "%s() in SCpnt=0x%p\n", __FUNCTION__, SCpnt);
 
 	/* setup synch transfer registers */
 	nsp_index_write(base, SYNCREG,	sync->SyncRegister);
@@ -916,7 +916,7 @@
 	nsp_write(base, IRQCONTROL, IRQCONTROL_TIMER_CLEAR | IRQCONTROL_FIFO_CLEAR);
 
 	if (data->CurrentSC == NULL) {
-		printk(KERN_DEBUG __FUNCTION__ " CurrentSC==NULL irq_status=0x%x phase=0x%x irq_phase=0x%x this can't be happen\n", i_src, phase, irq_phase);
+		printk(KERN_DEBUG "%s CurrentSC==NULL irq_status=0x%x phase=0x%x irq_phase=0x%x this can't be happen\n", __FUNCTION__, i_src, phase, irq_phase);
 		return;
 	} else {
 		tmpSC    = data->CurrentSC;
@@ -930,7 +930,7 @@
 	 */
 	if ((i_src & IRQSTATUS_SCSI) != 0) {
 		if ((irq_phase & SCSI_RESET_IRQ) != 0) {
-			printk(KERN_DEBUG " " __FUNCTION__ "() bus reset (power off?)\n");
+			printk(KERN_DEBUG " %s() bus reset (power off?)\n", __FUNCTION__);
 			*sync_neg          = SYNC_NOT_YET;
 			data->CurrentSC    = NULL;
 			tmpSC->result	   = DID_RESET << 16;
@@ -1028,7 +1028,7 @@
 
 	/* check unexpected bus free state */
 	if (phase == 0) {
-		printk(KERN_DEBUG " " __FUNCTION__ " unexpected bus free. i_src=0x%x, phase=0x%x, irq_phase=0x%x\n", i_src, phase, irq_phase);
+		printk(KERN_DEBUG " %s unexpected bus free. i_src=0x%x, phase=0x%x, irq_phase=0x%x\n", __FUNCTION__, i_src, phase, irq_phase);
 
 		*sync_neg       = SYNC_NOT_YET;
 		data->CurrentSC = NULL;
@@ -1163,7 +1163,7 @@
 		break;
 	}
 
-	//DEBUG(0, __FUNCTION__ "() out\n");
+	//DEBUG(0, "%s() out\n", __FUNCTION__);
 	return;	
 
 timer_out:
@@ -1183,7 +1183,7 @@
 	struct Scsi_Host *host;	/* registered host structure */
 	nsp_hw_data *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ " this_id=%d\n", sht->this_id);
+	DEBUG(0, "%s this_id=%d\n", __FUNCTION__, sht->this_id);
 
 	request_region(data->BaseAddress, data->NumAddress, "nsp_cs");
 	host		  = scsi_register(sht, 0);
@@ -1202,7 +1202,7 @@
 		host->irq);
 	sht->name	  = nspinfo;
 
-	DEBUG(0, __FUNCTION__ " end\n");
+	DEBUG(0, "%s end\n", __FUNCTION__);
 
 	return 1; /* detect done. */
 }
@@ -1234,7 +1234,7 @@
 /*---------------------------------------------------------------*/
 static int nsp_reset(Scsi_Cmnd *SCpnt, unsigned int why)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p why=%d\n", SCpnt, why);
+	DEBUG(0, "%s SCpnt=0x%p why=%d\n", __FUNCTION__, SCpnt, why);
 
 	nsp_eh_bus_reset(SCpnt);
 
@@ -1243,7 +1243,7 @@
 
 static int nsp_abort(Scsi_Cmnd *SCpnt)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p\n", SCpnt);
+	DEBUG(0, "%s SCpnt=0x%p\n", __FUNCTION__, SCpnt);
 
 	nsp_eh_bus_reset(SCpnt);
 
@@ -1257,7 +1257,7 @@
 
 static int nsp_eh_abort(Scsi_Cmnd *SCpnt)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p\n", SCpnt);
+	DEBUG(0, "%s SCpnt=0x%p\n", __FUNCTION__, SCpnt);
 
 	nsp_eh_bus_reset(SCpnt);
 
@@ -1266,7 +1266,7 @@
 
 static int nsp_eh_device_reset(Scsi_Cmnd *SCpnt)
 {
-	DEBUG(0, __FUNCTION__ " SCpnt=0x%p\n", SCpnt);
+	DEBUG(0, "%s SCpnt=0x%p\n", __FUNCTION__, SCpnt);
 
 	return FAILED;
 }
@@ -1276,7 +1276,7 @@
 	unsigned int base = SCpnt->host->io_port;
 	int	     i;
 
-	DEBUG(0, __FUNCTION__ "() SCpnt=0x%p base=0x%x\n", SCpnt, base);
+	DEBUG(0, "%s() SCpnt=0x%p base=0x%x\n", __FUNCTION__, SCpnt, base);
 
 	nsp_write(base, IRQCONTROL, IRQCONTROL_ALLMASK);
 
@@ -1296,7 +1296,7 @@
 {
 	nsp_hw_data *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ "\n");
+	DEBUG(0, "%s\n", __FUNCTION__);
 
 	nsphw_init(data);
 
@@ -1331,7 +1331,7 @@
 	dev_link_t   *link;
 	int	      ret, i;
 
-	DEBUG(0, __FUNCTION__ "()\n");
+	DEBUG(0, "%s()\n", __FUNCTION__);
 
 	/* Create new SCSI device */
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
@@ -1398,7 +1398,7 @@
 {
 	dev_link_t **linkp;
 
-	DEBUG(0, __FUNCTION__ "(0x%p)\n", link);
+	DEBUG(0, "%s(0x%p)\n", __FUNCTION__, link);
     
 	/* Locate device structure */
 	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next) {
@@ -1455,7 +1455,7 @@
 	struct Scsi_Host *host;
 	nsp_hw_data      *data = &nsp_data;
 
-	DEBUG(0, __FUNCTION__ "() in\n");
+	DEBUG(0, "%s() in\n", __FUNCTION__);
 
 	tuple.DesiredTuple    = CISTPL_CONFIG;
 	tuple.Attributes      = 0;
@@ -1488,7 +1488,7 @@
 			break;
 		}
 	next_entry:
-		DEBUG(0, __FUNCTION__ " next\n");
+		DEBUG(0, "%s next\n", __FUNCTION__);
 		CS_CHECK(GetNextTuple, handle, &tuple);
 	}
 
@@ -1503,8 +1503,8 @@
 	data->NumAddress  = link->io.NumPorts1;
 	data->IrqNumber   = link->irq.AssignedIRQ;
 
-	DEBUG(0, __FUNCTION__ " I/O[0x%x+0x%x] IRQ %d\n",
-	      data->BaseAddress, data->NumAddress, data->IrqNumber);
+	DEBUG(0, "%s I/O[0x%x+0x%x] IRQ %d\n",
+	      __FUNCTION__, data->BaseAddress, data->NumAddress, data->IrqNumber);
 
 	if(nsphw_init(data) == FALSE) {
 		goto cs_failed;
@@ -1592,7 +1592,7 @@
 {
 	dev_link_t *link = (dev_link_t *)arg;
 
-	DEBUG(0, __FUNCTION__ "(0x%p)\n", link);
+	DEBUG(0, "%s(0x%p)\n", __FUNCTION__, link);
 
 	/*
 	 * If the device is currently in use, we won't release until it
@@ -1646,7 +1646,7 @@
 	dev_link_t  *link = args->client_data;
 	scsi_info_t *info = link->priv;
 
-	DEBUG(1, __FUNCTION__ "(0x%06x)\n", event);
+	DEBUG(1, "%s(0x%06x)\n", __FUNCTION__, event);
 
 	switch (event) {
 	case CS_EVENT_CARD_REMOVAL:
@@ -1695,7 +1695,7 @@
 		DEBUG(0, " event: unknown\n");
 		break;
 	}
-	DEBUG(0, __FUNCTION__ " end\n");
+	DEBUG(0, "%s end\n", __FUNCTION__);
 	return 0;
 } /* nsp_cs_event */
 
@@ -1706,7 +1706,7 @@
 {
 	servinfo_t serv;
 
-	DEBUG(0, __FUNCTION__ "() in\n");
+	DEBUG(0, "%s() in\n", __FUNCTION__);
 	DEBUG(0, "%s\n", version);
 	CardServices(GetCardServicesInfo, &serv);
 	if (serv.Revision != CS_RELEASE_CODE) {
@@ -1716,14 +1716,14 @@
 	}
 	register_pcmcia_driver(&dev_info, &nsp_cs_attach, &nsp_cs_detach);
 
-	DEBUG(0, __FUNCTION__ "() out\n");
+	DEBUG(0, "%s() out\n", __FUNCTION__);
 	return 0;
 }
 
 
 static void __exit nsp_cs_cleanup(void)
 {
-	DEBUG(0, __FUNCTION__ "() unloading\n");
+	DEBUG(0, "%s() unloading\n", __FUNCTION__);
 	unregister_pcmcia_driver(&dev_info);
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG) {
--- linux-2.4.22-rc2/drivers/scsi/pcmcia/nsp_message.c	2001-10-11 13:04:57.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/scsi/pcmcia/nsp_message.c	2003-08-21 00:08:28.000000000 -0300
@@ -64,7 +64,7 @@
 	DEBUG(0, " msgout loop\n");
 	do {
 		if (nsp_xfer(SCpnt, data, BUSPHASE_MESSAGE_OUT)) {
-			printk(KERN_DEBUG " " __FUNCTION__ " msgout: xfer short\n");
+			printk(KERN_DEBUG " %s msgout: xfer short\n", __FUNCTION__);
 		}
 
 		/* catch a next signal */

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
