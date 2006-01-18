Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWARAzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWARAzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWARAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:54:49 -0500
Received: from fmr20.intel.com ([134.134.136.19]:64133 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932528AbWARAyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:54:41 -0500
Subject: [patch 3/4] pci: really fix parent's subordinate busnr
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
References: <20060116200218.275371000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 16:57:01 -0800
Message-Id: <1137545822.19858.48.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 00:54:09.0953 (UTC) FILETIME=[B10E7910:01C61BC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After you find the maximum value of the subordinate buses below the child
bus, you must fix the parent's subordinate bus number again, otherwise
it may be too small.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com> 


 drivers/pci/probe.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.15-mm.orig/drivers/pci/probe.c
+++ linux-2.6.15-mm/drivers/pci/probe.c
@@ -537,6 +537,11 @@ int __devinit pci_scan_bridge(struct pci
 			pci_fixup_parent_subordinate_busnr(child, max);
 			/* Now we can scan all subordinate buses... */
 			max = pci_scan_child_bus(child);
+			/*
+			 * now fix it up again since we have found
+			 * the real value of max.
+			 */
+			pci_fixup_parent_subordinate_busnr(child, max);
 		} else {
 			/*
 			 * For CardBus bridges, we leave 4 bus numbers

