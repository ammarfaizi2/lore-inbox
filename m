Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWI1QHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWI1QHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWI1QHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:07:51 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2742 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751921AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 28] IB/ipath - drop unnecessary "(void *)" casts
X-Mercurial-Node: cdbbf110848d15d93674a342a0c64e89d1563655
Message-Id: <cdbbf110848d15d93674.1159459212@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:12 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r dcf5ac390abd -r cdbbf110848d drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1350,7 +1350,7 @@ int ipath_create_rcvhdrq(struct ipath_de
 
 	/* clear for security and sanity on each use */
 	memset(pd->port_rcvhdrq, 0, pd->port_rcvhdrq_size);
-	memset((void *)pd->port_rcvhdrtail_kvaddr, 0, PAGE_SIZE);
+	memset(pd->port_rcvhdrtail_kvaddr, 0, PAGE_SIZE);
 
 	/*
 	 * tell chip each time we init it, even if we are re-using previous
@@ -1803,7 +1803,7 @@ void ipath_free_pddata(struct ipath_devd
 		pd->port_rcvhdrq = NULL;
 		if (pd->port_rcvhdrtail_kvaddr) {
 			dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
-					 (void *)pd->port_rcvhdrtail_kvaddr,
+					 pd->port_rcvhdrtail_kvaddr,
 					 pd->port_rcvhdrqtailaddr_phys);
 			pd->port_rcvhdrtail_kvaddr = NULL;
 		}
@@ -1934,7 +1934,7 @@ static void cleanup_device(struct ipath_
 
 	if (dd->ipath_pioavailregs_dma) {
 		dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
-				  (void *) dd->ipath_pioavailregs_dma,
+				  dd->ipath_pioavailregs_dma,
 				  dd->ipath_pioavailregs_phys);
 		dd->ipath_pioavailregs_dma = NULL;
 	}
