Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSJLRop>; Sat, 12 Oct 2002 13:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJLRop>; Sat, 12 Oct 2002 13:44:45 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30898 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261310AbSJLRoo>; Sat, 12 Oct 2002 13:44:44 -0400
Subject: Strange patch to the Z85230 driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 19:02:29 +0100
Message-Id: <1034445749.15067.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are DMA ring buffers for ISA DMA, they do not need to be zeroed. 

diff -Nru a/drivers/net/wan/z85230.c b/drivers/net/wan/z85230.c
--- a/drivers/net/wan/z85230.c	Fri Oct 11 21:22:51 2002
+++ b/drivers/net/wan/z85230.c	Fri Oct 11 21:22:51 2002
@@ -889,12 +889,12 @@
 	if(c->mtu  > PAGE_SIZE/2)
 		return -EMSGSIZE;
 	 
-	c->rx_buf[0]=(void *)get_free_page(GFP_KERNEL|GFP_DMA);
+	c->rx_buf[0]=(void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
 	if(c->rx_buf[0]==NULL)
 		return -ENOBUFS;
 	c->rx_buf[1]=c->rx_buf[0]+PAGE_SIZE/2;
 	
-	c->tx_dma_buf[0]=(void *)get_free_page(GFP_KERNEL|GFP_DMA);
+	c->tx_dma_buf[0]=(void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
 	if(c->tx_dma_buf[0]==NULL)
 	{
 		free_page((unsigned long)c->rx_buf[0]);
@@ -1079,7 +1079,7 @@
 	if(c->mtu  > PAGE_SIZE/2)
 		return -EMSGSIZE;
 	 
-	c->tx_dma_buf[0]=(void *)get_free_page(GFP_KERNEL|GFP_DMA);
+	c->tx_dma_buf[0]=(void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
 	if(c->tx_dma_buf[0]==NULL)
 		return -ENOBUFS;
 
