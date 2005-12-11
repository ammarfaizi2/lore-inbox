Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVLKTeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVLKTeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVLKTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:34:09 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:58316 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbVLKTeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:34:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=sbMe9dzJsDsVQ09tQxjVJQ1QA73mJr9rZLNYL4WTY9LGIsht5eXhgWSZW6SI6x+l5jgj5HTfDornki0xLjJJGzFbyhCyDk3pQCSnpXfO1JCG2z6ve+4kof4qVD3nJHMXF2F4XMym445N2Wz/glSXuzaOAi9OzGL+rq9s8B+Q6S4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] drivers/atm: Remove unneeded kmalloc() return value casts + tiny whitespace cleanup
Date: Sun, 11 Dec 2005 20:34:40 +0100
User-Agent: KMail/1.9
Cc: Werner Almesberger <werner@almesberger.net>,
       Chas Williams <chas@cmf.nrl.navy.mil>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512112034.40905.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small cleanups for drivers/atm/zatm.c
 Get rid of unneeded cast of kmalloc() return value.
 Small whitespace/CodingStyle/formatting cleanup (since I was in there anyway).


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/atm/zatm.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.15-rc5-git1-orig/drivers/atm/zatm.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/drivers/atm/zatm.c	2005-12-11 20:00:02.000000000 +0100
@@ -669,11 +669,13 @@ printk("NONONONOO!!!!\n");
 		u32 *put;
 		int i;
 
-		dsc = (u32 *) kmalloc(uPD98401_TXPD_SIZE*2+
-		    uPD98401_TXBD_SIZE*ATM_SKB(skb)->iovcnt,GFP_ATOMIC);
+		dsc = kmalloc(uPD98401_TXPD_SIZE * 2 +
+			uPD98401_TXBD_SIZE * ATM_SKB(skb)->iovcnt, GFP_ATOMIC);
 		if (!dsc) {
-			if (vcc->pop) vcc->pop(vcc,skb);
-			else dev_kfree_skb_irq(skb);
+			if (vcc->pop)
+				vcc->pop(vcc, skb);
+			else
+				dev_kfree_skb_irq(skb);
 			return -EAGAIN;
 		}
 		/* @@@ should check alignment */
@@ -683,7 +685,7 @@ printk("NONONONOO!!!!\n");
 		    (ATM_SKB(skb)->atm_options & ATM_ATMOPT_CLP ?
 		    uPD98401_CLPM_1 : uPD98401_CLPM_0));
 		dsc[1] = 0;
-		dsc[2] = ATM_SKB(skb)->iovcnt*uPD98401_TXBD_SIZE;
+		dsc[2] = ATM_SKB(skb)->iovcnt * uPD98401_TXBD_SIZE;
 		dsc[3] = virt_to_bus(put);
 		for (i = 0; i < ATM_SKB(skb)->iovcnt; i++) {
 			*put++ = ((struct iovec *) skb->data)[i].iov_len;



