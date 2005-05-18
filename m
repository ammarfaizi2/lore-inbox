Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVERVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVERVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVERVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:54:09 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:28364 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262303AbVERVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:52:56 -0400
Message-Id: <200505182152.j4ILqb5M001881@ginger.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] atm: kill pointless NULL checks and casts before kfree() [take two] 
In-reply-to: <Pine.LNX.4.62.0505102159270.2386@dragon.hyggekrogen.localhost> 
Date: Wed, 18 May 2005 17:52:38 -0400
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dave,

please apply to 2.6 head -- thanks!


[ATM]: [drivers] kill pointless NULL checks and casts before kfree()

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Chas Williams <chas@cmf.nrl.navy.mil>

---
commit a44767a5b20b70aa4ba5fb423f5f251a37bea62f
tree 5c19a71aeba54620a1843a94d692ca1926e6d172
parent 70ac1c1be822318a3b706d00397b2bf24ffe0a6e
author chas williams <chas@relax.(none)> Wed, 18 May 2005 15:26:49 -0400
committer chas williams <chas@relax.(none)> Wed, 18 May 2005 15:26:49 -0400

 atm/fore200e.c |    6 ++----
 atm/he.c       |    6 ++----
 atm/nicstar.c  |   20 ++++++++++----------
 atm/zatm.c     |   11 ++++-------
 4 files changed, 18 insertions(+), 25 deletions(-)

Index: drivers/atm/fore200e.c
===================================================================
--- fe56ec270cfb1155e9370731e49900172ec73de6/drivers/atm/fore200e.c  (mode:100644)
+++ 5c19a71aeba54620a1843a94d692ca1926e6d172/drivers/atm/fore200e.c  (mode:100644)
@@ -383,8 +383,7 @@
     switch(fore200e->state) {
 
     case FORE200E_STATE_COMPLETE:
-	if (fore200e->stats)
-	    kfree(fore200e->stats);
+	kfree(fore200e->stats);
 
     case FORE200E_STATE_IRQ:
 	free_irq(fore200e->irq, fore200e->atm_dev);
@@ -963,8 +962,7 @@
 		entry, txq->tail, entry->vc_map, entry->skb);
 
 	/* free copy of misaligned data */
-	if (entry->data)
-	    kfree(entry->data);
+	kfree(entry->data);
 	
 	/* remove DMA mapping */
 	fore200e->bus->dma_unmap(fore200e, entry->tpd->tsd[ 0 ].buffer, entry->tpd->tsd[ 0 ].length,
Index: drivers/atm/he.c
===================================================================
--- fe56ec270cfb1155e9370731e49900172ec73de6/drivers/atm/he.c  (mode:100644)
+++ 5c19a71aeba54620a1843a94d692ca1926e6d172/drivers/atm/he.c  (mode:100644)
@@ -412,8 +412,7 @@
 init_one_failure:
 	if (atm_dev)
 		atm_dev_deregister(atm_dev);
-	if (he_dev)
-		kfree(he_dev);
+	kfree(he_dev);
 	pci_disable_device(pci_dev);
 	return err;
 }
@@ -2534,8 +2533,7 @@
 open_failed:
 
 	if (err) {
-		if (he_vcc)
-			kfree(he_vcc);
+		kfree(he_vcc);
 		clear_bit(ATM_VF_ADDR, &vcc->flags);
 	}
 	else
Index: drivers/atm/nicstar.c
===================================================================
--- fe56ec270cfb1155e9370731e49900172ec73de6/drivers/atm/nicstar.c  (mode:100644)
+++ 5c19a71aeba54620a1843a94d692ca1926e6d172/drivers/atm/nicstar.c  (mode:100644)
@@ -676,10 +676,10 @@
    PRINTK("nicstar%d: RSQ base at 0x%x.\n", i, (u32) card->rsq.base);
       
    /* Initialize SCQ0, the only VBR SCQ used */
-   card->scq1 = (scq_info *) NULL;
-   card->scq2 = (scq_info *) NULL;
+   card->scq1 = NULL;
+   card->scq2 = NULL;
    card->scq0 = get_scq(VBR_SCQSIZE, NS_VRSCD0);
-   if (card->scq0 == (scq_info *) NULL)
+   if (card->scq0 == NULL)
    {
       printk("nicstar%d: can't get SCQ0.\n", i);
       error = 12;
@@ -993,24 +993,24 @@
    int i;
 
    if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
-      return (scq_info *) NULL;
+      return NULL;
 
    scq = (scq_info *) kmalloc(sizeof(scq_info), GFP_KERNEL);
-   if (scq == (scq_info *) NULL)
-      return (scq_info *) NULL;
+   if (scq == NULL)
+      return NULL;
    scq->org = kmalloc(2 * size, GFP_KERNEL);
    if (scq->org == NULL)
    {
       kfree(scq);
-      return (scq_info *) NULL;
+      return NULL;
    }
    scq->skb = (struct sk_buff **) kmalloc(sizeof(struct sk_buff *) *
                                           (size / NS_SCQE_SIZE), GFP_KERNEL);
-   if (scq->skb == (struct sk_buff **) NULL)
+   if (scq->skb == NULL)
    {
       kfree(scq->org);
       kfree(scq);
-      return (scq_info *) NULL;
+      return NULL;
    }
    scq->num_entries = size / NS_SCQE_SIZE;
    scq->base = (ns_scqe *) ALIGN_ADDRESS(scq->org, size);
@@ -1498,7 +1498,7 @@
          vc->cbr_scd = NS_FRSCD + frscdi * NS_FRSCD_SIZE;
 
          scq = get_scq(CBR_SCQSIZE, vc->cbr_scd);
-         if (scq == (scq_info *) NULL)
+         if (scq == NULL)
          {
             PRINTK("nicstar%d: can't get fixed rate SCQ.\n", card->index);
             card->scd2vc[frscdi] = NULL;
Index: drivers/atm/zatm.c
===================================================================
--- fe56ec270cfb1155e9370731e49900172ec73de6/drivers/atm/zatm.c  (mode:100644)
+++ 5c19a71aeba54620a1843a94d692ca1926e6d172/drivers/atm/zatm.c  (mode:100644)
@@ -902,7 +902,7 @@
 		zatm_dev->tx_bw += vcc->qos.txtp.min_pcr;
 		dealloc_shaper(vcc->dev,zatm_vcc->shaper);
 	}
-	if (zatm_vcc->ring) kfree(zatm_vcc->ring);
+	kfree(zatm_vcc->ring);
 }
 
 
@@ -1339,12 +1339,9 @@
 	return 0;
     out:
 	for (i = 0; i < NR_MBX; i++)
-		if (zatm_dev->mbx_start[i] != 0)
-			kfree((void *) zatm_dev->mbx_start[i]);
-	if (zatm_dev->rx_map != NULL)
-		kfree(zatm_dev->rx_map);
-	if (zatm_dev->tx_map != NULL)
-		kfree(zatm_dev->tx_map);
+		kfree(zatm_dev->mbx_start[i]);
+	kfree(zatm_dev->rx_map);
+	kfree(zatm_dev->tx_map);
 	free_irq(zatm_dev->irq, dev);
 	return error;
 }
