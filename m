Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWCWUEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWCWUEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWCWUEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:04:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59273 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964907AbWCWUEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:04:11 -0500
Date: Thu, 23 Mar 2006 15:03:42 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 4/10] 64 bit resources drivers media changes
Message-ID: <20060323200342.GH7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200227.GG7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required under drivers/media/* for 64bit resources.

Signed-off-by: Murali M Chakravarthy <muralim@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/media/video/bttv-driver.c          |   10 ++++++----
 drivers/media/video/cx88/cx88-alsa.c       |    8 ++++----
 drivers/media/video/cx88/cx88-core.c       |    4 ++--
 drivers/media/video/cx88/cx88-mpeg.c       |    4 ++--
 drivers/media/video/cx88/cx88-video.c      |    4 ++--
 drivers/media/video/saa7134/saa7134-core.c |    8 ++++----
 6 files changed, 20 insertions(+), 18 deletions(-)

diff -puN drivers/media/video/cx88/cx88-alsa.c~64bit-resources-drivers-media-chages drivers/media/video/cx88/cx88-alsa.c
--- linux-2.6.16-mm1/drivers/media/video/cx88/cx88-alsa.c~64bit-resources-drivers-media-chages	2006-03-23 11:39:04.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/media/video/cx88/cx88-alsa.c	2006-03-23 11:39:04.000000000 -0500
@@ -713,9 +713,9 @@ static int __devinit snd_cx88_create(str
 	pci_read_config_byte(pci, PCI_LATENCY_TIMER,  &chip->pci_lat);
 
 	dprintk(1,"ALSA %s/%i: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", core->name, devno,
+	       "latency: %d, mmio: 0x%llx\n", core->name, devno,
 	       pci_name(pci), chip->pci_rev, pci->irq,
-	       chip->pci_lat,pci_resource_start(pci,0));
+	       chip->pci_lat,(unsigned long long)pci_resource_start(pci,0));
 
 	chip->irq = pci->irq;
 	synchronize_irq(chip->irq);
@@ -767,8 +767,8 @@ static int __devinit cx88_audio_initdev(
 
 	strcpy (card->driver, "CX88x");
 	sprintf(card->shortname, "Conexant CX%x", pci->device);
-	sprintf(card->longname, "%s at %#lx",
-		card->shortname, pci_resource_start(pci, 0));
+	sprintf(card->longname, "%s at %#llx",
+		card->shortname,(unsigned long long)pci_resource_start(pci, 0));
 	strcpy (card->mixername, "CX88");
 
 	dprintk (0, "%s/%i: ALSA support for cx2388x boards\n",
diff -puN drivers/media/video/cx88/cx88-core.c~64bit-resources-drivers-media-chages drivers/media/video/cx88/cx88-core.c
--- linux-2.6.16-mm1/drivers/media/video/cx88/cx88-core.c~64bit-resources-drivers-media-chages	2006-03-23 11:39:04.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/media/video/cx88/cx88-core.c	2006-03-23 11:39:04.000000000 -0500
@@ -1027,8 +1027,8 @@ static int get_ressources(struct cx88_co
 			       pci_resource_len(pci,0),
 			       core->name))
 		return 0;
-	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%lx\n",
-	       core->name,pci_resource_start(pci,0));
+	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx\n",
+	       core->name,(unsigned long long)pci_resource_start(pci,0));
 	return -EBUSY;
 }
 
diff -puN drivers/media/video/cx88/cx88-mpeg.c~64bit-resources-drivers-media-chages drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.16-mm1/drivers/media/video/cx88/cx88-mpeg.c~64bit-resources-drivers-media-chages	2006-03-23 11:39:04.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/media/video/cx88/cx88-mpeg.c	2006-03-23 11:39:04.000000000 -0500
@@ -386,9 +386,9 @@ int cx8802_init_common(struct cx8802_dev
 	pci_read_config_byte(dev->pci, PCI_CLASS_REVISION, &dev->pci_rev);
 	pci_read_config_byte(dev->pci, PCI_LATENCY_TIMER,  &dev->pci_lat);
 	printk(KERN_INFO "%s/2: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", dev->core->name,
+	       "latency: %d, mmio: 0x%llx\n", dev->core->name,
 	       pci_name(dev->pci), dev->pci_rev, dev->pci->irq,
-	       dev->pci_lat,pci_resource_start(dev->pci,0));
+	       dev->pci_lat,(unsigned long long)pci_resource_start(dev->pci,0));
 
 	/* initialize driver struct */
 	spin_lock_init(&dev->slock);
