Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWBGPmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWBGPmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBGPlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24770 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751131AbWBGPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:19 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marcin Rudowski <mar_rud@poczta.onet.pl>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/16] Fix NICAM buzz on analog sound
Date: Tue, 07 Feb 2006 13:33:29 -0200
Message-id: <20060207153329.PS68062700002@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Rudowski <mar_rud@poczta.onet.pl>

Apparently, having the number of lines fixed at 4 reduces (or even kills)
the buzz found in NICAM stereo with analog sound.

Signed-off-by: Marcin Rudowski <mar_rud@poczta.onet.pl>
Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-core.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

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

