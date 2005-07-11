Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVGKMbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVGKMbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGKMbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:31:15 -0400
Received: from [85.8.12.41] ([85.8.12.41]:33408 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261665AbVGKM3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:29:54 -0400
Message-ID: <42D2663F.8010008@drzeus.cx>
Date: Mon, 11 Jul 2005 14:29:51 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-7109-1121084993-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix whitespace in wbsd
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-7109-1121084993-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Remove lots of trailing whitespace caused by not-so-great editor.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-7109-1121084993-0001-2
Content-Type: text/x-patch; name="wbsd-whitespace.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-whitespace.patch"

--- linux/drivers/mmc/wbsd.c.orig	2005-07-11 14:26:40.000000000 +0200
+++ linux/drivers/mmc/wbsd.c	2005-07-11 14:27:02.000000000 +0200
@@ -93,7 +93,7 @@
 static inline void wbsd_unlock_config(struct wbsd_host* host)
 {
 	BUG_ON(host->config == 0);
-	
+
 	outb(host->unlock_code, host->config);
 	outb(host->unlock_code, host->config);
 }
@@ -101,14 +101,14 @@
 static inline void wbsd_lock_config(struct wbsd_host* host)
 {
 	BUG_ON(host->config == 0);
-	
+
 	outb(LOCK_CODE, host->config);
 }
 
 static inline void wbsd_write_config(struct wbsd_host* host, u8 reg, u8 value)
 {
 	BUG_ON(host->config == 0);
-	
+
 	outb(reg, host->config);
 	outb(value, host->config + 1);
 }
@@ -116,7 +116,7 @@
 static inline u8 wbsd_read_config(struct wbsd_host* host, u8 reg)
 {
 	BUG_ON(host->config == 0);
-	
+
 	outb(reg, host->config);
 	return inb(host->config + 1);
 }
@@ -140,21 +140,21 @@
 static void wbsd_init_device(struct wbsd_host* host)
 {
 	u8 setup, ier;
-	
+
 	/*
 	 * Reset chip (SD/MMC part) and fifo.
 	 */
 	setup = wbsd_read_index(host, WBSD_IDX_SETUP);
 	setup |= WBSD_FIFO_RESET | WBSD_SOFT_RESET;
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
-	
+
 	/*
 	 * Set DAT3 to input
 	 */
 	setup &= ~WBSD_DAT3_H;
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
 	host->flags &= ~WBSD_FIGNORE_DETECT;
-	
+
 	/*
 	 * Read back default clock.
 	 */
@@ -164,12 +164,12 @@
 	 * Power down port.
 	 */
 	outb(WBSD_POWER_N, host->base + WBSD_CSR);
-	
+
 	/*
 	 * Set maximum timeout.
 	 */
 	wbsd_write_index(host, WBSD_IDX_TAAC, 0x7F);
-	
+
 	/*
 	 * Test for card presence
 	 */
@@ -177,7 +177,7 @@
 		host->flags |= WBSD_FCARD_PRESENT;
 	else
 		host->flags &= ~WBSD_FCARD_PRESENT;
-	
+
 	/*
 	 * Enable interesting interrupts.
 	 */
@@ -200,9 +200,9 @@
 static void wbsd_reset(struct wbsd_host* host)
 {
 	u8 setup;
-	
+
 	printk(KERN_ERR DRIVER_NAME ": Resetting chip\n");
-	
+
 	/*
 	 * Soft reset of chip (SD/MMC part).
 	 */
@@ -214,9 +214,9 @@
 static void wbsd_request_end(struct wbsd_host* host, struct mmc_request* mrq)
 {
 	unsigned long dmaflags;
-	
+
 	DBGF("Ending request, cmd (%x)\n", mrq->cmd->opcode);
-	
+
 	if (host->dma >= 0)
 	{
 		/*
@@ -232,7 +232,7 @@
 		 */
 		wbsd_write_index(host, WBSD_IDX_DMA, 0);
 	}
-	
+
 	host->mrq = NULL;
 
 	/*
@@ -275,7 +275,7 @@
 	    host->offset = 0;
 	    host->remain = host->cur_sg->length;
 	  }
-	
+
 	return host->num_sg;
 }
 
@@ -297,12 +297,12 @@
 	struct scatterlist* sg;
 	char* dmabuf = host->dma_buffer;
 	char* sgbuf;
-	
+
 	size = host->size;
-	
+
 	sg = data->sg;
 	len = data->sg_len;
-	
+
 	/*
 	 * Just loop through all entries. Size might not
 	 * be the entire list though so make sure that
@@ -317,23 +317,23 @@
 			memcpy(dmabuf, sgbuf, sg[i].length);
 		kunmap_atomic(sgbuf, KM_BIO_SRC_IRQ);
 		dmabuf += sg[i].length;
-		
+
 		if (size < sg[i].length)
 			size = 0;
 		else
 			size -= sg[i].length;
-	
+
 		if (size == 0)
 			break;
 	}
-	
+
 	/*
 	 * Check that we didn't get a request to transfer
 	 * more data than can fit into the SG list.
 	 */
-	
+
 	BUG_ON(size != 0);
-	
+
 	host->size -= size;
 }
 
@@ -343,12 +343,12 @@
 	struct scatterlist* sg;
 	char* dmabuf = host->dma_buffer;
 	char* sgbuf;
-	
+
 	size = host->size;
-	
+
 	sg = data->sg;
 	len = data->sg_len;
-	
+
 	/*
 	 * Just loop through all entries. Size might not
 	 * be the entire list though so make sure that
@@ -363,30 +363,30 @@
 			memcpy(sgbuf, dmabuf, sg[i].length);
 		kunmap_atomic(sgbuf, KM_BIO_SRC_IRQ);
 		dmabuf += sg[i].length;
-		
+
 		if (size < sg[i].length)
 			size = 0;
 		else
 			size -= sg[i].length;
-		
+
 		if (size == 0)
 			break;
 	}
-	
+
 	/*
 	 * Check that we didn't get a request to transfer
 	 * more data than can fit into the SG list.
 	 */
-	
+
 	BUG_ON(size != 0);
-	
+
 	host->size -= size;
 }
 
 /*
  * Command handling
  */
- 
+
 static inline void wbsd_get_short_reply(struct wbsd_host* host,
 	struct mmc_command* cmd)
 {
@@ -398,7 +398,7 @@
 		cmd->error = MMC_ERR_INVALID;
 		return;
 	}
-	
+
 	cmd->resp[0] =
 		wbsd_read_index(host, WBSD_IDX_RESP12) << 24;
 	cmd->resp[0] |=
@@ -415,7 +415,7 @@
 	struct mmc_command* cmd)
 {
 	int i;
-	
+
 	/*
 	 * Correct response type?
 	 */
@@ -424,7 +424,7 @@
 		cmd->error = MMC_ERR_INVALID;
 		return;
 	}
-	
+
 	for (i = 0;i < 4;i++)
 	{
 		cmd->resp[i] =
@@ -442,7 +442,7 @@
 {
 	int i;
 	u8 status, isr;
-	
+
 	DBGF("Sending cmd (%x)\n", cmd->opcode);
 
 	/*
@@ -451,16 +451,16 @@
 	 * transfer.
 	 */
 	host->isr = 0;
-	
+
 	/*
 	 * Send the command (CRC calculated by host).
 	 */
 	outb(cmd->opcode, host->base + WBSD_CMDR);
 	for (i = 3;i >= 0;i--)
 		outb((cmd->arg >> (i * 8)) & 0xff, host->base + WBSD_CMDR);
-	
+
 	cmd->error = MMC_ERR_NONE;
-	
+
 	/*
 	 * Wait for the request to complete.
 	 */
@@ -477,7 +477,7 @@
 		 * Read back status.
 		 */
 		isr = host->isr;
-		
+
 		/* Card removed? */
 		if (isr & WBSD_INT_CARD)
 			cmd->error = MMC_ERR_TIMEOUT;
@@ -509,13 +509,13 @@
 	struct mmc_data* data = host->mrq->cmd->data;
 	char* buffer;
 	int i, fsr, fifo;
-	
+
 	/*
 	 * Handle excessive data.
 	 */
 	if (data->bytes_xfered == host->size)
 		return;
-	
+
 	buffer = wbsd_kmap_sg(host) + host->offset;
 
 	/*
@@ -527,14 +527,14 @@
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
-		 */		
+		 */
 		if (fsr & WBSD_FIFO_FULL)
 			fifo = 16;
 		else if (fsr & WBSD_FIFO_FUTHRE)
 			fifo = 8;
 		else
 			fifo = 1;
-		
+
 		for (i = 0;i < fifo;i++)
 		{
 			*buffer = inb(host->base + WBSD_DFR);
@@ -543,23 +543,23 @@
 			host->remain--;
 
 			data->bytes_xfered++;
-			
+
 			/*
 			 * Transfer done?
 			 */
 			if (data->bytes_xfered == host->size)
 			{
-				wbsd_kunmap_sg(host);				
+				wbsd_kunmap_sg(host);
 				return;
 			}
-			
+
 			/*
 			 * End of scatter list entry?
 			 */
 			if (host->remain == 0)
 			{
 				wbsd_kunmap_sg(host);
-				
+
 				/*
 				 * Get next entry. Check if last.
 				 */
@@ -572,17 +572,17 @@
 					 * into the scatter list.
 					 */
 					BUG_ON(1);
-					
+
 					host->size = data->bytes_xfered;
-					
+
 					return;
 				}
-				
+
 				buffer = wbsd_kmap_sg(host);
 			}
 		}
 	}
-	
+
 	wbsd_kunmap_sg(host);
 
 	/*
@@ -599,7 +599,7 @@
 	struct mmc_data* data = host->mrq->cmd->data;
 	char* buffer;
 	int i, fsr, fifo;
-	
+
 	/*
 	 * Check that we aren't being called after the
 	 * entire buffer has been transfered.
@@ -618,7 +618,7 @@
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
-		 */		
+		 */
 		if (fsr & WBSD_FIFO_EMPTY)
 			fifo = 0;
 		else if (fsr & WBSD_FIFO_EMTHRE)
@@ -632,9 +632,9 @@
 			buffer++;
 			host->offset++;
 			host->remain--;
-			
+
 			data->bytes_xfered++;
-			
+
 			/*
 			 * Transfer done?
 			 */
@@ -650,7 +650,7 @@
 			if (host->remain == 0)
 			{
 				wbsd_kunmap_sg(host);
-				
+
 				/*
 				 * Get next entry. Check if last.
 				 */
@@ -663,19 +663,19 @@
 					 * into the scatter list.
 					 */
 					BUG_ON(1);
-					
+
 					host->size = data->bytes_xfered;
-					
+
 					return;
 				}
-				
+
 				buffer = wbsd_kmap_sg(host);
 			}
 		}
 	}
