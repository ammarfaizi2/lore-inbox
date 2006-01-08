Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752653AbWAHRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbWAHRsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbWAHRsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:48:21 -0500
Received: from [85.8.13.51] ([85.8.13.51]:53442 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1752653AbWAHRsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:48:20 -0500
Message-ID: <43C15052.7080706@drzeus.cx>
Date: Sun, 08 Jan 2006 18:48:02 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20060103)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_hermes.drzeus.cx-21691-1136742488-0001-2"
To: Pierre Ossman <drzeus-list@drzeus.cx>,
       Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH] [MMC] Lindent wbsd driver
References: <20060107231747.29389.80042.stgit@poseidon.drzeus.cx> <20060108142535.GC10927@flint.arm.linux.org.uk> <43C12319.2060604@drzeus.cx>
In-Reply-To: <43C12319.2060604@drzeus.cx>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-21691-1136742488-0001-2
Content-Type: multipart/mixed;
 boundary="------------020304020903030307040305"

This is a multi-part message in MIME format.
--------------020304020903030307040305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Let's have another go at this shall we.


--------------020304020903030307040305
Content-Type: text/x-patch;
 name="wbsd-lindent.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="wbsd-lindent.patch"

[MMC] Lindent wbsd driver

Fix the coding style in the wbsd driver once and for all.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |  437 ++++++++++++++++++++++------------------------=
------
 1 files changed, 185 insertions(+), 252 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index 60afc12..f257576 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -90,7 +90,7 @@ static int dma =3D 2;
  * Basic functions
  */
