Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWJHOAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWJHOAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWJHOAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:00:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13445 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751182AbWJHOAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:00:45 -0400
Date: Sun, 8 Oct 2006 15:00:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc ppc pt_regs fixes
Message-ID: <20061008140044.GU29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/macintosh/macio-adb.c |    2 +-
 drivers/net/mv643xx_eth.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index 57ccc19..797cef7 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -270,6 +270,6 @@ static void macio_adb_poll(void)
 
 	local_irq_save(flags);
 	if (in_8(&adb->intr.r) != 0)
-		macio_adb_interrupt(0, NULL, NULL);
+		macio_adb_interrupt(0, NULL);
 	local_irq_restore(flags);
 }
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index d26a819..2ffa3a5 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -1251,7 +1251,7 @@ static void mv643xx_netpoll(struct net_d
 	/* wait for previous write to complete */
 	mv_read(MV643XX_ETH_INTERRUPT_MASK_REG(port_num));
 
-	mv643xx_eth_int_handler(netdev->irq, netdev, NULL);
+	mv643xx_eth_int_handler(netdev->irq, netdev);
 
 	mv_write(MV643XX_ETH_INTERRUPT_MASK_REG(port_num), ETH_INT_UNMASK_ALL);
 }
-- 
1.4.2.GIT

