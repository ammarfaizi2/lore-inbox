Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWJJU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWJJU4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWJJU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:56:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:54240 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030356AbWJJU4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:56:06 -0400
Date: Tue, 10 Oct 2006 15:56:04 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 1/21]: powerpc/cell spidernet ethtool -i version number info.
Message-ID: <20061010205603.GX4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds version information as reported by 
ethtool -i to the Spidernet driver.

From: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c         |    3 +++
 drivers/net/spider_net.h         |    2 ++
 drivers/net/spider_net_ethtool.c |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-05 11:12:44.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-05 11:14:33.000000000 -0500
@@ -55,6 +55,7 @@ MODULE_AUTHOR("Utz Bacher <utz.bacher@de
 	      "<Jens.Osterkamp@de.ibm.com>");
 MODULE_DESCRIPTION("Spider Southbridge Gigabit Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
 
 static int rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_DEFAULT;
 static int tx_descriptors = SPIDER_NET_TX_DESCRIPTORS_DEFAULT;
@@ -2252,6 +2253,8 @@ static struct pci_driver spider_net_driv
  */
 static int __init spider_net_init(void)
 {
+	printk(KERN_INFO "Spidernet version %s.\n", VERSION);
+
 	if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MIN) {
 		rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_MIN;
 		pr_info("adjusting rx descriptors to %i.\n", rx_descriptors);
Index: linux-2.6.18-mm2/drivers/net/spider_net.h
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.h	2006-10-05 11:13:53.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.h	2006-10-05 11:14:33.000000000 -0500
@@ -24,6 +24,8 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
+#define VERSION "1.1 A"
+
 #include "sungem_phy.h"
 
 extern int spider_net_stop(struct net_device *netdev);
Index: linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net_ethtool.c	2006-10-05 11:12:44.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net_ethtool.c	2006-10-05 11:14:33.000000000 -0500
@@ -76,7 +76,7 @@ spider_net_ethtool_get_drvinfo(struct ne
 	/* clear and fill out info */
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
 	strncpy(drvinfo->driver, spider_net_driver_name, 32);
-	strncpy(drvinfo->version, "0.1", 32);
+	strncpy(drvinfo->version, VERSION, 32);
 	strcpy(drvinfo->fw_version, "no information");
 	strncpy(drvinfo->bus_info, pci_name(card->pdev), 32);
 }
