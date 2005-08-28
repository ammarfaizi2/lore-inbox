Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVH1Rp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVH1Rp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVH1Rp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:45:27 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:31425 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S1750713AbVH1Rp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:45:27 -0400
Message-ID: <4311F843.4030000@free.fr>
Date: Sun, 28 Aug 2005 19:45:39 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: acpi-devel@lists.sourceforge.net
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>,
       linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] PNPACPI: only parse device that have CRS method
Content-Type: multipart/mixed;
 boundary="------------060303020506050103090206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060303020506050103090206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch blacklist device that don't have CRS method as there are 
useless for pnp layer as they don't provide any resource.

Please comment and consider for inclusion.

Thanks,

Matthieu

--------------060303020506050103090206
Content-Type: text/x-patch;
 name="pnpacpi_nocrs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_nocrs.patch"

Index: linux-2.6.13rc/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.13rc.orig/drivers/pnp/pnpacpi/core.c	2005-08-28 19:24:40.000000000 +0200
+++ linux-2.6.13rc/drivers/pnp/pnpacpi/core.c	2005-08-28 19:26:35.000000000 +0200
@@ -131,7 +131,8 @@
 	struct pnp_id *dev_id;
 	struct pnp_dev *dev;
 
-	if (!ispnpidacpi(acpi_device_hid(device)) ||
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
 		is_exclusive_device(device))
 		return 0;
 

--------------060303020506050103090206--
