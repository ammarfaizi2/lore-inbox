Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUI3ICq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUI3ICq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbUI3ICp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:02:45 -0400
Received: from [195.167.234.212] ([195.167.234.212]:23777 "EHLO atchik.com")
	by vger.kernel.org with ESMTP id S268779AbUI3ICU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:02:20 -0400
Date: Thu, 30 Sep 2004 10:01:56 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Revert mistakenly applied patch to sungem
Message-ID: <20040930100156.6012a290@pirandello>
X-Mailer: Sylpheed-Claws 0.9.12cvs110.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Atchik-MailScanner-Information: Please contact the ISP for more information
X-Atchik-MailScanner: Found to be clean
X-MailScanner-From: colin@colino.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, everyone,

There's a mistake in 2.6.9-rc3, you applied a patch I sent yesterday,
for something that was already implemented (netpoll support in sungem).

As Eric Lemoine and I didn't add the stuff at the same place, there has
been no conflict.

See http://marc.theaimsgroup.com/?l=linux-kernel&m=109647405508937&w=2
http://linux.bkbits.net:8080/linux-2.5/cset@4149f001_LtxxbZOVP8q363TiTcSVg
http://linux.bkbits.net:8080/linux-2.5/cset@415b4276tcoFzDd1YSqq2ZJ_OkYlfQ

Following is the reverse patch to reverse my stuff :)
Sorry about that.

Signed-off-by: Colin Leroy <colin@colino.net>

--- a/drivers/net/sungem.c	2004-09-29 12:15:56.000000000 +0200
+++ b/drivers/net/sungem.c	2004-09-29 12:22:41.000000000 +0200
@@ -2687,23 +2687,6 @@
 }
 #endif /* not Sparc and not PPC */
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/*
- * Polling 'interrupt' - used by things like netconsole to send skbs
- * without having to re-enable interrupts. It's not called while
- * the interrupt routine is executing.
- */
-static void gem_netpoll(struct net_device *netdev)
-{
-	struct gem *gp = netdev->priv;
-	if (!gp->pdev)
-		return;
-	disable_irq(gp->pdev->irq);
-	gem_interrupt(gp->pdev->irq, netdev, NULL);
-	enable_irq(gp->pdev->irq);
-}
-#endif
-
 static int __devinit gem_get_device_address(struct gem *gp)
 {
 #if defined(__sparc__) || defined(CONFIG_PPC_PMAC)
@@ -2899,9 +2882,6 @@
 	dev->set_multicast_list = gem_set_multicast;
 	dev->do_ioctl = gem_ioctl;
 	dev->poll = gem_poll;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = gem_netpoll;
-#endif
 	dev->weight = 64;
 	dev->ethtool_ops = &gem_ethtool_ops;
 	dev->tx_timeout = gem_tx_timeout;
