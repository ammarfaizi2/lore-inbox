Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUIWH6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUIWH6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUIWH6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:58:42 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:39367 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S268316AbUIWH6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:58:40 -0400
From: Michal Rokos <michal@rokos.info>
To: thockin@hockin.org
Subject: [PATCH 2.6] Natsemi - remove compilation warnings
Date: Thu, 23 Sep 2004 09:58:31 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409230958.31758.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

natsemi driver emits a lot of warnings.

This patch make compilation calm again.

Code taken from drivers/net/pci-skeleton.c. Thanks Jeff.

Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/23 09:43:08+02:00 michal@nb-rokos.nx.cz
#   [PATCH 2.6] Natsemi - remove compilation warnings
#
# drivers/net/natsemi.c
#   2004/09/23 09:42:50+02:00 michal@nb-rokos.nx.cz +13 -0
#   Remove zillion of
#   drivers/net/natsemi.c:806: warning: passing arg 2 of `writew' makes 
pointer from integer without a cast
#   drivers/net/natsemi.c:807: warning: passing arg 1 of `readw' makes 
pointer from integer without a cast
#
diff -Nru a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c     2004-09-23 09:44:14 +02:00
+++ b/drivers/net/natsemi.c     2004-09-23 09:44:14 +02:00
@@ -769,6 +769,19 @@
 static int netdev_get_regs(struct net_device *dev, u8 *buf);
 static int netdev_get_eeprom(struct net_device *dev, u8 *buf);

+#undef readb
+#undef readw
+#undef readl
+#undef writeb
+#undef writew
+#undef writel
+#define readb(addr) inb((unsigned long)(addr))
+#define readw(addr) inw((unsigned long)(addr))
+#define readl(addr) inl((unsigned long)(addr))
+#define writeb(val,addr) outb((val), (unsigned long)(addr))
+#define writew(val,addr) outw((val), (unsigned long)(addr))
+#define writel(val,addr) outl((val), (unsigned long)(addr))
+
 static void move_int_phy(struct net_device *dev, int addr)
 {
        struct netdev_private *np = netdev_priv(dev);

