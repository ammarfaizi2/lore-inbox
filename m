Return-Path: <linux-kernel-owner+w=401wt.eu-S965082AbXATBPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbXATBPh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 20:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbXATBPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 20:15:36 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:27969 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965082AbXATBPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 20:15:36 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
       openib-general@openib.org
Subject: [PATCH 2.6.20 2/2] ehca: ehca_irq.c: fix mismatched spin_unlock in irq handler
Date: Fri, 19 Jan 2007 22:51:01 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland!
This is a patch for ehca_irq.c that fixes an unproper use of spin_unlock
in irq handler.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_irq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index e7209af..93788d8 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -440,7 +440,7 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);
 						break;
 					}
 
