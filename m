Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWHQHSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWHQHSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWHQHSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:18:37 -0400
Received: from msr12.hinet.net ([168.95.4.112]:26356 "EHLO msr12.hinet.net")
	by vger.kernel.org with ESMTP id S932090AbWHQHSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:18:36 -0400
Subject: [PATCH 3/6] IP100A Remove CONFIG_SUNDANCE_MMIO, mask of mapping
	address
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:06:01 -0400
Message-Id: <1155841561.4532.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Remove CONFIG_SUNDANCE_MMIO, mask of mapping address

Change Logs:
    Remove CONFIG_SUNDANCE_MMIO, mask of mapping address

---

 drivers/net/sundance.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

dc932975858ae18801620d04212c516ced6920bd
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index 910ea17..2bde1b3 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -21,8 +21,8 @@
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.2"
-#define DRV_RELDATE	"03-Aug-2006"
+#define DRV_VERSION	"1.01+LK1.13"
+#define DRV_RELDATE	"04-Aug-2006"
 
 
 /* The user-configurable values.
@@ -199,10 +199,6 @@ IVc. Errata
 
 */
 
-/* Work-around for Kendin chip bugs. */
-#ifndef CONFIG_SUNDANCE_MMIO
-#define USE_IO_OPS 1
-#endif
 
 static const struct pci_device_id sundance_pci_tbl[] = {
 	{ 0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0 },
@@ -491,10 +487,13 @@ #endif
 	if (pci_request_regions(pdev, DRV_NAME))
 		goto err_out_netdev;
 
-	ioaddr = pci_iomap(pdev, bar, netdev_io_size);
+	ioaddr =(void __iomem *)
+		 ((unsigned long)pci_iomap(pdev, bar, netdev_io_size) & 
+	          0xffffff80);
 	if (!ioaddr)
 		goto err_out_res;
 
+
 	for (i = 0; i < 3; i++)
 		((u16 *)dev->dev_addr)[i] =
 			le16_to_cpu(eeprom_read(ioaddr, i + EEPROM_SA_OFFSET));
-- 
1.3.GIT




