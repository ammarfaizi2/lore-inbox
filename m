Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266797AbUG1HPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266797AbUG1HPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUG1HOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:14:22 -0400
Received: from ozlabs.org ([203.10.76.45]:8074 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266802AbUG1HLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:48 -0400
Date: Wed, 28 Jul 2004 16:58:00 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [9/15] orinoco merge preliminaries - make things static
Message-ID: <20040728065800.GL16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065725.GK16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make various functions and variables static which always should have
been, but weren't.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:40.435498704 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:43.818984336 +1000
@@ -214,7 +214,7 @@
 	return pci_module_init(&orinoco_tmd_driver);
 }
 
-void __exit orinoco_tmd_exit(void)
+static void __exit orinoco_tmd_exit(void)
 {
 	pci_unregister_driver(&orinoco_tmd_driver);
 	current->state = TASK_UNINTERRUPTIBLE;
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:40.438498248 +1000
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:43.819984184 +1000
@@ -341,7 +341,7 @@
 	return pci_module_init(&orinoco_plx_driver);
 }
 
-void __exit orinoco_plx_exit(void)
+static void __exit orinoco_plx_exit(void)
 {
 	pci_unregister_driver(&orinoco_plx_driver);
 	current->state = TASK_UNINTERRUPTIBLE;
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:39.586627752 +1000
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:43.820984032 +1000
@@ -387,7 +387,7 @@
 	return pci_module_init(&orinoco_pci_driver);
 }
 
-void __exit orinoco_pci_exit(void)
+static void __exit orinoco_pci_exit(void)
 {
 	pci_unregister_driver(&orinoco_pci_driver);
 }
Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:40.433499008 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:43.829982664 +1000
@@ -507,7 +507,7 @@
 /********************************************************************/
 
 /* The frequency of each channel in MHz */
-const long channel_frequency[] = {
+static const long channel_frequency[] = {
 	2412, 2417, 2422, 2427, 2432, 2437, 2442,
 	2447, 2452, 2457, 2462, 2467, 2472, 2484
 };
@@ -515,7 +515,7 @@
 
 /* This tables gives the actual meanings of the bitrate IDs returned
  * by the firmware. */
-struct {
+static struct {
 	int bitrate; /* in 100s of kilobits */
 	int automatic;
 	u16 agere_txratectrl;
@@ -643,14 +643,14 @@
 	return err;
 }
 
-struct net_device_stats *orinoco_get_stats(struct net_device *dev)
+static struct net_device_stats *orinoco_get_stats(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	
 	return &priv->stats;
 }
 
-struct iw_statistics *orinoco_get_wireless_stats(struct net_device *dev)
+static struct iw_statistics *orinoco_get_wireless_stats(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	hermes_t *hw = &priv->hw;
@@ -985,9 +985,9 @@
 		}
 }
 
-void orinoco_stat_gather(struct net_device *dev,
-			 struct sk_buff *skb,
-			 struct hermes_rx_descriptor *desc)
+static void orinoco_stat_gather(struct net_device *dev,
+				struct sk_buff *skb,
+				struct hermes_rx_descriptor *desc)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
