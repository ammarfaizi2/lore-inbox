Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUBBT7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUBBT5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:57:46 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:33928 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265846AbUBBT4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:56:51 -0500
Date: Mon, 2 Feb 2004 20:56:50 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 22/42]
Message-ID: <20040202195650.GV6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


interrupt.c:201: warning: unsigned int format, different type arg (arg 4)

dma_addr_t can be 64 bit long even on x86 (when CONFIG_HIGHMEM64G is
defined). Cast to dma64_addr_t in the printk.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/tulip/interrupt.c linux-2.4/drivers/net/tulip/interrupt.c
--- linux-2.4-vanilla/drivers/net/tulip/interrupt.c	Fri Jun 13 16:51:35 2003
+++ linux-2.4/drivers/net/tulip/interrupt.c	Sat Jan 31 18:03:47 2004
@@ -194,10 +194,10 @@
 				if (tp->rx_buffers[entry].mapping !=
 				    le32_to_cpu(tp->rx_ring[entry].buffer1)) {
 					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-					       "do not match in tulip_rx: %08x vs. %08x %p / %p.\n",
+					       "do not match in tulip_rx: %08x vs. %08Lx %p / %p.\n",
 					       dev->name,
 					       le32_to_cpu(tp->rx_ring[entry].buffer1),
-					       tp->rx_buffers[entry].mapping,
+					       (dma64_addr_t)tp->rx_buffers[entry].mapping,
 					       skb->head, temp);
 				}
 #endif

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non ho ancora capito se il mio cane e` maschio o femmina:
quando fa la pipi` si chiude in bagno
