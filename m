Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWIVVv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWIVVv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWIVVv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:51:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965166AbWIVVv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:51:28 -0400
Date: Fri, 22 Sep 2006 14:51:20 -0700
From: Judith Lebzelter <judith@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dale@farnsworth.org
Subject: Re: Arrr! Linux 2.6.18
Message-ID: <20060922215120.GD23169@shell0.pdx.osdl.net>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Dale Farnsworth:
>       mv643xx_eth: Unmap DMA buffers in receive path
> 

In OSDL's automated cross-compile for powerpc64, kernel 2.6.18 had this 
unexpected error:

drivers/net/mv643xx_eth.c: In function 'mv643xx_eth_receive_queue':
drivers/net/mv643xx_eth.c:388: error: 'RX_SKB_SIZE' undeclared (first use in this function)

Here is a patch that stops the error.

Judith Lebzelter
OSDL

--- drivers/net/mv643xx_eth.c.old	2006-09-22 11:22:47.951049416 -0700
+++ drivers/net/mv643xx_eth.c	2006-09-22 11:23:17.787625304 -0700
@@ -385,7 +385,7 @@
 	struct pkt_info pkt_info;
 
 	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
-		dma_unmap_single(NULL, pkt_info.buf_ptr, RX_SKB_SIZE,
+		dma_unmap_single(NULL, pkt_info.buf_ptr, ETH_RX_SKB_SIZE,
 							DMA_FROM_DEVICE);
 		mp->rx_desc_count--;
 		received_packets++;
