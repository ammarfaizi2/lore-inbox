Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVDLKrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVDLKrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVDLKov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:44:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:55242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262284AbVDLKdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:46 -0400
Message-Id: <200504121033.j3CAXKLo005852@shell0.pdx.osdl.net>
Subject: [patch 172/198] IB/mthca: print assigned IRQ when interrupt test fails
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Print IRQ number when NOP command interrupt test fails to help debugging.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-print-assigned-irq-when-interrupt-test-fails drivers/infiniband/hw/mthca/mthca_main.c
--- 25/drivers/infiniband/hw/mthca/mthca_main.c~ib-mthca-print-assigned-irq-when-interrupt-test-fails	2005-04-12 03:21:44.474375768 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-12 03:21:44.477375312 -0700
@@ -672,7 +672,10 @@ static int __devinit mthca_setup_hca(str
 
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
_
