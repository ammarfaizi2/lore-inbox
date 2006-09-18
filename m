Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbWIRAxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWIRAxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWIRAxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:53:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965189AbWIRAxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:53:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YhUOLWaT5EcO+/04cbMAjwjZAOfegyM+7XQKT2UvocjIjXdQhef7n3iKsfrjRgi7UnLDGM0J/M09sYiDqrOPZjssP5nuw5uyM1+Kf4oO0hi1JGAWr4KYSsytRzGGrcEzyshPc4SW8kJfnkWu1GCFnCDT8FqbzuFAsfWdZQH5yMU=
Message-ID: <6b4e42d10609171753i63697c8et3e6e1c5706b60d5f@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:53:49 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-atm-general@lists.sourceforge.net
Subject: kmalloc to kzalloc patches for drivers/atm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by compiling.

I have not subscribed to ATM list. Please cc me any comments.

Signed off by Om Narasimhan <om.turyx@gmail.com>

 drivers/atm/adummy.c     |    4 +---
 drivers/atm/atmtcp.c     |    2 +-
 drivers/atm/firestream.c |   13 +++----------
 drivers/atm/he.c         |    6 ++----
 drivers/atm/horizon.c    |    6 ++----
 drivers/atm/idt77105.c   |    2 +-
 drivers/atm/idt77252.c   |   21 ++++++---------------
 drivers/atm/iphase.c     |   22 ++++++++++------------
 drivers/atm/lanai.c      |   10 ++--------
 drivers/atm/nicstar.c    |   12 ++++++------
 drivers/atm/suni.c       |    2 +-
 drivers/atm/uPD98402.c   |    2 +-
 drivers/atm/zatm.c       |   12 +++++-------
 13 files changed, 41 insertions(+), 73 deletions(-)

diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
index 6cc93de..a3c3f3b 100644
--- a/drivers/atm/adummy.c
+++ b/drivers/atm/adummy.c
@@ -113,15 +113,13 @@ static int __init adummy_init(void)

 	printk(KERN_ERR "adummy: version %s\n", DRV_VERSION);

