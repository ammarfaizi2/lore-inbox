Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWABPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWABPpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWABPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:45:52 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:43882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750755AbWABPpv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:45:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OcNkM6HNYL6zC5ab4C7JJKdnTjvPJpp425841aYTxoQ2SMIjVLo7GhkVci5284jP6rXq3Oex7Z+haXyNJbYz82i+B5F8HLCIj/J1v26BON0skSiesOF8iMnJwP83t+iY9l2kTLjTyuGiDonPgO7U97cosbKFSXxkCX645ZBZHjw=
Message-ID: <6ec4247d0601020745s2b6a486dg@mail.gmail.com>
Date: Tue, 3 Jan 2006 02:15:50 +1030
From: Graham Gower <graham.gower@gmail.com>
To: linux-kernel@vger.kernel.org, prism54-devel@prism54.org
Subject: [PATCH] [TRIVIAL] prism54/islpci_eth.c: dev_kfree_skb in irq context
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev_kfree_skb shouldn't be used in an IRQ context.

Signed-off-by: Graham Gower <graham.gower@gmail.com>


--- linux/drivers/net/wireless/prism54/islpci_eth.c.orig	2006-01-03
01:23:27.000000000 +1030
+++ linux/drivers/net/wireless/prism54/islpci_eth.c	2006-01-03
00:38:46.000000000 +1030
@@ -178,7 +178,7 @@
 #endif

 			newskb->dev = skb->dev;
-			dev_kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			skb = newskb;
 		}
 	}
@@ -242,7 +242,7 @@

       drop_free:
 	/* free the skbuf structure before aborting */
-	dev_kfree_skb(skb);
+	dev_kfree_skb_irq(skb);
 	skb = NULL;

 	priv->statistics.tx_dropped++;
