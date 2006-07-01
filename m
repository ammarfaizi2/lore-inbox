Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932896AbWGAPIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbWGAPIK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbWGAPHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:07:31 -0400
Received: from www.osadl.org ([213.239.205.134]:56740 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751899AbWGAO53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:29 -0400
Message-Id: <20060701145227.065417000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:58 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 33/44] media: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-media.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/media/common/saa7146_core.c        |    2 +-
 drivers/media/dvb/b2c2/flexcop-pci.c       |    2 +-
 drivers/media/dvb/bt8xx/bt878.c            |    2 +-
 drivers/media/dvb/pluto2/pluto2.c          |    2 +-
 drivers/media/video/bt8xx/bttv-driver.c    |    2 +-
 drivers/media/video/cx88/cx88-alsa.c       |    2 +-
 drivers/media/video/cx88/cx88-mpeg.c       |    2 +-
 drivers/media/video/cx88/cx88-video.c      |    2 +-
 drivers/media/video/meye.c                 |    2 +-
 drivers/media/video/saa7134/saa7134-alsa.c |    2 +-
 drivers/media/video/saa7134/saa7134-core.c |    2 +-
 drivers/media/video/saa7134/saa7134-oss.c  |    2 +-
 drivers/media/video/stradis.c              |    2 +-
 drivers/media/video/zoran_card.c           |    2 +-
 drivers/media/video/zr36120.c              |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