-	
+
 	wbsd_kunmap_sg(host);
-	
+
 	/*
 	 * The controller stops sending interrupts for
 	 * 'FIFO empty' under certain conditions. So we
@@ -694,7 +694,7 @@
 		1 << data->blksz_bits, data->blocks, data->flags);
 	DBGF("tsac %d ms nsac %d clk\n",
 		data->timeout_ns / 1000000, data->timeout_clks);
-	
+
 	/*
 	 * Calculate size.
 	 */
@@ -708,12 +708,12 @@
 		wbsd_write_index(host, WBSD_IDX_TAAC, 127);
 	else
 		wbsd_write_index(host, WBSD_IDX_TAAC, data->timeout_ns/1000000);
-	
+
 	if (data->timeout_clks > 255)
 		wbsd_write_index(host, WBSD_IDX_NSAC, 255);
 	else
 		wbsd_write_index(host, WBSD_IDX_NSAC, data->timeout_clks);
-	
+
 	/*
 	 * Inform the chip of how large blocks will be
 	 * sent. It needs this to determine when to
@@ -722,7 +722,7 @@
 	 * Space for CRC must be included in the size.
 	 */
 	blksize = (1 << data->blksz_bits) + 2;
-	
+
 	wbsd_write_index(host, WBSD_IDX_PBSMSB, (blksize >> 4) & 0xF0);
 	wbsd_write_index(host, WBSD_IDX_PBSLSB, blksize & 0xFF);
 
