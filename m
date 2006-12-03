Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760047AbWLCTzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047AbWLCTzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760048AbWLCTzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:55:45 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:37000 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1760047AbWLCTzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:55:44 -0500
Date: Sun, 3 Dec 2006 11:55:34 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Martin Mares <mj@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci quirks: remove redundant check
Message-ID: <Pine.LNX.4.64N.0612031153370.18549@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes redundant check for dev->subordinate; if it is NULL, the function 
returns before the patch-affected code region.

Cc: Martin Mares <mj@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 drivers/pci/quirks.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9ca9b9b..7571863 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1688,8 +1688,7 @@ static void __devinit quirk_nvidia_ck804
 	 * a single one having MSI is enough to be sure that MSI are supported.
 	 */
 	pdev = pci_get_slot(dev->bus, 0);
-	if (dev->subordinate && !msi_ht_cap_enabled(dev)
-	    && !msi_ht_cap_enabled(pdev)) {
+	if (!msi_ht_cap_enabled(dev) && !msi_ht_cap_enabled(pdev)) {
 		printk(KERN_WARNING "PCI: MSI quirk detected. "
 		       "MSI disabled on chipset %s.\n",
 		       pci_name(dev));
