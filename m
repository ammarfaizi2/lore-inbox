Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVBOBQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVBOBQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVBOBCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:02:40 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:43680 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261540AbVBOBCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:02:14 -0500
Date: Tue, 15 Feb 2005 02:01:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in AGP
Message-ID: <20050215010159.GM5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix u32 vs. pm_message_t confusion in AGP. Last patch for
tonight, please apply,
								Pavel

--- clean-mm/drivers/char/agp/via-agp.c	2005-02-15 00:46:40.000000000 +0100
+++ linux-mm/drivers/char/agp/via-agp.c	2005-02-15 01:04:09.000000000 +0100
@@ -440,10 +440,10 @@
 
 #ifdef CONFIG_PM
 
-static int agp_via_suspend(struct pci_dev *pdev, u32 state)
+static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -452,7 +452,7 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state(pdev);
 
 	if (bridge->driver == &via_agp3_driver)


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
