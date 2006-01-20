Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWATUHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWATUHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWATUHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:07:42 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:30600 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932125AbWATUHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:07:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=s4fpt59HOBpE5GKlG4/jE7FboY/0rer4PXvOzi/sGJpuqfbIFn3ldVpfv6+Mxt/EQ7CcH9TFPFRVjoakS9WKR5AvluBHx6kO1IvVo6YZbrO6ZzppeWkyyJ9a2ZFEuh/b0UR9wZebAmGS/97sC1nZLhOM9eQbZ6IAIJ1koTpa51c=
Date: Fri, 20 Jan 2006 23:24:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tobias Klauser <tklauser@nuerscht.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] umem: check pci_set_dma_mask return value correctly
Message-ID: <20060120202442.GA8905@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/block/umem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -882,7 +882,7 @@ static int __devinit mm_pci_probe(struct
 	       card->card_number, dev->bus->number, dev->devfn);
 
 	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
-	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
+	    pci_set_dma_mask(dev, 0xffffffffLL)) {
 		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
 		return  -ENOMEM;
 	}

