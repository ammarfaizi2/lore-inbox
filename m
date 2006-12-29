Return-Path: <linux-kernel-owner+w=401wt.eu-S1755033AbWL2CKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbWL2CKJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 21:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755036AbWL2CKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 21:10:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1801 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755032AbWL2CKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 21:10:08 -0500
Date: Fri, 29 Dec 2006 03:10:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, rolandd@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [-mm patch] infiniband/ulp/ipoib/ipoib_cm.c: make functions static
Message-ID: <20061229021009.GN20714@stusta.de>
References: <20061228024237.375a482f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc1-mm1:
>...
>  git-infiniband.patch
>...
>  git trees
>...


This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/infiniband/ulp/ipoib/ipoib_cm.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- linux-2.6.20-rc2-mm1/drivers/infiniband/ulp/ipoib/ipoib_cm.c.old	2006-12-29 01:40:17.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/infiniband/ulp/ipoib/ipoib_cm.c	2006-12-29 01:43:22.000000000 +0100
@@ -56,7 +56,8 @@
 	u32 remote_mtu;
 };
 
-int ipoib_cm_tx_handler(struct ib_cm_id *cm_id, struct ib_cm_event *event);
+static int ipoib_cm_tx_handler(struct ib_cm_id *cm_id,
+			       struct ib_cm_event *event);
 
 static void ipoib_cm_dma_unmap_rx(struct ipoib_dev_priv *priv,
 				  dma_addr_t mapping[IPOIB_CM_RX_SG])
@@ -265,7 +266,8 @@
 	return ret;
 }
 
-int ipoib_cm_rx_handler(struct ib_cm_id *cm_id, struct ib_cm_event *event)
+static int ipoib_cm_rx_handler(struct ib_cm_id *cm_id,
+			       struct ib_cm_event *event)
 {
 	struct ipoib_cm_rx *p;
 	struct ipoib_dev_priv *priv;
@@ -396,7 +398,7 @@
 			   "for buf %d\n", wr_id);
 }
 
-void ipoib_cm_rx_completion(struct ib_cq *cq, void *dev_ptr)
+static void ipoib_cm_rx_completion(struct ib_cq *cq, void *dev_ptr)
 {
 	struct net_device *dev = (struct net_device *) dev_ptr;
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
@@ -550,7 +552,7 @@
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 }
 
-void ipoib_cm_tx_completion(struct ib_cq *cq, void *tx_ptr)
+static void ipoib_cm_tx_completion(struct ib_cq *cq, void *tx_ptr)
 {
 	struct ipoib_cm_tx *tx = tx_ptr;
 	int n, i;
@@ -768,7 +770,8 @@
 	return 0;
 }
 
-int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn, struct ib_sa_path_rec *pathrec)
+static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
+			    struct ib_sa_path_rec *pathrec)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(p->dev);
 	int ret;
@@ -841,7 +844,7 @@
 	return ret;
 }
 
-void ipoib_cm_tx_destroy(struct ipoib_cm_tx *p)
+static void ipoib_cm_tx_destroy(struct ipoib_cm_tx *p)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(p->dev);
 	struct ipoib_tx_buf *tx_req;
@@ -875,7 +878,8 @@
 	kfree(p);
 }
 
-int ipoib_cm_tx_handler(struct ib_cm_id *cm_id, struct ib_cm_event *event)
+static int ipoib_cm_tx_handler(struct ib_cm_id *cm_id,
+			       struct ib_cm_event *event)
 {
 	struct ipoib_cm_tx *tx = cm_id->context;
 	struct ipoib_dev_priv *priv = netdev_priv(tx->dev);
@@ -960,7 +964,7 @@
 	}
 }
 
-void ipoib_cm_tx_start(struct work_struct *work)
+static void ipoib_cm_tx_start(struct work_struct *work)
 {
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, cm.start_task);
@@ -1003,7 +1007,7 @@
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 }
 
-void ipoib_cm_tx_reap(struct work_struct *work)
+static void ipoib_cm_tx_reap(struct work_struct *work)
 {
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, cm.reap_task);

