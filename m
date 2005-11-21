Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVKUQNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVKUQNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVKUQNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:13:11 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:25754 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932351AbVKUQNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:13:07 -0500
Message-ID: <4381F1F9.60108@ens-lyon.org>
Date: Mon, 21 Nov 2005 11:12:41 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "James P. Ketrenos" <ipw2100-admin@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Duplicate IPW_DEBUG option for ipw2100 and 2200
Content-Type: multipart/mixed;
 boundary="------------010402090709070109040102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010402090709070109040102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Andrew,

There are currently two IPW_DEBUG options in drivers/net/wireless/Kconfig
(one for ipw2100 and one for ipw2200). The attached patch splits it into
IPW2100_DEBUG and IPW2200_DEBUG. It applies on top of -rc1-mm2 and -rc2.

By the way, a patch for the forgotten IPW2200_MONITOR patch has been posted
a week ago (http://lkml.org/lkml/2005/11/12/229). Could be good to have
it in -mm :)

Thanks,
Brice

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>


--------------010402090709070109040102
Content-Type: text/x-patch;
 name="split-duplicate-ipw_debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="split-duplicate-ipw_debug.diff"

--- linux-mm/drivers/net/wireless/Kconfig.old	2005-11-21 10:54:05.000000000 -0500
+++ linux-mm/drivers/net/wireless/Kconfig	2005-11-21 10:54:23.000000000 -0500
@@ -173,7 +173,7 @@ config IPW2100_MONITOR
 	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
 	  mode, no packets can be sent.
 
-config IPW_DEBUG
+config IPW2100_DEBUG
 	bool "Enable full debugging output in IPW2100 module."
 	depends on IPW2100
 	---help---
@@ -217,7 +217,7 @@ config IPW2200
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2200.ko.
 
-config IPW_DEBUG
+config IPW2200_DEBUG
 	bool "Enable full debugging output in IPW2200 module."
 	depends on IPW2200
 	---help---
--- linux-mm/drivers/net/wireless/ipw2100.h.old	2005-11-21 10:57:25.000000000 -0500
+++ linux-mm/drivers/net/wireless/ipw2100.h	2005-11-21 10:58:17.000000000 -0500
@@ -73,7 +73,7 @@ struct ipw2100_rx_packet;
  * you simply need to add your entry to the ipw2100_debug_levels array.
  *
  * If you do not see debug_level in /proc/net/ipw2100 then you do not have
- * CONFIG_IPW_DEBUG defined in your kernel configuration
+ * CONFIG_IPW2100_DEBUG defined in your kernel configuration
  *
  */
 
--- linux-mm/drivers/net/wireless/ipw2100.c.old	2005-11-21 10:57:21.000000000 -0500
+++ linux-mm/drivers/net/wireless/ipw2100.c	2005-11-21 10:58:05.000000000 -0500
@@ -175,7 +175,7 @@ that only one external action is invoked
 #define DRV_COPYRIGHT	"Copyright(c) 2003-2005 Intel Corporation"
 
 /* Debugging stuff */
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 #define CONFIG_IPW2100_RX_DEBUG	/* Reception debugging */
 #endif
 