@@ -734,12 +734,12 @@
 	setup = wbsd_read_index(host, WBSD_IDX_SETUP);
 	setup |= WBSD_FIFO_RESET;
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
-	
+
 	/*
 	 * DMA transfer?
 	 */
 	if (host->dma >= 0)
-	{	
+	{
 		/*
 		 * The buffer for DMA is only 64 kB.
 		 */
@@ -749,17 +749,17 @@
 			data->error = MMC_ERR_INVALID;
 			return;
 		}
-		
+
 		/*
 		 * Transfer data from the SG list to
 		 * the DMA buffer.
 		 */
 		if (data->flags & MMC_DATA_WRITE)
 			wbsd_sg_to_dma(host, data);
-		
+
 		/*
 		 * Initialise the ISA DMA controller.
-		 */	
+		 */
 		dmaflags = claim_dma_lock();
 		disable_dma(host->dma);
 		clear_dma_ff(host->dma);
@@ -785,17 +785,17 @@
 		 * output to a minimum.
 		 */
 		host->firsterr = 1;
-		
+
 		/*
 		 * Initialise the SG list.
 		 */
 		wbsd_init_sg(host, data);
-	
+
 		/*
 		 * Turn off DMA.
 		 */
 		wbsd_write_index(host, WBSD_IDX_DMA, 0);
-	
+
 		/*
 		 * Set up FIFO threshold levels (and fill
 		 * buffer if doing a write).
@@ -811,8 +811,8 @@
 				WBSD_FIFOEN_EMPTY | 8);
 			wbsd_fill_fifo(host);
 		}
-	}	
-		
+	}
+
 	data->error = MMC_ERR_NONE;
 }
 
@@ -821,7 +821,7 @@
 	unsigned long dmaflags;
 	int count;
 	u8 status;
-	
+
 	WARN_ON(host->mrq == NULL);
 
 	/*
@@ -838,7 +838,7 @@
 	{
 		status = wbsd_read_index(host, WBSD_IDX_STATUS);
 	} while (status & (WBSD_BLOCK_READ | WBSD_BLOCK_WRITE));
-	
+
 	/*
 	 * DMA transfer?
 	 */
@@ -848,7 +848,7 @@
 		 * Disable DMA on the host.
 		 */
 		wbsd_write_index(host, WBSD_IDX_DMA, 0);
-		
+
 		/*
 		 * Turn of ISA DMA controller.
 		 */
@@ -857,7 +857,7 @@
 		clear_dma_ff(host->dma);
 		count = get_dma_residue(host->dma);
 		release_dma_lock(dmaflags);
-		
+
 		/*
 		 * Any leftover data?
 		 */
@@ -865,7 +865,7 @@
 		{
 			printk(KERN_ERR DRIVER_NAME ": Incomplete DMA "
 				"transfer. %d bytes left.\n", count);
-			
+
 			data->error = MMC_ERR_FAILED;
 		}
 		else
@@ -876,13 +876,13 @@
 			 */
 			if (data->flags & MMC_DATA_READ)
 				wbsd_dma_to_sg(host, data);
-			
+
 			data->bytes_xfered = host->size;
 		}
 	}
