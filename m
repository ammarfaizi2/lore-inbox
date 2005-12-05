Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVLEFr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVLEFr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLEFr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:47:29 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:61603 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751094AbVLEFr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:47:28 -0500
Date: Mon, 5 Dec 2005 06:47:26 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051205055235.14897.57377.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
References: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 1/3] net: Replace driver_data with dev_[gs]et_drvdata
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace (found) dev->driver_data with dev_[gs]et_drvdata() + ^L deletion.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 3c509.c            |    2 +-
 depca.c            |    2 +-
 dgrs.c             |    4 ++--
 hp100.c            |    4 ++--
 ne3210.c           |    4 ++--
 smc-mca.c          |    4 ++--
 tulip/de4x5.c      |    6 +++---
 wireless/ipw2100.c |    8 ++++----
 wireless/ipw2200.c |   46 +++++++++++++++++++++++-----------------------
 9 files changed, 40 insertions(+), 40 deletions(-)

diff -Narup a/drivers/net/3c509.c b/drivers/net/3c509.c
--- a/drivers/net/3c509.c	2005-12-02 16:15:04.000000000 +0100
+++ b/drivers/net/3c509.c	2005-12-02 16:15:17.000000000 +0100
@@ -744,7 +744,7 @@ static int __devexit el3_device_remove (
 {
 	struct net_device *dev;
 
-	dev  = device->driver_data;
+	dev = dev_get_drvdata(device);
 
 	el3_common_remove (dev);
 	return 0;
diff -Narup a/drivers/net/depca.c b/drivers/net/depca.c
--- a/drivers/net/depca.c	2005-12-02 16:17:11.000000000 +0100
+++ b/drivers/net/depca.c	2005-12-02 16:17:13.000000000 +0100
@@ -1624,7 +1624,7 @@ static int __devexit depca_device_remove
 	struct depca_private *lp;
 	int bus;
 
-	dev  = device->driver_data;
+	dev  = dev_get_drvdata(device);
 	lp   = dev->priv;
 
 	unregister_netdev (dev);
diff -Narup a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	2005-12-02 10:24:57.000000000 +0100
+++ b/drivers/net/dgrs.c	2005-12-02 10:47:57.000000000 +0100
@@ -1494,7 +1494,7 @@ static int __init dgrs_eisa_probe (struc
 		goto err_out;
 	}
 
-	gendev->driver_data = dev;
+	dev_set_drvdata(gendev, dev);
 	return 0;
  err_out:
 	release_region(io, 256);
@@ -1503,7 +1503,7 @@ static int __init dgrs_eisa_probe (struc
 
 static int __devexit dgrs_eisa_remove(struct device *gendev)
 {
-	struct net_device *dev = gendev->driver_data;
+	struct net_device *dev = dev_get_drvdata(gendev);
 	
 	dgrs_remove(dev);
 
diff -Narup a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	2005-12-02 12:10:26.000000000 +0100
+++ b/drivers/net/hp100.c	2005-12-02 12:14:49.000000000 +0100
@@ -2869,7 +2869,7 @@ static int __init hp100_eisa_probe (stru
 	printk("hp100: %s: EISA adapter found at 0x%x\n", dev->name, 
 	       dev->base_addr);
 #endif
-	gendev->driver_data = dev;
+	dev_set_drvdata(gendev, dev);
 	return 0;
  out1:
 	free_netdev(dev);
@@ -2878,7 +2878,7 @@ static int __init hp100_eisa_probe (stru
 
 static int __devexit hp100_eisa_remove (struct device *gendev)
 {
-	struct net_device *dev = gendev->driver_data;
+	struct net_device *dev = dev_get_drvdata(gendev);
 	cleanup_dev(dev);
 	return 0;
 }
diff -Narup a/drivers/net/ne3210.c b/drivers/net/ne3210.c
--- a/drivers/net/ne3210.c	2005-12-02 16:07:28.000000000 +0100
+++ b/drivers/net/ne3210.c	2005-12-02 16:06:38.000000000 +0100
@@ -107,7 +107,7 @@ static int __init ne3210_eisa_probe (str
 
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, device);
-	device->driver_data = dev;
+	dev_set_drvdata(device, dev);
 	ioaddr = edev->base_addr;
 
 	if (!request_region(ioaddr, NE3210_IO_EXTENT, DRV_NAME)) {
@@ -232,7 +232,7 @@ static int __init ne3210_eisa_probe (str
 
 static int __devexit ne3210_eisa_remove (struct device *device)
 {
-	struct net_device  *dev    = device->driver_data;
+	struct net_device  *dev    = dev_get_drvdata(device);
 	unsigned long       ioaddr = to_eisa_device (device)->base_addr;
 
 	unregister_netdev (dev);
diff -Narup a/drivers/net/smc-mca.c b/drivers/net/smc-mca.c
--- a/drivers/net/smc-mca.c	2005-12-02 12:23:36.000000000 +0100
+++ b/drivers/net/smc-mca.c	2005-12-02 12:28:35.000000000 +0100
@@ -353,7 +353,7 @@ static int __init ultramca_probe(struct 
 
 	outb(reg4, ioaddr + 4);
 
-	gen_dev->driver_data = dev;
+	dev_set_drvdata(gen_dev, dev);
 
 	/* The 8390 isn't at the base address, so fake the offset
 	 */
@@ -519,7 +519,7 @@ static int ultramca_close_card(struct ne
 static int ultramca_remove(struct device *gen_dev)
 {
 	struct mca_device *mca_dev = to_mca_device(gen_dev);
-	struct net_device *dev = (struct net_device *)gen_dev->driver_data;
+	struct net_device *dev = dev_get_drvdata(gen_dev);
 
 	if (dev) {
 		/* NB: ultra_close_card() does free_irq */
diff -Narup a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	2005-12-02 12:16:29.000000000 +0100
+++ b/drivers/net/tulip/de4x5.c	2005-12-02 16:18:44.000000000 +0100
@@ -1081,7 +1081,7 @@ static int (*dc_infoblock[])(struct net_
     mdelay(2);                           /* Wait for 2ms */\
 }
 
-
+
 static int __devinit 
 de4x5_hw_init(struct net_device *dev, u_long iobase, struct device *gendev)
 {
@@ -1090,7 +1090,7 @@ de4x5_hw_init(struct net_device *dev, u_
     struct pci_dev *pdev = NULL;
     int i, status=0;
 
-    gendev->driver_data = dev;
+    dev_set_drvdata(gendev, dev);
 
     /* Ensure we're not sleeping */
     if (lp->bus == EISA) {
@@ -2100,7 +2100,7 @@ static int __devexit de4x5_eisa_remove (
 	struct net_device *dev;
 	u_long iobase;
 
-	dev = device->driver_data;
+	dev = dev_get_drvdata(device);
 	iobase = dev->base_addr;
 	
 	unregister_netdev (dev);
diff -Narup a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
--- a/drivers/net/wireless/ipw2100.c	2005-12-02 15:50:15.000000000 +0100
+++ b/drivers/net/wireless/ipw2100.c	2005-12-02 15:52:39.000000000 +0100
@@ -3362,7 +3362,7 @@ static DEVICE_ATTR(pci, S_IRUGO, show_pc
 static ssize_t show_cfg(struct device *d, struct device_attribute *attr,
 			char *buf)
 {
-	struct ipw2100_priv *p = d->driver_data;
+	struct ipw2100_priv *p = dev_get_drvdata(d);
 	return sprintf(buf, "0x%08x\n", (int)p->config);
 }
 
@@ -3371,7 +3371,7 @@ static DEVICE_ATTR(cfg, S_IRUGO, show_cf
 static ssize_t show_status(struct device *d, struct device_attribute *attr,
 			   char *buf)
 {
-	struct ipw2100_priv *p = d->driver_data;
+	struct ipw2100_priv *p = dev_get_drvdata(d);
 	return sprintf(buf, "0x%08x\n", (int)p->status);
 }
 
@@ -3380,7 +3380,7 @@ static DEVICE_ATTR(status, S_IRUGO, show
 static ssize_t show_capability(struct device *d, struct device_attribute *attr,
 			       char *buf)
 {
-	struct ipw2100_priv *p = d->driver_data;
+	struct ipw2100_priv *p = dev_get_drvdata(d);
 	return sprintf(buf, "0x%08x\n", (int)p->capability);
 }
 
@@ -4102,7 +4102,7 @@ static ssize_t show_rf_kill(struct devic
 	   1 - SW based RF kill active (sysfs)
 	   2 - HW based RF kill active
 	   3 - Both HW and SW baed RF kill active */
-	struct ipw2100_priv *priv = (struct ipw2100_priv *)d->driver_data;
+	struct ipw2100_priv *priv = dev_get_drvdata(d);
 	int val = ((priv->status & STATUS_RF_KILL_SW) ? 0x1 : 0x0) |
 	    (rf_kill_active(priv) ? 0x2 : 0x0);
 	return sprintf(buf, "%i\n", val);
diff -Narup a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
--- a/drivers/net/wireless/ipw2200.c	2005-12-02 15:38:51.000000000 +0100
+++ b/drivers/net/wireless/ipw2200.c	2005-12-02 15:48:18.000000000 +0100
@@ -1305,7 +1305,7 @@ static DEVICE_ATTR(led, S_IWUSR | S_IRUG
 static ssize_t show_status(struct device *d,
 			   struct device_attribute *attr, char *buf)
 {
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 	return sprintf(buf, "0x%08x\n", (int)p->status);
 }
 
@@ -1314,7 +1314,7 @@ static DEVICE_ATTR(status, S_IRUGO, show
 static ssize_t show_cfg(struct device *d, struct device_attribute *attr,
 			char *buf)
 {
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 	return sprintf(buf, "0x%08x\n", (int)p->config);
 }
 
@@ -1323,7 +1323,7 @@ static DEVICE_ATTR(cfg, S_IRUGO, show_cf
 static ssize_t show_nic_type(struct device *d,
 			     struct device_attribute *attr, char *buf)
 {
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 	return sprintf(buf, "TYPE: %d\n", priv->nic_type);
 }
 
@@ -1333,7 +1333,7 @@ static ssize_t show_ucode_version(struct
 				  struct device_attribute *attr, char *buf)
 {
 	u32 len = sizeof(u32), tmp = 0;
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 
 	if (ipw_get_ordinal(p, IPW_ORD_STAT_UCODE_VERSION, &tmp, &len))
 		return 0;
@@ -1347,7 +1347,7 @@ static ssize_t show_rtc(struct device *d
 			char *buf)
 {
 	u32 len = sizeof(u32), tmp = 0;
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 
 	if (ipw_get_ordinal(p, IPW_ORD_STAT_RTC, &tmp, &len))
 		return 0;
@@ -1364,14 +1364,14 @@ static DEVICE_ATTR(rtc, S_IWUSR | S_IRUG
 static ssize_t show_eeprom_delay(struct device *d,
 				 struct device_attribute *attr, char *buf)
 {
-	int n = ((struct ipw_priv *)d->driver_data)->eeprom_delay;
+	int n = ((struct ipw_priv *)dev_get_drvdata(d))->eeprom_delay;
 	return sprintf(buf, "%i\n", n);
 }
 static ssize_t store_eeprom_delay(struct device *d,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 	sscanf(buf, "%i", &p->eeprom_delay);
 	return strnlen(buf, count);
 }
@@ -1383,7 +1383,7 @@ static ssize_t show_command_event_reg(st
 				      struct device_attribute *attr, char *buf)
 {
 	u32 reg = 0;
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 
 	reg = ipw_read_reg32(p, IPW_INTERNAL_CMD_EVENT);
 	return sprintf(buf, "0x%08x\n", reg);
@@ -1393,7 +1393,7 @@ static ssize_t store_command_event_reg(s
 				       const char *buf, size_t count)
 {
 	u32 reg;
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 
 	sscanf(buf, "%x", &reg);
 	ipw_write_reg32(p, IPW_INTERNAL_CMD_EVENT, reg);
@@ -1407,7 +1407,7 @@ static ssize_t show_mem_gpio_reg(struct 
 				 struct device_attribute *attr, char *buf)
 {
 	u32 reg = 0;
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 
 	reg = ipw_read_reg32(p, 0x301100);
 	return sprintf(buf, "0x%08x\n", reg);
@@ -1417,7 +1417,7 @@ static ssize_t store_mem_gpio_reg(struct
 				  const char *buf, size_t count)
 {
 	u32 reg;
-	struct ipw_priv *p = d->driver_data;
+	struct ipw_priv *p = dev_get_drvdata(d);
 
 	sscanf(buf, "%x", &reg);
 	ipw_write_reg32(p, 0x301100, reg);
@@ -1431,7 +1431,7 @@ static ssize_t show_indirect_dword(struc
 				   struct device_attribute *attr, char *buf)
 {
 	u32 reg = 0;
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	if (priv->status & STATUS_INDIRECT_DWORD)
 		reg = ipw_read_reg32(priv, priv->indirect_dword);
@@ -1444,7 +1444,7 @@ static ssize_t store_indirect_dword(stru
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	sscanf(buf, "%x", &priv->indirect_dword);
 	priv->status |= STATUS_INDIRECT_DWORD;
@@ -1458,7 +1458,7 @@ static ssize_t show_indirect_byte(struct
 				  struct device_attribute *attr, char *buf)
 {
 	u8 reg = 0;
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	if (priv->status & STATUS_INDIRECT_BYTE)
 		reg = ipw_read_reg8(priv, priv->indirect_byte);
@@ -1471,7 +1471,7 @@ static ssize_t store_indirect_byte(struc
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	sscanf(buf, "%x", &priv->indirect_byte);
 	priv->status |= STATUS_INDIRECT_BYTE;
@@ -1485,7 +1485,7 @@ static ssize_t show_direct_dword(struct 
 				 struct device_attribute *attr, char *buf)
 {
 	u32 reg = 0;
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	if (priv->status & STATUS_DIRECT_DWORD)
 		reg = ipw_read32(priv, priv->direct_dword);
@@ -1498,7 +1498,7 @@ static ssize_t store_direct_dword(struct
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	sscanf(buf, "%x", &priv->direct_dword);
 	priv->status |= STATUS_DIRECT_DWORD;
@@ -1525,7 +1525,7 @@ static ssize_t show_rf_kill(struct devic
 	   1 - SW based RF kill active (sysfs)
 	   2 - HW based RF kill active
 	   3 - Both HW and SW baed RF kill active */
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 	int val = ((priv->status & STATUS_RF_KILL_SW) ? 0x1 : 0x0) |
 	    (rf_kill_active(priv) ? 0x2 : 0x0);
 	return sprintf(buf, "%i\n", val);
@@ -1565,7 +1565,7 @@ static int ipw_radio_kill_sw(struct ipw_
 static ssize_t store_rf_kill(struct device *d, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct ipw_priv *priv = d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 
 	ipw_radio_kill_sw(priv, buf[0] == '1');
 
@@ -1577,7 +1577,7 @@ static DEVICE_ATTR(rf_kill, S_IWUSR | S_
 static ssize_t show_speed_scan(struct device *d, struct device_attribute *attr,
 			       char *buf)
 {
-	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 	int pos = 0, len = 0;
 	if (priv->config & CFG_SPEED_SCAN) {
 		while (priv->speed_scan[pos] != 0)
@@ -1592,7 +1592,7 @@ static ssize_t show_speed_scan(struct de
 static ssize_t store_speed_scan(struct device *d, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 	int channel, pos = 0;
 	const char *p = buf;
 
@@ -1631,14 +1631,14 @@ static DEVICE_ATTR(speed_scan, S_IWUSR |
 static ssize_t show_net_stats(struct device *d, struct device_attribute *attr,
 			      char *buf)
 {
-	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 	return sprintf(buf, "%c\n", (priv->config & CFG_NET_STATS) ? '1' : '0');
 }
 
 static ssize_t store_net_stats(struct device *d, struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
-	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
+	struct ipw_priv *priv = dev_get_drvdata(d);
 	if (buf[0] == '1')
 		priv->config |= CFG_NET_STATS;
 	else
