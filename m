Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTDVT3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTDVT2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:28:53 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:1432 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263384AbTDVT1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:27:21 -0400
Date: Tue, 22 Apr 2003 23:38:44 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Memleak fix for DIGITAL EtherWORKS 3 ethernet driver
Message-ID: <20030422193844.GA7418@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a memleak on error exit path that is trivial to fix.
   The problem is present both in 2.4 and 2.5, the same patch applies.

   Please consider applying.

Bye,
    Oleg

===== drivers/net/ewrk3.c 1.20 vs edited =====
--- 1.20/drivers/net/ewrk3.c	Tue Dec  3 04:22:09 2002
+++ edited/drivers/net/ewrk3.c	Tue Apr 22 23:33:40 2003
@@ -1972,7 +1972,10 @@
 	case EWRK3_GET_STATS: { /* Get the driver statistics */
 		struct ewrk3_stats *tmp_stats =
         		kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
-		if (!tmp_stats) return -ENOMEM;
+		if (!tmp_stats) {
+			status = -ENOMEM;
+			break;
+		}
 
 		spin_lock_irqsave(&lp->hw_lock, flags);
 		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
