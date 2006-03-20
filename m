Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965785AbWCTQI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965785AbWCTQI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWCTQI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:08:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26776 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966353AbWCTPPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marcin Rudowski <mar_rud@poczta.onet.pl>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 040/141] V4L/DVB (3266): Fix NICAM buzz on analog sound
Date: Mon, 20 Mar 2006 12:08:43 -0300
Message-id: <20060320150843.PS675323000040@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Rudowski <mar_rud@poczta.onet.pl>
Date: 1139224514 -0200

Apparently, having the number of lines fixed at 4 reduces (or even kills)
the buzz found in NICAM stereo with analog sound.

Signed-off-by: Marcin Rudowski <mar_rud@poczta.onet.pl>
Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index 8d6d6a6..3720f24 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -787,12 +787,14 @@ static int set_pll(struct cx88_core *cor
 
 int cx88_start_audio_dma(struct cx88_core *core)
 {
+	/* constant 128 made buzz in analog Nicam-stereo for bigger fifo_size */
+	int bpl = cx88_sram_channels[SRAM_CH25].fifo_size/4;
 	/* setup fifo + format */
-	cx88_sram_channel_setup(core, &cx88_sram_channels[SRAM_CH25], 128, 0);
-	cx88_sram_channel_setup(core, &cx88_sram_channels[SRAM_CH26], 128, 0);
+	cx88_sram_channel_setup(core, &cx88_sram_channels[SRAM_CH25], bpl, 0);
+	cx88_sram_channel_setup(core, &cx88_sram_channels[SRAM_CH26], bpl, 0);
 
-	cx_write(MO_AUDD_LNGTH,    128); /* fifo bpl size */
-	cx_write(MO_AUDR_LNGTH,    128); /* fifo bpl size */
+	cx_write(MO_AUDD_LNGTH, bpl); /* fifo bpl size */
+	cx_write(MO_AUDR_LNGTH, bpl); /* fifo bpl size */
 
 	/* start dma */
 	cx_write(MO_AUD_DMACNTRL, 0x0003); /* Up and Down fifo enable */

