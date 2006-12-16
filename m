Return-Path: <linux-kernel-owner+w=401wt.eu-S1161438AbWLPTtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161438AbWLPTtQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 14:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWLPTtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 14:49:16 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33860 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161438AbWLPTtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 14:49:14 -0500
Date: Sat, 16 Dec 2006 20:47:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Divy Le Ray <divy@chelsio.com>
cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/10] cxgb3, p2
In-Reply-To: <4580E3D7.3050708@chelsio.com>
Message-ID: <Pine.LNX.4.61.0612162046190.5411@yvahk01.tjqt.qr>
References: <4580E3D7.3050708@chelsio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A corresponding monolithic patch is posted at the following URL:
> http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

Stylistic stuff that was mentioned. (TYPE * a  -> TYPE *a)

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc1/drivers/net/cxgb3/common.h
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/common.h
+++ linux-2.6.20-rc1/drivers/net/cxgb3/common.h
@@ -139,10 +139,10 @@ struct cphy;
 struct adapter;
 
 struct mdio_ops {
-	int (*read) (struct adapter * adapter, int phy_addr, int mmd_addr,
-		     int reg_addr, unsigned int *val);
-	int (*write) (struct adapter * adapter, int phy_addr, int mmd_addr,
-		      int reg_addr, unsigned int val);
+	int (*read)(struct adapter *adapter, int phy_addr, int mmd_addr,
+		    int reg_addr, unsigned int *val);
+	int (*write)(struct adapter *adapter, int phy_addr, int mmd_addr,
+		     int reg_addr, unsigned int val);
 };
 
 struct adapter_info {
@@ -158,8 +158,8 @@ struct adapter_info {
 };
 
 struct port_type_info {
-	void (*phy_prep) (struct cphy * phy, struct adapter * adapter,
-			  int phy_addr, const struct mdio_ops * ops);
+	void (*phy_prep)(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *ops);
 	unsigned int caps;
 	const char *desc;
 };
@@ -476,23 +476,23 @@ enum {
 
 /* PHY operations */
 struct cphy_ops {
-	void (*destroy) (struct cphy * phy);
-	int (*reset) (struct cphy * phy, int wait);
+	void (*destroy)(struct cphy *phy);
+	int (*reset)(struct cphy *phy, int wait);
 
-	int (*intr_enable) (struct cphy * phy);
-	int (*intr_disable) (struct cphy * phy);
-	int (*intr_clear) (struct cphy * phy);
-	int (*intr_handler) (struct cphy * phy);
-
-	int (*autoneg_enable) (struct cphy * phy);
-	int (*autoneg_restart) (struct cphy * phy);
-
-	int (*advertise) (struct cphy * phy, unsigned int advertise_map);
-	int (*set_loopback) (struct cphy * phy, int mmd, int dir, int enable);
-	int (*set_speed_duplex) (struct cphy * phy, int speed, int duplex);
-	int (*get_link_status) (struct cphy * phy, int *link_ok, int *speed,
-				int *duplex, int *fc);
-	int (*power_down) (struct cphy * phy, int enable);
+	int (*intr_enable)(struct cphy *phy);
+	int (*intr_disable)(struct cphy *phy);
+	int (*intr_clear)(struct cphy *phy);
+	int (*intr_handler)(struct cphy *phy);
+
+	int (*autoneg_enable)(struct cphy *phy);
+	int (*autoneg_restart)(struct cphy *phy);
+
+	int (*advertise)(struct cphy *phy, unsigned int advertise_map);
+	int (*set_loopback)(struct cphy *phy, int mmd, int dir, int enable);
+	int (*set_speed_duplex)(struct cphy *phy, int speed, int duplex);
+	int (*get_link_status)(struct cphy *phy, int *link_ok, int *speed,
+			       int *duplex, int *fc);
+	int (*power_down)(struct cphy *phy, int enable);
 };
 
 /* A PHY instance */
@@ -501,10 +501,10 @@ struct cphy {
 	struct adapter *adapter;	/* associated adapter */
 	unsigned long fifo_errors;	/* FIFO over/under-flows */
 	const struct cphy_ops *ops;	/* PHY operations */
-	int (*mdio_read) (struct adapter * adapter, int phy_addr, int mmd_addr,
-			  int reg_addr, unsigned int *val);
-	int (*mdio_write) (struct adapter * adapter, int phy_addr, int mmd_addr,
-			   int reg_addr, unsigned int val);
+	int (*mdio_read)(struct adapter *adapter, int phy_addr, int mmd_addr,
+			 int reg_addr, unsigned int *val);
+	int (*mdio_write)(struct adapter *adapter, int phy_addr, int mmd_addr,
+			  int reg_addr, unsigned int val);
 };
 
 /* Convenience MDIO read/write wrappers */
Index: linux-2.6.20-rc1/drivers/net/cxgb3/cxgb3_main.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/cxgb3_main.c
+++ linux-2.6.20-rc1/drivers/net/cxgb3/cxgb3_main.c
@@ -1479,7 +1479,7 @@ static int in_range(int val, int lo, int
 	return val < 0 || (val <= hi && val >= lo);
 }
 
-static int cxgb_extension_ioctl(struct net_device *dev, void __user * useraddr)
+static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
 {
 	int ret;
 	u32 cmd;
Index: linux-2.6.20-rc1/drivers/net/cxgb3/cxgb3_offload.h
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/cxgb3_offload.h
+++ linux-2.6.20-rc1/drivers/net/cxgb3/cxgb3_offload.h
@@ -64,16 +64,16 @@ void cxgb3_unregister_client(struct cxgb
 void cxgb3_add_clients(struct t3cdev *tdev);
 void cxgb3_remove_clients(struct t3cdev *tdev);
 
-typedef int (*cxgb3_cpl_handler_func) (struct t3cdev * dev,
-				       struct sk_buff * skb, void *ctx);
+typedef int (*cxgb3_cpl_handler_func)(struct t3cdev *dev,
+				      struct sk_buff *skb, void *ctx);
 
 struct cxgb3_client {
 	char *name;
 	void (*add) (struct t3cdev *);
 	void (*remove) (struct t3cdev *);
 	cxgb3_cpl_handler_func *handlers;
-	int (*redirect) (void *ctx, struct dst_entry * old,
-			 struct dst_entry * new, struct l2t_entry * l2t);
+	int (*redirect)(void *ctx, struct dst_entry *old,
+			struct dst_entry *new, struct l2t_entry *l2t);
 	struct list_head client_list;
 };
 
@@ -113,7 +113,7 @@ enum {
 	CPL_RET_UNKNOWN_TID = 4	/* unexpected unknown TID */
 };
 
-typedef int (*cpl_handler_func) (struct t3cdev * dev, struct sk_buff * skb);
+typedef int (*cpl_handler_func)(struct t3cdev *dev, struct sk_buff *skb);
 
 /*
  * Returns a pointer to the first byte of the CPL header in an sk_buff that
Index: linux-2.6.20-rc1/drivers/net/cxgb3/l2t.h
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/l2t.h
+++ linux-2.6.20-rc1/drivers/net/cxgb3/l2t.h
@@ -80,8 +80,8 @@ struct l2t_data {
 	struct l2t_entry l2tab[0];
 };
 
-typedef void (*arp_failure_handler_func) (struct t3cdev * dev,
-					  struct sk_buff * skb);
+typedef void (*arp_failure_handler_func)(struct t3cdev *dev,
+					 struct sk_buff *skb);
 
 /*
  * Callback stored in an skb to handle address resolution failure.
Index: linux-2.6.20-rc1/drivers/net/cxgb3/sge.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/sge.c
+++ linux-2.6.20-rc1/drivers/net/cxgb3/sge.c
@@ -426,7 +426,7 @@ static void recycle_rx_buf(struct adapte
  *	of the SW ring.
  */
 static void *alloc_ring(struct pci_dev *pdev, size_t nelem, size_t elem_size,
-			size_t sw_size, dma_addr_t * phys, void *metadata)
+			size_t sw_size, dma_addr_t *phys, void *metadata)
 {
 	size_t len = nelem * elem_size;
 	void *s = NULL;
@@ -2263,7 +2263,7 @@ static irqreturn_t t3b_intr_napi(int irq
  *	(MSI-X, MSI, or legacy) and whether NAPI will be used to service the
  *	response queues.
  */
-intr_handler_t t3_intr_handler(struct adapter * adap, int polling)
+intr_handler_t t3_intr_handler(struct adapter *adap, int polling)
 {
 	if (adap->flags & USING_MSIX)
 		return polling ? t3_sge_intr_msix_napi : t3_sge_intr_msix;
Index: linux-2.6.20-rc1/drivers/net/cxgb3/t3_hw.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/t3_hw.c
+++ linux-2.6.20-rc1/drivers/net/cxgb3/t3_hw.c
@@ -483,22 +483,22 @@ struct t3_vpd {
 	u8 id_data[16];
 	u8 vpdr_tag;
 	u8 vpdr_len[2];
-	 VPD_ENTRY(pn, 16);	/* part number */
-	 VPD_ENTRY(ec, 16);	/* EC level */
-	 VPD_ENTRY(sn, 16);	/* serial number */
-	 VPD_ENTRY(na, 12);	/* MAC address base */
-	 VPD_ENTRY(cclk, 6);	/* core clock */
-	 VPD_ENTRY(mclk, 6);	/* mem clock */
-	 VPD_ENTRY(uclk, 6);	/* uP clk */
-	 VPD_ENTRY(mdc, 6);	/* MDIO clk */
-	 VPD_ENTRY(mt, 2);	/* mem timing */
-	 VPD_ENTRY(xaui0cfg, 6);	/* XAUI0 config */
-	 VPD_ENTRY(xaui1cfg, 6);	/* XAUI1 config */
-	 VPD_ENTRY(port0, 2);	/* PHY0 complex */
-	 VPD_ENTRY(port1, 2);	/* PHY1 complex */
-	 VPD_ENTRY(port2, 2);	/* PHY2 complex */
-	 VPD_ENTRY(port3, 2);	/* PHY3 complex */
-	 VPD_ENTRY(rv, 1);	/* csum */
+	VPD_ENTRY(pn, 16);	/* part number */
+	VPD_ENTRY(ec, 16);	/* EC level */
+	VPD_ENTRY(sn, 16);	/* serial number */
+	VPD_ENTRY(na, 12);	/* MAC address base */
+	VPD_ENTRY(cclk, 6);	/* core clock */
+	VPD_ENTRY(mclk, 6);	/* mem clock */
+	VPD_ENTRY(uclk, 6);	/* uP clk */
+	VPD_ENTRY(mdc, 6);	/* MDIO clk */
+	VPD_ENTRY(mt, 2);	/* mem timing */
+	VPD_ENTRY(xaui0cfg, 6);	/* XAUI0 config */
+	VPD_ENTRY(xaui1cfg, 6);	/* XAUI1 config */
+	VPD_ENTRY(port0, 2);	/* PHY0 complex */
+	VPD_ENTRY(port1, 2);	/* PHY1 complex */
+	VPD_ENTRY(port2, 2);	/* PHY2 complex */
+	VPD_ENTRY(port3, 2);	/* PHY3 complex */
+	VPD_ENTRY(rv, 1);	/* csum */
 	u32 pad;		/* for multiple-of-4 sizing and alignment */
 };
 
@@ -611,7 +611,7 @@ static int get_vpd_params(struct adapter
 	 * Card information is normally at VPD_BASE but some early cards had
 	 * it at 0.
 	 */
-	ret = t3_seeprom_read(adapter, VPD_BASE, (u32 *) & vpd);
+	ret = t3_seeprom_read(adapter, VPD_BASE, (u32 *)&vpd);
 	if (ret)
 		return ret;
 	addr = vpd.id_tag == 0x82 ? VPD_BASE : 0;
@@ -789,7 +789,7 @@ int t3_read_flash(struct adapter *adapte
  *	at the given address.
  */
 static int t3_write_flash(struct adapter *adapter, unsigned int addr,
-			  unsigned int n, const u8 * data)
+			  unsigned int n, const u8 *data)
 {
 	int ret;
 	u32 buf[64];
@@ -899,7 +899,7 @@ static int t3_flash_erase_sectors(struct
  *	data, followed by 4 bytes of FW version, followed by the 32-bit
  *	1's complement checksum of the whole image.
  */
-int t3_load_fw(struct adapter *adapter, const u8 * fw_data, unsigned int size)
+int t3_load_fw(struct adapter *adapter, const u8 *fw_data, unsigned int size)
 {
 	u32 csum;
 	unsigned int i;
Index: linux-2.6.20-rc1/drivers/net/cxgb3/t3cdev.h
===================================================================
--- linux-2.6.20-rc1.orig/drivers/net/cxgb3/t3cdev.h
+++ linux-2.6.20-rc1/drivers/net/cxgb3/t3cdev.h
@@ -58,10 +58,10 @@ struct t3cdev {
 	struct list_head ofld_dev_list;	/* for list linking */
 	struct net_device *lldev;	/* LL dev associated with T3C messages */
 	struct proc_dir_entry *proc_dir;	/* root of proc dir for this T3C */
-	int (*send) (struct t3cdev * dev, struct sk_buff * skb);
-	int (*recv) (struct t3cdev * dev, struct sk_buff ** skb, int n);
-	int (*ctl) (struct t3cdev * dev, unsigned int req, void *data);
-	void (*neigh_update) (struct t3cdev * dev, struct neighbour * neigh);
+	int (*send)(struct t3cdev *dev, struct sk_buff *skb);
+	int (*recv)(struct t3cdev *dev, struct sk_buff **skb, int n);
+	int (*ctl)(struct t3cdev *dev, unsigned int req, void *data);
+	void (*neigh_update)(struct t3cdev *dev, struct neighbour *neigh);
 	void *priv;		/* driver private data */
 	void *l2opt;		/* optional layer 2 data */
 	void *l3opt;		/* optional layer 3 data */
#<EOF>

	-`J'
-- 
