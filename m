Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWALRvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWALRvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWALRvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:51:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:53899 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932485AbWALRvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:51:08 -0500
Date: Thu, 12 Jan 2006 11:50:51 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: mulix@mulix.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060112175051.GA17539@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some pcnet32 hardware erroneously has the Vendor ID for Trident.  The
pcnet32 driver looks for the PCI ethernet class before grabbing the
hardware, but the current trident driver does not check against the
PCI audio class.  This allows the trident driver to claim the pcnet32 
hardware.  This patch prevents that.

This patch is untested on Trident 4DWAVE_DX hardware, but has been
tested on pcnet32 hardware.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 4a7597b41d25 sound/oss/trident.c
--- a/sound/oss/trident.c	Wed Jan 11 19:14:08 2006
+++ b/sound/oss/trident.c	Thu Jan 12 11:32:26 2006
@@ -279,7 +279,8 @@
 
 static struct pci_device_id trident_pci_tbl[] = {
 	{PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, TRIDENT_4D_DX},
+	 PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 
+	 TRIDENT_4D_DX},
 	{PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, TRIDENT_4D_NX},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7018,
