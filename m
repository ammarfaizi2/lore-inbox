Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWARFOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWARFOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWARFOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:14:32 -0500
Received: from xenotime.net ([66.160.160.81]:24233 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030250AbWARFOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:14:31 -0500
Date: Tue, 17 Jan 2006 21:10:38 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, airlied@linux.ie
Subject: [PATCH] drm/ati: use NULL instead of 0
Message-Id: <20060117211038.3495406d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Use NULL instead of 0 (sparse warnings):

drivers/char/drm/ati_pcigart.c:64:10: warning: Using plain integer as NULL pointer
drivers/char/drm/ati_pcigart.c:130:21: warning: Using plain integer as NULL pointer
drivers/char/drm/ati_pcigart.c:171:14: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/drm/ati_pcigart.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2616-rc1.orig/drivers/char/drm/ati_pcigart.c
+++ linux-2616-rc1/drivers/char/drm/ati_pcigart.c
@@ -61,7 +61,7 @@ static void *drm_ati_alloc_pcigart_table
 
 	address = __get_free_pages(GFP_KERNEL, ATI_PCIGART_TABLE_ORDER);
 	if (address == 0UL) {
-		return 0;
+		return NULL;
 	}
 
 	page = virt_to_page(address);
@@ -127,7 +127,7 @@ int drm_ati_pcigart_cleanup(drm_device_t
 	if (gart_info->gart_table_location == DRM_ATI_GART_MAIN
 	    && gart_info->addr) {
 		drm_ati_free_pcigart_table(gart_info->addr);
-		gart_info->addr = 0;
+		gart_info->addr = NULL;
 	}
 
 	return 1;
@@ -168,7 +168,7 @@ int drm_ati_pcigart_init(drm_device_t *d
 		if (bus_address == 0) {
 			DRM_ERROR("unable to map PCIGART pages!\n");
 			drm_ati_free_pcigart_table(address);
-			address = 0;
+			address = NULL;
 			goto done;
 		}
 	} else {


---
