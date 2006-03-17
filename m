Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932837AbWCQXCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbWCQXCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbWCQXBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:01:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932838AbWCQXBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:01:16 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Eric Sesterhenn <snakebyte@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/21] BUG_ON() Conversion in drivers/video/media
Date: Fri, 17 Mar 2006 17:54:35 -0300
Message-id: <20060317205435.PS48214700010@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric Sesterhenn <snakebyte@gmx.de>
Date: 1142266631 \-0300

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/common/saa7146_core.c               |    3 +--
 drivers/media/common/saa7146_fops.c               |    6 ++----
 drivers/media/dvb/ttpci/av7110.c                  |    6 ++----
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    3 +--
 drivers/media/video/bttv-risc.c                   |    3 +--
 drivers/media/video/cx88/cx88-core.c              |    3 +--
 drivers/media/video/cx88/cx88-video.c             |    3 +--
 drivers/media/video/saa7134/saa7134-alsa.c        |    3 +--
 drivers/media/video/saa7134/saa7134-core.c        |    3 +--
 drivers/media/video/saa7134/saa7134-oss.c         |    6 ++----
 drivers/media/video/saa7134/saa7134-video.c       |    3 +--
 drivers/media/video/video-buf.c                   |    3 +--
 12 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/media/common/saa7146_core.c b/drivers/media/common/saa7146_core.c
index 04c1938..98c4322 100644
--- a/drivers/media/common/saa7146_core.c
+++ b/drivers/media/common/saa7146_core.c
@@ -116,8 +116,7 @@ static struct scatterlist* vmalloc_to_sg
 		pg = vmalloc_to_page(virt);
 		if (NULL == pg)
 			goto err;
-		if (PageHighMem(pg))
-			BUG();
+		BUG_ON(PageHighMem(pg));
 		sglist[i].page   = pg;
 		sglist[i].length = PAGE_SIZE;
 	}
