Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWFUOKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFUOKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFUOKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:10:53 -0400
Received: from mail.gmx.de ([213.165.64.21]:61874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750794AbWFUOKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:10:52 -0400
X-Authenticated: #704063
Subject: [Patch] Remove useless check in drivers/net/pcmcia/xirc2ps_cs.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 16:10:48 +0200
Message-Id: <1150899048.16427.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity choked at this check (id #223), assuming that
skb might be NULL and used anyways later. Since
start_hard_xmit() always gets called with a valid
skb, the check is useless and this patch removes it.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/pcmcia/xirc2ps_cs.c.orig	2006-06-21 16:06:48.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/pcmcia/xirc2ps_cs.c	2006-06-21 16:06:59.000000000 +0200
@@ -1359,7 +1359,7 @@ do_start_xmit(struct sk_buff *skb, struc
     kio_addr_t ioaddr = dev->base_addr;
     int okay;
     unsigned freespace;
-    unsigned pktlen = skb? skb->len : 0;
+    unsigned pktlen = skb->len;
 
     DEBUG(1, "do_start_xmit(skb=%p, dev=%p) len=%u\n",
 	  skb, dev, pktlen);


