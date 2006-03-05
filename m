Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWCEAqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWCEAqz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWCEAqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:46:55 -0500
Received: from webbox269.server-home.net ([195.137.213.113]:51380 "EHLO
	blackwhale.net") by vger.kernel.org with ESMTP id S932309AbWCEAqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:46:54 -0500
From: Andreas Happe <andreashappe@snikt.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc5-mm2: IPW_QOS: two remarks
Date: Sun, 5 Mar 2006 01:46:26 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com, jgarzik@pobox.com, netdev@vger.kernel.org
References: <20060303045651.1f3b55ec.akpm@osdl.org> <20060303152641.GR9295@stusta.de>
In-Reply-To: <20060303152641.GR9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603050146.27529.andreashappe@snikt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 16:26, Adrian Bunk wrote:
> Two remarks regarding the new IPW_QOS option:
> - it should be named IPW2200_QOS (similar to the other IPW2200_*
>   options)

done.

> - please add a help text

i could add some stuff about WMM to its help text, but I think someone more 
involved with the ipw2200-project should do that.

andy

Add the following config entries for the ipw2200 driver to 
drivers/net/wireless/Kconfig
 * IPW2200_MONITOR
	enables Monitor mode, as this seems to generate lots of firmware errors
	it depends upon BROKEN
 * IPW2200_QOS
	enables QoS feature - this is under development right now, so it depends 
	upon EXPERIMENTAL.

Changes:
 * Renamed IPW_QOS to IPW2200_QOS as requested by Adrian Bunk.
 * Made IPW2200_MONITOR depend upon BROKEN
 * QoS option is named IPW_QOS not IPW2200_MONITOR.
   Spotted by Daniel Paschka, thanks.

Signed-off-by: Andreas Happe <andreashappe@snikt.net>
diff -uprN linux-2.6.15-base/drivers/net/wireless/ipw2200.c 
linux-2.6.15/drivers/net/wireless/ipw2200.c
--- linux-2.6.15-base/drivers/net/wireless/ipw2200.c	2006-03-05 
01:17:52.000000000 +0100
+++ linux-2.6.15/drivers/net/wireless/ipw2200.c	2006-03-05 01:28:04.000000000 
+0100
@@ -60,7 +60,7 @@ static const char ipw_modes[] = {
 	'a', 'b', 'g', '?'
 };
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 static int qos_enable = 0;
 static int qos_burst_enable = 0;
 static int qos_no_ack_mask = 0;
@@ -124,7 +124,7 @@ static int ipw_send_qos_params_command(s
 				       *qos_param);
 static int ipw_send_qos_info_command(struct ipw_priv *priv, struct 
ieee80211_qos_information_element
 				     *qos_param);
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 static struct iw_statistics *ipw_get_wireless_stats(struct net_device *dev);
 static void ipw_remove_current_network(struct ipw_priv *priv);
@@ -4208,7 +4208,7 @@ static void ipw_rx_notification(struct i
 					queue_work(priv->workqueue,
 						   &priv->system_config);
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 #define IPW_GET_PACKET_STYPE(x) WLAN_FC_GET_STYPE( \
 			 le16_to_cpu(((struct ieee80211_hdr *)(x))->frame_ctl))
 					if ((priv->status & STATUS_AUTH) &&
@@ -6549,7 +6549,7 @@ static int ipw_wx_set_mlme(struct net_de
 	return 0;
 }
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 
 /* QoS */
 /*
@@ -7031,7 +7031,7 @@ static int ipw_send_qos_info_command(str
 	return ipw_send_cmd(priv, &cmd);
 }
 
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 static int ipw_associate_network(struct ipw_priv *priv,
 				 struct ieee80211_network *network,
@@ -7193,7 +7193,7 @@ static int ipw_associate_network(struct 
 
 	priv->assoc_network = network;
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	ipw_qos_association(priv, network);
 #endif
 
@@ -8027,10 +8027,10 @@ static int ipw_sw_reset(struct ipw_priv 
 		IPW_DEBUG_INFO("Bind to static channel %d\n", channel);
 		/* TODO: Validate that provided channel is in range */
 	}
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	ipw_qos_init(priv, qos_enable, qos_burst_enable,
 		     burst_duration_CCK, burst_duration_OFDM);
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 	switch (mode) {
 	case 1:
@@ -9636,7 +9636,7 @@ static int ipw_tx_skb(struct ipw_priv *p
 	    txb->fragments[0]->data;
 	int i = 0;
 	struct tfd_frame *tfd;
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	int tx_id = ipw_get_tx_queue_number(priv, pri);
 	struct clx2_tx_queue *txq = &priv->txq[tx_id];
 #else
@@ -9749,9 +9749,9 @@ static int ipw_tx_skb(struct ipw_priv *p
 		/* No hardware encryption */
 		tfd->u.data.tx_flags |= DCT_FLAG_NO_WEP;
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	ipw_qos_set_tx_queue_command(priv, pri, &(tfd->u.data), unicast);
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 	/* payload */
 	tfd->u.data.num_chunks = cpu_to_le32(min((u8) (NUM_TFD_CHUNKS - 2),
@@ -9828,12 +9828,12 @@ static int ipw_tx_skb(struct ipw_priv *p
 static int ipw_net_is_queue_full(struct net_device *dev, int pri)
 {
 	struct ipw_priv *priv = ieee80211_priv(dev);
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	int tx_id = ipw_get_tx_queue_number(priv, pri);
 	struct clx2_tx_queue *txq = &priv->txq[tx_id];
 #else
 	struct clx2_tx_queue *txq = &priv->txq[0];
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 	if (ipw_queue_space(&txq->q) < txq->q.high_mark)
 		return 1;
@@ -10157,10 +10157,10 @@ static int ipw_setup_deferred_work(struc
 	INIT_WORK(&priv->merge_networks,
 		  (void (*)(void *))ipw_merge_adhoc_network, priv);
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	INIT_WORK(&priv->qos_activate, (void (*)(void *))ipw_bg_qos_activate,
 		  priv);
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 	tasklet_init(&priv->irq_tasklet, (void (*)(unsigned long))
 		     ipw_irq_tasklet, (unsigned long)priv);
@@ -10309,10 +10309,10 @@ static int ipw_config(struct ipw_priv *p
 		if (ipw_send_rts_threshold(priv, priv->rts_threshold))
 			goto error;
 	}
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	IPW_DEBUG_QOS("QoS: call ipw_qos_activate\n");
 	ipw_qos_activate(priv, NULL);
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 	if (ipw_set_random_seed(priv))
 		goto error;
@@ -11023,11 +11023,11 @@ static int ipw_pci_probe(struct pci_dev 
 	priv->ieee->set_security = shim__set_security;
 	priv->ieee->is_queue_full = ipw_net_is_queue_full;
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 	priv->ieee->handle_probe_response = ipw_handle_beacon;
 	priv->ieee->handle_beacon = ipw_handle_probe_response;
 	priv->ieee->handle_assoc_response = ipw_handle_assoc_response;
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 	priv->ieee->perfect_rssi = -20;
 	priv->ieee->worst_rssi = -85;
@@ -11256,7 +11256,7 @@ MODULE_PARM_DESC(debug, "debug output ma
 module_param(channel, int, 0444);
 MODULE_PARM_DESC(channel, "channel to limit associate to (default 0 [ANY])");
 
-#ifdef CONFIG_IPW_QOS
+#ifdef CONFIG_IPW2200_QOS
 module_param(qos_enable, int, 0444);
 MODULE_PARM_DESC(qos_enable, "enable all QoS functionalitis");
 
@@ -11271,7 +11271,7 @@ MODULE_PARM_DESC(burst_duration_CCK, "se
 
 module_param(burst_duration_OFDM, int, 0444);
 MODULE_PARM_DESC(burst_duration_OFDM, "set OFDM burst value");
-#endif				/* CONFIG_IPW_QOS */
+#endif				/* CONFIG_IPW2200_QOS */
 
 #ifdef CONFIG_IPW2200_MONITOR
 module_param(mode, int, 0444);
diff -uprN linux-2.6.15-base/drivers/net/wireless/Kconfig 
linux-2.6.15/drivers/net/wireless/Kconfig
--- linux-2.6.15-base/drivers/net/wireless/Kconfig	2006-03-05 
01:17:52.000000000 +0100
+++ linux-2.6.15/drivers/net/wireless/Kconfig	2006-03-05 01:25:38.000000000 
+0100
@@ -237,6 +237,20 @@ config IPW2200_DEBUG
 	  If you are not trying to debug or develop the IPW2200 driver, you 
 	  most likely want to say N here.
 
+config IPW2200_MONITOR
+	bool "Enable promiscuous mode"
+	depends on IPW2200 && BROKEN
+	---help---
+	Enables promiscuous/monitor mode support for the ipw2200 driver.
+	
+	With this feature compiled into the driver, you can switch to.
+	promiscuous mode via the Wireless Tool's Monitor mode.  While in this
+	mode, no packets can be sent.
+	
+config IPW2200_QOS
+	bool "Enable QoS support"
+	depends on IPW2200 && EXPERIMENTAL
+
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
 	depends on NET_RADIO && ISA_DMA_API && CRYPTO && (PCI || BROKEN)