-	
+
 	DBGF("Ending data transfer (%d bytes)\n", data->bytes_xfered);
-	
+
 	wbsd_request_end(host, host->mrq);
 }
 
@@ -907,7 +907,7 @@
 	cmd = mrq->cmd;
 
 	host->mrq = mrq;
-	
+
 	/*
 	 * If there is no card in the slot then
 	 * timeout immediatly.
@@ -924,18 +924,18 @@
 	if (cmd->data)
 	{
 		wbsd_prepare_data(host, cmd->data);
-		
+
 		if (cmd->data->error != MMC_ERR_NONE)
 			goto done;
 	}
-	
+
 	wbsd_send_command(host, cmd);
 
 	/*
 	 * If this is a data transfer the request
 	 * will be finished after the data has
 	 * transfered.
-	 */	
+	 */
 	if (cmd->data && (cmd->error == MMC_ERR_NONE))
 	{
 		/*
@@ -948,7 +948,7 @@
 
 		return;
 	}
-		
+
 done:
 	wbsd_request_end(host, mrq);
 
@@ -959,7 +959,7 @@
 {
 	struct wbsd_host* host = mmc_priv(mmc);
 	u8 clk, setup, pwr;
-	
+
 	DBGF("clock %uHz busmode %u powermode %u Vdd %u\n",
 		ios->clock, ios->bus_mode, ios->power_mode, ios->vdd);
 
@@ -971,7 +971,7 @@
 	 */
 	if (ios->power_mode == MMC_POWER_OFF)
 		wbsd_init_device(host);
-	
+
 	if (ios->clock >= 24000000)
 		clk = WBSD_CLK_24M;
 	else if (ios->clock >= 16000000)
@@ -1020,7 +1020,7 @@
 		host->flags &= ~WBSD_FIGNORE_DETECT;
 	}
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
-	
+
 	spin_unlock_bh(&host->lock);
 }
 
@@ -1041,12 +1041,12 @@
 static void wbsd_detect_card(unsigned long data)
 {
 	struct wbsd_host *host = (struct wbsd_host*)data;
-	
+
 	BUG_ON(host == NULL);
-	
+
 	DBG("Executing card detection\n");
-	
-	mmc_detect_change(host->mmc);	
+
+	mmc_detect_change(host->mmc);
 }
 
 /*
@@ -1066,7 +1066,7 @@
 	WARN_ON(!host->mrq->cmd->data);
 	if (!host->mrq->cmd->data)
 		return NULL;
-	
+
 	return host->mrq->cmd->data;
 }
 
@@ -1074,49 +1074,49 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	u8 csr;
-	
+
 	spin_lock(&host->lock);
-	
+
 	if (host->flags & WBSD_FIGNORE_DETECT)
 	{
 		spin_unlock(&host->lock);
 		return;
 	}
-	
+
 	csr = inb(host->base + WBSD_CSR);
 	WARN_ON(csr == 0xff);
-	
+
 	if (csr & WBSD_CARDPRESENT)
 	{
 		if (!(host->flags & WBSD_FCARD_PRESENT))
 		{
 			DBG("Card inserted\n");
 			host->flags |= WBSD_FCARD_PRESENT;
-			
+
 			/*
 			 * Delay card detection to allow electrical connections
 			 * to stabilise.
 			 */
 			mod_timer(&host->timer, jiffies + HZ/2);
 		}
