Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUHDJif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUHDJif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUHDJif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:38:35 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:30161 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S262062AbUHDJiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:38:23 -0400
Date: Wed, 4 Aug 2004 11:37:09 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [via-rhine] Really call rhine_power_init()
Message-ID: <20040804093709.GA1536@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix for the heisenbug with via-rhine refusing to work
sometimes. Patch "[9/9] Restructure reset code" contained a change made
necessary by patch [8/9]. Mainline merged [8/9] for 2.6.8 and is still
missing the fix, while -mm got it with [9/9].

Jesper Juhl provided crucial test data when no one else was able to
reproduce the symptoms.

Roger

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- tmp/drivers/net/via-rhine.c.00_broken	2004-07-29 13:58:17.000000000 +0200
+++ tmp/drivers/net/via-rhine.c	2004-07-30 15:12:36.656007543 +0200
@@ -748,6 +748,8 @@ static int __devinit rhine_init_one(stru
 	}
 #endif /* USE_MMIO */
 	dev->base_addr = ioaddr;
+	rp = netdev_priv(dev);
+	rp->quirks = quirks;
 
 	rhine_power_init(dev);
 
@@ -792,10 +794,8 @@ static int __devinit rhine_init_one(stru
 
 	dev->irq = pdev->irq;
 
-	rp = netdev_priv(dev);
 	spin_lock_init(&rp->lock);
 	rp->pdev = pdev;
-	rp->quirks = quirks;
 	rp->mii_if.dev = dev;
 	rp->mii_if.mdio_read = mdio_read;
 	rp->mii_if.mdio_write = mdio_write;
