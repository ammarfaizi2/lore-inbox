Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBCVdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBCVdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263283AbVBCVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:32:52 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:33754 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262777AbVBCV3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:29:39 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jgarzik@redhat.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050203212938.4546.3768.35836@localhost.localdomain>
Subject: [PATCH] hw_random: provide more information when driver loads
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [70.16.225.90] at Thu, 3 Feb 2005 15:29:38 -0600
Date: Thu, 3 Feb 2005 15:29:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the hw_random driver a little more informative when it is starting up -
currently, there is no easy way to tell if the driver detected any hardware.

The AMD driver does mention that it found the chip - this adds the same for the VIA
and Intel sections of the driver.

Tested with an i810-equipped system.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urpN -X /home/jim/kernel_sources/dontdiff-osdl linux-2.6.11-rc2-mm2-original/drivers/char/hw_random.c linux-2.6.11-rc2-mm2/drivers/char/hw_random.c
--- linux-2.6.11-rc2-mm2-original/drivers/char/hw_random.c	2005-01-29 19:02:41.000000000 -0500
+++ linux-2.6.11-rc2-mm2/drivers/char/hw_random.c	2005-02-02 19:53:50.000000000 -0500
@@ -248,6 +249,7 @@ static int __init intel_init (struct pci
 		goto err_out_free_map;
 	}
 
+	pr_info (PFX "Intel i810 RNG enabled\n");
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 
@@ -451,6 +453,8 @@ static int __init via_init(struct pci_de
 		return -ENODEV;
 	}
 
+	pr_info(PFX "VIA C3 RNG enabled\n");
+
 	return 0;
 }
 
@@ -577,6 +581,8 @@ static int __init rng_init (void)
 
 	DPRINTK ("ENTER\n");
 
+	pr_info( RNG_DRIVER_NAME "\n");
+
 	/* Probe for Intel, AMD RNGs */
 	for_each_pci_dev(pdev) {
 		ent = pci_match_device (rng_pci_tbl, pdev);
@@ -595,6 +601,7 @@ static int __init rng_init (void)
 	}
 #endif
 
+	printk (KERN_ERR PFX "no supported hardware RNGs found\n");
 	DPRINTK ("EXIT, returning -ENODEV\n");
 	return -ENODEV;
 
@@ -603,8 +610,6 @@ match:
 	if (rc)
 		return rc;
 
-	pr_info( RNG_DRIVER_NAME " loaded\n");
-
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 }