-		
+
 		spin_unlock(&host->lock);
 	}
 	else if (host->flags & WBSD_FCARD_PRESENT)
 	{
 		DBG("Card removed\n");
 		host->flags &= ~WBSD_FCARD_PRESENT;
-		
+
 		if (host->mrq)
 		{
 			printk(KERN_ERR DRIVER_NAME
 				": Card removed during transfer!\n");
 			wbsd_reset(host);
-			
+
 			host->mrq->cmd->error = MMC_ERR_FAILED;
 			tasklet_schedule(&host->finish_tasklet);
 		}
-		
+
 		/*
 		 * Unlock first since we might get a call back.
 		 */
@@ -1130,12 +1130,12 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	struct mmc_data* data;
-	
+
 	spin_lock(&host->lock);
-		
+
 	if (!host->mrq)
 		goto end;
-	
+
 	data = wbsd_get_data(host);
 	if (!data)
 		goto end;
@@ -1154,7 +1154,7 @@
 		tasklet_schedule(&host->finish_tasklet);
 	}
 
-end:	
+end:
 	spin_unlock(&host->lock);
 }
 
@@ -1162,23 +1162,23 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	struct mmc_data* data;
-	
+
 	spin_lock(&host->lock);
-	
+
 	if (!host->mrq)
 		goto end;
-	
+
 	data = wbsd_get_data(host);
 	if (!data)
 		goto end;
-	
+
 	DBGF("CRC error\n");
 
 	data->error = MMC_ERR_BADCRC;
-	
+
 	tasklet_schedule(&host->finish_tasklet);
 
-end:		
+end:
 	spin_unlock(&host->lock);
 }
 
@@ -1186,23 +1186,23 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	struct mmc_data* data;
-	
+
 	spin_lock(&host->lock);
-	
+
 	if (!host->mrq)
 		goto end;
-	
+
 	data = wbsd_get_data(host);
 	if (!data)
 		goto end;
-	
+
 	DBGF("Timeout\n");
 
 	data->error = MMC_ERR_TIMEOUT;
-	
+
 	tasklet_schedule(&host->finish_tasklet);
 
-end:	
+end:
 	spin_unlock(&host->lock);
 }
 
@@ -1210,20 +1210,20 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	struct mmc_data* data;
-	
+
 	spin_lock(&host->lock);
-	
+
 	WARN_ON(!host->mrq);
 	if (!host->mrq)
 		goto end;
-	
+
 	data = wbsd_get_data(host);
 	if (!data)
 		goto end;
 
 	wbsd_finish_data(host, data);
-	
-end:	
+
+end:
 	spin_unlock(&host->lock);
 }
 
@@ -1231,7 +1231,7 @@
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	struct mmc_data* data;
-	
+
 	spin_lock(&host->lock);
 
 	if ((wbsd_read_index(host, WBSD_IDX_CRCSTATUS) & WBSD_CRC_MASK) !=
@@ -1240,15 +1240,15 @@
 		data = wbsd_get_data(host);
 		if (!data)
 			goto end;
-		
+
 		DBGF("CRC error\n");
 
 		data->error = MMC_ERR_BADCRC;
-	
+
 		tasklet_schedule(&host->finish_tasklet);
 	}
 
-end:	
+end:
 	spin_unlock(&host->lock);
 }
 
@@ -1260,7 +1260,7 @@
 {
 	struct wbsd_host* host = dev_id;
 	int isr;
-	
+
 	isr = inb(host->base + WBSD_ISR);
 
 	/*
@@ -1268,7 +1268,7 @@
 	 */
 	if (isr == 0xff || isr == 0x00)
 		return IRQ_NONE;
-	
+
 	host->isr |= isr;
 
 	/*
@@ -1286,7 +1286,7 @@
 		tasklet_hi_schedule(&host->block_tasklet);
 	if (isr & WBSD_INT_TC)
 		tasklet_schedule(&host->finish_tasklet);
-	
+
 	return IRQ_HANDLED;
 }
 
@@ -1304,14 +1304,14 @@
 {
 	struct mmc_host* mmc;
 	struct wbsd_host* host;
-	
+
 	/*
 	 * Allocate MMC structure.
 	 */
 	mmc = mmc_alloc_host(sizeof(struct wbsd_host), dev);
 	if (!mmc)
 		return -ENOMEM;
-	
+
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
@@ -1324,37 +1324,37 @@
 	mmc->f_min = 375000;
 	mmc->f_max = 24000000;
 	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
-	
+
 	spin_lock_init(&host->lock);
-	
+
 	/*
 	 * Set up detection timer
 	 */
 	init_timer(&host->timer);
 	host->timer.data = (unsigned long)host;
 	host->timer.function = wbsd_detect_card;
-	
+
 	/*
 	 * Maximum number of segments. Worst case is one sector per segment
 	 * so this will be 64kB/512.
 	 */
 	mmc->max_hw_segs = 128;
 	mmc->max_phys_segs = 128;
-	
+
 	/*
 	 * Maximum number of sectors in one transfer. Also limited by 64kB
 	 * buffer.
 	 */
 	mmc->max_sectors = 128;
-	
+
 	/*
 	 * Maximum segment size. Could be one segment with the maximum number
 	 * of segments.
 	 */
 	mmc->max_seg_size = mmc->max_sectors * 512;
-	
+
 	dev_set_drvdata(dev, mmc);
-	
+
 	return 0;
 }
 
