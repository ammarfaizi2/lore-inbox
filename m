Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUG1Q6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUG1Q6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267320AbUG1Q6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:58:05 -0400
Received: from ool-43554ab1.dyn.optonline.net ([67.85.74.177]:12163 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id S267319AbUG1Q5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:57:36 -0400
Date: Wed, 28 Jul 2004 12:57:26 -0400
From: Nick Orlov <bugfixer@list.ru>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] 2.6.8-rc2-mm1 e1000 inline fix (trivial)
Message-ID: <20040728165726.GA2812@nikolas.hn.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Andrew,

e1000-build-fix.patch in 2.6.8-rc2-mm1 is incomplete.

The following hunks are missing:


--- linux/drivers/net/e1000/e1000_main.c.orig	2004-07-28 10:52:57.000000000 -0400
+++ linux/drivers/net/e1000/e1000_main.c	2004-07-28 11:39:33.000000000 -0400
@@ -132,7 +132,7 @@
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
 static int e1000_change_mtu(struct net_device *netdev, int new_mtu);
 static int e1000_set_mac(struct net_device *netdev, void *p);
-static inline void e1000_irq_disable(struct e1000_adapter *adapter);
+static void e1000_irq_disable(struct e1000_adapter *adapter);
 static void e1000_irq_enable(struct e1000_adapter *adapter);
 static irqreturn_t e1000_intr(int irq, void *data, struct pt_regs *regs);
 static boolean_t e1000_clean_tx_irq(struct e1000_adapter *adapter);
@@ -2059,7 +2059,7 @@
  * @adapter: board private structure
  **/
 
-static inline void
+static void
 e1000_irq_disable(struct e1000_adapter *adapter)
 {
 	atomic_inc(&adapter->irq_sem);
@@ -150,9 +150,9 @@
 void set_ethtool_ops(struct net_device *netdev);
 static void e1000_enter_82542_rst(struct e1000_adapter *adapter);
 static void e1000_leave_82542_rst(struct e1000_adapter *adapter);
-static inline void e1000_rx_checksum(struct e1000_adapter *adapter,
-                                     struct e1000_rx_desc *rx_desc,
-                                     struct sk_buff *skb);
+static void e1000_rx_checksum(struct e1000_adapter *adapter,
+                              struct e1000_rx_desc *rx_desc,
+                              struct sk_buff *skb);
 static void e1000_tx_timeout(struct net_device *dev);
 static void e1000_tx_timeout_task(struct net_device *dev);
 static void e1000_smartspeed(struct e1000_adapter *adapter);
@@ -2587,7 +2587,7 @@
  * @sk_buff: socket buffer with received data
  **/
 
-static inline void
+static void
 e1000_rx_checksum(struct e1000_adapter *adapter,
                   struct e1000_rx_desc *rx_desc,
                   struct sk_buff *skb)


Please CC me - I'm not subscribed to the list.

Thanks,
	Nick.
-- 
With best wishes,
	Nick Orlov.


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="e1000-inline-fix.patch"

--- linux/drivers/net/e1000/e1000_main.c.orig	2004-07-28 10:52:57.000000000 -0400
+++ linux/drivers/net/e1000/e1000_main.c	2004-07-28 11:39:33.000000000 -0400
@@ -132,7 +132,7 @@
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
 static int e1000_change_mtu(struct net_device *netdev, int new_mtu);
 static int e1000_set_mac(struct net_device *netdev, void *p);
-static inline void e1000_irq_disable(struct e1000_adapter *adapter);
+static void e1000_irq_disable(struct e1000_adapter *adapter);
 static void e1000_irq_enable(struct e1000_adapter *adapter);
 static irqreturn_t e1000_intr(int irq, void *data, struct pt_regs *regs);
 static boolean_t e1000_clean_tx_irq(struct e1000_adapter *adapter);
@@ -2059,7 +2059,7 @@
  * @adapter: board private structure
  **/
 
-static inline void
+static void
 e1000_irq_disable(struct e1000_adapter *adapter)
 {
 	atomic_inc(&adapter->irq_sem);
@@ -150,9 +150,9 @@
 void set_ethtool_ops(struct net_device *netdev);
 static void e1000_enter_82542_rst(struct e1000_adapter *adapter);
 static void e1000_leave_82542_rst(struct e1000_adapter *adapter);
-static inline void e1000_rx_checksum(struct e1000_adapter *adapter,
-                                     struct e1000_rx_desc *rx_desc,
-                                     struct sk_buff *skb);
+static void e1000_rx_checksum(struct e1000_adapter *adapter,
+                              struct e1000_rx_desc *rx_desc,
+                              struct sk_buff *skb);
 static void e1000_tx_timeout(struct net_device *dev);
 static void e1000_tx_timeout_task(struct net_device *dev);
 static void e1000_smartspeed(struct e1000_adapter *adapter);
@@ -2587,7 +2587,7 @@
  * @sk_buff: socket buffer with received data
  **/
 
-static inline void
+static void
 e1000_rx_checksum(struct e1000_adapter *adapter,
                   struct e1000_rx_desc *rx_desc,
                   struct sk_buff *skb)

--bg08WKrSYDhXBjb5--