=20
-static inline void wbsd_unlock_config(struct wbsd_host* host)
+static inline void wbsd_unlock_config(struct wbsd_host *host)
 {
 	BUG_ON(host->config =3D=3D 0);
=20
@@ -98,14 +98,14 @@ static inline void wbsd_unlock_config(st
 	outb(host->unlock_code, host->config);
 }
=20
-static inline void wbsd_lock_config(struct wbsd_host* host)
+static inline void wbsd_lock_config(struct wbsd_host *host)
 {
 	BUG_ON(host->config =3D=3D 0);
=20
 	outb(LOCK_CODE, host->config);
 }
=20
-static inline void wbsd_write_config(struct wbsd_host* host, u8 reg, u8 =
value)
+static inline void wbsd_write_config(struct wbsd_host *host, u8 reg, u8 =
value)
 {
 	BUG_ON(host->config =3D=3D 0);
=20
@@ -113,7 +113,7 @@ static inline void wbsd_write_config(str
 	outb(value, host->config + 1);
 }
=20
-static inline u8 wbsd_read_config(struct wbsd_host* host, u8 reg)
+static inline u8 wbsd_read_config(struct wbsd_host *host, u8 reg)
 {
 	BUG_ON(host->config =3D=3D 0);
=20
@@ -121,13 +121,13 @@ static inline u8 wbsd_read_config(struct
 	return inb(host->config + 1);
 }
=20
-static inline void wbsd_write_index(struct wbsd_host* host, u8 index, u8=
 value)
+static inline void wbsd_write_index(struct wbsd_host *host, u8 index, u8=
 value)
 {
 	outb(index, host->base + WBSD_IDXR);
 	outb(value, host->base + WBSD_DATAR);
 }
=20
-static inline u8 wbsd_read_index(struct wbsd_host* host, u8 index)
+static inline u8 wbsd_read_index(struct wbsd_host *host, u8 index)
 {
 	outb(index, host->base + WBSD_IDXR);
 	return inb(host->base + WBSD_DATAR);
@@ -137,7 +137,7 @@ static inline u8 wbsd_read_index(struct=20
  * Common routines
  */
=20
-static void wbsd_init_device(struct wbsd_host* host)
+static void wbsd_init_device(struct wbsd_host *host)
 {
 	u8 setup, ier;
=20
@@ -197,7 +197,7 @@ static void wbsd_init_device(struct wbsd
 	inb(host->base + WBSD_ISR);
 }
=20
-static void wbsd_reset(struct wbsd_host* host)
+static void wbsd_reset(struct wbsd_host *host)
 {
 	u8 setup;
=20
@@ -211,14 +211,13 @@ static void wbsd_reset(struct wbsd_host*
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
 }
=20
-static void wbsd_request_end(struct wbsd_host* host, struct mmc_request*=
 mrq)
+static void wbsd_request_end(struct wbsd_host *host, struct mmc_request =
*mrq)
 {
 	unsigned long dmaflags;
=20
 	DBGF("Ending request, cmd (%x)\n", mrq->cmd->opcode);
=20
-	if (host->dma >=3D 0)
-	{
+	if (host->dma >=3D 0) {
 		/*
 		 * Release ISA DMA controller.
 		 */
@@ -247,7 +246,7 @@ static void wbsd_request_end(struct wbsd
  * Scatter/gather functions
  */
=20
-static inline void wbsd_init_sg(struct wbsd_host* host, struct mmc_data*=
 data)
+static inline void wbsd_init_sg(struct wbsd_host *host, struct mmc_data =
*data)
 {
 	/*
 	 * Get info. about SG list from data structure.
@@ -259,7 +258,7 @@ static inline void wbsd_init_sg(struct w
 	host->remain =3D host->cur_sg->length;
 }
=20
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
-	    host->offset =3D 0;
-	    host->remain =3D host->cur_sg->length;
-	  }
+	if (host->num_sg > 0) {
+		host->offset =3D 0;
+		host->remain =3D host->cur_sg->length;
+	}
=20
 	return host->num_sg;
 }
=20
-static inline char* wbsd_kmap_sg(struct wbsd_host* host)
+static inline char *wbsd_kmap_sg(struct wbsd_host *host)
 {
 	host->mapped_sg =3D kmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ) +
 		host->cur_sg->offset;
 	return host->mapped_sg;
 }
=20
-static inline void wbsd_kunmap_sg(struct wbsd_host* host)
+static inline void wbsd_kunmap_sg(struct wbsd_host *host)
 {
 	kunmap_atomic(host->mapped_sg, KM_BIO_SRC_IRQ);
 }
=20
-static inline void wbsd_sg_to_dma(struct wbsd_host* host, struct mmc_dat=
a* data)
+static inline void wbsd_sg_to_dma(struct wbsd_host *host, struct mmc_dat=
a *data)
 {
 	unsigned int len, i, size;
-	struct scatterlist* sg;
-	char* dmabuf =3D host->dma_buffer;
-	char* sgbuf;
+	struct scatterlist *sg;
+	char *dmabuf =3D host->dma_buffer;
+	char *sgbuf;
=20
 	size =3D host->size;
=20
@@ -308,8 +306,7 @@ static inline void wbsd_sg_to_dma(struct
 	 * be the entire list though so make sure that
 	 * we do not transfer too much.
 	 */
-	for (i =3D 0;i < len;i++)
-	{
+	for (i =3D 0; i < len; i++) {
 		sgbuf =3D kmap_atomic(sg[i].page, KM_BIO_SRC_IRQ) + sg[i].offset;
 		if (size < sg[i].length)
 			memcpy(dmabuf, sgbuf, size);
@@ -337,12 +334,12 @@ static inline void wbsd_sg_to_dma(struct
 	host->size -=3D size;
 }
=20
-static inline void wbsd_dma_to_sg(struct wbsd_host* host, struct mmc_dat=
a* data)
+static inline void wbsd_dma_to_sg(struct wbsd_host *host, struct mmc_dat=
a *data)
 {
 	unsigned int len, i, size;
-	struct scatterlist* sg;
-	char* dmabuf =3D host->dma_buffer;
-	char* sgbuf;
+	struct scatterlist *sg;
+	char *dmabuf =3D host->dma_buffer;
+	char *sgbuf;
=20
 	size =3D host->size;
=20
@@ -354,8 +351,7 @@ static inline void wbsd_dma_to_sg(struct
 	 * be the entire list though so make sure that
 	 * we do not transfer too much.
 	 */
-	for (i =3D 0;i < len;i++)
-	{
+	for (i =3D 0; i < len; i++) {
 		sgbuf =3D kmap_atomic(sg[i].page, KM_BIO_SRC_IRQ) + sg[i].offset;
 		if (size < sg[i].length)
 			memcpy(sgbuf, dmabuf, size);
@@ -387,46 +383,38 @@ static inline void wbsd_dma_to_sg(struct
  * Command handling
  */
=20
-static inline void wbsd_get_short_reply(struct wbsd_host* host,
-	struct mmc_command* cmd)
+static inline void wbsd_get_short_reply(struct wbsd_host *host,
+					struct mmc_command *cmd)
 {
 	/*
 	 * Correct response type?
 	 */
-	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) !=3D WBSD_RSP_SHORT)
-	{
+	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) !=3D WBSD_RSP_SHORT) {
 		cmd->error =3D MMC_ERR_INVALID;
 		return;
 	}
=20
-	cmd->resp[0] =3D
-		wbsd_read_index(host, WBSD_IDX_RESP12) << 24;
-	cmd->resp[0] |=3D
-		wbsd_read_index(host, WBSD_IDX_RESP13) << 16;
-	cmd->resp[0] |=3D
-		wbsd_read_index(host, WBSD_IDX_RESP14) << 8;
-	cmd->resp[0] |=3D
-		wbsd_read_index(host, WBSD_IDX_RESP15) << 0;
-	cmd->resp[1] =3D
-		wbsd_read_index(host, WBSD_IDX_RESP16) << 24;
+	cmd->resp[0]  =3D wbsd_read_index(host, WBSD_IDX_RESP12) << 24;
+	cmd->resp[0] |=3D wbsd_read_index(host, WBSD_IDX_RESP13) << 16;
+	cmd->resp[0] |=3D wbsd_read_index(host, WBSD_IDX_RESP14) << 8;
+	cmd->resp[0] |=3D wbsd_read_index(host, WBSD_IDX_RESP15) << 0;
+	cmd->resp[1]  =3D wbsd_read_index(host, WBSD_IDX_RESP16) << 24;
 }
=20
-static inline void wbsd_get_long_reply(struct wbsd_host* host,
-	struct mmc_command* cmd)
+static inline void wbsd_get_long_reply(struct wbsd_host *host,
+	struct mmc_command *cmd)
 {
 	int i;
=20
 	/*
 	 * Correct response type?
 	 */
-	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) !=3D WBSD_RSP_LONG)
-	{
+	if (wbsd_read_index(host, WBSD_IDX_RSPLEN) !=3D WBSD_RSP_LONG) {
 		cmd->error =3D MMC_ERR_INVALID;
 		return;
 	}
=20
-	for (i =3D 0;i < 4;i++)
-	{
+	for (i =3D 0; i < 4; i++) {
 		cmd->resp[i] =3D
 			wbsd_read_index(host, WBSD_IDX_RESP1 + i * 4) << 24;
 		cmd->resp[i] |=3D
@@ -438,7 +426,7 @@ static inline void wbsd_get_long_reply(s
 	}
 }
=20
-static void wbsd_send_command(struct wbsd_host* host, struct mmc_command=
* cmd)
+static void wbsd_send_command(struct wbsd_host *host, struct mmc_command=
 *cmd)
 {
 	int i;
 	u8 status, isr;
@@ -456,7 +444,7 @@ static void wbsd_send_command(struct wbs
 	 * Send the command (CRC calculated by host).
 	 */
 	outb(cmd->opcode, host->base + WBSD_CMDR);
-	for (i =3D 3;i >=3D 0;i--)
+	for (i =3D 3; i >=3D 0; i--)
 		outb((cmd->arg >> (i * 8)) & 0xff, host->base + WBSD_CMDR);
=20
 	cmd->error =3D MMC_ERR_NONE;
@@ -471,8 +459,7 @@ static void wbsd_send_command(struct wbs
 	/*
 	 * Do we expect a reply?
 	 */
-	if ((cmd->flags & MMC_RSP_MASK) !=3D MMC_RSP_NONE)
-	{
+	if ((cmd->flags & MMC_RSP_MASK) !=3D MMC_RSP_NONE) {
 		/*
 		 * Read back status.
 		 */
@@ -488,8 +475,7 @@ static void wbsd_send_command(struct wbs
 		else if ((cmd->flags & MMC_RSP_CRC) && (isr & WBSD_INT_CRC))
 			cmd->error =3D MMC_ERR_BADCRC;
 		/* All ok */
-		else
-		{
+		else {
 			if ((cmd->flags & MMC_RSP_MASK) =3D=3D MMC_RSP_SHORT)
 				wbsd_get_short_reply(host, cmd);
 			else
@@ -504,10 +490,10 @@ static void wbsd_send_command(struct wbs
  * Data functions
  */
=20
-static void wbsd_empty_fifo(struct wbsd_host* host)
+static void wbsd_empty_fifo(struct wbsd_host *host)
 {
-	struct mmc_data* data =3D host->mrq->cmd->data;
-	char* buffer;
+	struct mmc_data *data =3D host->mrq->cmd->data;
+	char *buffer;
 	int i, fsr, fifo;
=20
 	/*
@@ -522,8 +508,7 @@ static void wbsd_empty_fifo(struct wbsd_
 	 * Drain the fifo. This has a tendency to loop longer
 	 * than the FIFO length (usually one block).
 	 */
-	while (!((fsr =3D inb(host->base + WBSD_FSR)) & WBSD_FIFO_EMPTY))
-	{
+	while (!((fsr =3D inb(host->base + WBSD_FSR)) & WBSD_FIFO_EMPTY)) {
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
@@ -535,8 +520,7 @@ static void wbsd_empty_fifo(struct wbsd_
 		else
 			fifo =3D 1;
=20
-		for (i =3D 0;i < fifo;i++)
-		{
+		for (i =3D 0; i < fifo; i++) {
 			*buffer =3D inb(host->base + WBSD_DFR);
 			buffer++;
 			host->offset++;
@@ -547,8 +531,7 @@ static void wbsd_empty_fifo(struct wbsd_
 			/*
 			 * Transfer done?
 			 */
-			if (data->bytes_xfered =3D=3D host->size)
-			{
+			if (data->bytes_xfered =3D=3D host->size) {
 				wbsd_kunmap_sg(host);
 				return;
 			}
@@ -556,15 +539,13 @@ static void wbsd_empty_fifo(struct wbsd_
 			/*
 			 * End of scatter list entry?
 			 */
-			if (host->remain =3D=3D 0)
-			{
+			if (host->remain =3D=3D 0) {
 				wbsd_kunmap_sg(host);
=20
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
=20
-static void wbsd_fill_fifo(struct wbsd_host* host)
+static void wbsd_fill_fifo(struct wbsd_host *host)
 {
-	struct mmc_data* data =3D host->mrq->cmd->data;
-	char* buffer;
+	struct mmc_data *data =3D host->mrq->cmd->data;
+	char *buffer;
 	int i, fsr, fifo;
=20
 	/*
@@ -613,8 +594,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 	 * Fill the fifo. This has a tendency to loop longer
 	 * than the FIFO length (usually one block).
 	 */
-	while (!((fsr =3D inb(host->base + WBSD_FSR)) & WBSD_FIFO_FULL))
-	{
+	while (!((fsr =3D inb(host->base + WBSD_FSR)) & WBSD_FIFO_FULL)) {
 		/*
 		 * The size field in the FSR is broken so we have to
 		 * do some guessing.
@@ -626,8 +606,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 		else
 			fifo =3D 15;
=20
-		for (i =3D 16;i > fifo;i--)
-		{
+		for (i =3D 16; i > fifo; i--) {
 			outb(*buffer, host->base + WBSD_DFR);
 			buffer++;
 			host->offset++;
@@ -638,8 +617,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 			/*
 			 * Transfer done?
 			 */
-			if (data->bytes_xfered =3D=3D host->size)
-			{
+			if (data->bytes_xfered =3D=3D host->size) {
 				wbsd_kunmap_sg(host);
 				return;
 			}
@@ -647,15 +625,13 @@ static void wbsd_fill_fifo(struct wbsd_h
 			/*
 			 * End of scatter list entry?
 			 */
-			if (host->remain =3D=3D 0)
-			{
+			if (host->remain =3D=3D 0) {
 				wbsd_kunmap_sg(host);
=20
 				/*
 				 * Get next entry. Check if last.
 				 */
-				if (!wbsd_next_sg(host))
-				{
+				if (!wbsd_next_sg(host)) {
 					/*
 					 * We should never reach this point.
 					 * It means that we're trying to
@@ -684,7 +660,7 @@ static void wbsd_fill_fifo(struct wbsd_h
 	tasklet_schedule(&host->fifo_tasklet);
 }
=20
-static void wbsd_prepare_data(struct wbsd_host* host, struct mmc_data* d=
ata)
+static void wbsd_prepare_data(struct wbsd_host *host, struct mmc_data *d=
ata)
 {
 	u16 blksize;
 	u8 setup;
@@ -706,8 +682,10 @@ static void wbsd_prepare_data(struct wbs
 	 */
 	if (data->timeout_ns > 127000000)
 		wbsd_write_index(host, WBSD_IDX_TAAC, 127);
-	else
-		wbsd_write_index(host, WBSD_IDX_TAAC, data->timeout_ns/1000000);
+	else {
+		wbsd_write_index(host, WBSD_IDX_TAAC,
+			data->timeout_ns / 1000000);
+	}
=20
 	if (data->timeout_clks > 255)
 		wbsd_write_index(host, WBSD_IDX_NSAC, 255);
@@ -722,23 +700,18 @@ static void wbsd_prepare_data(struct wbs
 	 * Space for CRC must be included in the size.
 	 * Two bytes are needed for each data line.
 	 */
-	if (host->bus_width =3D=3D MMC_BUS_WIDTH_1)
-	{
+	if (host->bus_width =3D=3D MMC_BUS_WIDTH_1) {
 		blksize =3D (1 << data->blksz_bits) + 2;
=20
 		wbsd_write_index(host, WBSD_IDX_PBSMSB, (blksize >> 4) & 0xF0);
 		wbsd_write_index(host, WBSD_IDX_PBSLSB, blksize & 0xFF);
-	}
-	else if (host->bus_width =3D=3D MMC_BUS_WIDTH_4)
-	{
+	} else if (host->bus_width =3D=3D MMC_BUS_WIDTH_4) {
 		blksize =3D (1 << data->blksz_bits) + 2 * 4;
=20
-		wbsd_write_index(host, WBSD_IDX_PBSMSB, ((blksize >> 4) & 0xF0)
-			| WBSD_DATA_WIDTH);
+		wbsd_write_index(host, WBSD_IDX_PBSMSB,
+			((blksize >> 4) & 0xF0) | WBSD_DATA_WIDTH);
 		wbsd_write_index(host, WBSD_IDX_PBSLSB, blksize & 0xFF);
-	}
-	else
-	{
+	} else {
 		data->error =3D MMC_ERR_INVALID;
 		return;
 	}
@@ -755,14 +728,12 @@ static void wbsd_prepare_data(struct wbs
 	/*
 	 * DMA transfer?
 	 */
-	if (host->dma >=3D 0)
-	{
+	if (host->dma >=3D 0) {
 		/*
 		 * The buffer for DMA is only 64 kB.
 		 */
 		BUG_ON(host->size > 0x10000);
-		if (host->size > 0x10000)
-		{
+		if (host->size > 0x10000) {
 			data->error =3D MMC_ERR_INVALID;
 			return;
 		}
@@ -794,9 +765,7 @@ static void wbsd_prepare_data(struct wbs
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
@@ -817,13 +786,10 @@ static void wbsd_prepare_data(struct wbs
 		 * Set up FIFO threshold levels (and fill
 		 * buffer if doing a write).
 		 */
-		if (data->flags & MMC_DATA_READ)
-		{
+		if (data->flags & MMC_DATA_READ) {
 			wbsd_write_index(host, WBSD_IDX_FIFOEN,
 				WBSD_FIFOEN_FULL | 8);
-		}
-		else
-		{
+		} else {
 			wbsd_write_index(host, WBSD_IDX_FIFOEN,
 				WBSD_FIFOEN_EMPTY | 8);
 			wbsd_fill_fifo(host);
@@ -833,7 +799,7 @@ static void wbsd_prepare_data(struct wbs
 	data->error =3D MMC_ERR_NONE;
 }
=20
-static void wbsd_finish_data(struct wbsd_host* host, struct mmc_data* da=
ta)
+static void wbsd_finish_data(struct wbsd_host *host, struct mmc_data *da=
ta)
 {
 	unsigned long dmaflags;
 	int count;
@@ -851,16 +817,14 @@ static void wbsd_finish_data(struct wbsd
 	 * Wait for the controller to leave data
 	 * transfer state.
 	 */
-	do
-	{
+	do {
 		status =3D wbsd_read_index(host, WBSD_IDX_STATUS);
 	} while (status & (WBSD_BLOCK_READ | WBSD_BLOCK_WRITE));
=20
 	/*
 	 * DMA transfer?
 	 */
-	if (host->dma >=3D 0)
-	{
+	if (host->dma >=3D 0) {
 		/*
 		 * Disable DMA on the host.
 		 */
@@ -878,16 +842,13 @@ static void wbsd_finish_data(struct wbsd
 		/*
 		 * Any leftover data?
 		 */
-		if (count)
-		{
+		if (count) {
 			printk(KERN_ERR "%s: Incomplete DMA transfer. "
 				"%d bytes left.\n",
 				mmc_hostname(host->mmc), count);
=20
 			data->error =3D MMC_ERR_FAILED;
-		}
-		else
-		{
+		} else {
 			/*
 			 * Transfer data from DMA buffer to
 			 * SG list.
@@ -910,10 +871,10 @@ static void wbsd_finish_data(struct wbsd
  *                                                                      =
     *
 \***********************************************************************=
******/
=20
-static void wbsd_request(struct mmc_host* mmc, struct mmc_request* mrq)
+static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-	struct wbsd_host* host =3D mmc_priv(mmc);
-	struct mmc_command* cmd;
+	struct wbsd_host *host =3D mmc_priv(mmc);
+	struct mmc_command *cmd;
=20
 	/*
 	 * Disable tasklets to avoid a deadlock.
@@ -930,8 +891,7 @@ static void wbsd_request(struct mmc_host
 	 * If there is no card in the slot then
 	 * timeout immediatly.
 	 */
-	if (!(host->flags & WBSD_FCARD_PRESENT))
-	{
+	if (!(host->flags & WBSD_FCARD_PRESENT)) {
 		cmd->error =3D MMC_ERR_TIMEOUT;
 		goto done;
 	}
@@ -939,8 +899,7 @@ static void wbsd_request(struct mmc_host
 	/*
 	 * Does the request include data?
 	 */
-	if (cmd->data)
-	{
+	if (cmd->data) {
 		wbsd_prepare_data(host, cmd->data);
=20
 		if (cmd->data->error !=3D MMC_ERR_NONE)
@@ -954,8 +913,7 @@ static void wbsd_request(struct mmc_host
 	 * will be finished after the data has
 	 * transfered.
 	 */
-	if (cmd->data && (cmd->error =3D=3D MMC_ERR_NONE))
-	{
+	if (cmd->data && (cmd->error =3D=3D MMC_ERR_NONE)) {
 		/*
 		 * Dirty fix for hardware bug.
 		 */
@@ -973,14 +931,14 @@ done:
 	spin_unlock_bh(&host->lock);
 }
=20
-static void wbsd_set_ios(struct mmc_host* mmc, struct mmc_ios* ios)
+static void wbsd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct wbsd_host* host =3D mmc_priv(mmc);
+	struct wbsd_host *host =3D mmc_priv(mmc);
 	u8 clk, setup, pwr;
=20
 	DBGF("clock %uHz busmode %u powermode %u cs %u Vdd %u width %u\n",
-	     ios->clock, ios->bus_mode, ios->power_mode, ios->chip_select,
-	     ios->vdd, ios->bus_width);
+		ios->clock, ios->bus_mode, ios->power_mode, ios->chip_select,
+		ios->vdd, ios->bus_width);
=20
 	spin_lock_bh(&host->lock);
=20
@@ -1004,8 +962,7 @@ static void wbsd_set_ios(struct mmc_host
 	 * Only write to the clock register when
 	 * there is an actual change.
 	 */
-	if (clk !=3D host->clk)
-	{
+	if (clk !=3D host->clk) {
 		wbsd_write_index(host, WBSD_IDX_CLK, clk);
 		host->clk =3D clk;
 	}
@@ -1013,8 +970,7 @@ static void wbsd_set_ios(struct mmc_host
 	/*
 	 * Power up card.
 	 */
-	if (ios->power_mode !=3D MMC_POWER_OFF)
-	{
+	if (ios->power_mode !=3D MMC_POWER_OFF) {
 		pwr =3D inb(host->base + WBSD_CSR);
 		pwr &=3D ~WBSD_POWER_N;
 		outb(pwr, host->base + WBSD_CSR);
@@ -1026,23 +982,19 @@ static void wbsd_set_ios(struct mmc_host
 	 * that needs to be disabled.
 	 */
 	setup =3D wbsd_read_index(host, WBSD_IDX_SETUP);
-	if (ios->chip_select =3D=3D MMC_CS_HIGH)
-	{
+	if (ios->chip_select =3D=3D MMC_CS_HIGH) {
 		BUG_ON(ios->bus_width !=3D MMC_BUS_WIDTH_1);
 		setup |=3D WBSD_DAT3_H;
 		host->flags |=3D WBSD_FIGNORE_DETECT;
-	}
-	else
-	{
-		if (setup & WBSD_DAT3_H)
-		{
+	} else {
+		if (setup & WBSD_DAT3_H) {
 			setup &=3D ~WBSD_DAT3_H;
=20
 			/*
 			 * We cannot resume card detection immediatly
 			 * because of capacitance and delays in the chip.
 			 */
-			mod_timer(&host->ignore_timer, jiffies + HZ/100);
+			mod_timer(&host->ignore_timer, jiffies + HZ / 100);
 		}
 	}
 	wbsd_write_index(host, WBSD_IDX_SETUP, setup);
@@ -1056,9 +1008,9 @@ static void wbsd_set_ios(struct mmc_host
 	spin_unlock_bh(&host->lock);
 }
=20
-static int wbsd_get_ro(struct mmc_host* mmc)
+static int wbsd_get_ro(struct mmc_host *mmc)
 {
-	struct wbsd_host* host =3D mmc_priv(mmc);
+	struct wbsd_host *host =3D mmc_priv(mmc);
 	u8 csr;
=20
 	spin_lock_bh(&host->lock);
@@ -1096,7 +1048,7 @@ static struct mmc_host_ops wbsd_ops =3D {
=20
 static void wbsd_reset_ignore(unsigned long data)
 {
-	struct wbsd_host *host =3D (struct wbsd_host*)data;
+	struct wbsd_host *host =3D (struct wbsd_host *)data;
=20
 	BUG_ON(host =3D=3D NULL);
=20
@@ -1119,7 +1071,7 @@ static void wbsd_reset_ignore(unsigned l
  * Tasklets
  */
=20
-static inline struct mmc_data* wbsd_get_data(struct wbsd_host* host)
+static inline struct mmc_data *wbsd_get_data(struct wbsd_host *host)
 {
 	WARN_ON(!host->mrq);
 	if (!host->mrq)
@@ -1138,14 +1090,13 @@ static inline struct mmc_data* wbsd_get_
=20
 static void wbsd_tasklet_card(unsigned long param)
 {
-	struct wbsd_host* host =3D (struct wbsd_host*)param;
+	struct wbsd_host *host =3D (struct wbsd_host *)param;
 	u8 csr;
 	int delay =3D -1;
=20
 	spin_lock(&host->lock);
=20
-	if (host->flags & WBSD_FIGNORE_DETECT)
-	{
+	if (host->flags & WBSD_FIGNORE_DETECT) {
 		spin_unlock(&host->lock);
 		return;
 	}
@@ -1153,23 +1104,18 @@ static void wbsd_tasklet_card(unsigned l
 	csr =3D inb(host->base + WBSD_CSR);
 	WARN_ON(csr =3D=3D 0xff);
=20
-	if (csr & WBSD_CARDPRESENT)
-	{
-		if (!(host->flags & WBSD_FCARD_PRESENT))
-		{
+	if (csr & WBSD_CARDPRESENT) {
+		if (!(host->flags & WBSD_FCARD_PRESENT)) {
 			DBG("Card inserted\n");
 			host->flags |=3D WBSD_FCARD_PRESENT;
=20
 			delay =3D 500;
 		}
-	}
-	else if (host->flags & WBSD_FCARD_PRESENT)
-	{
+	} else if (host->flags & WBSD_FCARD_PRESENT) {
 		DBG("Card removed\n");
 		host->flags &=3D ~WBSD_FCARD_PRESENT;
=20
-		if (host->mrq)
-		{
+		if (host->mrq) {
 			printk(KERN_ERR "%s: Card removed during transfer!\n",
 				mmc_hostname(host->mmc));
 			wbsd_reset(host);
@@ -1193,8 +1139,8 @@ static void wbsd_tasklet_card(unsigned l
=20
 static void wbsd_tasklet_fifo(unsigned long param)
 {
-	struct wbsd_host* host =3D (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host =3D (struct wbsd_host *)param;
+	struct mmc_data *data;
=20
 	spin_lock(&host->lock);
=20
@@ -1213,8 +1159,7 @@ static void wbsd_tasklet_fifo(unsigned l
 	/*
 	 * Done?
 	 */
-	if (host->size =3D=3D data->bytes_xfered)
-	{
+	if (host->size =3D=3D data->bytes_xfered) {
 		wbsd_write_index(host, WBSD_IDX_FIFOEN, 0);
 		tasklet_schedule(&host->finish_tasklet);
 	}
@@ -1225,8 +1170,8 @@ end:
=20
 static void wbsd_tasklet_crc(unsigned long param)
 {
-	struct wbsd_host* host =3D (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host =3D (struct wbsd_host *)param;
+	struct mmc_data *data;
=20
 	spin_lock(&host->lock);
=20
@@ -1249,8 +1194,8 @@ end:
=20
 static void wbsd_tasklet_timeout(unsigned long param)
 {
-	struct wbsd_host* host =3D (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host =3D (struct wbsd_host *)param;
+	struct mmc_data *data;
=20
 	spin_lock(&host->lock);
=20
@@ -1273,8 +1218,8 @@ end:
=20
 static void wbsd_tasklet_finish(unsigned long param)
 {
-	struct wbsd_host* host =3D (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host =3D (struct wbsd_host *)param;
+	struct mmc_data *data;
=20
 	spin_lock(&host->lock);
=20
@@ -1294,14 +1239,13 @@ end:
=20
 static void wbsd_tasklet_block(unsigned long param)
 {
-	struct wbsd_host* host =3D (struct wbsd_host*)param;
-	struct mmc_data* data;
+	struct wbsd_host *host =3D (struct wbsd_host *)param;
+	struct mmc_data *data;
=20
 	spin_lock(&host->lock);
=20
 	if ((wbsd_read_index(host, WBSD_IDX_CRCSTATUS) & WBSD_CRC_MASK) !=3D
-		WBSD_CRC_OK)
-	{
+		WBSD_CRC_OK) {
 		data =3D wbsd_get_data(host);
 		if (!data)
 			goto end;
@@ -1323,7 +1267,7 @@ end:
=20
 static irqreturn_t wbsd_irq(int irq, void *dev_id, struct pt_regs *regs)=

 {
-	struct wbsd_host* host =3D dev_id;
+	struct wbsd_host *host =3D dev_id;
 	int isr;
=20
 	isr =3D inb(host->base + WBSD_ISR);
@@ -1365,10 +1309,10 @@ static irqreturn_t wbsd_irq(int irq, voi
  * Allocate/free MMC structure.
  */
=20
-static int __devinit wbsd_alloc_mmc(struct device* dev)
+static int __devinit wbsd_alloc_mmc(struct device *dev)
 {
-	struct mmc_host* mmc;
-	struct wbsd_host* host;
+	struct mmc_host *mmc;
+	struct wbsd_host *host;
=20
 	/*
 	 * Allocate MMC structure.
@@ -1388,7 +1332,7 @@ static int __devinit wbsd_alloc_mmc(stru
 	mmc->ops =3D &wbsd_ops;
 	mmc->f_min =3D 375000;
 	mmc->f_max =3D 24000000;
-	mmc->ocr_avail =3D MMC_VDD_32_33|MMC_VDD_33_34;
+	mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps =3D MMC_CAP_4_BIT_DATA;
=20
 	spin_lock_init(&host->lock);
@@ -1424,10 +1368,10 @@ static int __devinit wbsd_alloc_mmc(stru
 	return 0;
 }
=20
-static void __devexit wbsd_free_mmc(struct device* dev)
+static void __devexit wbsd_free_mmc(struct device *dev)
 {
-	struct mmc_host* mmc;
-	struct wbsd_host* host;
+	struct mmc_host *mmc;
+	struct wbsd_host *host;
=20
 	mmc =3D dev_get_drvdata(dev);
 	if (!mmc)
@@ -1447,7 +1391,7 @@ static void __devexit wbsd_free_mmc(stru
  * Scan for known chip id:s
  */
=20
-static int __devinit wbsd_scan(struct wbsd_host* host)
+static int __devinit wbsd_scan(struct wbsd_host *host)
 {
 	int i, j, k;
 	int id;
@@ -1477,16 +1421,14 @@ static int __devinit wbsd_scan(struct wb
 			wbsd_lock_config(host);
=20
 			for (k =3D 0; k < ARRAY_SIZE(valid_ids); k++) {
-				if (id =3D=3D valid_ids[k])
-				{
+				if (id =3D=3D valid_ids[k]) {
 					host->chip_id =3D id;
=20
 					return 0;
 				}
 			}
=20
-			if (id !=3D 0xFFFF)
-			{
+			if (id !=3D 0xFFFF) {
 				DBG("Unknown hardware (id %x) found at %x\n",
 					id, config_ports[i]);
 			}
@@ -1505,7 +1447,7 @@ static int __devinit wbsd_scan(struct wb
  * Allocate/free io port ranges
  */
=20
-static int __devinit wbsd_request_region(struct wbsd_host* host, int bas=
e)
+static int __devinit wbsd_request_region(struct wbsd_host *host, int bas=
e)
 {
 	if (io & 0x7)
 		return -EINVAL;
@@ -1518,7 +1460,7 @@ static int __devinit wbsd_request_region
 	return 0;
 }
=20
-static void __devexit wbsd_release_regions(struct wbsd_host* host)
+static void __devexit wbsd_release_regions(struct wbsd_host *host)
 {
 	if (host->base)
 		release_region(host->base, 8);
@@ -1535,7 +1477,7 @@ static void __devexit wbsd_release_regio
  * Allocate/free DMA port and buffer
  */
=20
-static void __devinit wbsd_request_dma(struct wbsd_host* host, int dma)
+static void __devinit wbsd_request_dma(struct wbsd_host *host, int dma)
 {
 	if (dma < 0)
 		return;
@@ -1579,8 +1521,8 @@ kfree:
 	 */
 	BUG_ON(1);
=20
-	dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
-		DMA_BIDIRECTIONAL);
+	dma_unmap_single(host->mmc->dev, host->dma_addr,
+		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 	host->dma_addr =3D (dma_addr_t)NULL;
=20
 	kfree(host->dma_buffer);
@@ -1594,11 +1536,12 @@ err:
 		"Falling back on FIFO.\n", dma);
 }
=20
-static void __devexit wbsd_release_dma(struct wbsd_host* host)
+static void __devexit wbsd_release_dma(struct wbsd_host *host)
 {
-	if (host->dma_addr)
-		dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
-			DMA_BIDIRECTIONAL);
+	if (host->dma_addr) {
+		dma_unmap_single(host->mmc->dev, host->dma_addr,
+			WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
+	}
 	kfree(host->dma_buffer);
 	if (host->dma >=3D 0)
 		free_dma(host->dma);
@@ -1612,7 +1555,7 @@ static void __devexit wbsd_release_dma(s
  * Allocate/free IRQ.
  */
=20
-static int __devinit wbsd_request_irq(struct wbsd_host* host, int irq)
+static int __devinit wbsd_request_irq(struct wbsd_host *host, int irq)
 {
 	int ret;
=20
@@ -1629,17 +1572,23 @@ static int __devinit wbsd_request_irq(st
 	/*
 	 * Set up tasklets.
 	 */
-	tasklet_init(&host->card_tasklet, wbsd_tasklet_card, (unsigned long)hos=
t);
-	tasklet_init(&host->fifo_tasklet, wbsd_tasklet_fifo, (unsigned long)hos=
t);
-	tasklet_init(&host->crc_tasklet, wbsd_tasklet_crc, (unsigned long)host)=
;
-	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout, (unsigned lo=
ng)host);
-	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish, (unsigned long=
)host);
-	tasklet_init(&host->block_tasklet, wbsd_tasklet_block, (unsigned long)h=
ost);
+	tasklet_init(&host->card_tasklet, wbsd_tasklet_card,
+			(unsigned long)host);
+	tasklet_init(&host->fifo_tasklet, wbsd_tasklet_fifo,
+			(unsigned long)host);
+	tasklet_init(&host->crc_tasklet, wbsd_tasklet_crc,
+			(unsigned long)host);
+	tasklet_init(&host->timeout_tasklet, wbsd_tasklet_timeout,
+			(unsigned long)host);
+	tasklet_init(&host->finish_tasklet, wbsd_tasklet_finish,
+			(unsigned long)host);
+	tasklet_init(&host->block_tasklet, wbsd_tasklet_block,
+			(unsigned long)host);
=20
 	return 0;
 }
=20
-static void __devexit wbsd_release_irq(struct wbsd_host* host)
+static void __devexit wbsd_release_irq(struct wbsd_host *host)
 {
 	if (!host->irq)
 		return;
@@ -1660,7 +1609,7 @@ static void __devexit wbsd_release_irq(s
  * Allocate all resources for the host.
  */
=20
-static int __devinit wbsd_request_resources(struct wbsd_host* host,
+static int __devinit wbsd_request_resources(struct wbsd_host *host,
 	int base, int irq, int dma)
 {
 	int ret;
@@ -1691,7 +1640,7 @@ static int __devinit wbsd_request_resour
  * Release all resources for the host.
  */
=20
-static void __devexit wbsd_release_resources(struct wbsd_host* host)
+static void __devexit wbsd_release_resources(struct wbsd_host *host)
 {
 	wbsd_release_dma(host);
 	wbsd_release_irq(host);
@@ -1702,7 +1651,7 @@ static void __devexit wbsd_release_resou
  * Configure the resources the chip should use.
  */
=20
-static void wbsd_chip_config(struct wbsd_host* host)
+static void wbsd_chip_config(struct wbsd_host *host)
 {
 	wbsd_unlock_config(host);
=20
@@ -1746,7 +1695,7 @@ static void wbsd_chip_config(struct wbsd
  * Check that configured resources are correct.
  */
=20
-static int wbsd_chip_validate(struct wbsd_host* host)
+static int wbsd_chip_validate(struct wbsd_host *host)
 {
 	int base, irq, dma;
=20
@@ -1786,7 +1735,7 @@ static int wbsd_chip_validate(struct wbs
  * Powers down the SD function
  */
=20
-static void wbsd_chip_poweroff(struct wbsd_host* host)
+static void wbsd_chip_poweroff(struct wbsd_host *host)
 {
 	wbsd_unlock_config(host);
=20
@@ -1802,11 +1751,11 @@ static void wbsd_chip_poweroff(struct wb
  *                                                                      =
     *
 \***********************************************************************=
******/
=20
-static int __devinit wbsd_init(struct device* dev, int base, int irq, in=
t dma,
+static int __devinit wbsd_init(struct device *dev, int base, int irq, in=
t dma,
 	int pnp)
 {
-	struct wbsd_host* host =3D NULL;
-	struct mmc_host* mmc =3D NULL;
+	struct wbsd_host *host =3D NULL;
+	struct mmc_host *mmc =3D NULL;
 	int ret;
=20
 	ret =3D wbsd_alloc_mmc(dev);
@@ -1820,16 +1769,12 @@ static int __devinit wbsd_init(struct de
 	 * Scan for hardware.
 	 */
 	ret =3D wbsd_scan(host);
-	if (ret)
-	{
-		if (pnp && (ret =3D=3D -ENODEV))
-		{
+	if (ret) {
+		if (pnp && (ret =3D=3D -ENODEV)) {
 			printk(KERN_WARNING DRIVER_NAME
 				": Unable to confirm device presence. You may "
 				"experience lock-ups.\n");
-		}
-		else
-		{
+		} else {
 			wbsd_free_mmc(dev);
 			return ret;
 		}
@@ -1839,8 +1784,7 @@ static int __devinit wbsd_init(struct de
 	 * Request resources.
 	 */
 	ret =3D wbsd_request_resources(host, io, irq, dma);
-	if (ret)
-	{
+	if (ret) {
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
 		return ret;
@@ -1849,18 +1793,15 @@ static int __devinit wbsd_init(struct de
 	/*
 	 * See if chip needs to be configured.
 	 */
-	if (pnp)
-	{
-		if ((host->config !=3D 0) && !wbsd_chip_validate(host))
-		{
+	if (pnp) {
+		if ((host->config !=3D 0) && !wbsd_chip_validate(host)) {
 			printk(KERN_WARNING DRIVER_NAME
 				": PnP active but chip not configured! "
 				"You probably have a buggy BIOS. "
 				"Configuring chip manually.\n");
 			wbsd_chip_config(host);
 		}
-	}
-	else
+	} else
 		wbsd_chip_config(host);
=20
 	/*
@@ -1868,8 +1809,7 @@ static int __devinit wbsd_init(struct de
 	 * Not tested.
 	 */
 #ifdef CONFIG_PM
-	if (host->config)
-	{
+	if (host->config) {
 		wbsd_unlock_config(host);
 		wbsd_write_config(host, WBSD_CONF_PME, 0xA0);
 		wbsd_lock_config(host);
@@ -1902,10 +1842,10 @@ static int __devinit wbsd_init(struct de
 	return 0;
 }
=20
-static void __devexit wbsd_shutdown(struct device* dev, int pnp)
+static void __devexit wbsd_shutdown(struct device *dev, int pnp)
 {
-	struct mmc_host* mmc =3D dev_get_drvdata(dev);
-	struct wbsd_host* host;
+	struct mmc_host *mmc =3D dev_get_drvdata(dev);
+	struct wbsd_host *host;
=20
 	if (!mmc)
 		return;
@@ -1929,12 +1869,12 @@ static void __devexit wbsd_shutdown(stru
  * Non-PnP
  */
=20
-static int __devinit wbsd_probe(struct platform_device* dev)
+static int __devinit wbsd_probe(struct platform_device *dev)
 {
 	return wbsd_init(&dev->dev, io, irq, dma, 0);
 }
=20
-static int __devexit wbsd_remove(struct platform_device* dev)
+static int __devexit wbsd_remove(struct platform_device *dev)
 {
 	wbsd_shutdown(&dev->dev, 0);
=20
@@ -1948,7 +1888,7 @@ static int __devexit wbsd_remove(struct=20
 #ifdef CONFIG_PNP
=20
 static int __devinit
-wbsd_pnp_probe(struct pnp_dev * pnpdev, const struct pnp_device_id *dev_=
id)
+wbsd_pnp_probe(struct pnp_dev *pnpdev, const struct pnp_device_id *dev_i=
d)
 {
 	int io, irq, dma;
=20
@@ -1967,7 +1907,7 @@ wbsd_pnp_probe(struct pnp_dev * pnpdev,=20
 	return wbsd_init(&pnpdev->dev, io, irq, dma, 1);
 }
=20
-static void __devexit wbsd_pnp_remove(struct pnp_dev * dev)
+static void __devexit wbsd_pnp_remove(struct pnp_dev *dev)
 {
 	wbsd_shutdown(&dev->dev, 1);
 }
@@ -1996,7 +1936,8 @@ static int wbsd_resume(struct wbsd_host=20
 	return mmc_resume_host(host->mmc);
 }
=20
-static int wbsd_platform_suspend(struct platform_device *dev, pm_message=
_t state)
+static int wbsd_platform_suspend(struct platform_device *dev,
+				 pm_message_t state)
 {
 	struct mmc_host *mmc =3D platform_get_drvdata(dev);
 	struct wbsd_host *host;
@@ -2072,10 +2013,8 @@ static int wbsd_pnp_resume(struct pnp_de
 	/*
 	 * See if chip needs to be configured.
 	 */
-	if (host->config !=3D 0)
-	{
-		if (!wbsd_chip_validate(host))
-		{
+	if (host->config !=3D 0) {
+		if (!wbsd_chip_validate(host)) {
 			printk(KERN_WARNING DRIVER_NAME
 				": PnP active but chip not configured! "
 				"You probably have a buggy BIOS. "
@@ -2146,31 +2085,26 @@ static int __init wbsd_drv_init(void)
=20
 #ifdef CONFIG_PNP
=20
-	if (!nopnp)
-	{
+	if (!nopnp) {
 		result =3D pnp_register_driver(&wbsd_pnp_driver);
 		if (result < 0)
 			return result;
 	}
-
 #endif /* CONFIG_PNP */
=20
-	if (nopnp)
-	{
+	if (nopnp) {
 		result =3D platform_driver_register(&wbsd_driver);
 		if (result < 0)
 			return result;
=20
 		wbsd_device =3D platform_device_alloc(DRIVER_NAME, -1);
-		if (!wbsd_device)
-		{
+		if (!wbsd_device) {
 			platform_driver_unregister(&wbsd_driver);
 			return -ENOMEM;
 		}
=20
 		result =3D platform_device_add(wbsd_device);
-		if (result)
-		{
+		if (result) {
 			platform_device_put(wbsd_device);
 			platform_driver_unregister(&wbsd_driver);
 			return result;
@@ -2189,8 +2123,7 @@ static void __exit wbsd_drv_exit(void)
=20
 #endif /* CONFIG_PNP */
=20
-	if (nopnp)
-	{
+	if (nopnp) {
 		platform_device_unregister(wbsd_device);
=20
 		platform_driver_unregister(&wbsd_driver);

--------------020304020903030307040305--

--=_hermes.drzeus.cx-21691-1136742488-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDwVBX7b8eESbyJLgRAn30AJ4ysJxITbn9NAF0/kdWhvFftxhfnACg3b4x
5GFkaxbVJMCzG73YHvsUQn4=
=/8mP
-----END PGP SIGNATURE-----

--=_hermes.drzeus.cx-21691-1136742488-0001-2--