@@ -1362,18 +1362,18 @@
 {
 	struct mmc_host* mmc;
 	struct wbsd_host* host;
-	
+
 	mmc = dev_get_drvdata(dev);
 	if (!mmc)
 		return;
-	
+
 	host = mmc_priv(mmc);
 	BUG_ON(host == NULL);
-	
+
 	del_timer_sync(&host->timer);
-	
+
 	mmc_free_host(mmc);
-	
+
 	dev_set_drvdata(dev, NULL);
 }
 
@@ -1385,7 +1385,7 @@
 {
 	int i, j, k;
 	int id;
-	
+
 	/*
 	 * Iterate through all ports, all codes to
 	 * find hardware that is in our known list.
@@ -1394,32 +1394,32 @@
 	{
 		if (!request_region(config_ports[i], 2, DRIVER_NAME))
 			continue;
-			
+
 		for (j = 0;j < sizeof(unlock_codes)/sizeof(int);j++)
 		{
 			id = 0xFFFF;
-			
+
 			outb(unlock_codes[j], config_ports[i]);
 			outb(unlock_codes[j], config_ports[i]);
-			
+
 			outb(WBSD_CONF_ID_HI, config_ports[i]);
 			id = inb(config_ports[i] + 1) << 8;
 
 			outb(WBSD_CONF_ID_LO, config_ports[i]);
 			id |= inb(config_ports[i] + 1);
-			
+
 			for (k = 0;k < sizeof(valid_ids)/sizeof(int);k++)
 			{
 				if (id == valid_ids[k])
-				{				
+				{
 					host->chip_id = id;
 					host->config = config_ports[i];
 					host->unlock_code = unlock_codes[i];
-				
+
 					return 0;
 				}
 			}
-			
+
 			if (id != 0xFFFF)
 			{
 				DBG("Unknown hardware (id %x) found at %x\n",
@@ -1428,10 +1428,10 @@
 
 			outb(LOCK_CODE, config_ports[i]);
 		}
-		
+
 		release_region(config_ports[i], 2);
 	}
-	
+
 	return -ENODEV;
 }
 
@@ -1443,12 +1443,12 @@
 {
 	if (io & 0x7)
 		return -EINVAL;
-	
+
 	if (!request_region(base, 8, DRIVER_NAME))
 		return -EIO;
-	
+
 	host->base = io;
-		
+
 	return 0;
 }
 
@@ -1456,12 +1456,12 @@
 {
 	if (host->base)
 		release_region(host->base, 8);
-	
+
 	host->base = 0;
 
 	if (host->config)
 		release_region(host->config, 2);
-	
+
 	host->config = 0;
 }
 
@@ -1473,10 +1473,10 @@
 {
 	if (dma < 0)
 		return;
-	
+
 	if (request_dma(dma, DRIVER_NAME))
 		goto err;
-	
+
 	/*
 	 * We need to allocate a special buffer in
 	 * order for ISA to be able to DMA to it.
@@ -1491,7 +1491,7 @@
 	 */
 	host->dma_addr = dma_map_single(host->mmc->dev, host->dma_buffer,
 		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
-			
+
 	/*
 	 * ISA DMA must be aligned on a 64k basis.
 	 */
@@ -1504,19 +1504,19 @@
 		goto kfree;
 
 	host->dma = dma;
-	
+
 	return;
-	
+
 kfree:
 	/*
 	 * If we've gotten here then there is some kind of alignment bug
 	 */
 	BUG_ON(1);
-	
+
 	dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
 		DMA_BIDIRECTIONAL);
 	host->dma_addr = (dma_addr_t)NULL;
-	
+
 	kfree(host->dma_buffer);
 	host->dma_buffer = NULL;
 
@@ -1537,7 +1537,7 @@
 		kfree(host->dma_buffer);
 	if (host->dma >= 0)
 		free_dma(host->dma);
-	
+
 	host->dma = -1;
 	host->dma_buffer = NULL;
 	host->dma_addr = (dma_addr_t)NULL;
@@ -1550,7 +1550,7 @@
 static int __devinit wbsd_request_irq(struct wbsd_host* host, int irq)
 {
 	int ret;
-	
+
 	/*
 	 * Allocate interrupt.
 	 */
@@ -1558,7 +1558,7 @@
 	ret = request_irq(irq, wbsd_irq, SA_SHIRQ, DRIVER_NAME, host);
 	if (ret)
 		return ret;
-	
+
 	host->irq = irq;
 
 	/*
@@ -1570,7 +1570,7 @@
 	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout, (unsigned long)host);
 	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish, (unsigned long)host);
 	tasklet_init(&host->block_tasklet, wbsd_tasklet_block, (unsigned long)host);
-	
+
 	return 0;
 }
 
@@ -1580,9 +1580,9 @@
 		return;
 
 	free_irq(host->irq, host);
-	
+
 	host->irq = 0;
-		
+
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->fifo_tasklet);
 	tasklet_kill(&host->crc_tasklet);
@@ -1599,7 +1599,7 @@
 	int base, int irq, int dma)
 {
 	int ret;
-	
+
 	/*
 	 * Allocate I/O ports.
 	 */
@@ -1618,7 +1618,7 @@
 	 * Allocate DMA.
 	 */
 	wbsd_request_dma(host, dma);
-	
+
 	return 0;
 }
 
@@ -1641,7 +1641,7 @@
 {
 	/*
 	 * Reset the chip.
-	 */	
+	 */
 	wbsd_write_config(host, WBSD_CONF_SWRST, 1);
 	wbsd_write_config(host, WBSD_CONF_SWRST, 0);
 
@@ -1649,23 +1649,23 @@
 	 * Select SD/MMC function.
 	 */
 	wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
-	
+
 	/*
 	 * Set up card detection.
 	 */
 	wbsd_write_config(host, WBSD_CONF_PINS, WBSD_PINS_DETECT_GP11);
-	
+
 	/*
 	 * Configure chip
 	 */
 	wbsd_write_config(host, WBSD_CONF_PORT_HI, host->base >> 8);
 	wbsd_write_config(host, WBSD_CONF_PORT_LO, host->base & 0xff);
-	
+
 	wbsd_write_config(host, WBSD_CONF_IRQ, host->irq);
-	
+
 	if (host->dma >= 0)
 		wbsd_write_config(host, WBSD_CONF_DRQ, host->dma);
-	
+
 	/*
 	 * Enable and power up chip.
 	 */
@@ -1676,26 +1676,26 @@
 /*
  * Check that configured resources are correct.
  */
- 
+
 static int __devinit wbsd_chip_validate(struct wbsd_host* host)
 {
 	int base, irq, dma;
-	
+
 	/*
 	 * Select SD/MMC function.
 	 */
 	wbsd_write_config(host, WBSD_CONF_DEVICE, DEVICE_SD);
-	
+
 	/*
 	 * Read configuration.
 	 */
 	base = wbsd_read_config(host, WBSD_CONF_PORT_HI) << 8;
 	base |= wbsd_read_config(host, WBSD_CONF_PORT_LO);
-	
+
 	irq = wbsd_read_config(host, WBSD_CONF_IRQ);
-	
+
 	dma = wbsd_read_config(host, WBSD_CONF_DRQ);
-	
+
 	/*
 	 * Validate against given configuration.
 	 */
@@ -1705,7 +1705,7 @@
 		return 0;
 	if ((dma != host->dma) && (host->dma != -1))
 		return 0;
-	
+
 	return 1;
 }
 
@@ -1721,14 +1721,14 @@
 	struct wbsd_host* host = NULL;
 	struct mmc_host* mmc = NULL;
 	int ret;
-	
+
 	ret = wbsd_alloc_mmc(dev);
 	if (ret)
 		return ret;
-	
+
 	mmc = dev_get_drvdata(dev);
 	host = mmc_priv(mmc);
-	
+
 	/*
 	 * Scan for hardware.
 	 */
@@ -1747,7 +1747,7 @@
 			return ret;
 		}
 	}