diff --git a/drivers/media/common/saa7146_fops.c b/drivers/media/common/saa7146_fops.c
index f8cf73e..c53fd69 100644
--- a/drivers/media/common/saa7146_fops.c
+++ b/drivers/media/common/saa7146_fops.c
@@ -37,8 +37,7 @@ void saa7146_res_free(struct saa7146_fh 
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	if ((fh->resources & bits) != bits)
-		BUG();
+	BUG_ON((fh->resources & bits) != bits);
 
 	down(&dev->lock);
 	fh->resources  &= ~bits;
@@ -55,8 +54,7 @@ void saa7146_dma_free(struct saa7146_dev
 {
 	DEB_EE(("dev:%p, buf:%p\n",dev,buf));
 
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	videobuf_waiton(&buf->vb,0,0);
 	videobuf_dma_pci_unmap(dev->pci, &buf->vb.dma);
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 7c6ccb9..d5ef440 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -1088,11 +1088,9 @@ static int dvb_get_stc(struct dmx_demux 
 	struct av7110 *av7110;
 
 	/* pointer casting paranoia... */
-	if (!demux)
-		BUG();
+	BUG_ON(!demux);
 	dvbdemux = (struct dvb_demux *) demux->priv;
-	if (!dvbdemux)
-		BUG();
+	BUG_ON(!dvbdemux);
 	av7110 = (struct av7110 *) dvbdemux->priv;
 
 	dprintk(4, "%p\n", av7110);
diff --git a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
index 5a13c47..182b68b 100644
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -689,8 +689,7 @@ static void ttusb_process_frame(struct t
 				memcpy(ttusb->muxpack + ttusb->muxpack_ptr,
 				       data, avail);
 				ttusb->muxpack_ptr += avail;
-				if (ttusb->muxpack_ptr > 264)
-					BUG();
+				BUG_ON(ttusb->muxpack_ptr > 264);
 				data += avail;
 				len -= avail;
 				/* determine length */
diff --git a/drivers/media/video/bttv-risc.c b/drivers/media/video/bttv-risc.c
index af66a8d..952f1be 100644
--- a/drivers/media/video/bttv-risc.c
+++ b/drivers/media/video/bttv-risc.c
@@ -509,8 +509,7 @@ bttv_risc_hook(struct bttv *btv, int slo
 void
 bttv_dma_free(struct bttv *btv, struct bttv_buffer *buf)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	videobuf_waiton(&buf->vb,0,0);
 	videobuf_dma_pci_unmap(btv->c.pci, &buf->vb.dma);
 	videobuf_dma_free(&buf->vb.dma);
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index 3720f24..db3882b 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -215,8 +215,7 @@ int cx88_risc_stopper(struct pci_dev *pc
 void
 cx88_free_buffer(struct pci_dev *pci, struct cx88_buffer *buf)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	videobuf_waiton(&buf->vb,0,0);
 	videobuf_dma_pci_unmap(pci, &buf->vb.dma);
 	videobuf_dma_free(&buf->vb.dma);
diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index 39328bb..5f69980 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -366,8 +366,7 @@ static
 void res_free(struct cx8800_dev *dev, struct cx8800_fh *fh, unsigned int bits)
 {
 	struct cx88_core *core = dev->core;
-	if ((fh->resources & bits) != bits)
-		BUG();
+	BUG_ON((fh->resources & bits) != bits);
 
 	down(&core->lock);
 	fh->resources  &= ~bits;
diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
index 7df5e08..900541f 100644
--- a/drivers/media/video/saa7134/saa7134-alsa.c
+++ b/drivers/media/video/saa7134/saa7134-alsa.c
@@ -308,8 +308,7 @@ static int dsp_buffer_init(struct saa713
 
 static int dsp_buffer_free(struct saa7134_dev *dev)
 {
-	if (!dev->dmasound.blksize)
-		BUG();
+	BUG_ON(!dev->dmasound.blksize);
 
 	videobuf_dma_free(&dev->dmasound.dma);
 
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 996b5ee..3880234 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -256,8 +256,7 @@ void saa7134_pgtable_free(struct pci_dev
 
 void saa7134_dma_free(struct saa7134_dev *dev,struct saa7134_buf *buf)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	videobuf_waiton(&buf->vb,0,0);
 	videobuf_dma_pci_unmap(dev->pci, &buf->vb.dma);
diff --git a/drivers/media/video/saa7134/saa7134-oss.c b/drivers/media/video/saa7134/saa7134-oss.c
index 7448e38..1667d51 100644
--- a/drivers/media/video/saa7134/saa7134-oss.c
+++ b/drivers/media/video/saa7134/saa7134-oss.c
@@ -84,8 +84,7 @@ static int dsp_buffer_init(struct saa713
 {
 	int err;
 
-	if (!dev->dmasound.bufsize)
-		BUG();
+	BUG_ON(!dev->dmasound.bufsize);
 	videobuf_dma_init(&dev->dmasound.dma);
 	err = videobuf_dma_init_kernel(&dev->dmasound.dma, PCI_DMA_FROMDEVICE,
 				       (dev->dmasound.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
@@ -96,8 +95,7 @@ static int dsp_buffer_init(struct saa713
 
 static int dsp_buffer_free(struct saa7134_dev *dev)
 {
-	if (!dev->dmasound.blksize)
-		BUG();
+	BUG_ON(!dev->dmasound.blksize);
 	videobuf_dma_free(&dev->dmasound.dma);
 	dev->dmasound.blocks  = 0;
 	dev->dmasound.blksize = 0;
diff --git a/drivers/media/video/saa7134/saa7134-video.c b/drivers/media/video/saa7134/saa7134-video.c
index e97426b..e0480ea 100644
--- a/drivers/media/video/saa7134/saa7134-video.c
+++ b/drivers/media/video/saa7134/saa7134-video.c
@@ -489,8 +489,7 @@ int res_locked(struct saa7134_dev *dev, 
 static
 void res_free(struct saa7134_dev *dev, struct saa7134_fh *fh, unsigned int bits)
 {
-	if ((fh->resources & bits) != bits)
-		BUG();
+	BUG_ON((fh->resources & bits) != bits);
 
 	down(&dev->lock);
 	fh->resources  &= ~bits;
diff --git a/drivers/media/video/video-buf.c b/drivers/media/video/video-buf.c
index 9ef4775..ced1419 100644
--- a/drivers/media/video/video-buf.c
+++ b/drivers/media/video/video-buf.c
@@ -59,8 +59,7 @@ videobuf_vmalloc_to_sg(unsigned char *vi
 		pg = vmalloc_to_page(virt);
 		if (NULL == pg)
 			goto err;
-		if (PageHighMem(pg))
-			BUG();
+		BUG_ON(PageHighMem(pg));
 		sglist[i].page   = pg;
 		sglist[i].length = PAGE_SIZE;
 	}

