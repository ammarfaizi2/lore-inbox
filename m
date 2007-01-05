Return-Path: <linux-kernel-owner+w=401wt.eu-S1030312AbXAEFlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbXAEFlw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 00:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbXAEFlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 00:41:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:59168 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030312AbXAEFlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 00:41:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=GdqVfLurwASphrnStwlGCzE7sv7l106UK+ni8nOCX54kctwz3Y4MYoqFNpqRUGwDSa3ykLGQJ7j54rJJioCHsgdOeRLSZsIABPuBN2lSskUzTLf3Nvb8pS5Yt32zwM/8x7bZM7AqMYUIyqL3ow2+/U5yi6pEfRaWthK0Xx3650o=
Date: Fri, 5 Jan 2007 07:41:43 +0200
To: yi.zhu@intel.com, jketreno@linux.intel.com,
       ipw2100-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] Remove unneeded kmalloc casts
Message-ID: <20070105054143.GA10679@Ahmed>
Mail-Followup-To: yi.zhu@intel.com, jketreno@linux.intel.com,
	ipw2100-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded kmalloc casts

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 0e94fbb..682b1bb 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -3361,11 +3361,9 @@ static int ipw2100_msg_allocate(struct ipw2100_priv *priv)
 	void *v;
 	dma_addr_t p;
 
-	priv->msg_buffers =
-	    (struct ipw2100_tx_packet *)kmalloc(IPW_COMMAND_POOL_SIZE *
-						sizeof(struct
-						       ipw2100_tx_packet),
-						GFP_KERNEL);
+	priv->msg_buffers = kmalloc(IPW_COMMAND_POOL_SIZE * 
+				    sizeof(struct ipw2100_tx_packet), 
+				    GFP_KERNEL);
 	if (!priv->msg_buffers) {
 		printk(KERN_ERR DRV_NAME ": %s: PCI alloc failed for msg "
 		       "buffers.\n", priv->net_dev->name);
@@ -4395,11 +4393,9 @@ static int ipw2100_tx_allocate(struct ipw2100_priv *priv)
 		return err;
 	}
 
-	priv->tx_buffers =
-	    (struct ipw2100_tx_packet *)kmalloc(TX_PENDED_QUEUE_LENGTH *
-						sizeof(struct
-						       ipw2100_tx_packet),
-						GFP_ATOMIC);
+	priv->tx_buffers = kmalloc(TX_PENDED_QUEUE_LENGTH *
+				   sizeof(struct ipw2100_tx_packet), 
+				   GFP_ATOMIC);
 	if (!priv->tx_buffers) {
 		printk(KERN_ERR DRV_NAME
 		       ": %s: alloc failed form tx buffers.\n",
@@ -4548,9 +4544,9 @@ static int ipw2100_rx_allocate(struct ipw2100_priv *priv)
 	/*
 	 * allocate packets
 	 */
-	priv->rx_buffers = (struct ipw2100_rx_packet *)
-	    kmalloc(RX_QUEUE_LENGTH * sizeof(struct ipw2100_rx_packet),
-		    GFP_KERNEL);
+	priv->rx_buffers = kmalloc(RX_QUEUE_LENGTH * 
+				   sizeof(struct ipw2100_rx_packet),
+				   GFP_KERNEL);
 	if (!priv->rx_buffers) {
 		IPW_DEBUG_INFO("can't allocate rx packet buffer table\n");
 

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
