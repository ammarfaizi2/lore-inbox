Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUBBT4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUBBTtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:49:06 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:22621 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265982AbUBBTsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:48:39 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:48:38 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 21/42]
Message-ID: <20040202194838.GU6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


idt77252.c:669: warning: unsigned int format, different type arg (arg 5)

dma_addr_t can be 64 bit long even on x86 (when CONFIG_HIGHMEM64G is
defined). Cast to dma64_addr_t in the printk.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/atm/idt77252.c linux-2.4/drivers/atm/idt77252.c
--- linux-2.4-vanilla/drivers/atm/idt77252.c	Tue Nov 11 17:51:38 2003
+++ linux-2.4/drivers/atm/idt77252.c	Sat Jan 31 17:58:57 2004
@@ -665,8 +665,8 @@
 	skb_queue_head_init(&scq->transmit);
 	skb_queue_head_init(&scq->pending);
 
-	TXPRINTK("idt77252: SCQ: base 0x%p, next 0x%p, last 0x%p, paddr %08x\n",
-		 scq->base, scq->next, scq->last, scq->paddr);
+	TXPRINTK("idt77252: SCQ: base 0x%p, next 0x%p, last 0x%p, paddr %08Lx\n",
+		 scq->base, scq->next, scq->last, (dma64_addr_t)scq->paddr);
 
 	return scq;
 }

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Tentare e` il primo passo verso il fallimento.
Homer J. Simpson
