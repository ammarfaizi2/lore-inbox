Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVDAUz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVDAUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVDAUyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:55 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262899AbVDAUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:10 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][10/27] IB/mthca: print assigned IRQ when interrupt test fails
In-Reply-To: <2005411249.XnosdnfHawyDkITW@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.tAq0qtfjGbz3oHeg@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0935 (UTC) FILETIME=[5A95C370:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print IRQ number when NOP command interrupt test fails to help debugging.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:19.884644268 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:23.852782896 -0800
@@ -672,7 +672,10 @@
 
 	err = mthca_NOP(dev, &status);
 	if (err || status) {
-		mthca_err(dev, "NOP command failed to generate interrupt, aborting.\n");
+		mthca_err(dev, "NOP command failed to generate interrupt (IRQ %d), aborting.\n",
+			  dev->mthca_flags & MTHCA_FLAG_MSI_X ?
+			  dev->eq_table.eq[MTHCA_EQ_CMD].msi_x_vector :
+			  dev->pdev->irq);
 		if (dev->mthca_flags & (MTHCA_FLAG_MSI | MTHCA_FLAG_MSI_X))
 			mthca_err(dev, "Try again with MSI/MSI-X disabled.\n");
 		else

