Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVDSAle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDSAle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVDSAle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:41:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30476 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261225AbVDSAkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:40:31 -0400
Date: Tue, 19 Apr 2005 02:40:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/cx88/: possible cleanups
Message-ID: <20050419004029.GI5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following unneeded EXPORT_SYMBOL:
  - cx88-core.c: cx88_pci_irqs

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/cx88/cx88-core.c  |    5 ++---
 drivers/media/video/cx88/cx88-dvb.c   |    4 ++--
 drivers/media/video/cx88/cx88-i2c.c   |    4 ++--
 drivers/media/video/cx88/cx88-vbi.c   |    6 +++---
 drivers/media/video/cx88/cx88-video.c |   12 ++++++------
 drivers/media/video/cx88/cx88.h       |    4 ----
 6 files changed, 15 insertions(+), 20 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88.h.old	2005-04-19 01:35:51.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88.h	2005-04-19 01:37:54.000000000 +0200
@@ -420,7 +420,6 @@
 /* ----------------------------------------------------------- */
 /* cx88-core.c                                                 */
 
-extern char *cx88_pci_irqs[32];
 extern char *cx88_vid_irqs[32];
 extern char *cx88_mpeg_irqs[32];
 extern void cx88_print_irqbits(char *name, char *tag, char **strings,
@@ -472,9 +471,6 @@
 /* cx88-vbi.c                                                  */
 
 void cx8800_vbi_fmt(struct cx8800_dev *dev, struct v4l2_format *f);
-int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
-			 struct cx88_dmaqueue *q,
-			 struct cx88_buffer   *buf);
 int cx8800_stop_vbi_dma(struct cx8800_dev *dev);
 int cx8800_restart_vbi_queue(struct cx8800_dev    *dev,
 			     struct cx88_dmaqueue *q);
--- linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-core.c.old	2005-04-19 01:36:05.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-core.c	2005-04-19 01:36:30.000000000 +0200
@@ -429,7 +429,7 @@
 /* ------------------------------------------------------------------ */
 /* debug helper code                                                  */
 
-int cx88_risc_decode(u32 risc)
+static int cx88_risc_decode(u32 risc)
 {
 	static char *instr[16] = {
 		[ RISC_SYNC    >> 28 ] = "sync",
@@ -542,7 +542,7 @@
 	       core->name,cx_read(ch->cnt2_reg));
 }
 
-char *cx88_pci_irqs[32] = {
+static char *cx88_pci_irqs[32] = {
 	"vid", "aud", "ts", "vip", "hst", "5", "6", "tm1",
 	"src_dma", "dst_dma", "risc_rd_err", "risc_wr_err",
 	"brdg_err", "src_dma_err", "dst_dma_err", "ipb_dma_err",
@@ -1206,7 +1206,6 @@
 /* ------------------------------------------------------------------ */
 
 EXPORT_SYMBOL(cx88_print_ioctl);
-EXPORT_SYMBOL(cx88_pci_irqs);
 EXPORT_SYMBOL(cx88_vid_irqs);
 EXPORT_SYMBOL(cx88_mpeg_irqs);
 EXPORT_SYMBOL(cx88_print_irqbits);
--- linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-dvb.c.old	2005-04-19 01:36:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-dvb.c	2005-04-19 01:36:56.000000000 +0200
@@ -91,7 +91,7 @@
 	cx88_free_buffer(dev->pci, (struct cx88_buffer*)vb);
 }
 
-struct videobuf_queue_ops dvb_qops = {
+static struct videobuf_queue_ops dvb_qops = {
 	.buf_setup    = dvb_buf_setup,
 	.buf_prepare  = dvb_buf_prepare,
 	.buf_queue    = dvb_buf_queue,
@@ -191,7 +191,7 @@
 	return 0;
 }
 
-struct or51132_config pchdtv_hd3000 = {
+static struct or51132_config pchdtv_hd3000 = {
 	.demod_address    = 0x15,
 	.pll_address      = 0x61,
 	.pll_desc         = &dvb_pll_thomson_dtt7610,
--- linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-i2c.c.old	2005-04-19 01:37:06.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-i2c.c	2005-04-19 01:37:23.000000000 +0200
@@ -45,7 +45,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-void cx8800_bit_setscl(void *data, int state)
+static void cx8800_bit_setscl(void *data, int state)
 {
 	struct cx88_core *core = data;
 
@@ -57,7 +57,7 @@
 	cx_read(MO_I2C);
 }
 
-void cx8800_bit_setsda(void *data, int state)
+static void cx8800_bit_setsda(void *data, int state)
 {
 	struct cx88_core *core = data;
 
--- linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-vbi.c.old	2005-04-19 01:38:02.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-vbi.c	2005-04-19 01:38:11.000000000 +0200
@@ -46,9 +46,9 @@
 	}
 }
 
-int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
-			 struct cx88_dmaqueue *q,
-			 struct cx88_buffer   *buf)
+static int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
+				struct cx88_dmaqueue *q,
+				struct cx88_buffer   *buf)
 {
 	struct cx88_core *core = dev->core;
 
--- linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-video.c.old	2005-04-19 01:38:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/cx88/cx88-video.c	2005-04-19 01:39:19.000000000 +0200
@@ -325,7 +325,7 @@
 		.shift                 = 0,
 	}
 };
-const int CX8800_CTLS = ARRAY_SIZE(cx8800_ctls);
+static const int CX8800_CTLS = ARRAY_SIZE(cx8800_ctls);
 
 /* ------------------------------------------------------------------- */
 /* resource management                                                 */
@@ -665,7 +665,7 @@
 	cx88_free_buffer(fh->dev->pci,buf);
 }
 
-struct videobuf_queue_ops cx8800_video_qops = {
+static struct videobuf_queue_ops cx8800_video_qops = {
 	.buf_setup    = buffer_setup,
 	.buf_prepare  = buffer_prepare,
 	.buf_queue    = buffer_queue,
@@ -1924,7 +1924,7 @@
 	.llseek        = no_llseek,
 };
 
-struct video_device cx8800_video_template =
+static struct video_device cx8800_video_template =
 {
 	.name          = "cx8800-video",
 	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_SCALES,
@@ -1933,7 +1933,7 @@
 	.minor         = -1,
 };
 
-struct video_device cx8800_vbi_template =
+static struct video_device cx8800_vbi_template =
 {
 	.name          = "cx8800-vbi",
 	.type          = VID_TYPE_TELETEXT|VID_TYPE_TUNER,
@@ -1951,7 +1951,7 @@
 	.llseek        = no_llseek,
 };
 
-struct video_device cx8800_radio_template =
+static struct video_device cx8800_radio_template =
 {
 	.name          = "cx8800-radio",
 	.type          = VID_TYPE_TUNER,
@@ -2226,7 +2226,7 @@
 
 /* ----------------------------------------------------------- */
 
-struct pci_device_id cx8800_pci_tbl[] = {
+static struct pci_device_id cx8800_pci_tbl[] = {
 	{
 		.vendor       = 0x14f1,
 		.device       = 0x8800,

