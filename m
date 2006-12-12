Return-Path: <linux-kernel-owner+w=401wt.eu-S932222AbWLLQ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWLLQ7X (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWLLQ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:59:23 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:60634 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbWLLQ7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:59:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BqxmpMtY5lY0mAzZ2cRlmhdaIAk5QQVEqIV1V57ZHs15UZrEHAuno9QgcIriE0x1LY6gKvsehP2lLZyTcWMVU9UAo3AQ4Pnav355PHnDbUyQP8qPAdJvE0uER+fXUy9wxJVUL2yVVMxvKeOi7LH+OIx/XHk7jgDaHh90NZVY2Vk=
Subject: [PATCH 2.6.19] ep93xx: Some minor cleanups to the ep93xx eth driver
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Content-Type: text/plain
Date: Tue, 12 Dec 2006 19:00:41 +0200
Message-Id: <1165942841.5611.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanup in the Cirrus Logic EP93xx ethernet driver:
Check for NULL pointer before dereferencing it instead of after.
Remove unreferenced variable.

Signed-off-by: Yan Burman <burman.yan@gmail.com>

--- linux-2.6.19_orig/drivers/net/arm/ep93xx_eth.c	2006-11-30 21:28:21.000000000 +0200
+++ linux-2.6.19/drivers/net/arm/ep93xx_eth.c	2006-12-12 18:38:48.000000000 +0200
@@ -780,12 +780,10 @@ static struct ethtool_ops ep93xx_ethtool
 struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
 {
 	struct net_device *dev;
-	struct ep93xx_priv *ep;
 
 	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
 	if (dev == NULL)
 		return NULL;
-	ep = netdev_priv(dev);
 
 	memcpy(dev->dev_addr, data->dev_addr, ETH_ALEN);
 
@@ -840,9 +838,9 @@ static int ep93xx_eth_probe(struct platf
 	struct ep93xx_priv *ep;
 	int err;
 
-	data = pdev->dev.platform_data;
 	if (pdev == NULL)
 		return -ENODEV;
+	data = pdev->dev.platform_data;
 
 	dev = ep93xx_dev_alloc(data);
 	if (dev == NULL) {