-	
+
 	/*
 	 * Request resources.
 	 */
@@ -1758,7 +1758,7 @@
 		wbsd_free_mmc(dev);
 		return ret;
 	}
-	
+
 	/*
 	 * See if chip needs to be configured.
 	 */
@@ -1775,7 +1775,7 @@
 	}
 	else
 		wbsd_chip_config(host);
-	
+
 	/*
 	 * Power Management stuff. No idea how this works.
 	 * Not tested.
@@ -1793,7 +1793,7 @@
 	 * Reset the chip into a known state.
 	 */
 	wbsd_init_device(host);
-	
+
 	mmc_add_host(mmc);
 
 	printk(KERN_INFO "%s: W83L51xD", mmc->host_name);
@@ -1815,12 +1815,12 @@
 {
 	struct mmc_host* mmc = dev_get_drvdata(dev);
 	struct wbsd_host* host;
-	
+
 	if (!mmc)
 		return;
 
 	host = mmc_priv(mmc);
-	
+
 	mmc_remove_host(mmc);
 
 	if (!pnp)
@@ -1833,9 +1833,9 @@
 		wbsd_write_config(host, WBSD_CONF_ENABLE, 0);
 		wbsd_lock_config(host);
 	}
-	
+
 	wbsd_release_resources(host);
