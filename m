Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUIOVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUIOVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUIOViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:38:21 -0400
Received: from 1-1-1-9a.ghn.gbg.bostream.se ([82.182.69.4]:57566 "EHLO
	scream.fjortis.info") by vger.kernel.org with ESMTP id S267571AbUIOVdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:33:20 -0400
Date: Wed, 15 Sep 2004 23:43:28 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Remove i810fb explicit agp initialization hack.
Message-ID: <20040915214328.GA1180@scream.fjortis.info>
Mail-Followup-To: Andreas Henriksson <andreas@fjortis.info>,
	Andrew Morton <akpm@osdl.org>, adaplas@pol.net, davej@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When Antonino A. Daplas posted his "fbdev: Initialize i810fb after agpgart"
patch he said that the ugly agp initialization hack for intel agp shouldn't be
needed but that he couldn't test it.

I have tested the framebuffer updates and additionally removed the
initialization hack and it does indeed work.

Signed-off-by: Andreas Henriksson <andreas@fjortis.info>

--- linux-2.6.9-rc1-mm5/drivers/char/agp/intel-agp.c.old	2004-09-15 23:13:05.000000000 +0200
+++ linux-2.6.9-rc1-mm5/drivers/char/agp/intel-agp.c	2004-09-15 23:13:23.000000000 +0200
@@ -1781,16 +1781,8 @@ static struct pci_driver agp_intel_pci_d
 	.resume		= agp_intel_resume,
 };
 
-/* intel_agp_init() must not be declared static for explicit
-   early initialization to work (ie i810fb) */
-int __init agp_intel_init(void)
+static int __init agp_intel_init(void)
 {
-	static int agp_initialised=0;
-
-	if (agp_initialised == 1)
-		return 0;
-	agp_initialised=1;
-
 	return pci_module_init(&agp_intel_pci_driver);
 }
 
