Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144145AbRA1UjV>; Sun, 28 Jan 2001 15:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144147AbRA1UjM>; Sun, 28 Jan 2001 15:39:12 -0500
Received: from crusoe.degler.net ([160.79.55.71]:448 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S144145AbRA1UjC>;
	Sun, 28 Jan 2001 15:39:02 -0500
Date: Sun, 28 Jan 2001 15:38:54 -0500
From: Stephen Degler <sdegler@degler.net>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: tulip autonegotiation patch
Message-ID: <20010128153854.A13829@crusoe.degler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one-liner fixes a subtle 21143 autonegotiation problem for me on a Zynx
quad card.  The driver would claim to negotiate 100-FD, but would report late
collisions and bad transmit throughput.

The driver still allows packets to be transmitted during autonegotiation,
but that only drops a few packets.

skd

--- 21142.c.bad	Sun Jan 28 15:26:25 2001
+++ 21142.c	Sun Jan 28 11:51:59 2001
@@ -171,7 +171,7 @@
 			for (i = 0; i < tp->mtable->leafcount; i++)
 				if (tp->mtable->mleaf[i].media == dev->if_port) {
 					tp->cur_index = i;
-					tulip_select_media(dev, 0);
+					tulip_select_media(dev, 1);
 					setup_done = 1;
 					break;
 				}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
