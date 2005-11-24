Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030602AbVKXFVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbVKXFVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKXFVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:21:14 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:41382 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030602AbVKXFVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:21:14 -0500
Date: Thu, 24 Nov 2005 05:21:07 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Reboot through the BIOS on newer HP laptops
Message-ID: <20051124052107.GA28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Newer HP laptops (nc4200, nc6xxx, nc8xxx) hang on reboot with a standard 
configuration. Passing reboot=b makes them work. This patch adds a DMI 
quirk that defaults them to this mode, and doesn't appear to have any 
adverse affects on older HPs.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- a/arch/i386/kernel/reboot.c.orig	2005-09-20 18:54:50.000000000 +0100
+++ a/arch/i386/kernel/reboot.c	2005-09-20 18:58:11.000000000 +0100
@@ -135,6 +135,14 @@
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 		},
 	},
+	{       /* HP laptops have weird reboot issues */
+	        .callback = set_bios_reboot,
+		.ident = "HP Laptop",
+		.matches = {
+		        DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
+		},
+	},
 	{ }
 };

-- 
Matthew Garrett | mjg59@srcf.ucam.org
