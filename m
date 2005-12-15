Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbVLOFqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbVLOFqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVLOFqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:46:24 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:12885 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161130AbVLOFp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:45:57 -0500
Message-Id: <20051215054444.734214000.dtor_core@ameritech.net>
References: <20051215053933.125918000.dtor_core@ameritech.net>
Date: Thu, 15 Dec 2005 00:39:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: [patch 2/3] wbsd: run through Lindent
Content-Disposition: inline; filename=wbsd-lindent.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd: run through Lindent to ensure conding style compliance

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/mmc/wbsd.c |  506 ++++++++++++++++++++++-------------------------------
 drivers/mmc/wbsd.h |    3 
 2 files changed, 218 insertions(+), 291 deletions(-)

Index: work/drivers/mmc/wbsd.c
===================================================================
--- work.orig/drivers/mmc/wbsd.c
+++ work/drivers/mmc/wbsd.c
@@ -75,7 +75,7 @@ static const int unlock_codes[] = { 0x83
 
 static const int valid_ids[] = {
 	0x7112,
-	};
+};
 
 #ifdef CONFIG_PNP
 static unsigned int nopnp = 0;
@@ -90,7 +90,7 @@ static int dma = 2;
  * Basic functions
  */
 
-static inline void wbsd_unlock_config(struct wbsd_host* host)
+static inline void wbsd_unlock_config(struct wbsd_host *host)
 {
 	BUG_ON(host->config == 0);
 
@@ -98,14 +98,14 @@ static inline void wbsd_unlock_config(st
 	outb(host->unlock_code, host->config);
 }
 
-static inline void wbsd_lock_config(struct wbsd_host* host)
+static inline void wbsd_lock_config(struct wbsd_host *host)
 {
 	BUG_ON(host->config == 0);
 
 	outb(LOCK_CODE, host->config);
 }
 
-static inline void wbsd_write_config(struct wbsd_host* host, u8 reg, u8 value)
+static inline void wbsd_write_config(struct wbsd_host *host, u8 reg, u8 value)
 {
 	BUG_ON(host->config == 0);
 
@@ -113,7 +113,7 @@ static inline void wbsd_write_config(str
 	outb(value, host->config + 1);
 }
 
-static inline u8 wbsd_read_config(struct wbsd_host* host, u8 reg)
+static inline u8 wbsd_read_config(struct wbsd_host *host, u8 reg)
 {
 	BUG_ON(host->config == 0);
 
@@ -121,13 +121,13 @@ static inline u8 wbsd_read_config(struct
 	return inb(host->config + 1);
 }
 
-static inline void wbsd_write_index(struct wbsd_host* host, u8 index, u8 value)
+static inline void wbsd_write_index(struct wbsd_host *host, u8 index, u8 value)
 {
 	outb(index, host->base + WBSD_IDXR);
 	outb(value, host->base + WBSD_DATAR);
 }
 
-static inline u8 wbsd_read_index(struct wbsd_host* host, u8 index)
+static inline u8 wbsd_read_index(struct wbsd_host *host, u8 index)
 {
 	outb(index, host->base + WBSD_IDXR);
 	return inb(host->base + WBSD_DATAR);
@@ -137,7 +137,7 @@ static inline u8 wbsd_read_index(struct 
  * Common routines
  */
 
-static void wbsd_init_device(struct wbsd_host* host)
+static void wbsd_init_device(struct wbsd_host *host)
 {
 	u8 setup, ier;
 
@@ -197,7 +197,7 @@ static void wbsd_init_device(struct wbsd
 	inb(host->base + WBSD_ISR);
 }
 
-static void wbsd_reset(struct wbsd_host* host)
+static void wbsd_reset(struct wbsd_host *host)
 {
 	u8 setup;
 
@@ -211,14 +211,13 @@ static void wbsd_reset(struct wbsd_host*
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
 }
 
-static void wbsd_request_end(struct wbsd_host* host, struct mmc_request* mrq)
+static void wbsd_request_end(struct wbsd_host *host, struct mmc_request *mrq)
 {
 	unsigned long dmaflags;
 
 	DBGF("Ending request, cmd (%x)\n", mrq->cmd->opcode);
 
-	if (host->dma >= 0)
-	{
+	if (host->dma >= 0) {
 		/*
 		 * Release ISA DMA controller.
 		 */
@@ -247,7 +246,7 @@ static void wbsd_request_end(struct wbsd
  * Scatter/gather functions
  */
 
-static inline void wbsd_init_sg(struct wbsd_host* host, struct mmc_data* data)
+static inline void wbsd_init_sg(struct wbsd_host *host, struct mmc_data *data)
 {
 	/*
 	 * Get info. about SG list from data structure.
@@ -259,7 +258,7 @@ static inline void wbsd_init_sg(struct w
 	host->remain = host->cur_sg->length;
 }
 
-static inline int wbsd_next_sg(struct wbsd_host* host)
+static inline int wbsd_next_sg(struct wbsd_host *host)
 {
 	/*
 	 * Skip to next SG entry.
@@ -270,33 +269,32 @@ static inline int wbsd_next_sg(struct wb
 	/*
 	 * Any entries left?
 	 */
-	if (host->num_sg > 0)
-	  {
-	    host->offset = 0;
-	    host->remain = host->cur_sg->length;
-	  }
+	if (host->num_sg > 0) {
+		host->offset = 0;
+		host->remain = host->cur_sg->length;
+	}
 
 	return host->num_sg;
 }
 
-static inline char* wbsd_kmap_sg(struct wbsd_host* host)
+static inline char *wbsd_kmap_sg(struct wbsd_host *host)
 {
 	host->mapped_sg = kmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ) +
-		host->cur_sg->offset;
+			  host->cur_sg->offset;
 	return host->mapped_sg;
 }
 
-static inline void wbsd_kunmap_sg(struct wbsd_host* host)
+static inline void wbsd_kunmap_sg(struct wbsd_host *host)
 {
 	kunmap_atomic(host->mapped_sg, KM_BIO_SRC_IRQ);
 }
 
-static inline void wbsd_sg_to_dma(struct wbsd_host* host, struct mmc_data* data)
+static inline void wbsd_sg_to_dma(struct wbsd_host *host, struct mmc_data *data)
 {
 	unsigned int len, i, size;
-	struct scatterlist* sg;
-	char* dmabuf = host->dma_buffer;
-	char* sgbuf;
+	struct scatterlist *sg;
+	char *dmabuf = host->dma_buffer;
+	char *sgbuf;
 
 	size = host->size;
 
@@ -308,8 +306,7 @@ static inline void wbsd_sg_to_dma(struct
 	 * be the entire list though so make sure that
 	 * we do not transfer too much.
 	 */
-	for (i = 0;i < len;i++)
-	{
+	for (i = 0; i < len; i++) {
 		sgbuf = kmap_atomic(sg[i].page, KM_BIO_SRC_IRQ) + sg[i].offset;
 		if (size < sg[i].length)
 			memcpy(dmabuf, sgbuf, size);
@@ -337,12 +334,12 @@ static inline void wbsd_sg_to_dma(struct
 	host->size -= size;
 }
 
-static inline void wbsd_dma_to_sg(struct wbsd_host* host, struct mmc_data* data)
+static inline void wbsd_dma_to_sg(struct wbsd_host *host, struct mmc_data *data)
 {
 	unsigned int len, i, size;
-	struct scatterlist* sg;
-	char* dmabuf = host->dma_buffer;
-	char* sgbuf;
+	struct scatterlist *sg;
+	char *dmabuf = host->dma_buffer;
+	char *sgbuf;
 
 	size = host->size;
 
@@ -354,8 +351,7 @@ static inline void wbsd_dma_to_sg(struct
 	 * be the entire list though so make sure that
 	 * we do not transfer too much.
 	 */
-	for (i = 0;i < len;i++)
-	{
+	for (i = 0; i < len; i++) {
 		sgbuf = kmap_atomic(sg[i].page, KM_BIO_SRC_IRQ) + sg[i].offset;
 		if (size < sg[i].length)
 			memcpy(sgbuf, dmabuf, size);
@@ -387,46 +383,38 @@ static inline void wbsd_dma_to_sg(struct
  * Command handling
  */
 
-static inline void wbsd_get_short_reply(struct wbsd_host* host,
-	struct mmc_command* cmd)
+static inline void wbsd_get_short_reply(struct wbsd_host *host,
+					struct mmc_command *cmd)
 {
 	/*
 	 * Correct response type?
 	 */
-	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) != WBSD_RSP_SHORT)
-	{
+	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) != WBSD_RSP_SHORT) {
 		cmd->error = MMC_ERR_INVALID;
 		return;
 	}
 
-	cmd->resp[0] =
-		wbsd_read_index(host, WBSD_IDX_RESP12) << 24;
-	cmd->resp[0] |=
-		wbsd_read_index(host, WBSD_IDX_RESP13) << 16;
-	cmd->resp[0] |=
-		wbsd_read_index(host, WBSD_IDX_RESP14) << 8;
-	cmd->resp[0] |=
-		wbsd_read_index(host, WBSD_IDX_RESP15) << 0;
-	cmd->resp[1] =
-		wbsd_read_index(host, WBSD_IDX_RESP16) << 24;
+	cmd->resp[0] = wbsd_read_index(host, WBSD_IDX_RESP12) << 24;
+	cmd->resp[0] |= wbsd_read_index(host, WBSD_IDX_RESP13) << 16;
+	cmd->resp[0] |= wbsd_read_index(host, WBSD_IDX_RESP14) << 8;
+	cmd->resp[0] |= wbsd_read_index(host, WBSD_IDX_RESP15) << 0;
+	cmd->resp[1] = wbsd_read_index(host, WBSD_IDX_RESP16) << 24;
 }
 
-static inline void wbsd_get_long_reply(struct wbsd_host* host,
-	struct mmc_command* cmd)
+static inline void wbsd_get_long_reply(struct wbsd_host *host,
+				       struct mmc_command *cmd)
 {
 	int i;
 
 	/*
 	 * Correct response type?
 	 */
-	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) != WBSD_RSP_LONG)
-	{
+	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) != WBSD_RSP_LONG) {
 		cmd->error = MMC_ERR_INVALID;
 		return;
 	}
 
-	for (i = 0;i < 4;i++)
-	{
+	for (i = 0; i < 4; i++) {
 		cmd->resp[i] =
 			wbsd_read_index(host, WBSD_IDX_RESP1 + i * 4) << 24;
 		cmd->resp[i] |=
@@ -438,7 +426,7 @@ static inline void wbsd_get_long_reply(s
 	}
 }
 
-static void wbsd_send_command(struct wbsd_host* host, struct mmc_command* cmd)
+static void wbsd_send_command(struct wbsd_host *host, struct mmc_command *cmd)
 {
 	int i;
 	u8 status, isr;
@@ -456,7 +444,7 @@ static void wbsd_send_command(struct wbs
 	 * Send the command (CRC calculated by host).
 	 */
 	outb(cmd->opcode, host->base + WBSD_CMDR);
-	for (i = 3;i >= 0;i--)
+	for (i = 3; i >= 0; i--)
 		outb((cmd->arg >> (i * 8)) & 0xff, host->base + WBSD_CMDR);
 
 	cmd->error = MMC_ERR_NONE;
@@ -471,8 +459,7 @@ static void wbsd_send_command(struct wbs
 	/*
 	 * Do we expect a reply?
 	 */
-	if ((cmd->flags & MMC_RSP_MASK) != MMC_RSP_NONE)
-	{
+	if ((cmd->flags & MMC_RSP_MASK) != MMC_RSP_NONE) {
 		/*
 		 * Read back status.
 		 */
@@ -488,8 +475,7 @@ static void wbsd_send_command(struct wbs
 		else if ((cmd->flags & MMC_RSP_CRC) && (isr & WBSD_INT_CRC))
 			cmd->error = MMC_ERR_BADCRC;
 		/* All ok */
-		else
-		{
+		else {
 			if ((cmd->flags & MMC_RSP_MASK) == MMC_RSP_SHORT)
 				wbsd_get_short_reply(host, cmd);
 			else
@@ -504,10 +490,10 @@ static void wbsd_send_command(struct wbs
  * Data functions
  */
 
-static void wbsd_empty_fifo(struct wbsd_host* host)
+static void wbsd_empty_fifo(struct wbsd_host *host)
 {
-	struct mmc_data* data = host->mrq->cmd->data;
-	char* buffer;
+	struct mmc_data *data = host->mrq->cmd->data;
+	char *buffer;
 	int i, fsr, fifo;
 
 	/*
@@ -522,8 +508,7 @@ static void wbsd_empty_fifo(struct wbsd_
 	 * Drain the fifo. This has a tendency to loop longer
 	 * than the FIFO length (usually one block).
 	 */
-	while (!((fsr = inb(host->base + WBSD_FSR)) & WBSD_FIFO_EMPTY))
-	{
+	while (!((fsr = inb(host->base + WBSD_FSR)) & WBSD_FIFO_EMPTY)) {
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
@@ -535,8 +520,7 @@ static void wbsd_empty_fifo(struct wbsd_
 		else
 			fifo = 1;
 
-		for (i = 0;i < fifo;i++)
-		{
+		for (i = 0; i < fifo; i++) {
 			*buffer = inb(host->base + WBSD_DFR);
 			buffer++;
 			host->offset++;
@@ -547,8 +531,7 @@ static void wbsd_empty_fifo(struct wbsd_
 			/*
 			 * Transfer done?
 			 */
-			if (data->bytes_xfered == host->size)
-			{
+			if (data->bytes_xfered == host->size) {
 				wbsd_kunmap_sg(host);
 				return;
 			}
@@ -556,15 +539,13 @@ static void wbsd_empty_fifo(struct wbsd_
 			/*
 			 * End of scatter list entry?
 			 */
-			if (host->remain == 0)
-			{
+			if (host->remain == 0) {
 				wbsd_kunmap_sg(host);
 
 				/*
 				 * Get next entry. Check if last.
 				 */
-				if (!wbsd_next_sg(host))
-				{
+				if (!wbsd_next_sg(host)) {
 					/*
 					 * We should never reach this point.
 					 * It means that we're trying to
@@ -594,10 +575,10 @@ static void wbsd_empty_fifo(struct wbsd_
 		tasklet_schedule(&host->fifo_tasklet);
 }
 
-static void wbsd_fill_fifo(struct wbsd_host* host)
+static void wbsd_fill_fifo(struct wbsd_host *host)
 {
-	struct mmc_data* data = host->mrq->cmd->data;
-	char* buffer;
+	struct mmc_data *data = host->mrq->cmd->data;
+	char *buffer;
 	int i, fsr, fifo;
 
 	/*
@@ -613,8 +594,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 	 * Fill the fifo. This has a tendency to loop longer
 	 * than the FIFO length (usually one block).
 	 */
-	while (!((fsr = inb(host->base + WBSD_FSR)) & WBSD_FIFO_FULL))
-	{
+	while (!((fsr = inb(host->base + WBSD_FSR)) & WBSD_FIFO_FULL)) {
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
@@ -626,8 +606,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 		else
 			fifo = 15;
 
-		for (i = 16;i > fifo;i--)
-		{
+		for (i = 16; i > fifo; i--) {
 			outb(*buffer, host->base + WBSD_DFR);
 			buffer++;
 			host->offset++;
@@ -638,8 +617,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 			/*
 			 * Transfer done?
 			 */
-			if (data->bytes_xfered == host->size)
-			{
+			if (data->bytes_xfered == host->size) {
 				wbsd_kunmap_sg(host);
 				return;
 			}
@@ -647,15 +625,13 @@ static void wbsd_fill_fifo(struct wbsd_h
 			/*
 			 * End of scatter list entry?
 			 */
-			if (host->remain == 0)
-			{
+			if (host->remain == 0) {
 				wbsd_kunmap_sg(host);
 
 				/*
 				 * Get next entry. Check if last.
 				 */
-				if (!wbsd_next_sg(host))
-				{
+				if (!wbsd_next_sg(host)) {
 					/*
 					 * We should never reach this point.
 					 * It means that we're trying to
@@ -684,16 +660,16 @@ static void wbsd_fill_fifo(struct wbsd_h
 	tasklet_schedule(&host->fifo_tasklet);
 }
 
-static void wbsd_prepare_data(struct wbsd_host* host, struct mmc_data* data)
+static void wbsd_prepare_data(struct wbsd_host *host, struct mmc_data *data)
 {
 	u16 blksize;
 	u8 setup;
 	unsigned long dmaflags;
 
 	DBGF("blksz %04x blks %04x flags %08x\n",
-		1 << data->blksz_bits, data->blocks, data->flags);
+	     1 << data->blksz_bits, data->blocks, data->flags);
 	DBGF("tsac %d ms nsac %d clk\n",
-		data->timeout_ns / 1000000, data->timeout_clks);
+	     data->timeout_ns / 1000000, data->timeout_clks);
 
 	/*
 	 * Calculate size.
@@ -707,7 +683,8 @@ static void wbsd_prepare_data(struct wbs
 	if (data->timeout_ns > 127000000)
 		wbsd_write_index(host, WBSD_IDX_TAAC, 127);
 	else
-		wbsd_write_index(host, WBSD_IDX_TAAC, data->timeout_ns/1000000);
+		wbsd_write_index(host, WBSD_IDX_TAAC,
+				 data->timeout_ns / 1000000);
 
 	if (data->timeout_clks > 255)
 		wbsd_write_index(host, WBSD_IDX_NSAC, 255);
@@ -722,23 +699,18 @@ static void wbsd_prepare_data(struct wbs
 	 * Space for CRC must be included in the size.
 	 * Two bytes are needed for each data line.
 	 */
-	if (host->bus_width == MMC_BUS_WIDTH_1)
-	{
+	if (host->bus_width == MMC_BUS_WIDTH_1) {
 		blksize = (1 << data->blksz_bits) + 2;
 
 		wbsd_write_index(host, WBSD_IDX_PBSMSB, (blksize >> 4) & 0xF0);
 		wbsd_write_index(host, WBSD_IDX_PBSLSB, blksize & 0xFF);
-	}
-	else if (host->bus_width == MMC_BUS_WIDTH_4)
-	{
+	} else if (host->bus_width == MMC_BUS_WIDTH_4) {
 		blksize = (1 << data->blksz_bits) + 2 * 4;
 
 		wbsd_write_index(host, WBSD_IDX_PBSMSB, ((blksize >> 4) & 0xF0)
-			| WBSD_DATA_WIDTH);
+				 | WBSD_DATA_WIDTH);
 		wbsd_write_index(host, WBSD_IDX_PBSLSB, blksize & 0xFF);
-	}
-	else
-	{
+	} else {
 		data->error = MMC_ERR_INVALID;
 		return;
 	}
@@ -755,14 +727,12 @@ static void wbsd_prepare_data(struct wbs
 	/*
 	 * DMA transfer?
 	 */
-	if (host->dma >= 0)
-	{
+	if (host->dma >= 0) {
 		/*
 		 * The buffer for DMA is only 64 kB.
 		 */
 		BUG_ON(host->size > 0x10000);
-		if (host->size > 0x10000)
-		{
+		if (host->size > 0x10000) {
 			data->error = MMC_ERR_INVALID;
 			return;
 		}
@@ -794,9 +764,7 @@ static void wbsd_prepare_data(struct wbs
 		 * Enable DMA on the host.
 		 */
 		wbsd_write_index(host, WBSD_IDX_DMA, WBSD_DMA_ENABLE);
-	}
-	else
-	{
+	} else {
 		/*
 		 * This flag is used to keep printk
 		 * output to a minimum.
@@ -817,15 +785,12 @@ static void wbsd_prepare_data(struct wbs
 		 * Set up FIFO threshold levels (and fill
 		 * buffer if doing a write).
 		 */
-		if (data->flags & MMC_DATA_READ)
-		{
+		if (data->flags & MMC_DATA_READ) {
 			wbsd_write_index(host, WBSD_IDX_FIFOEN,
-				WBSD_FIFOEN_FULL | 8);
-		}
-		else
-		{
+					 WBSD_FIFOEN_FULL | 8);
+		} else {
 			wbsd_write_index(host, WBSD_IDX_FIFOEN,
-				WBSD_FIFOEN_EMPTY | 8);
+					 WBSD_FIFOEN_EMPTY | 8);
 			wbsd_fill_fifo(host);
 		}
 	}
@@ -833,7 +798,7 @@ static void wbsd_prepare_data(struct wbs
 	data->error = MMC_ERR_NONE;
 }
 
-static void wbsd_finish_data(struct wbsd_host* host, struct mmc_data* data)
+static void wbsd_finish_data(struct wbsd_host *host, struct mmc_data *data)
 {
 	unsigned long dmaflags;
 	int count;
@@ -851,16 +816,14 @@ static void wbsd_finish_data(struct wbsd
 	 * Wait for the controller to leave data
 	 * transfer state.
 	 */
-	do
-	{
+	do {
 		status = wbsd_read_index(host, WBSD_IDX_STATUS);
 	} while (status & (WBSD_BLOCK_READ | WBSD_BLOCK_WRITE));
 
 	/*
 	 * DMA transfer?
 	 */
-	if (host->dma >= 0)
-	{
+	if (host->dma >= 0) {
 		/*
 		 * Disable DMA on the host.
 		 */
@@ -878,16 +841,13 @@ static void wbsd_finish_data(struct wbsd
 		/*
 		 * Any leftover data?
 		 */
-		if (count)
-		{
+		if (count) {
 			printk(KERN_ERR "%s: Incomplete DMA transfer. "
-				"%d bytes left.\n",
-				mmc_hostname(host->mmc), count);
+			       "%d bytes left.\n",
+			       mmc_hostname(host->mmc), count);
 
 			data->error = MMC_ERR_FAILED;
-		}
-		else
-		{
+		} else {
 			/*
 			 * Transfer data from DMA buffer to
 			 * SG list.
@@ -910,10 +870,10 @@ static void wbsd_finish_data(struct wbsd
  *                                                                           *
 \*****************************************************************************/
 
-static void wbsd_request(struct mmc_host* mmc, struct mmc_request* mrq)
+static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-	struct wbsd_host* host = mmc_priv(mmc);
-	struct mmc_command* cmd;
+	struct wbsd_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
 
 	/*
 	 * Disable tasklets to avoid a deadlock.
@@ -930,8 +890,7 @@ static void wbsd_request(struct mmc_host
 	 * If there is no card in the slot then
 	 * timeout immediatly.
 	 */
-	if (!(host->flags & WBSD_FCARD_PRESENT))
-	{
+	if (!(host->flags & WBSD_FCARD_PRESENT)) {
 		cmd->error = MMC_ERR_TIMEOUT;
 		goto done;
 	}
@@ -939,8 +898,7 @@ static void wbsd_request(struct mmc_host
 	/*
 	 * Does the request include data?
 	 */
-	if (cmd->data)
-	{
+	if (cmd->data) {
 		wbsd_prepare_data(host, cmd->data);
 
 		if (cmd->data->error != MMC_ERR_NONE)
@@ -954,8 +912,7 @@ static void wbsd_request(struct mmc_host
 	 * will be finished after the data has
 	 * transfered.
 	 */
-	if (cmd->data && (cmd->error == MMC_ERR_NONE))
-	{
+	if (cmd->data && (cmd->error == MMC_ERR_NONE)) {
 		/*
 		 * Dirty fix for hardware bug.
 		 */
@@ -967,15 +924,15 @@ static void wbsd_request(struct mmc_host
 		return;
 	}
 
-done:
+      done:
 	wbsd_request_end(host, mrq);
 
 	spin_unlock_bh(&host->lock);
 }
 
-static void wbsd_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
+static void wbsd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct wbsd_host* host = mmc_priv(mmc);
+	struct wbsd_host *host = mmc_priv(mmc);
 	u8 clk, setup, pwr;
 
 	DBGF("clock %uHz busmode %u powermode %u cs %u Vdd %u width %u\n",
@@ -1004,8 +961,7 @@ static void wbsd_set_ios(struct mmc_host
 	 * Only write to the clock register when
 	 * there is an actual change.
 	 */
-	if (clk != host->clk)
-	{
+	if (clk != host->clk) {
 		wbsd_write_index(host, WBSD_IDX_CLK, clk);
 		host->clk = clk;
 	}
@@ -1013,8 +969,7 @@ static void wbsd_set_ios(struct mmc_host
 	/*
 	 * Power up card.
 	 */
-	if (ios->power_mode != MMC_POWER_OFF)
-	{
+	if (ios->power_mode != MMC_POWER_OFF) {
 		pwr = inb(host->base + WBSD_CSR);
 		pwr &= ~WBSD_POWER_N;
 		outb(pwr, host->base + WBSD_CSR);
@@ -1026,23 +981,19 @@ static void wbsd_set_ios(struct mmc_host
 	 * that needs to be disabled.
 	 */
 	setup = wbsd_read_index(host, WBSD_IDX_SETUP);
-	if (ios->chip_select == MMC_CS_HIGH)
-	{
+	if (ios->chip_select == MMC_CS_HIGH) {
 		BUG_ON(ios->bus_width != MMC_BUS_WIDTH_1);
 		setup |= WBSD_DAT3_H;
 		host->flags |= WBSD_FIGNORE_DETECT;
-	}
-	else
-	{
-		if (setup & WBSD_DAT3_H)
-		{
+	} else {
+		if (setup & WBSD_DAT3_H) {
 			setup &= ~WBSD_DAT3_H;
 
 			/*
 			 * We cannot resume card detection immediatly
 			 * because of capacitance and delays in the chip.
 			 */
-			mod_timer(&host->ignore_timer, jiffies + HZ/100);
+			mod_timer(&host->ignore_timer, jiffies + HZ / 100);
 		}
 	}
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
@@ -1056,9 +1007,9 @@ static void wbsd_set_ios(struct mmc_host
 	spin_unlock_bh(&host->lock);
 }
 
-static int wbsd_get_ro(struct mmc_host* mmc)
+static int wbsd_get_ro(struct mmc_host *mmc)
 {
-	struct wbsd_host* host = mmc_priv(mmc);
+	struct wbsd_host *host = mmc_priv(mmc);
 	u8 csr;
 
 	spin_lock_bh(&host->lock);
@@ -1079,9 +1030,9 @@ static int wbsd_get_ro(struct mmc_host* 
 }
 
 static struct mmc_host_ops wbsd_ops = {
-	.request	= wbsd_request,
-	.set_ios	= wbsd_set_ios,
-	.get_ro		= wbsd_get_ro,
+	.request = wbsd_request,
+	.set_ios = wbsd_set_ios,
+	.get_ro = wbsd_get_ro,
 };
 
 /*****************************************************************************\
@@ -1096,7 +1047,7 @@ static struct mmc_host_ops wbsd_ops = {
 
 static void wbsd_reset_ignore(unsigned long data)
 {
-	struct wbsd_host *host = (struct wbsd_host*)data;
+	struct wbsd_host *host = (struct wbsd_host *)data;
 
 	BUG_ON(host == NULL);
 
@@ -1119,7 +1070,7 @@ static void wbsd_reset_ignore(unsigned l
  * Tasklets
  */
 
-static inline struct mmc_data* wbsd_get_data(struct wbsd_host* host)
+static inline struct mmc_data *wbsd_get_data(struct wbsd_host *host)
 {
 	WARN_ON(!host->mrq);
 	if (!host->mrq)
@@ -1138,14 +1089,13 @@ static inline struct mmc_data* wbsd_get_
 
 static void wbsd_tasklet_card(unsigned long param)
 {
-	struct wbsd_host* host = (struct wbsd_host*)param;
+	struct wbsd_host *host = (struct wbsd_host *)param;
 	u8 csr;
 	int delay = -1;
 
 	spin_lock(&host->lock);
 
-	if (host->flags & WBSD_FIGNORE_DETECT)
-	{
+	if (host->flags & WBSD_FIGNORE_DETECT) {
 		spin_unlock(&host->lock);
 		return;
 	}
@@ -1153,25 +1103,20 @@ static void wbsd_tasklet_card(unsigned l
 	csr = inb(host->base + WBSD_CSR);
 	WARN_ON(csr == 0xff);
 
-	if (csr & WBSD_CARDPRESENT)
-	{
-		if (!(host->flags & WBSD_FCARD_PRESENT))
-		{
+	if (csr & WBSD_CARDPRESENT) {
+		if (!(host->flags & WBSD_FCARD_PRESENT)) {
 			DBG("Card inserted\n");
 			host->flags |= WBSD_FCARD_PRESENT;
 
 			delay = 500;
 		}
-	}
-	else if (host->flags & WBSD_FCARD_PRESENT)
-	{
+	} else if (host->flags & WBSD_FCARD_PRESENT) {
 		DBG("Card removed\n");
 		host->flags &= ~WBSD_FCARD_PRESENT;
 
-		if (host->mrq)
-		{
+		if (host->mrq) {
 			printk(KERN_ERR "%s: Card removed during transfer!\n",
-				mmc_hostname(host->mmc));
+			       mmc_hostname(host->mmc));
 			wbsd_reset(host);
 
 			host->mrq->cmd->error = MMC_ERR_FAILED;
@@ -1193,8 +1138,8 @@ static void wbsd_tasklet_card(unsigned l
 
 static void wbsd_tasklet_fifo(unsigned long param)
 {
-	struct wbsd_host* host = (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host = (struct wbsd_host *)param;
+	struct mmc_data *data;
 
 	spin_lock(&host->lock);
 
@@ -1213,20 +1158,19 @@ static void wbsd_tasklet_fifo(unsigned l
 	/*
 	 * Done?
 	 */
-	if (host->size == data->bytes_xfered)
-	{
+	if (host->size == data->bytes_xfered) {
 		wbsd_write_index(host, WBSD_IDX_FIFOEN, 0);
 		tasklet_schedule(&host->finish_tasklet);
 	}
 
-end:
+ end:
 	spin_unlock(&host->lock);
 }
 
 static void wbsd_tasklet_crc(unsigned long param)
 {
-	struct wbsd_host* host = (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host = (struct wbsd_host *)param;
+	struct mmc_data *data;
 
 	spin_lock(&host->lock);
 
@@ -1243,14 +1187,14 @@ static void wbsd_tasklet_crc(unsigned lo
 
 	tasklet_schedule(&host->finish_tasklet);
 
-end:
+ end:
 	spin_unlock(&host->lock);
 }
 
 static void wbsd_tasklet_timeout(unsigned long param)
 {
-	struct wbsd_host* host = (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host = (struct wbsd_host *)param;
+	struct mmc_data *data;
 
 	spin_lock(&host->lock);
 
@@ -1267,14 +1211,14 @@ static void wbsd_tasklet_timeout(unsigne
 
 	tasklet_schedule(&host->finish_tasklet);
 
-end:
+ end:
 	spin_unlock(&host->lock);
 }
 
 static void wbsd_tasklet_finish(unsigned long param)
 {
-	struct wbsd_host* host = (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host = (struct wbsd_host *)param;
+	struct mmc_data *data;
 
 	spin_lock(&host->lock);
 
@@ -1288,20 +1232,19 @@ static void wbsd_tasklet_finish(unsigned
 
 	wbsd_finish_data(host, data);
 
-end:
+ end:
 	spin_unlock(&host->lock);
 }
 
 static void wbsd_tasklet_block(unsigned long param)
 {
-	struct wbsd_host* host = (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host = (struct wbsd_host *)param;
+	struct mmc_data *data;
 
 	spin_lock(&host->lock);
 
 	if ((wbsd_read_index(host, WBSD_IDX_CRCSTATUS) & WBSD_CRC_MASK) !=
-		WBSD_CRC_OK)
-	{
+	    WBSD_CRC_OK) {
 		data = wbsd_get_data(host);
 		if (!data)
 			goto end;
@@ -1313,7 +1256,7 @@ static void wbsd_tasklet_block(unsigned 
 		tasklet_schedule(&host->finish_tasklet);
 	}
 
-end:
+ end:
 	spin_unlock(&host->lock);
 }
 
@@ -1323,7 +1266,7 @@ end:
 
 static irqreturn_t wbsd_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct wbsd_host* host = dev_id;
+	struct wbsd_host *host = dev_id;
 	int isr;
 
 	isr = inb(host->base + WBSD_ISR);
@@ -1365,10 +1308,10 @@ static irqreturn_t wbsd_irq(int irq, voi
  * Allocate/free MMC structure.
  */
 
-static int __devinit wbsd_alloc_mmc(struct device* dev)
+static int __devinit wbsd_alloc_mmc(struct device *dev)
 {
-	struct mmc_host* mmc;
-	struct wbsd_host* host;
+	struct mmc_host *mmc;
+	struct wbsd_host *host;
 
 	/*
 	 * Allocate MMC structure.
@@ -1388,7 +1331,7 @@ static int __devinit wbsd_alloc_mmc(stru
 	mmc->ops = &wbsd_ops;
 	mmc->f_min = 375000;
 	mmc->f_max = 24000000;
-	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
 
 	spin_lock_init(&host->lock);
@@ -1424,10 +1367,10 @@ static int __devinit wbsd_alloc_mmc(stru
 	return 0;
 }
 
-static void __devexit wbsd_free_mmc(struct device* dev)
+static void __devexit wbsd_free_mmc(struct device *dev)
 {
-	struct mmc_host* mmc;
-	struct wbsd_host* host;
+	struct mmc_host *mmc;
+	struct wbsd_host *host;
 
 	mmc = dev_get_drvdata(dev);
 	if (!mmc)
@@ -1447,7 +1390,7 @@ static void __devexit wbsd_free_mmc(stru
  * Scan for known chip id:s
  */
 
-static int __devinit wbsd_scan(struct wbsd_host* host)
+static int __devinit wbsd_scan(struct wbsd_host *host)
 {
 	int i, j, k;
 	int id;
@@ -1456,13 +1399,11 @@ static int __devinit wbsd_scan(struct wb
 	 * Iterate through all ports, all codes to
 	 * find hardware that is in our known list.
 	 */
-	for (i = 0;i < sizeof(config_ports)/sizeof(int);i++)
-	{
+	for (i = 0; i < sizeof(config_ports) / sizeof(int); i++) {
 		if (!request_region(config_ports[i], 2, DRIVER_NAME))
 			continue;
 
-		for (j = 0;j < sizeof(unlock_codes)/sizeof(int);j++)
-		{
+		for (j = 0; j < sizeof(unlock_codes) / sizeof(int); j++) {
 			id = 0xFFFF;
 
 			host->config = config_ports[i];
@@ -1478,20 +1419,17 @@ static int __devinit wbsd_scan(struct wb
 
 			wbsd_lock_config(host);
 
-			for (k = 0;k < sizeof(valid_ids)/sizeof(int);k++)
-			{
-				if (id == valid_ids[k])
-				{
+			for (k = 0; k < sizeof(valid_ids) / sizeof(int); k++) {
+				if (id == valid_ids[k]) {
 					host->chip_id = id;
 
 					return 0;
 				}
 			}
 
-			if (id != 0xFFFF)
-			{
+			if (id != 0xFFFF) {
 				DBG("Unknown hardware (id %x) found at %x\n",
-					id, config_ports[i]);
+				    id, config_ports[i]);
 			}
 		}
 
@@ -1508,7 +1446,7 @@ static int __devinit wbsd_scan(struct wb
  * Allocate/free io port ranges
  */
 
-static int __devinit wbsd_request_region(struct wbsd_host* host, int base)
+static int __devinit wbsd_request_region(struct wbsd_host *host, int base)
 {
 	if (io & 0x7)
 		return -EINVAL;
@@ -1521,7 +1459,7 @@ static int __devinit wbsd_request_region
 	return 0;
 }
 
-static void __devexit wbsd_release_regions(struct wbsd_host* host)
+static void __devexit wbsd_release_regions(struct wbsd_host *host)
 {
 	if (host->base)
 		release_region(host->base, 8);
@@ -1538,7 +1476,7 @@ static void __devexit wbsd_release_regio
  * Allocate/free DMA port and buffer
  */
 
-static void __devinit wbsd_request_dma(struct wbsd_host* host, int dma)
+static void __devinit wbsd_request_dma(struct wbsd_host *host, int dma)
 {
 	if (dma < 0)
 		return;
@@ -1551,7 +1489,8 @@ static void __devinit wbsd_request_dma(s
 	 * order for ISA to be able to DMA to it.
 	 */
 	host->dma_buffer = kmalloc(WBSD_DMA_SIZE,
-		GFP_NOIO | GFP_DMA | __GFP_REPEAT | __GFP_NOWARN);
+				   GFP_NOIO | GFP_DMA | __GFP_REPEAT |
+				   __GFP_NOWARN);
 	if (!host->dma_buffer)
 		goto free;
 
@@ -1559,7 +1498,7 @@ static void __devinit wbsd_request_dma(s
 	 * Translate the address to a physical address.
 	 */
 	host->dma_addr = dma_map_single(host->mmc->dev, host->dma_buffer,
-		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
+					WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 
 	/*
 	 * ISA DMA must be aligned on a 64k basis.
@@ -1576,46 +1515,46 @@ static void __devinit wbsd_request_dma(s
 
 	return;
 
-kfree:
+ kfree:
 	/*
 	 * If we've gotten here then there is some kind of alignment bug
 	 */
 	BUG_ON(1);
 
 	dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
-		DMA_BIDIRECTIONAL);
-	host->dma_addr = (dma_addr_t)NULL;
+			 DMA_BIDIRECTIONAL);
+	host->dma_addr = (dma_addr_t) NULL;
 
 	kfree(host->dma_buffer);
 	host->dma_buffer = NULL;
 
-free:
+ free:
 	free_dma(dma);
 
-err:
+ err:
 	printk(KERN_WARNING DRIVER_NAME ": Unable to allocate DMA %d. "
-		"Falling back on FIFO.\n", dma);
+	       "Falling back on FIFO.\n", dma);
 }
 
-static void __devexit wbsd_release_dma(struct wbsd_host* host)
+static void __devexit wbsd_release_dma(struct wbsd_host *host)
 {
 	if (host->dma_addr)
 		dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
-			DMA_BIDIRECTIONAL);
+				 DMA_BIDIRECTIONAL);
 	kfree(host->dma_buffer);
 	if (host->dma >= 0)
 		free_dma(host->dma);
 
 	host->dma = -1;
 	host->dma_buffer = NULL;
-	host->dma_addr = (dma_addr_t)NULL;
+	host->dma_addr = (dma_addr_t) NULL;
 }
 
 /*
  * Allocate/free IRQ.
  */
 
-static int __devinit wbsd_request_irq(struct wbsd_host* host, int irq)
+static int __devinit wbsd_request_irq(struct wbsd_host *host, int irq)
 {
 	int ret;
 
@@ -1632,17 +1571,22 @@ static int __devinit wbsd_request_irq(st
 	/*
 	 * Set up tasklets.
 	 */
-	tasklet_init(&host->card_tasklet, wbsd_tasklet_card, (unsigned long)host);
-	tasklet_init(&host->fifo_tasklet, wbsd_tasklet_fifo, (unsigned long)host);
+	tasklet_init(&host->card_tasklet, wbsd_tasklet_card,
+		     (unsigned long)host);
+	tasklet_init(&host->fifo_tasklet, wbsd_tasklet_fifo,
+		     (unsigned long)host);
 	tasklet_init(&host->crc_tasklet, wbsd_tasklet_crc, (unsigned long)host);
-	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout, (unsigned long)host);
-	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish, (unsigned long)host);
-	tasklet_init(&host->block_tasklet, wbsd_tasklet_block, (unsigned long)host);
+	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout,
+		     (unsigned long)host);
+	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish,
+		     (unsigned long)host);
+	tasklet_init(&host->block_tasklet, wbsd_tasklet_block,
+		     (unsigned long)host);
 
 	return 0;
 }
 
-static void __devexit wbsd_release_irq(struct wbsd_host* host)
+static void __devexit wbsd_release_irq(struct wbsd_host *host)
 {
 	if (!host->irq)
 		return;
@@ -1663,8 +1607,8 @@ static void __devexit wbsd_release_irq(s
  * Allocate all resources for the host.
  */
 
-static int __devinit wbsd_request_resources(struct wbsd_host* host,
-	int base, int irq, int dma)
+static int __devinit wbsd_request_resources(struct wbsd_host *host,
+					    int base, int irq, int dma)
 {
 	int ret;
 
@@ -1694,7 +1638,7 @@ static int __devinit wbsd_request_resour
  * Release all resources for the host.
  */
 
-static void __devexit wbsd_release_resources(struct wbsd_host* host)
+static void __devexit wbsd_release_resources(struct wbsd_host *host)
 {
 	wbsd_release_dma(host);
 	wbsd_release_irq(host);
@@ -1705,7 +1649,7 @@ static void __devexit wbsd_release_resou
  * Configure the resources the chip should use.
  */
 
-static void wbsd_chip_config(struct wbsd_host* host)
+static void wbsd_chip_config(struct wbsd_host *host)
 {
 	wbsd_unlock_config(host);
 
@@ -1749,7 +1693,7 @@ static void wbsd_chip_config(struct wbsd
  * Check that configured resources are correct.
  */
 
-static int wbsd_chip_validate(struct wbsd_host* host)
+static int wbsd_chip_validate(struct wbsd_host *host)
 {
 	int base, irq, dma;
 
@@ -1789,7 +1733,7 @@ static int wbsd_chip_validate(struct wbs
  * Powers down the SD function
  */
 
-static void wbsd_chip_poweroff(struct wbsd_host* host)
+static void wbsd_chip_poweroff(struct wbsd_host *host)
 {
 	wbsd_unlock_config(host);
 
@@ -1805,11 +1749,11 @@ static void wbsd_chip_poweroff(struct wb
  *                                                                           *
 \*****************************************************************************/
 
-static int __devinit wbsd_init(struct device* dev, int base, int irq, int dma,
-	int pnp)
+static int __devinit wbsd_init(struct device *dev, int base, int irq, int dma,
+			       int pnp)
 {
-	struct wbsd_host* host = NULL;
-	struct mmc_host* mmc = NULL;
+	struct wbsd_host *host = NULL;
+	struct mmc_host *mmc = NULL;
 	int ret;
 
 	ret = wbsd_alloc_mmc(dev);
@@ -1823,16 +1767,12 @@ static int __devinit wbsd_init(struct de
 	 * Scan for hardware.
 	 */
 	ret = wbsd_scan(host);
-	if (ret)
-	{
-		if (pnp && (ret == -ENODEV))
-		{
+	if (ret) {
+		if (pnp && (ret == -ENODEV)) {
 			printk(KERN_WARNING DRIVER_NAME
-				": Unable to confirm device presence. You may "
-				"experience lock-ups.\n");
-		}
-		else
-		{
+			       ": Unable to confirm device presence. "
+			       "You may experience lock-ups.\n");
+		} else {
 			wbsd_free_mmc(dev);
 			return ret;
 		}
@@ -1842,8 +1782,7 @@ static int __devinit wbsd_init(struct de
 	 * Request resources.
 	 */
 	ret = wbsd_request_resources(host, io, irq, dma);
-	if (ret)
-	{
+	if (ret) {
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
 		return ret;
@@ -1852,18 +1791,15 @@ static int __devinit wbsd_init(struct de
 	/*
 	 * See if chip needs to be configured.
 	 */
-	if (pnp)
-	{
-		if ((host->config != 0) && !wbsd_chip_validate(host))
-		{
+	if (pnp) {
+		if ((host->config != 0) && !wbsd_chip_validate(host)) {
 			printk(KERN_WARNING DRIVER_NAME
-				": PnP active but chip not configured! "
-				"You probably have a buggy BIOS. "
-				"Configuring chip manually.\n");
+			       ": PnP active but chip not configured! "
+			       "You probably have a buggy BIOS. "
+			       "Configuring chip manually.\n");
 			wbsd_chip_config(host);
 		}
-	}
-	else
+	} else
 		wbsd_chip_config(host);
 
 	/*
@@ -1871,8 +1807,7 @@ static int __devinit wbsd_init(struct de
 	 * Not tested.
 	 */
 #ifdef CONFIG_PM
-	if (host->config)
-	{
+	if (host->config) {
 		wbsd_unlock_config(host);
 		wbsd_write_config(host, WBSD_CONF_PME, 0xA0);
 		wbsd_lock_config(host);
@@ -1905,10 +1840,10 @@ static int __devinit wbsd_init(struct de
 	return 0;
 }
 
-static void __devexit wbsd_shutdown(struct device* dev, int pnp)
+static void __devexit wbsd_shutdown(struct device *dev, int pnp)
 {
-	struct mmc_host* mmc = dev_get_drvdata(dev);
-	struct wbsd_host* host;
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct wbsd_host *host;
 
 	if (!mmc)
 		return;
@@ -1932,12 +1867,12 @@ static void __devexit wbsd_shutdown(stru
  * Non-PnP
  */
 
-static int __devinit wbsd_probe(struct platform_device* dev)
+static int __devinit wbsd_probe(struct platform_device *dev)
 {
 	return wbsd_init(&dev->dev, io, irq, dma, 0);
 }
 
-static int __devexit wbsd_remove(struct platform_device* dev)
+static int __devexit wbsd_remove(struct platform_device *dev)
 {
 	wbsd_shutdown(&dev->dev, 0);
 
@@ -1950,8 +1885,8 @@ static int __devexit wbsd_remove(struct 
 
 #ifdef CONFIG_PNP
 
-static int __devinit
-wbsd_pnp_probe(struct pnp_dev * pnpdev, const struct pnp_device_id *dev_id)
+static int __devinit wbsd_pnp_probe(struct pnp_dev *pnpdev,
+				    const struct pnp_device_id *dev_id)
 {
 	int io, irq, dma;
 
@@ -1970,12 +1905,12 @@ wbsd_pnp_probe(struct pnp_dev * pnpdev, 
 	return wbsd_init(&pnpdev->dev, io, irq, dma, 1);
 }
 
-static void __devexit wbsd_pnp_remove(struct pnp_dev * dev)
+static void __devexit wbsd_pnp_remove(struct pnp_dev *dev)
 {
 	wbsd_shutdown(&dev->dev, 1);
 }
 
-#endif /* CONFIG_PNP */
+#endif				/* CONFIG_PNP */
 
 /*
  * Power management
@@ -2029,12 +1964,12 @@ static int wbsd_resume(struct platform_d
 	return mmc_resume_host(mmc);
 }
 
-#else /* CONFIG_PM */
+#else				/* CONFIG_PM */
 
 #define wbsd_suspend NULL
 #define wbsd_resume NULL
 
-#endif /* CONFIG_PM */
+#endif				/* CONFIG_PM */
 
 static struct platform_device *wbsd_device;
 
@@ -2058,7 +1993,7 @@ static struct pnp_driver wbsd_pnp_driver
 	.remove		= __devexit_p(wbsd_pnp_remove),
 };
 
-#endif /* CONFIG_PNP */
+#endif				/* CONFIG_PNP */
 
 /*
  * Module loading/unloading
@@ -2069,37 +2004,32 @@ static int __init wbsd_drv_init(void)
 	int result;
 
 	printk(KERN_INFO DRIVER_NAME
-		": Winbond W83L51xD SD/MMC card interface driver, "
-		DRIVER_VERSION "\n");
+	       ": Winbond W83L51xD SD/MMC card interface driver, "
+	       DRIVER_VERSION "\n");
 	printk(KERN_INFO DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
 
 #ifdef CONFIG_PNP
 
-	if (!nopnp)
-	{
+	if (!nopnp) {
 		result = pnp_register_driver(&wbsd_pnp_driver);
 		if (result < 0)
 			return result;
 	}
+#endif				/* CONFIG_PNP */
 
-#endif /* CONFIG_PNP */
-
-	if (nopnp)
-	{
+	if (nopnp) {
 		result = platform_driver_register(&wbsd_driver);
 		if (result < 0)
 			return result;
 
 		wbsd_device = platform_device_alloc(DRIVER_NAME, -1);
-		if (!wbsd_device)
-		{
+		if (!wbsd_device) {
 			platform_driver_unregister(&wbsd_driver);
 			return -ENOMEM;
 		}
 
 		result = platform_device_add(wbsd_device);
-		if (result)
-		{
+		if (result) {
 			platform_device_put(wbsd_device);
 			platform_driver_unregister(&wbsd_driver);
 			return result;
@@ -2116,12 +2046,10 @@ static void __exit wbsd_drv_exit(void)
 	if (!nopnp)
 		pnp_unregister_driver(&wbsd_pnp_driver);
 
-#endif /* CONFIG_PNP */
+#endif				/* CONFIG_PNP */
 
-	if (nopnp)
-	{
+	if (nopnp) {
 		platform_device_unregister(wbsd_device);
-
 		platform_driver_unregister(&wbsd_driver);
 	}
 
Index: work/drivers/mmc/wbsd.h
===================================================================
--- work.orig/drivers/mmc/wbsd.h
+++ work/drivers/mmc/wbsd.h
@@ -136,8 +136,7 @@
 
 #define WBSD_DMA_SIZE		65536
 
-struct wbsd_host
-{
+struct wbsd_host {
 	struct mmc_host*	mmc;		/* MMC structure */
 
 	spinlock_t		lock;		/* Mutex */

