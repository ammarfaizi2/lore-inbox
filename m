Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTDGXWL (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbTDGXPL (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:15:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56960
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263795AbTDGXEf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:04:35 -0400
Date: Tue, 8 Apr 2003 01:23:25 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080023.h380NPZM009083@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix error in cops port to 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/appletalk/cops.c linux-2.5.67-ac1/drivers/net/appletalk/cops.c
--- linux-2.5.67/drivers/net/appletalk/cops.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/appletalk/cops.c	2003-04-04 18:35:34.000000000 +0100
@@ -801,7 +801,7 @@
                 lp->stats.rx_dropped++;
                 while(pkt_len--)        /* Discard packet */
                         inb(ioaddr);
-		restore_flags(flags);
+                spin_unlock_irqrestore(&lp->lock, flags);
                 return;
         }
         skb->dev = dev;
