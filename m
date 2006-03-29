Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWC2GR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWC2GR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWC2GR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:17:27 -0500
Received: from xenotime.net ([66.160.160.81]:44725 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751091AbWC2GR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:17:27 -0500
Date: Tue, 28 Mar 2006 22:19:40 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, rolandd@cisco.com
Subject: [PATCH -mm] infiniband: fix printk format warning
Message-Id: <20060328221940.bf1dd059.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warnings:
drivers/infiniband/hw/ipath/ipath_driver.c:452: warning: format '%lx' expects type 'long unsigned int', but argument 4 has type 'u64'
drivers/infiniband/hw/ipath/ipath_driver.c:452: warning: format '%lx' expects type 'long unsigned int', but argument 5 has type 'u64'
drivers/infiniband/hw/ipath/ipath_driver.c:452: warning: format '%lx' expects type 'long unsigned int', but argument 6 has type 'u64'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/infiniband/hw/ipath/ipath_driver.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2616-mm2.orig/drivers/infiniband/hw/ipath/ipath_driver.c
+++ linux-2616-mm2/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -449,10 +449,10 @@ static int __devinit ipath_init_one(stru
 	for (j = 0; j < 6; j++) {
 		if (!pdev->resource[j].start)
 			continue;
-		ipath_cdbg(VERBOSE, "BAR %d start %lx, end %lx, len %lx\n",
-			   j, pdev->resource[j].start,
-			   pdev->resource[j].end,
-			   pci_resource_len(pdev, j));
+		ipath_cdbg(VERBOSE, "BAR %d start %llx, end %llx, len %llx\n",
+			   j, (unsigned long long)pdev->resource[j].start,
+			   (unsigned long long)pdev->resource[j].end,
+			   (unsigned long long)pci_resource_len(pdev, j));
 	}
 
 	if (!addr) {


---