diff -puN drivers/media/video/cx88/cx88-video.c~64bit-resources-drivers-media-chages drivers/media/video/cx88/cx88-video.c
--- linux-2.6.16-mm1/drivers/media/video/cx88/cx88-video.c~64bit-resources-drivers-media-chages	2006-03-23 11:39:04.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/media/video/cx88/cx88-video.c	2006-03-23 11:39:04.000000000 -0500
@@ -1828,9 +1828,9 @@ static int __devinit cx8800_initdev(stru
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
 	pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
 	printk(KERN_INFO "%s/0: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", core->name,
+	       "latency: %d, mmio: 0x%llx\n", core->name,
 	       pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-	       dev->pci_lat,pci_resource_start(pci_dev,0));
+	       dev->pci_lat,(unsigned long long)pci_resource_start(pci_dev,0));
 
 	pci_set_master(pci_dev);
 	if (!pci_dma_supported(pci_dev,0xffffffff)) {
diff -puN drivers/media/video/saa7134/saa7134-core.c~64bit-resources-drivers-media-chages drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.16-mm1/drivers/media/video/saa7134/saa7134-core.c~64bit-resources-drivers-media-chages	2006-03-23 11:39:04.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/media/video/saa7134/saa7134-core.c	2006-03-23 11:39:04.000000000 -0500
@@ -866,9 +866,9 @@ static int __devinit saa7134_initdev(str
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
 	pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
 	printk(KERN_INFO "%s: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", dev->name,
+	       "latency: %d, mmio: 0x%llx\n", dev->name,
 	       pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-	       dev->pci_lat,pci_resource_start(pci_dev,0));
+	       dev->pci_lat,(unsigned long long)pci_resource_start(pci_dev,0));
 	pci_set_master(pci_dev);
 	if (!pci_dma_supported(pci_dev,0xffffffff)) {
 		printk("%s: Oops: no 32bit PCI DMA ???\n",dev->name);
@@ -900,8 +900,8 @@ static int __devinit saa7134_initdev(str
 				pci_resource_len(pci_dev,0),
 				dev->name)) {
 		err = -EBUSY;
-		printk(KERN_ERR "%s: can't get MMIO memory @ 0x%lx\n",
-		       dev->name,pci_resource_start(pci_dev,0));
+		printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx\n",
+		       dev->name,(unsigned long long)pci_resource_start(pci_dev,0));
 		goto fail1;
 	}
 	dev->lmmio = ioremap(pci_resource_start(pci_dev,0), 0x1000);
diff -puN drivers/media/video/bttv-driver.c~64bit-resources-drivers-media-chages drivers/media/video/bttv-driver.c
--- linux-2.6.16-mm1/drivers/media/video/bttv-driver.c~64bit-resources-drivers-media-chages	2006-03-23 11:39:04.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/media/video/bttv-driver.c	2006-03-23 11:39:04.000000000 -0500
@@ -3956,8 +3956,9 @@ static int __devinit bttv_probe(struct p
 	if (!request_mem_region(pci_resource_start(dev,0),
 				pci_resource_len(dev,0),
 				btv->c.name)) {
-		printk(KERN_WARNING "bttv%d: can't request iomem (0x%lx).\n",
-		       btv->c.nr, pci_resource_start(dev,0));
+		printk(KERN_WARNING "bttv%d: can't request iomem (0x%llx).\n",
+		       btv->c.nr,
+		       (unsigned long long)pci_resource_start(dev,0));
 		return -EBUSY;
 	}
 	pci_set_master(dev);
@@ -3968,8 +3969,9 @@ static int __devinit bttv_probe(struct p
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
 	printk(KERN_INFO "bttv%d: Bt%d (rev %d) at %s, ",
 	       bttv_num,btv->id, btv->revision, pci_name(dev));
-	printk("irq: %d, latency: %d, mmio: 0x%lx\n",
-	       btv->c.pci->irq, lat, pci_resource_start(dev,0));
+	printk("irq: %d, latency: %d, mmio: 0x%llx\n",
+	       btv->c.pci->irq, lat,
+	       (unsigned long long)pci_resource_start(dev,0));
 	schedule();
 
 	btv->bt848_mmio=ioremap(pci_resource_start(dev,0), 0x1000);
_