Index: linux-2.6.git/drivers/media/common/saa7146_core.c
===================================================================
--- linux-2.6.git.orig/drivers/media/common/saa7146_core.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/common/saa7146_core.c	2006-07-01 16:51:41.000000000 +0200
@@ -363,7 +363,7 @@ static int saa7146_init_one(struct pci_d
 	saa7146_write(dev, MC2, 0xf8000000);
 
 	/* request an interrupt for the saa7146 */
-	err = request_irq(pci->irq, interrupt_hw, SA_SHIRQ | SA_INTERRUPT,
+	err = request_irq(pci->irq, interrupt_hw, IRQF_SHARED | IRQF_DISABLED,
 			  dev->name, dev);
 	if (err < 0) {
 		ERR(("request_irq() failed.\n"));
Index: linux-2.6.git/drivers/media/dvb/b2c2/flexcop-pci.c
===================================================================
--- linux-2.6.git.orig/drivers/media/dvb/b2c2/flexcop-pci.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/dvb/b2c2/flexcop-pci.c	2006-07-01 16:51:41.000000000 +0200
@@ -294,7 +294,7 @@ static int flexcop_pci_init(struct flexc
 	pci_set_drvdata(fc_pci->pdev, fc_pci);
 
 	if ((ret = request_irq(fc_pci->pdev->irq, flexcop_pci_isr,
-					SA_SHIRQ, DRIVER_NAME, fc_pci)) != 0)
+					IRQF_SHARED, DRIVER_NAME, fc_pci)) != 0)
 		goto err_pci_iounmap;
 
 	spin_lock_init(&fc_pci->irq_lock);
Index: linux-2.6.git/drivers/media/dvb/bt8xx/bt878.c
===================================================================
--- linux-2.6.git.orig/drivers/media/dvb/bt8xx/bt878.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/dvb/bt8xx/bt878.c	2006-07-01 16:51:41.000000000 +0200
@@ -488,7 +488,7 @@ static int __devinit bt878_probe(struct 
 	btwrite(0, BT848_INT_MASK);
 
 	result = request_irq(bt->irq, bt878_irq,
-			     SA_SHIRQ | SA_INTERRUPT, "bt878",
+			     IRQF_SHARED | IRQF_DISABLED, "bt878",
 			     (void *) bt);
 	if (result == -EINVAL) {
 		printk(KERN_ERR "bt878(%d): Bad irq number or handler\n",
Index: linux-2.6.git/drivers/media/dvb/pluto2/pluto2.c
===================================================================
--- linux-2.6.git.orig/drivers/media/dvb/pluto2/pluto2.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/dvb/pluto2/pluto2.c	2006-07-01 16:51:41.000000000 +0200
@@ -616,7 +616,7 @@ static int __devinit pluto2_probe(struct
 
 	pci_set_drvdata(pdev, pluto);
 
-	ret = request_irq(pdev->irq, pluto_irq, SA_SHIRQ, DRIVER_NAME, pluto);
+	ret = request_irq(pdev->irq, pluto_irq, IRQF_SHARED, DRIVER_NAME, pluto);
 	if (ret < 0)
 		goto err_pci_iounmap;
 
Index: linux-2.6.git/drivers/media/video/meye.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/meye.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/meye.c	2006-07-01 16:51:41.000000000 +0200
@@ -1881,7 +1881,7 @@ static int __devinit meye_probe(struct p
 
 	meye.mchip_irq = pcidev->irq;
 	if (request_irq(meye.mchip_irq, meye_irq,
-			SA_INTERRUPT | SA_SHIRQ, "meye", meye_irq)) {
+			IRQF_DISABLED | IRQF_SHARED, "meye", meye_irq)) {
 		printk(KERN_ERR "meye: request_irq failed\n");
 		goto outreqirq;
 	}
Index: linux-2.6.git/drivers/media/video/stradis.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/stradis.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/stradis.c	2006-07-01 16:51:41.000000000 +0200
@@ -1983,7 +1983,7 @@ static int __devinit configure_saa7146(s
 	memcpy(&saa->video_dev, &saa_template, sizeof(saa_template));
 	saawrite(0, SAA7146_IER);	/* turn off all interrupts */
 
-	retval = request_irq(saa->irq, saa7146_irq, SA_SHIRQ | SA_INTERRUPT,
+	retval = request_irq(saa->irq, saa7146_irq, IRQF_SHARED | IRQF_DISABLED,
 		"stradis", saa);
 	if (retval == -EINVAL)
 		dev_err(&pdev->dev, "%d: Bad irq number or handler\n", num);
Index: linux-2.6.git/drivers/media/video/zoran_card.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/zoran_card.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/zoran_card.c	2006-07-01 16:51:41.000000000 +0200
@@ -1380,7 +1380,7 @@ find_zr36057 (void)
 
 		result = request_irq(zr->pci_dev->irq,
 				     zoran_irq,
-				     SA_SHIRQ | SA_INTERRUPT,
+				     IRQF_SHARED | IRQF_DISABLED,
 				     ZR_DEVNAME(zr),
 				     (void *) zr);
 		if (result < 0) {
Index: linux-2.6.git/drivers/media/video/zr36120.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/zr36120.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/zr36120.c	2006-07-01 16:51:41.000000000 +0200
@@ -1858,7 +1858,7 @@ int __init find_zoran(void)
 		DEBUG(printk(KERN_DEBUG "zoran: mapped-memory at 0x%p\n",ztv->zoran_mem));
 
 		result = request_irq(dev->irq, zoran_irq,
-			SA_SHIRQ|SA_INTERRUPT,"zoran", ztv);
+			IRQF_SHARED|IRQF_DISABLED,"zoran", ztv);
 		if (result==-EINVAL)
 		{
 			iounmap(ztv->zoran_mem);
Index: linux-2.6.git/drivers/media/video/bt8xx/bttv-driver.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/bt8xx/bttv-driver.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/bt8xx/bttv-driver.c	2006-07-01 16:51:41.000000000 +0200
@@ -4050,7 +4050,7 @@ static int __devinit bttv_probe(struct p
 	/* disable irqs, register irq handler */
 	btwrite(0, BT848_INT_MASK);
 	result = request_irq(btv->c.pci->irq, bttv_irq,
-			     SA_SHIRQ | SA_INTERRUPT,btv->c.name,(void *)btv);
+			     IRQF_SHARED | IRQF_DISABLED,btv->c.name,(void *)btv);
 	if (result < 0) {
 		printk(KERN_ERR "bttv%d: can't get IRQ %d\n",
 		       bttv_num,btv->c.pci->irq);
Index: linux-2.6.git/drivers/media/video/cx88/cx88-alsa.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/cx88/cx88-alsa.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/cx88/cx88-alsa.c	2006-07-01 16:51:41.000000000 +0200
@@ -700,7 +700,7 @@ static int __devinit snd_cx88_create(str
 
 	/* get irq */
 	err = request_irq(chip->pci->irq, cx8801_irq,
-			  SA_SHIRQ | SA_INTERRUPT, chip->core->name, chip);
+			  IRQF_SHARED | IRQF_DISABLED, chip->core->name, chip);
 	if (err < 0) {
 		dprintk(0, "%s: can't get IRQ %d\n",
 		       chip->core->name, chip->pci->irq);
Index: linux-2.6.git/drivers/media/video/cx88/cx88-mpeg.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/cx88/cx88-mpeg.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/cx88/cx88-mpeg.c	2006-07-01 16:51:41.000000000 +0200
@@ -438,7 +438,7 @@ int cx8802_init_common(struct cx8802_dev
 
 	/* get irq */
 	err = request_irq(dev->pci->irq, cx8802_irq,
-			  SA_SHIRQ | SA_INTERRUPT, dev->core->name, dev);
+			  IRQF_SHARED | IRQF_DISABLED, dev->core->name, dev);
 	if (err < 0) {
 		printk(KERN_ERR "%s: can't get IRQ %d\n",
 		       dev->core->name, dev->pci->irq);
Index: linux-2.6.git/drivers/media/video/cx88/cx88-video.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/cx88/cx88-video.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/cx88/cx88-video.c	2006-07-01 16:51:41.000000000 +0200
@@ -1915,7 +1915,7 @@ static int __devinit cx8800_initdev(stru
 
 	/* get irq */
 	err = request_irq(pci_dev->irq, cx8800_irq,
-			  SA_SHIRQ | SA_INTERRUPT, core->name, dev);
+			  IRQF_SHARED | IRQF_DISABLED, core->name, dev);
 	if (err < 0) {
 		printk(KERN_ERR "%s: can't get IRQ %d\n",
 		       core->name,pci_dev->irq);
Index: linux-2.6.git/drivers/media/video/saa7134/saa7134-alsa.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/saa7134/saa7134-alsa.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/saa7134/saa7134-alsa.c	2006-07-01 16:51:41.000000000 +0200
@@ -929,7 +929,7 @@ static int alsa_card_saa7134_create(stru
 
 
 	err = request_irq(dev->pci->irq, saa7134_alsa_irq,
-				SA_SHIRQ | SA_INTERRUPT, dev->name,
+				IRQF_SHARED | IRQF_DISABLED, dev->name,
 				(void*) &dev->dmasound);
 
 	if (err < 0) {
Index: linux-2.6.git/drivers/media/video/saa7134/saa7134-core.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/saa7134/saa7134-core.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/saa7134/saa7134-core.c	2006-07-01 16:51:41.000000000 +0200
@@ -923,7 +923,7 @@ static int __devinit saa7134_initdev(str
 
 	/* get irq */
 	err = request_irq(pci_dev->irq, saa7134_irq,
-			  SA_SHIRQ | SA_INTERRUPT, dev->name, dev);
+			  IRQF_SHARED | IRQF_DISABLED, dev->name, dev);
 	if (err < 0) {
 		printk(KERN_ERR "%s: can't get IRQ %d\n",
 		       dev->name,pci_dev->irq);
Index: linux-2.6.git/drivers/media/video/saa7134/saa7134-oss.c
===================================================================
--- linux-2.6.git.orig/drivers/media/video/saa7134/saa7134-oss.c	2006-07-01 16:51:17.000000000 +0200
+++ linux-2.6.git/drivers/media/video/saa7134/saa7134-oss.c	2006-07-01 16:51:41.000000000 +0200
@@ -845,7 +845,7 @@ int saa7134_oss_init1(struct saa7134_dev
 {
 
 	if ((request_irq(dev->pci->irq, saa7134_oss_irq,
-			 SA_SHIRQ | SA_INTERRUPT, dev->name,
+			 IRQF_SHARED | IRQF_DISABLED, dev->name,
 			(void*) &dev->dmasound)) < 0)
 		return -1;
 

--

