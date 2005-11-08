Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVKHKtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVKHKtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 05:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKHKtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 05:49:41 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:56030 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751273AbVKHKtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 05:49:41 -0500
Date: Tue, 8 Nov 2005 10:49:27 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drm fixup pci gart settings.
Message-ID: <Pine.LNX.4.58.0511081048250.4500@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the PCIGART increment and add a cpu_to_le32 for ppc (untested)

Paulus was unsure if we need to cpu_to_le32 but the old code was definitely
wrong, so make it consistent and let the PPC guys figure it out later.

Signed-off-by: Dave Airlie <airlied@linux.ie>

diff --git a/drivers/char/drm/ati_pcigart.c b/drivers/char/drm/ati_pcigart.c
--- a/drivers/char/drm/ati_pcigart.c
+++ b/drivers/char/drm/ati_pcigart.c
@@ -203,10 +203,10 @@ int drm_ati_pcigart_init(drm_device_t *

 		for (j = 0; j < (PAGE_SIZE / ATI_PCIGART_PAGE_SIZE); j++) {
 			if (gart_info->is_pcie)
-				*pci_gart = (cpu_to_le32(page_base) >> 8) | 0xc;
+				*pci_gart = cpu_to_le32((page_base >> 8) | 0xc);
 			else
 				*pci_gart = cpu_to_le32(page_base);
-			*pci_gart++;
+			pci_gart++;
 			page_base += ATI_PCIGART_PAGE_SIZE;
 		}
 	}
