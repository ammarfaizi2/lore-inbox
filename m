Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVAXGWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVAXGWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVAXGUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:20:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261452AbVAXGO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:27 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][5/12] InfiniBand/mthca: don't write ECR in MSI-X mode
In-Reply-To: <20051232214.1JLCX02EnyVBhKBe@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.2iCZjnfrVaRa2RW5@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0200 (UTC) FILETIME=[F3F03B00:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>

We don't need to write to the ECR to clear events when using MSI-X,
since we never read the ECR anyway.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:38:50.946247760 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_eq.c	2005-01-23 20:47:40.946675448 -0800
@@ -381,7 +381,6 @@
 	struct mthca_eq  *eq  = eq_ptr;
 	struct mthca_dev *dev = eq->dev;
 
-	writel(eq->ecr_mask, dev->hcr + MTHCA_ECR_CLR_OFFSET + 4);
 	mthca_eq_int(dev, eq);
 
 	/* MSI-X vectors always belong to us */

