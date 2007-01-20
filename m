Return-Path: <linux-kernel-owner+w=401wt.eu-S965289AbXATPX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbXATPX7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbXATPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 10:23:59 -0500
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:9442 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965289AbXATPX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 10:23:58 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
       openib-general@openib.org
Subject: Re: [PATCH 2.6.20 2/2] ehca: ehca_irq.c: fix mismatched spin_unlock in irq handler
Date: Sat, 20 Jan 2007 16:20:15 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
References: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200701192251.01888.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701201620.16097.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, code line too long. please ignore the previous patch. here is the one
with correct length of code line.
Thanks
Nam


This is a patch for ehca_irq.c that fixes an unproper use of spin_unlock
in irq handler.


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_irq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index e7209af..fd1a5fb 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -440,7 +440,9 @@ void ehca_tasklet_eq(unsigned long data)
 					cq = idr_find(&ehca_cq_idr, token);
 
 					if (cq == NULL) {
-						spin_unlock(&ehca_cq_idr_lock);
+						spin_unlock_irqrestore(
+							&ehca_cq_idr_lock,
+							flags);
 						break;
 					}
 