@@ -208,7 +208,7 @@ MODULE_PARM_DESC(disable, "manually disa
 
 static u32 ipw2100_debug_level = IPW_DL_NONE;
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 #define IPW_DEBUG(level, message...) \
 do { \
 	if (ipw2100_debug_level & (level)) { \
@@ -219,9 +219,9 @@ do { \
 } while (0)
 #else
 #define IPW_DEBUG(level, message...) do {} while (0)
-#endif				/* CONFIG_IPW_DEBUG */
+#endif				/* CONFIG_IPW2100_DEBUG */
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 static const char *command_types[] = {
 	"undefined",
 	"unused",		/* HOST_ATTENTION */
@@ -2081,7 +2081,7 @@ static void isr_scan_complete(struct ipw
 	priv->status &= ~STATUS_SCANNING;
 }
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 #define IPW2100_HANDLER(v, f) { v, f, # v }
 struct ipw2100_status_indicator {
 	int status;
@@ -2094,7 +2094,7 @@ struct ipw2100_status_indicator {
 	int status;
 	void (*cb) (struct ipw2100_priv * priv, u32 status);
 };
-#endif				/* CONFIG_IPW_DEBUG */
+#endif				/* CONFIG_IPW2100_DEBUG */
 
 static void isr_indicate_scanning(struct ipw2100_priv *priv, u32 status)
 {
@@ -2149,7 +2149,7 @@ static void isr_status_change(struct ipw
 static void isr_rx_complete_command(struct ipw2100_priv *priv,
 				    struct ipw2100_cmd_header *cmd)
 {
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 	if (cmd->host_command_reg < ARRAY_SIZE(command_types)) {
 		IPW_DEBUG_HC("Command completed '%s (%d)'\n",
 			     command_types[cmd->host_command_reg],
@@ -2167,7 +2167,7 @@ static void isr_rx_complete_command(stru
 	wake_up_interruptible(&priv->wait_command_queue);
 }
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 static const char *frame_types[] = {
 	"COMMAND_STATUS_VAL",
 	"STATUS_CHANGE_VAL",
@@ -2290,7 +2290,7 @@ static u8 packet_data[IPW_RX_NIC_BUFFER_
 
 static inline void ipw2100_corruption_detected(struct ipw2100_priv *priv, int i)
 {
-#ifdef CONFIG_IPW_DEBUG_C3
+#ifdef CONFIG_IPW2100_DEBUG_C3
 	struct ipw2100_status *status = &priv->status_queue.drv[i];
 	u32 match, reg;
 	int j;
@@ -2312,7 +2312,7 @@ static inline void ipw2100_corruption_de
 	}
 #endif
 
-#ifdef CONFIG_IPW_DEBUG_C3
+#ifdef CONFIG_IPW2100_DEBUG_C3
 	/* Halt the fimrware so we can get a good image */
 	write_register(priv->net_dev, IPW_REG_RESET_REG,
 		       IPW_AUX_HOST_RESET_REG_STOP_MASTER);
@@ -2716,7 +2716,7 @@ static inline int __ipw2100_tx_process(s
 	list_del(element);
 	DEC_STAT(&priv->fw_pend_stat);
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 	{
 		int i = txq->oldest;
 		IPW_DEBUG_TX("TX%d V=%p P=%04X T=%04X L=%d\n", i,
@@ -2782,7 +2782,7 @@ static inline int __ipw2100_tx_process(s
 			       "something else: ids %d=%d.\n",
 			       priv->net_dev->name, txq->oldest, packet->index);
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 		if (packet->info.c_struct.cmd->host_command_reg <
 		    sizeof(command_types) / sizeof(*command_types))
 			IPW_DEBUG_TX("Command '%s (%d)' processed: %d.\n",
@@ -2975,7 +2975,7 @@ static void ipw2100_tx_send_data(struct 
 
 		IPW_DEBUG_TX("data header tbd TX%d P=%08x L=%d\n",
 			     packet->index, tbd->host_addr, tbd->buf_length);
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 		if (packet->info.d_struct.txb->nr_frags > 1)
 			IPW_DEBUG_FRAG("fragment Tx: %d frames\n",
 				       packet->info.d_struct.txb->nr_frags);
@@ -3827,7 +3827,7 @@ static ssize_t show_stats(struct device 
 		       priv->rx_interrupts, priv->inta_other);
 	out += sprintf(out, "firmware resets: %d\n", priv->resets);
 	out += sprintf(out, "firmware hangs: %d\n", priv->hangs);
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 	out += sprintf(out, "packet mismatch image: %s\n",
 		       priv->snapshot[0] ? "YES" : "NO");
 #endif
@@ -3982,7 +3982,7 @@ static ssize_t show_bssinfo(struct devic
 
 static DEVICE_ATTR(bssinfo, S_IRUGO, show_bssinfo, NULL);
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 static ssize_t show_debug_level(struct device_driver *d, char *buf)
 {
 	return sprintf(buf, "0x%08X\n", ipw2100_debug_level);
@@ -4011,7 +4011,7 @@ static ssize_t store_debug_level(struct 
 
 static DRIVER_ATTR(debug_level, S_IWUSR | S_IRUGO, show_debug_level,
 		   store_debug_level);
-#endif				/* CONFIG_IPW_DEBUG */
+#endif				/* CONFIG_IPW2100_DEBUG */
 
 static ssize_t show_fatal_error(struct device *d,
 				struct device_attribute *attr, char *buf)
@@ -4937,7 +4937,7 @@ static int ipw2100_set_mandatory_bssid(s
 	};
 	int err;
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 	if (bssid != NULL)
 		IPW_DEBUG_HC("MANDATORY_BSSID: %02X:%02X:%02X:%02X:%02X:%02X\n",
 			     bssid[0], bssid[1], bssid[2], bssid[3], bssid[4],
@@ -6857,7 +6857,7 @@ static int __init ipw2100_init(void)
 
 	ret = pci_module_init(&ipw2100_pci_driver);
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 	ipw2100_debug_level = debug;
 	driver_create_file(&ipw2100_pci_driver.driver,
 			   &driver_attr_debug_level);
@@ -6872,7 +6872,7 @@ static int __init ipw2100_init(void)
 static void __exit ipw2100_exit(void)
 {
 	/* FIXME: IPG: check that we have no instances of the devices open */
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 	driver_remove_file(&ipw2100_pci_driver.driver,
 			   &driver_attr_debug_level);
 #endif
@@ -8562,7 +8562,7 @@ static struct iw_statistics *ipw2100_wx_
 
 		quality = min(beacon_qual, min(tx_qual, rssi_qual));
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2100_DEBUG
 		if (beacon_qual == quality)
 			IPW_DEBUG_WX("Quality clamped by Missed Beacons\n");
 		else if (tx_qual == quality)
--- linux-mm/drivers/net/wireless/ipw2200.h.old	2005-11-21 10:57:11.000000000 -0500
+++ linux-mm/drivers/net/wireless/ipw2200.h	2005-11-21 10:56:46.000000000 -0500
@@ -1301,14 +1301,14 @@ struct ipw_priv {
 
 /* debug macros */
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 #define IPW_DEBUG(level, fmt, args...) \
 do { if (ipw_debug_level & (level)) \
   printk(KERN_DEBUG DRV_NAME": %c %s " fmt, \
          in_interrupt() ? 'I' : 'U', __FUNCTION__ , ## args); } while (0)
 #else
 #define IPW_DEBUG(level, fmt, args...) do {} while (0)
-#endif				/* CONFIG_IPW_DEBUG */
+#endif				/* CONFIG_IPW2200_DEBUG */
 
 /*
  * To use the debug system;
@@ -1332,7 +1332,7 @@ do { if (ipw_debug_level & (level)) \
  * you simply need to add your entry to the ipw_debug_levels array.
  *
  * If you do not see debug_level in /proc/net/ipw then you do not have
- * CONFIG_IPW_DEBUG defined in your kernel configuration
+ * CONFIG_IPW2200_DEBUG defined in your kernel configuration
  *
  */
 
--- linux-mm/drivers/net/wireless/ipw2200.c.old	2005-11-21 10:57:17.000000000 -0500
+++ linux-mm/drivers/net/wireless/ipw2200.c	2005-11-21 10:57:46.000000000 -0500
@@ -462,7 +462,7 @@ static inline void ipw_disable_interrupt
 	ipw_write32(priv, IPW_INTA_MASK_R, ~IPW_INTA_MASK_ALL);
 }
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 static char *ipw_error_desc(u32 val)
 {
 	switch (val) {
@@ -1235,7 +1235,7 @@ static ssize_t store_scan_age(struct dev
 			      const char *buf, size_t count)
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 	struct net_device *dev = priv->net_dev;
 #endif
 	char buffer[] = "00000000";
@@ -1754,7 +1754,7 @@ static void ipw_irq_tasklet(struct ipw_p
 		IPW_ERROR("Firmware error detected.  Restarting.\n");
 		if (priv->error) {
 			IPW_ERROR("Sysfs 'error' log already exists.\n");
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 			if (ipw_debug_level & IPW_DL_FW_ERRORS) {
 				struct ipw_fw_error *error =
 				    ipw_alloc_error_log(priv);
@@ -1770,7 +1770,7 @@ static void ipw_irq_tasklet(struct ipw_p
 			else
 				IPW_ERROR("Error allocating sysfs 'error' "
 					  "log.\n");
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 			if (ipw_debug_level & IPW_DL_FW_ERRORS)
 				ipw_dump_error_log(priv, priv->error);
 #endif
@@ -3778,7 +3778,7 @@ static const struct ipw_status_code ipw_
 	{0x2E, "Cipher suite is rejected per security policy"},
 };
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 static const char *ipw_get_status_code(u16 status)
 {
 	int i;
@@ -4250,7 +4250,7 @@ static inline void ipw_rx_notification(s
 					if (priv->
 					    status & (STATUS_ASSOCIATED |
 						      STATUS_AUTH)) {
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 						struct notif_authenticate *auth
 						    = &notif->u.auth;
 						IPW_DEBUG(IPW_DL_NOTIF |
@@ -5827,7 +5827,7 @@ static void ipw_bg_adhoc_check(void *dat
 	up(&priv->sem);
 }
 
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 static void ipw_debug_config(struct ipw_priv *priv)
 {
 	IPW_DEBUG_INFO("Scan completed, no valid APs matched "
@@ -7814,7 +7814,7 @@ static void ipw_rx(struct ipw_priv *priv
 
 	while (i != r) {
 		rxb = priv->rxq->queue[i];
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 		if (unlikely(rxb == NULL)) {
 			printk(KERN_CRIT "Queue not allocated!\n");
 			break;
@@ -10955,7 +10955,7 @@ static int ipw_pci_probe(struct pci_dev 
 
 	priv->net_dev = net_dev;
 	priv->pci_dev = pdev;
-#ifdef CONFIG_IPW_DEBUG
+#ifdef CONFIG_IPW2200_DEBUG
 	ipw_debug_level = debug;
 #endif
 	spin_lock_init(&priv->lock);

--------------010402090709070109040102--
