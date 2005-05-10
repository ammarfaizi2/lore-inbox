Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVEJUCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVEJUCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVEJUCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:02:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:4224 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261769AbVEJUCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:02:50 -0400
Date: Tue, 10 May 2005 22:06:42 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Rui Prior <rprior@inescn.pt>, akpm@osdl.org
Subject: [PATCH] atm/nicstar: remove a bunch of pointless casts of NULL
Message-ID: <Pine.LNX.4.62.0505102203170.2386@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to cast NULL. This patch removes the pointless casts 
from drivers/atm/nicstar.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/atm/nicstar.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.12-rc3-mm3-orig/drivers/atm/nicstar.c	2005-04-30 18:24:53.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/atm/nicstar.c	2005-05-10 22:02:29.000000000 +0200
@@ -676,10 +676,10 @@ static int __devinit ns_init_card(int i,
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
@@ -993,24 +993,24 @@ static scq_info *get_scq(int size, u32 s
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
@@ -1498,7 +1498,7 @@ static int ns_open(struct atm_vcc *vcc)
          vc->cbr_scd = NS_FRSCD + frscdi * NS_FRSCD_SIZE;
 
          scq = get_scq(CBR_SCQSIZE, vc->cbr_scd);
-         if (scq == (scq_info *) NULL)
+         if (scq == NULL)
          {
             PRINTK("nicstar%d: can't get fixed rate SCQ.\n", card->index);
             card->scd2vc[frscdi] = NULL;



