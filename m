Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293720AbSCKMZD>; Mon, 11 Mar 2002 07:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSCKMYx>; Mon, 11 Mar 2002 07:24:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25790 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293720AbSCKMYj>;
	Mon, 11 Mar 2002 07:24:39 -0500
Date: Mon, 11 Mar 2002 04:21:24 -0800 (PST)
Message-Id: <20020311.042124.103955441.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015849164.2153.3.camel@monkey>
In-Reply-To: <20020310.164350.107967417.davem@redhat.com>
	<1015834777.1802.8.camel@monkey>
	<1015849164.2153.3.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 11 Mar 2002 12:19:24 +0000

   I managed to run the latest patch, but it appears to Oops when the
   overflow condition occurs. Sadly I was not able to get the output of the
   oops... but it was at exactly the same time that I was run my "test"
   which causes the RX to halt.

Duh, this will fix it:

--- drivers/net/sungem.c.~1~	Mon Mar 11 04:18:58 2002
+++ drivers/net/sungem.c	Mon Mar 11 04:24:13 2002
@@ -317,7 +317,7 @@
 	}
 
 	/* Second, disable RX DMA. */
-	writel(0, RXDMA_CFG);
+	writel(0, gp->regs + RXDMA_CFG);
 	for (limit = 0; limit < 5000; limit++) {
 		if (!(readl(gp->regs + RXDMA_CFG) & RXDMA_CFG_ENABLE))
 			break;