-	adummy_dev = (struct adummy_dev *) kmalloc(sizeof(struct adummy_dev),
+	adummy_dev = (struct adummy_dev *) kzalloc(sizeof(struct adummy_dev),
 						   GFP_KERNEL);
 	if (!adummy_dev) {
 		printk(KERN_ERR DEV_LABEL ": kmalloc() failed\n");
 		err = -ENOMEM;
 		goto out;
 	}
-	memset(adummy_dev, 0, sizeof(struct adummy_dev));
-
 	atm_dev = atm_dev_register(DEV_LABEL, &adummy_ops, -1, NULL);
 	if (!atm_dev) {
 		printk(KERN_ERR DEV_LABEL ": atm_dev_register() failed\n");
diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index fc518d8..35dedb5 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -361,7 +361,7 @@ static int atmtcp_create(int itf,int per
 	struct atmtcp_dev_data *dev_data;
 	struct atm_dev *dev;

-	dev_data = kmalloc(sizeof(*dev_data),GFP_KERNEL);
+	dev_data = kzalloc(sizeof(*dev_data),GFP_KERNEL);
 	if (!dev_data)
 		return -ENOMEM;

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 38fc054..fafcdb2 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1784,7 +1784,7 @@ static int __devinit fs_init (struct fs_
 		write_fs (dev, RAM, (1 << (28 - FS155_VPI_BITS - FS155_VCI_BITS)) - 1);
 		dev->nchannels = FS155_NR_CHANNELS;
 	}
-	dev->atm_vccs = kmalloc (dev->nchannels * sizeof (struct atm_vcc *),
+	dev->atm_vccs = kzalloc (dev->nchannels * sizeof (struct atm_vcc *),
 				 GFP_KERNEL);
 	fs_dprintk (FS_DEBUG_ALLOC, "Alloc atmvccs: %p(%Zd)\n",
 		    dev->atm_vccs, dev->nchannels * sizeof (struct atm_vcc *));
@@ -1794,9 +1794,7 @@ static int __devinit fs_init (struct fs_
 		/* XXX Clean up..... */
 		return 1;
 	}
-	memset (dev->atm_vccs, 0, dev->nchannels * sizeof (struct atm_vcc *));
-
-	dev->tx_inuse = kmalloc (dev->nchannels / 8 /* bits/byte */ , GFP_KERNEL);
+	dev->tx_inuse = kzalloc (dev->nchannels / 8 /* bits/byte */ , GFP_KERNEL);
 	fs_dprintk (FS_DEBUG_ALLOC, "Alloc tx_inuse: %p(%d)\n",
 		    dev->atm_vccs, dev->nchannels / 8);

@@ -1805,8 +1803,6 @@ static int __devinit fs_init (struct fs_
 		/* XXX Clean up..... */
 		return 1;
 	}
-	memset (dev->tx_inuse, 0, dev->nchannels / 8);
-
 	/* -- RAS1 : FS155 and 50 differ. Default (0) should be OK for both */
 	/* -- RAS2 : FS50 only: Default is OK. */

@@ -1893,14 +1889,11 @@ static int __devinit firestream_init_one
 	if (pci_enable_device(pci_dev))
 		goto err_out;

-	fs_dev = kmalloc (sizeof (struct fs_dev), GFP_KERNEL);
+	fs_dev = kzalloc (sizeof (struct fs_dev), GFP_KERNEL);
 	fs_dprintk (FS_DEBUG_ALLOC, "Alloc fs-dev: %p(%Zd)\n",
 		    fs_dev, sizeof (struct fs_dev));
 	if (!fs_dev)
 		goto err_out;
-
-	memset (fs_dev, 0, sizeof (struct fs_dev));
-
 	atm_dev = atm_dev_register("fs", &ops, -1, NULL);
 	if (!atm_dev)
 		goto err_out_free_fs_dev;
diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index d369130..7e92a6f 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -383,14 +383,12 @@ he_init_one(struct pci_dev *pci_dev, con
 	}
 	pci_set_drvdata(pci_dev, atm_dev);

-	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
+	he_dev = (struct he_dev *) kzalloc(sizeof(struct he_dev),
 							GFP_KERNEL);
 	if (!he_dev) {
 		err = -ENOMEM;
 		goto init_one_failure;
 	}
-	memset(he_dev, 0, sizeof(struct he_dev));
-
 	he_dev->pci_dev = pci_dev;
 	he_dev->atm_dev = atm_dev;
 	he_dev->atm_dev->dev_data = he_dev;
@@ -675,7 +673,7 @@ he_init_cs_block_rcm(struct he_dev *he_d
 	unsigned long long rate_cps;
 	int mult, buf, buf_limit = 4;

-	rategrid = kmalloc( sizeof(unsigned) * 16 * 16, GFP_KERNEL);
+	rategrid = kzalloc( sizeof(unsigned) * 16 * 16, GFP_KERNEL);
 	if (!rategrid)
 		return -ENOMEM;

diff --git a/drivers/atm/horizon.c b/drivers/atm/horizon.c
index d1113e8..e993a4f 100644
--- a/drivers/atm/horizon.c
+++ b/drivers/atm/horizon.c
@@ -2457,7 +2457,7 @@ #endif
   }

   // get space for our vcc stuff and copy parameters into it
-  vccp = kmalloc (sizeof(hrz_vcc), GFP_KERNEL);
+  vccp = kzalloc (sizeof(hrz_vcc), GFP_KERNEL);
   if (!vccp) {
     PRINTK (KERN_ERR, "out of memory!");
     return -ENOMEM;
@@ -2719,7 +2719,7 @@ static int __devinit hrz_probe(struct pc
 		goto out_disable;
 	}

-	dev = kmalloc(sizeof(hrz_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(hrz_dev), GFP_KERNEL);
 	if (!dev) {
 		// perhaps we should be nice: deregister all adapters and abort?
 		PRINTD(DBG_ERR, "out of memory");
@@ -2727,8 +2727,6 @@ static int __devinit hrz_probe(struct pc
 		goto out_release;
 	}

-	memset(dev, 0, sizeof(hrz_dev));
-
 	pci_set_drvdata(pci_dev, dev);

 	// grab IRQ and install handler - move this someplace more sensible
diff --git a/drivers/atm/idt77105.c b/drivers/atm/idt77105.c
index 325325a..44644df 100644
--- a/drivers/atm/idt77105.c
+++ b/drivers/atm/idt77105.c
@@ -262,7 +262,7 @@ static int idt77105_start(struct atm_dev
 {
 	unsigned long flags;

-	if (!(dev->dev_data = kmalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
+	if (!(dev->dev_data = kzalloc(sizeof(struct idt77105_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	PRIV(dev)->dev = dev;
 	spin_lock_irqsave(&idt77105_priv_lock, flags);
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index b0369bb..d4c9ad2 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -642,11 +642,9 @@ alloc_scq(struct idt77252_dev *card, int
 {
 	struct scq_info *scq;

-	scq = (struct scq_info *) kmalloc(sizeof(struct scq_info), GFP_KERNEL);
+	scq = (struct scq_info *) kzalloc(sizeof(struct scq_info), GFP_KERNEL);
 	if (!scq)
 		return NULL;
-	memset(scq, 0, sizeof(struct scq_info));
-
 	scq->base = pci_alloc_consistent(card->pcidev, SCQ_SIZE,
 					 &scq->paddr);
 	if (scq->base == NULL) {
@@ -2142,11 +2140,9 @@ idt77252_init_est(struct vc_map *vc, int
 {
 	struct rate_estimator *est;

-	est = kmalloc(sizeof(struct rate_estimator), GFP_KERNEL);
+	est = kzalloc(sizeof(struct rate_estimator), GFP_KERNEL);
 	if (!est)
 		return NULL;
-	memset(est, 0, sizeof(*est));
-
 	est->maxcps = pcr < 0 ? -pcr : pcr;
 	est->cps = est->maxcps;
 	est->avcps = est->cps << 5;
@@ -2451,7 +2447,7 @@ idt77252_open(struct atm_vcc *vcc)

 	index = VPCI2VC(card, vpi, vci);
 	if (!card->vcs[index]) {
-		card->vcs[index] = kmalloc(sizeof(struct vc_map), GFP_KERNEL);
+		card->vcs[index] = kzalloc(sizeof(struct vc_map), GFP_KERNEL);
 		if (!card->vcs[index]) {
 			printk("%s: can't alloc vc in open()\n", card->name);
 			up(&card->mutex);
@@ -2926,13 +2922,11 @@ open_card_oam(struct idt77252_dev *card)
 		for (vci = 3; vci < 5; vci++) {
 			index = VPCI2VC(card, vpi, vci);

-			vc = kmalloc(sizeof(struct vc_map), GFP_KERNEL);
+			vc = kzalloc(sizeof(struct vc_map), GFP_KERNEL);
 			if (!vc) {
 				printk("%s: can't alloc vc\n", card->name);
 				return -ENOMEM;
 			}
-			memset(vc, 0, sizeof(struct vc_map));
-
 			vc->index = index;
 			card->vcs[index] = vc;

@@ -2995,12 +2989,11 @@ open_card_ubr0(struct idt77252_dev *card
 {
 	struct vc_map *vc;

-	vc = kmalloc(sizeof(struct vc_map), GFP_KERNEL);
+	vc = kzalloc(sizeof(struct vc_map), GFP_KERNEL);
 	if (!vc) {
 		printk("%s: can't alloc vc\n", card->name);
 		return -ENOMEM;
 	}
-	memset(vc, 0, sizeof(struct vc_map));
 	card->vcs[0] = vc;
 	vc->class = SCHED_UBR0;

@@ -3695,14 +3688,12 @@ idt77252_init_one(struct pci_dev *pcidev
 		goto err_out_disable_pdev;
 	}

-	card = kmalloc(sizeof(struct idt77252_dev), GFP_KERNEL);
+	card = kzalloc(sizeof(struct idt77252_dev), GFP_KERNEL);
 	if (!card) {
 		printk("idt77252-%d: can't allocate private data\n", index);
 		err = -ENOMEM;
 		goto err_out_disable_pdev;
 	}
-	memset(card, 0, sizeof(struct idt77252_dev));
-
 	card->revision = revision;
 	card->index = index;
 	card->pcidev = pcidev;
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index f20b0b2..a84e238 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -118,7 +118,7 @@ static void ia_enque_head_rtn_q (IARTN_Q
 }

 static int ia_enque_rtn_q (IARTN_Q *que, struct desc_tbl_t data) {
-   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+   IARTN_Q *entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
    if (!entry) return -1;
    entry->data = data;
    entry->next = NULL;
@@ -1601,14 +1601,13 @@ static int rx_init(struct atm_dev *dev)

 	skb_queue_head_init(&iadev->rx_dma_q);
 	iadev->rx_free_desc_qhead = NULL;
-	iadev->rx_open = kmalloc(4*iadev->num_vc,GFP_KERNEL);
+	iadev->rx_open = kzalloc(4*iadev->num_vc,GFP_KERNEL);
 	if (!iadev->rx_open)
 	{
 		printk(KERN_ERR DEV_LABEL "itf %d couldn't get free page\n",
 		dev->number);
 		goto err_free_dle;
 	}
-	memset(iadev->rx_open, 0, 4*iadev->num_vc);
         iadev->rxing = 1;
         iadev->rx_pkt_cnt = 0;
 	/* Mode Register */
@@ -1959,7 +1958,7 @@ static int tx_init(struct atm_dev *dev)
 		buf_desc_ptr++;		
 		tx_pkt_start += iadev->tx_buf_sz;
 	}
-        iadev->tx_buf = kmalloc(iadev->num_tx_desc*sizeof(struct
cpcs_trailer_desc), GFP_KERNEL);
+        iadev->tx_buf = kzalloc(iadev->num_tx_desc*sizeof(struct
cpcs_trailer_desc), GFP_KERNEL);
         if (!iadev->tx_buf) {
             printk(KERN_ERR DEV_LABEL " couldn't get mem\n");
 	    goto err_free_dle;
@@ -1968,7 +1967,7 @@ static int tx_init(struct atm_dev *dev)
        	{
 	    struct cpcs_trailer *cpcs;

-       	    cpcs = kmalloc(sizeof(*cpcs), GFP_KERNEL|GFP_DMA);
+       	    cpcs = kzalloc(sizeof(*cpcs), GFP_KERNEL|GFP_DMA);
             if(!cpcs) {
 		printk(KERN_ERR DEV_LABEL " couldn't get freepage\n");
 		goto err_free_tx_bufs;
@@ -1977,7 +1976,7 @@ static int tx_init(struct atm_dev *dev)
 	    iadev->tx_buf[i].dma_addr = pci_map_single(iadev->pci,
 		cpcs, sizeof(*cpcs), PCI_DMA_TODEVICE);
         }
-        iadev->desc_tbl = kmalloc(iadev->num_tx_desc *
+        iadev->desc_tbl = kzalloc(iadev->num_tx_desc *
                                    sizeof(struct desc_tbl_t), GFP_KERNEL);
 	if (!iadev->desc_tbl) {
 		printk(KERN_ERR DEV_LABEL " couldn't get mem\n");
@@ -2106,7 +2105,7 @@ #endif
 	memset((caddr_t)(iadev->seg_ram+i),  0, iadev->num_vc*4);
 	vc = (struct main_vc *)iadev->MAIN_VC_TABLE_ADDR;
 	evc = (struct ext_vc *)iadev->EXT_VC_TABLE_ADDR;
-        iadev->testTable = kmalloc(sizeof(long)*iadev->num_vc, GFP_KERNEL);
+        iadev->testTable = kzalloc(sizeof(long)*iadev->num_vc, GFP_KERNEL);
         if (!iadev->testTable) {
            printk("Get freepage  failed\n");
 	   goto err_free_desc_tbl;
@@ -2115,7 +2114,7 @@ #endif
 	{
 		memset((caddr_t)vc, 0, sizeof(*vc));
 		memset((caddr_t)evc, 0, sizeof(*evc));
-                iadev->testTable[i] = kmalloc(sizeof(struct testTable_t),
+                iadev->testTable[i] = kzalloc(sizeof(struct testTable_t),
 						GFP_KERNEL);
 		if (!iadev->testTable[i])
 			goto err_free_test_tables;
@@ -2695,7 +2694,7 @@ static int ia_open(struct atm_vcc *vcc)
                                  vcc->dev->number, vcc->vpi, vcc->vci);)

 	/* Device dependent initialization */
-	ia_vcc = kmalloc(sizeof(*ia_vcc), GFP_KERNEL);
+	ia_vcc = kzalloc(sizeof(*ia_vcc), GFP_KERNEL);
 	if (!ia_vcc) return -ENOMEM;
 	vcc->dev_data = ia_vcc;

@@ -2784,7 +2783,7 @@ static int ia_ioctl(struct atm_dev *dev,
              rfredn_t        *rfL;

 	     if (!capable(CAP_NET_ADMIN)) return -EPERM;
-	     regs_local = kmalloc(sizeof(*regs_local), GFP_KERNEL);
+	     regs_local = kzalloc(sizeof(*regs_local), GFP_KERNEL);
 	     if (!regs_local) return -ENOMEM;
 	     ffL = &regs_local->ffredn;
 	     rfL = &regs_local->rfredn;
@@ -3174,12 +3173,11 @@ static int __devinit ia_init_one(struct
         unsigned long flags;
 	int ret;

-	iadev = kmalloc(sizeof(*iadev), GFP_KERNEL);
+	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
-	memset(iadev, 0, sizeof(*iadev));
 	iadev->pci = pdev;

 	IF_INIT(printk("ia detected at bus:%d dev: %d function:%d\n",
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index fe60a59..4974b68 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -1482,16 +1482,10 @@ #endif
 static inline struct lanai_vcc *new_lanai_vcc(void)
 {
 	struct lanai_vcc *lvcc;
-	lvcc = (struct lanai_vcc *) kmalloc(sizeof(*lvcc), GFP_KERNEL);
+	lvcc = (struct lanai_vcc *) kzalloc(sizeof(*lvcc), GFP_KERNEL);
 	if (likely(lvcc != NULL)) {
-		lvcc->vbase = NULL;
-		lvcc->rx.atmvcc = lvcc->tx.atmvcc = NULL;
-		lvcc->nref = 0;
-		memset(&lvcc->stats, 0, sizeof lvcc->stats);
-		lvcc->rx.buf.start = lvcc->tx.buf.start = NULL;
 		skb_queue_head_init(&lvcc->tx.backlog);
 #ifdef DEBUG
-		lvcc->tx.unqueue = NULL;
 		lvcc->vci = -1;
 #endif
 	}
@@ -2610,7 +2604,7 @@ static int __devinit lanai_init_one(stru
 	struct atm_dev *atmdev;
 	int result;

-	lanai = (struct lanai_dev *) kmalloc(sizeof(*lanai), GFP_KERNEL);
+	lanai = (struct lanai_dev *) kzalloc(sizeof(*lanai), GFP_KERNEL);
 	if (lanai == NULL) {
 		printk(KERN_ERR DEV_LABEL
 		       ": couldn't allocate dev_data structure!\n");
diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index b803689..a4d1346 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -476,7 +476,7 @@ static int __devinit ns_init_card(int i,
       return error;
    }

-   if ((card = kmalloc(sizeof(ns_dev), GFP_KERNEL)) == NULL)
+   if ((card = kzalloc(sizeof(ns_dev), GFP_KERNEL)) == NULL)
    {
       printk("nicstar%d: can't allocate memory for device structure.\n", i);
       error = 2;
@@ -637,7 +637,7 @@ #endif
    writel(0x00000000, card->membase + VPM);

    /* Initialize TSQ */
-   card->tsq.org = kmalloc(NS_TSQSIZE + NS_TSQ_ALIGNMENT, GFP_KERNEL);
+   card->tsq.org = kzalloc(NS_TSQSIZE + NS_TSQ_ALIGNMENT, GFP_KERNEL);
    if (card->tsq.org == NULL)
    {
       printk("nicstar%d: can't allocate TSQ.\n", i);
@@ -656,7 +656,7 @@ #endif
           (u32) virt_to_bus(card->tsq.base), readl(card->membase + TSQB));

    /* Initialize RSQ */
-   card->rsq.org = kmalloc(NS_RSQSIZE + NS_RSQ_ALIGNMENT, GFP_KERNEL);
+   card->rsq.org = kzalloc(NS_RSQSIZE + NS_RSQ_ALIGNMENT, GFP_KERNEL);
    if (card->rsq.org == NULL)
    {
       printk("nicstar%d: can't allocate RSQ.\n", i);
@@ -997,16 +997,16 @@ static scq_info *get_scq(int size, u32 s
    if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
       return NULL;

-   scq = (scq_info *) kmalloc(sizeof(scq_info), GFP_KERNEL);
+   scq = (scq_info *) kzalloc(sizeof(scq_info), GFP_KERNEL);
    if (scq == NULL)
       return NULL;
-   scq->org = kmalloc(2 * size, GFP_KERNEL);
+   scq->org = kzalloc(2 * size, GFP_KERNEL);
    if (scq->org == NULL)
    {
       kfree(scq);
       return NULL;
    }
-   scq->skb = (struct sk_buff **) kmalloc(sizeof(struct sk_buff *) *
+   scq->skb = (struct sk_buff **) kzalloc(sizeof(struct sk_buff *) *
                                           (size / NS_SCQE_SIZE), GFP_KERNEL);
    if (scq->skb == NULL)
    {
diff --git a/drivers/atm/suni.c b/drivers/atm/suni.c
index f04f39c..afbf0c6 100644
--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -229,7 +229,7 @@ static int suni_start(struct atm_dev *de
 	unsigned long flags;
 	int first;

-	if (!(dev->phy_data = kmalloc(sizeof(struct suni_priv),GFP_KERNEL)))
+	if (!(dev->phy_data = kzalloc(sizeof(struct suni_priv),GFP_KERNEL)))
 		return -ENOMEM;

 	PRIV(dev)->dev = dev;
diff --git a/drivers/atm/uPD98402.c b/drivers/atm/uPD98402.c
index 9504cce..862bd49 100644
--- a/drivers/atm/uPD98402.c
+++ b/drivers/atm/uPD98402.c
@@ -210,7 +210,7 @@ static void uPD98402_int(struct atm_dev
 static int uPD98402_start(struct atm_dev *dev)
 {
 	DPRINTK("phy_start\n");
-	if (!(dev->dev_data = kmalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
+	if (!(dev->dev_data = kzalloc(sizeof(struct uPD98402_priv),GFP_KERNEL)))
 		return -ENOMEM;
 	spin_lock_init(&PRIV(dev)->lock);
 	memset(&PRIV(dev)->sonet_stats,0,sizeof(struct k_sonet_stats));
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 2c65e82..5f83691 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -603,9 +603,8 @@ static int start_rx(struct atm_dev *dev)
 DPRINTK("start_rx\n");
 	zatm_dev = ZATM_DEV(dev);
 	size = sizeof(struct atm_vcc *)*zatm_dev->chans;
-	zatm_dev->rx_map = (struct atm_vcc **) kmalloc(size,GFP_KERNEL);
+	zatm_dev->rx_map = (struct atm_vcc **) kzalloc(size,GFP_KERNEL);
 	if (!zatm_dev->rx_map) return -ENOMEM;
-	memset(zatm_dev->rx_map,0,size);
 	/* set VPI/VCI split (use all VCIs and give what's left to VPIs) */
 	zpokel(zatm_dev,(1 << dev->ci_range.vci_bits)-1,uPD98401_VRR);
 	/* prepare free buffer pools */
@@ -951,9 +950,8 @@ static int open_tx_first(struct atm_vcc
 	skb_queue_head_init(&zatm_vcc->tx_queue);
 	init_waitqueue_head(&zatm_vcc->tx_wait);
 	/* initialize ring */
-	zatm_vcc->ring = kmalloc(RING_SIZE,GFP_KERNEL);
+	zatm_vcc->ring = kzalloc(RING_SIZE,GFP_KERNEL);
 	if (!zatm_vcc->ring) return -ENOMEM;
-	memset(zatm_vcc->ring,0,RING_SIZE);
 	loop = zatm_vcc->ring+RING_ENTRIES*RING_WORDS;
 	loop[0] = uPD98401_TXPD_V;
 	loop[1] = loop[2] = 0;
@@ -997,7 +995,7 @@ static int start_tx(struct atm_dev *dev)

 	DPRINTK("start_tx\n");
 	zatm_dev = ZATM_DEV(dev);
-	zatm_dev->tx_map = (struct atm_vcc **) kmalloc(sizeof(struct atm_vcc *)*
+	zatm_dev->tx_map = (struct atm_vcc **) kzalloc(sizeof(struct atm_vcc *)*
 	    zatm_dev->chans,GFP_KERNEL);
 	if (!zatm_dev->tx_map) return -ENOMEM;
 	zatm_dev->tx_bw = ATM_OC3_PCR;
@@ -1399,7 +1397,7 @@ static int zatm_open(struct atm_vcc *vcc
 	DPRINTK(DEV_LABEL "(itf %d): open %d.%d\n",vcc->dev->number,vcc->vpi,
 	    vcc->vci);
 	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags)) {
-		zatm_vcc = kmalloc(sizeof(struct zatm_vcc),GFP_KERNEL);
+		zatm_vcc = kzalloc(sizeof(struct zatm_vcc),GFP_KERNEL);
 		if (!zatm_vcc) {
 			clear_bit(ATM_VF_ADDR,&vcc->flags);
 			return -ENOMEM;
@@ -1592,7 +1590,7 @@ static int __devinit zatm_init_one(struc
 	struct zatm_dev *zatm_dev;
 	int ret = -ENOMEM;

-	zatm_dev = (struct zatm_dev *) kmalloc(sizeof(*zatm_dev), GFP_KERNEL);
+	zatm_dev = (struct zatm_dev *) kzalloc(sizeof(*zatm_dev), GFP_KERNEL);
 	if (!zatm_dev) {
 		printk(KERN_EMERG "%s: memory shortage\n", DEV_LABEL);
 		goto out;
