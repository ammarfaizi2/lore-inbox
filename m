Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVILLHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVILLHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVILLHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:07:13 -0400
Received: from [85.8.12.41] ([85.8.12.41]:22402 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750728AbVILLHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:07:11 -0400
Message-ID: <4325615B.5090805@drzeus.cx>
Date: Mon, 12 Sep 2005 13:07:07 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-8442-1126523229-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove trailing whitespace in wbsd
References: <43249566.8050500@drzeus.cx> <43253305.9070508@drzeus.cx> <20050912105237.B23744@flint.arm.linux.org.uk>
In-Reply-To: <20050912105237.B23744@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-8442-1126523229-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Russell King wrote:

>Unfortunately, this patch is white-space damaged, so doesn't apply.
>I've tried fixing up the obvious stuff due to the wrapping, but I
>still get:
>
>patching file drivers/mmc/wbsd.c
>Hunk #14 FAILED at 363.
>Hunk #82 FAILED at 1743.
>
>  
>

Damn these wrapping mailers. I've attached the patch instead of inlining
it so the mailer should leave it alone this time.

Rgds
Pierre


--=_hermes.drzeus.cx-8442-1126523229-0001-2
Content-Type: text/x-patch; name="wbsd-whitespace.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-whitespace.patch"

Remove trailing whitespace in wbsd

Clean out trailing whitespace caused by not-so-great editor since it
generates a lot of problems with editors configured to automatically
strip whitespace.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |  416 ++++++++++++++++++++++++++--------------------------
 drivers/mmc/wbsd.h |   22 +--
 2 files changed, 219 insertions(+), 219 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -93,7 +93,7 @@ static int dma = 2;
 static inline void wbsd_unlock_config(struct wbsd_host* host)
 {
 	BUG_ON(host->config == 0);
-	
+
 	outb(host->unlock_code, host->config);
 	outb(host->unlock_code, host->config);
 }
@@ -101,14 +101,14 @@ static inline void wbsd_unlock_config(st
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
@@ -116,7 +116,7 @@ static inline void wbsd_write_config(str
 static inline u8 wbsd_read_config(struct wbsd_host* host, u8 reg)
 {
 	BUG_ON(host->config == 0);
-	
+
 	outb(reg, host->config);
 	return inb(host->config + 1);
 }
@@ -140,21 +140,21 @@ static inline u8 wbsd_read_index(struct 
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
@@ -164,12 +164,12 @@ static void wbsd_init_device(struct wbsd
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
@@ -177,7 +177,7 @@ static void wbsd_init_device(struct wbsd
 		host->flags |= WBSD_FCARD_PRESENT;
 	else
 		host->flags &= ~WBSD_FCARD_PRESENT;
-	
+
 	/*
 	 * Enable interesting interrupts.
 	 */
@@ -200,9 +200,9 @@ static void wbsd_init_device(struct wbsd
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
@@ -214,9 +214,9 @@ static void wbsd_reset(struct wbsd_host*
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
@@ -232,7 +232,7 @@ static void wbsd_request_end(struct wbsd
 		 */
 		wbsd_write_index(host, WBSD_IDX_DMA, 0);
 	}
-	
+
 	host->mrq = NULL;
 
 	/*
@@ -275,7 +275,7 @@ static inline int wbsd_next_sg(struct wb
 	    host->offset = 0;
 	    host->remain = host->cur_sg->length;
 	  }
-	
+
 	return host->num_sg;
 }
 
@@ -297,12 +297,12 @@ static inline void wbsd_sg_to_dma(struct
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
@@ -317,23 +317,23 @@ static inline void wbsd_sg_to_dma(struct
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
 
@@ -343,12 +343,12 @@ static inline void wbsd_dma_to_sg(struct
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
@@ -363,30 +363,30 @@ static inline void wbsd_dma_to_sg(struct
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
@@ -398,7 +398,7 @@ static inline void wbsd_get_short_reply(
 		cmd->error = MMC_ERR_INVALID;
 		return;
 	}
-	
+
 	cmd->resp[0] =
 		wbsd_read_index(host, WBSD_IDX_RESP12) << 24;
 	cmd->resp[0] |=
@@ -415,7 +415,7 @@ static inline void wbsd_get_long_reply(s
 	struct mmc_command* cmd)
 {
 	int i;
-	
+
 	/*
 	 * Correct response type?
 	 */
@@ -424,7 +424,7 @@ static inline void wbsd_get_long_reply(s
 		cmd->error = MMC_ERR_INVALID;
 		return;
 	}
-	
+
 	for (i = 0;i < 4;i++)
 	{
 		cmd->resp[i] =
@@ -442,7 +442,7 @@ static void wbsd_send_command(struct wbs
 {
 	int i;
 	u8 status, isr;
-	
+
 	DBGF("Sending cmd (%x)\n", cmd->opcode);
 
 	/*
@@ -451,16 +451,16 @@ static void wbsd_send_command(struct wbs
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
@@ -477,7 +477,7 @@ static void wbsd_send_command(struct wbs
 		 * Read back status.
 		 */
 		isr = host->isr;
-		
+
 		/* Card removed? */
 		if (isr & WBSD_INT_CARD)
 			cmd->error = MMC_ERR_TIMEOUT;
@@ -509,13 +509,13 @@ static void wbsd_empty_fifo(struct wbsd_
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
@@ -527,14 +527,14 @@ static void wbsd_empty_fifo(struct wbsd_
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
@@ -543,23 +543,23 @@ static void wbsd_empty_fifo(struct wbsd_
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
@@ -572,17 +572,17 @@ static void wbsd_empty_fifo(struct wbsd_
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
@@ -599,7 +599,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 	struct mmc_data* data = host->mrq->cmd->data;
 	char* buffer;
 	int i, fsr, fifo;
-	
+
 	/*
 	 * Check that we aren't being called after the
 	 * entire buffer has been transfered.
@@ -618,7 +618,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
-		 */		
+		 */
 		if (fsr & WBSD_FIFO_EMPTY)
 			fifo = 0;
 		else if (fsr & WBSD_FIFO_EMTHRE)
@@ -632,9 +632,9 @@ static void wbsd_fill_fifo(struct wbsd_h
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
@@ -650,7 +650,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 			if (host->remain == 0)
 			{
 				wbsd_kunmap_sg(host);
-				
+
 				/*
 				 * Get next entry. Check if last.
 				 */
@@ -663,19 +663,19 @@ static void wbsd_fill_fifo(struct wbsd_h
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
@@ -694,7 +694,7 @@ static void wbsd_prepare_data(struct wbs
 		1 << data->blksz_bits, data->blocks, data->flags);
 	DBGF("tsac %d ms nsac %d clk\n",
 		data->timeout_ns / 1000000, data->timeout_clks);
-	
+
 	/*
 	 * Calculate size.
 	 */
@@ -708,12 +708,12 @@ static void wbsd_prepare_data(struct wbs
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
@@ -732,7 +732,7 @@ static void wbsd_prepare_data(struct wbs
 	else if (host->bus_width == MMC_BUS_WIDTH_4)
 	{
 		blksize = (1 << data->blksz_bits) + 2 * 4;
-	
+
 		wbsd_write_index(host, WBSD_IDX_PBSMSB, ((blksize >> 4) & 0xF0)
 			| WBSD_DATA_WIDTH);
 		wbsd_write_index(host, WBSD_IDX_PBSLSB, blksize & 0xFF);
@@ -751,12 +751,12 @@ static void wbsd_prepare_data(struct wbs
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
@@ -766,17 +766,17 @@ static void wbsd_prepare_data(struct wbs
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
@@ -802,17 +802,17 @@ static void wbsd_prepare_data(struct wbs
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
@@ -828,8 +828,8 @@ static void wbsd_prepare_data(struct wbs
 				WBSD_FIFOEN_EMPTY | 8);
 			wbsd_fill_fifo(host);
 		}
-	}	
-		
+	}
+
 	data->error = MMC_ERR_NONE;
 }
 
@@ -838,7 +838,7 @@ static void wbsd_finish_data(struct wbsd
 	unsigned long dmaflags;
 	int count;
 	u8 status;
-	
+
 	WARN_ON(host->mrq == NULL);
 
 	/*
@@ -855,7 +855,7 @@ static void wbsd_finish_data(struct wbsd
 	{
 		status = wbsd_read_index(host, WBSD_IDX_STATUS);
 	} while (status & (WBSD_BLOCK_READ | WBSD_BLOCK_WRITE));
-	
+
 	/*
 	 * DMA transfer?
 	 */
@@ -865,7 +865,7 @@ static void wbsd_finish_data(struct wbsd
 		 * Disable DMA on the host.
 		 */
 		wbsd_write_index(host, WBSD_IDX_DMA, 0);
-		
+
 		/*
 		 * Turn of ISA DMA controller.
 		 */
@@ -874,7 +874,7 @@ static void wbsd_finish_data(struct wbsd
 		clear_dma_ff(host->dma);
 		count = get_dma_residue(host->dma);
 		release_dma_lock(dmaflags);
-		
+
 		/*
 		 * Any leftover data?
 		 */
@@ -882,7 +882,7 @@ static void wbsd_finish_data(struct wbsd
 		{
 			printk(KERN_ERR DRIVER_NAME ": Incomplete DMA "
 				"transfer. %d bytes left.\n", count);
-			
+
 			data->error = MMC_ERR_FAILED;
 		}
 		else
@@ -893,13 +893,13 @@ static void wbsd_finish_data(struct wbsd
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
 
@@ -924,7 +924,7 @@ static void wbsd_request(struct mmc_host
 	cmd = mrq->cmd;
 
 	host->mrq = mrq;
-	
+
 	/*
 	 * If there is no card in the slot then
 	 * timeout immediatly.
@@ -941,18 +941,18 @@ static void wbsd_request(struct mmc_host
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
@@ -965,7 +965,7 @@ static void wbsd_request(struct mmc_host
 
 		return;
 	}
-		
+
 done:
 	wbsd_request_end(host, mrq);
 
@@ -976,7 +976,7 @@ static void wbsd_set_ios(struct mmc_host
 {
 	struct wbsd_host* host = mmc_priv(mmc);
 	u8 clk, setup, pwr;
-	
+
 	DBGF("clock %uHz busmode %u powermode %u cs %u Vdd %u width %u\n",
 	     ios->clock, ios->bus_mode, ios->power_mode, ios->chip_select,
 	     ios->vdd, ios->bus_width);
@@ -989,7 +989,7 @@ static void wbsd_set_ios(struct mmc_host
 	 */
 	if (ios->power_mode == MMC_POWER_OFF)
 		wbsd_init_device(host);
-	
+
 	if (ios->clock >= 24000000)
 		clk = WBSD_CLK_24M;
 	else if (ios->clock >= 16000000)
@@ -1042,7 +1042,7 @@ static void wbsd_set_ios(struct mmc_host
 		mod_timer(&host->ignore_timer, jiffies + HZ/100);
 	}
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
-	
+
 	/*
 	 * Store bus width for later. Will be used when
 	 * setting up the data transfer.
@@ -1128,7 +1128,7 @@ static inline struct mmc_data* wbsd_get_
 	WARN_ON(!host->mrq->cmd->data);
 	if (!host->mrq->cmd->data)
 		return NULL;
-	
+
 	return host->mrq->cmd->data;
 }
 
@@ -1136,25 +1136,25 @@ static void wbsd_tasklet_card(unsigned l
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
 			spin_unlock(&host->lock);
 
 			/*
@@ -1170,17 +1170,17 @@ static void wbsd_tasklet_card(unsigned l
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
@@ -1196,12 +1196,12 @@ static void wbsd_tasklet_fifo(unsigned l
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
@@ -1220,7 +1220,7 @@ static void wbsd_tasklet_fifo(unsigned l
 		tasklet_schedule(&host->finish_tasklet);
 	}
 
-end:	
+end:
 	spin_unlock(&host->lock);
 }
 
@@ -1228,23 +1228,23 @@ static void wbsd_tasklet_crc(unsigned lo
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
 
@@ -1252,23 +1252,23 @@ static void wbsd_tasklet_timeout(unsigne
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
 
@@ -1276,20 +1276,20 @@ static void wbsd_tasklet_finish(unsigned
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
 
@@ -1297,7 +1297,7 @@ static void wbsd_tasklet_block(unsigned 
 {
 	struct wbsd_host* host = (struct wbsd_host*)param;
 	struct mmc_data* data;
-	
+
 	spin_lock(&host->lock);
 
 	if ((wbsd_read_index(host, WBSD_IDX_CRCSTATUS) & WBSD_CRC_MASK) !=
@@ -1306,15 +1306,15 @@ static void wbsd_tasklet_block(unsigned 
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
 
@@ -1326,7 +1326,7 @@ static irqreturn_t wbsd_irq(int irq, voi
 {
 	struct wbsd_host* host = dev_id;
 	int isr;
-	
+
 	isr = inb(host->base + WBSD_ISR);
 
 	/*
@@ -1334,7 +1334,7 @@ static irqreturn_t wbsd_irq(int irq, voi
 	 */
 	if (isr == 0xff || isr == 0x00)
 		return IRQ_NONE;
-	
+
 	host->isr |= isr;
 
 	/*
@@ -1352,7 +1352,7 @@ static irqreturn_t wbsd_irq(int irq, voi
 		tasklet_hi_schedule(&host->block_tasklet);
 	if (isr & WBSD_INT_TC)
 		tasklet_schedule(&host->finish_tasklet);
-	
+
 	return IRQ_HANDLED;
 }
 
@@ -1370,14 +1370,14 @@ static int __devinit wbsd_alloc_mmc(stru
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
 
@@ -1391,37 +1391,37 @@ static int __devinit wbsd_alloc_mmc(stru
 	mmc->f_max = 24000000;
 	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
-	
+
 	spin_lock_init(&host->lock);
-	
+
 	/*
 	 * Set up timers
 	 */
 	init_timer(&host->ignore_timer);
 	host->ignore_timer.data = (unsigned long)host;
 	host->ignore_timer.function = wbsd_reset_ignore;
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
 
@@ -1429,18 +1429,18 @@ static void __devexit wbsd_free_mmc(stru
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
 	del_timer_sync(&host->ignore_timer);
-	
+
 	mmc_free_host(mmc);
-	
+
 	dev_set_drvdata(dev, NULL);
 }
 
@@ -1452,7 +1452,7 @@ static int __devinit wbsd_scan(struct wb
 {
 	int i, j, k;
 	int id;
-	
+
 	/*
 	 * Iterate through all ports, all codes to
 	 * find hardware that is in our known list.
@@ -1461,32 +1461,32 @@ static int __devinit wbsd_scan(struct wb
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
@@ -1495,10 +1495,10 @@ static int __devinit wbsd_scan(struct wb
 
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
 
@@ -1510,12 +1510,12 @@ static int __devinit wbsd_request_region
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
 
@@ -1523,12 +1523,12 @@ static void __devexit wbsd_release_regio
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
 
@@ -1540,10 +1540,10 @@ static void __devinit wbsd_request_dma(s
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
@@ -1558,7 +1558,7 @@ static void __devinit wbsd_request_dma(s
 	 */
 	host->dma_addr = dma_map_single(host->mmc->dev, host->dma_buffer,
 		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
-			
+
 	/*
 	 * ISA DMA must be aligned on a 64k basis.
 	 */
@@ -1571,19 +1571,19 @@ static void __devinit wbsd_request_dma(s
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
 
@@ -1604,7 +1604,7 @@ static void __devexit wbsd_release_dma(s
 		kfree(host->dma_buffer);
 	if (host->dma >= 0)
 		free_dma(host->dma);
-	
+
 	host->dma = -1;
 	host->dma_buffer = NULL;
 	host->dma_addr = (dma_addr_t)NULL;
@@ -1617,7 +1617,7 @@ static void __devexit wbsd_release_dma(s
 static int __devinit wbsd_request_irq(struct wbsd_host* host, int irq)
 {
 	int ret;
-	
+
 	/*
 	 * Allocate interrupt.
 	 */
@@ -1625,7 +1625,7 @@ static int __devinit wbsd_request_irq(st
 	ret = request_irq(irq, wbsd_irq, SA_SHIRQ, DRIVER_NAME, host);
 	if (ret)
 		return ret;
-	
+
 	host->irq = irq;
 
 	/*
@@ -1637,7 +1637,7 @@ static int __devinit wbsd_request_irq(st
 	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout, (unsigned long)host);
 	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish, (unsigned long)host);
 	tasklet_init(&host->block_tasklet, wbsd_tasklet_block, (unsigned long)host);
-	
+
 	return 0;
 }
 
@@ -1647,9 +1647,9 @@ static void __devexit wbsd_release_irq(s
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
@@ -1666,7 +1666,7 @@ static int __devinit wbsd_request_resour
 	int base, int irq, int dma)
 {
 	int ret;
-	
+
 	/*
 	 * Allocate I/O ports.
 	 */
@@ -1685,7 +1685,7 @@ static int __devinit wbsd_request_resour
 	 * Allocate DMA.
 	 */
 	wbsd_request_dma(host, dma);
-	
+
 	return 0;
 }
 
@@ -1708,7 +1708,7 @@ static void __devinit wbsd_chip_config(s
 {
 	/*
 	 * Reset the chip.
-	 */	
+	 */
 	wbsd_write_config(host, WBSD_CONF_SWRST, 1);
 	wbsd_write_config(host, WBSD_CONF_SWRST, 0);
 
@@ -1716,23 +1716,23 @@ static void __devinit wbsd_chip_config(s
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
@@ -1743,26 +1743,26 @@ static void __devinit wbsd_chip_config(s
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
@@ -1772,7 +1772,7 @@ static int __devinit wbsd_chip_validate(
 		return 0;
 	if ((dma != host->dma) && (host->dma != -1))
 		return 0;
-	
+
 	return 1;
 }
 
@@ -1788,14 +1788,14 @@ static int __devinit wbsd_init(struct de
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
@@ -1814,7 +1814,7 @@ static int __devinit wbsd_init(struct de
 			return ret;
 		}
 	}
-	
+
 	/*
 	 * Request resources.
 	 */
@@ -1825,7 +1825,7 @@ static int __devinit wbsd_init(struct de
 		wbsd_free_mmc(dev);
 		return ret;
 	}
-	
+
 	/*
 	 * See if chip needs to be configured.
 	 */
@@ -1842,7 +1842,7 @@ static int __devinit wbsd_init(struct de
 	}
 	else
 		wbsd_chip_config(host);
-	
+
 	/*
 	 * Power Management stuff. No idea how this works.
 	 * Not tested.
@@ -1860,7 +1860,7 @@ static int __devinit wbsd_init(struct de
 	 * Reset the chip into a known state.
 	 */
 	wbsd_init_device(host);
-	
+
 	mmc_add_host(mmc);
 
 	printk(KERN_INFO "%s: W83L51xD", mmc_hostname(mmc));
@@ -1882,12 +1882,12 @@ static void __devexit wbsd_shutdown(stru
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
@@ -1900,9 +1900,9 @@ static void __devexit wbsd_shutdown(stru
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
 
@@ -1932,7 +1932,7 @@ static int __devinit
 wbsd_pnp_probe(struct pnp_dev * pnpdev, const struct pnp_device_id *dev_id)
 {
 	int io, irq, dma;
-	
+
 	/*
 	 * Get resources from PnP layer.
 	 */
@@ -1942,9 +1942,9 @@ wbsd_pnp_probe(struct pnp_dev * pnpdev, 
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
 
@@ -1985,7 +1985,7 @@ static struct device_driver wbsd_driver 
 	.bus		= &platform_bus_type,
 	.probe		= wbsd_probe,
 	.remove		= wbsd_remove,
-	
+
 	.suspend	= wbsd_suspend,
 	.resume		= wbsd_resume,
 };
@@ -2008,7 +2008,7 @@ static struct pnp_driver wbsd_pnp_driver
 static int __init wbsd_drv_init(void)
 {
 	int result;
-	
+
 	printk(KERN_INFO DRIVER_NAME
 		": Winbond W83L51xD SD/MMC card interface driver, "
 		DRIVER_VERSION "\n");
@@ -2023,8 +2023,8 @@ static int __init wbsd_drv_init(void)
 			return result;
 	}
 
-#endif /* CONFIG_PNP */	
-	
+#endif /* CONFIG_PNP */
+
 	if (nopnp)
 	{
 		result = driver_register(&wbsd_driver);
@@ -2046,13 +2046,13 @@ static void __exit wbsd_drv_exit(void)
 
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
 
diff --git a/drivers/mmc/wbsd.h b/drivers/mmc/wbsd.h
--- a/drivers/mmc/wbsd.h
+++ b/drivers/mmc/wbsd.h
@@ -139,51 +139,51 @@
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
 	unsigned char		bus_width;	/* Current bus width */
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
 	struct timer_list	detect_timer;	/* Card detection timer */
 	struct timer_list	ignore_timer;	/* Ignore detection timer */
 };

--=_hermes.drzeus.cx-8442-1126523229-0001-2--
