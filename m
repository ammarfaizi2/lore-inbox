Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUJASNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUJASNh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUJASN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:13:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:34481 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266115AbUJASMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:12:52 -0400
Date: Fri, 01 Oct 2004 11:11:12 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, davidm@hpl.hp.com,
       hannal@us.ibm.com
Subject: [PATCH 2.6.9-rc2-mm4 sba_iommu.c] Replace pci_find_device with pci_get_device
Message-ID: <112650000.1096654272@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away soon I have replaced the call with pci_get_device.
Judith, could you run these 3 ia64 ones through PLM, please? This should complete the
arch/ia64 conversion.

Thanks a lot.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc1-mm5/arch/ia64/hp/common/sba_iommu.c linux-2.6.9-rc1-mm5patch/arch/ia64/hp/common/sba_iommu.c
--- linux-2.6.9-rc1-mm5/arch/ia64/hp/common/sba_iommu.c	2004-09-14 16:25:34.000000000 -0700
+++ linux-2.6.9-rc1-mm5patch/arch/ia64/hp/common/sba_iommu.c	2004-09-21 15:27:16.000000000 -0700
@@ -1556,7 +1556,7 @@ ioc_iova_init(struct ioc *ioc)
 	** We program the next pdir index after we stop w/ a key for
 	** the GART code to handshake on.
 	*/
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)
+	while ((device = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)
 		agp_found |= pci_find_capability(device, PCI_CAP_ID_AGP);
 
 	if (agp_found && reserve_sba_gart) {