-	
+
 	wbsd_free_mmc(dev);
 }
 
@@ -1865,7 +1865,7 @@
 wbsd_pnp_probe(struct pnp_dev * pnpdev, const struct pnp_device_id *dev_id)
 {
 	int io, irq, dma;
-	
+
 	/*
 	 * Get resources from PnP layer.
 	 */
@@ -1875,9 +1875,9 @@
 		dma = pnp_dma(pnpdev, 0);
 	else
 		dma = -1;
-	
+
 	DBGF("PnP resources: port %3x irq %d dma %d\n", io, irq, dma);
-	
+
 	return wbsd_init(&pnpdev->dev, io, irq, dma, 1);
 }
 
@@ -1918,7 +1918,7 @@
 	.bus		= &platform_bus_type,
 	.probe		= wbsd_probe,
 	.remove		= wbsd_remove,
-	
+
 	.suspend	= wbsd_suspend,
 	.resume		= wbsd_resume,
 };
@@ -1941,7 +1941,7 @@
 static int __init wbsd_drv_init(void)
 {
 	int result;
-	
+
 	printk(KERN_INFO DRIVER_NAME
 		": Winbond W83L51xD SD/MMC card interface driver, "
 		DRIVER_VERSION "\n");
@@ -1956,8 +1956,8 @@
 			return result;
 	}
 
-#endif /* CONFIG_PNP */	
-	
+#endif /* CONFIG_PNP */
+
 	if (nopnp)
 	{
 		result = driver_register(&wbsd_driver);
@@ -1979,13 +1979,13 @@
 
 	if (!nopnp)
 		pnp_unregister_driver(&wbsd_pnp_driver);
-	
-#endif /* CONFIG_PNP */	
+
+#endif /* CONFIG_PNP */
 
 	if (nopnp)
 	{
 		platform_device_unregister(wbsd_device);
-	
+
 		driver_unregister(&wbsd_driver);
 	}
 
--- linux/drivers/mmc/wbsd.h.orig	2005-07-11 14:26:46.000000000 +0200
+++ linux/drivers/mmc/wbsd.h	2005-07-11 14:27:05.000000000 +0200
@@ -137,49 +137,49 @@
 struct wbsd_host
 {
 	struct mmc_host*	mmc;		/* MMC structure */
-	
+
 	spinlock_t		lock;		/* Mutex */
 
 	int			flags;		/* Driver states */
 
 #define WBSD_FCARD_PRESENT	(1<<0)		/* Card is present */
 #define WBSD_FIGNORE_DETECT	(1<<1)		/* Ignore card detection */
-	
+
 	struct mmc_request*	mrq;		/* Current request */
-	
+
 	u8			isr;		/* Accumulated ISR */
-	
+
 	struct scatterlist*	cur_sg;		/* Current SG entry */
 	unsigned int		num_sg;		/* Number of entries left */
 	void*			mapped_sg;	/* vaddr of mapped sg */
-	
+
 	unsigned int		offset;		/* Offset into current entry */
 	unsigned int		remain;		/* Data left in curren entry */
 
 	int			size;		/* Total size of transfer */
-	
+
 	char*			dma_buffer;	/* ISA DMA buffer */
 	dma_addr_t		dma_addr;	/* Physical address for same */
 
 	int			firsterr;	/* See fifo functions */
-	
+
 	u8			clk;		/* Current clock speed */
-	
+
 	int			config;		/* Config port */
 	u8			unlock_code;	/* Code to unlock config */
 
 	int			chip_id;	/* ID of controller */
-	
+
 	int			base;		/* I/O port base */
 	int			irq;		/* Interrupt */
 	int			dma;		/* DMA channel */
-	
+
 	struct tasklet_struct	card_tasklet;	/* Tasklet structures */
 	struct tasklet_struct	fifo_tasklet;
 	struct tasklet_struct	crc_tasklet;
 	struct tasklet_struct	timeout_tasklet;
 	struct tasklet_struct	finish_tasklet;
 	struct tasklet_struct	block_tasklet;
-	
+
 	struct timer_list	timer;		/* Card detection timer */
 };

--=_hermes.drzeus.cx-7109-1121084993-0001-2--
