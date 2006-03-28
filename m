Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWC1W2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWC1W2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWC1W2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:28:44 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:52118 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932462AbWC1W2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:28:43 -0500
Date: Tue, 28 Mar 2006 17:28:27 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Morton Andrew Morton <akpm@osdl.org>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] 64 bit resources more drivers others changes
Message-ID: <20060328222827.GE20335@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060328222703.GD20335@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328222703.GD20335@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required to fix compilation warnings for drivers/* dir for 64bit
  resources. These changes came up due to cross-compilation on powerpc
  with CONFIG_PPC=32

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/macintosh/macio_asic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/macintosh/macio_asic.c~64bit-resources-more-drivers-others-changes drivers/macintosh/macio_asic.c
--- linux-2.6.16-mm2-64bit-res/drivers/macintosh/macio_asic.c~64bit-resources-more-drivers-others-changes	2006-03-28 16:15:13.000000000 -0500
+++ linux-2.6.16-mm2-64bit-res-root/drivers/macintosh/macio_asic.c	2006-03-28 16:16:08.000000000 -0500
@@ -428,10 +428,10 @@ static struct macio_dev * macio_add_one_
 
 	/* MacIO itself has a different reg, we use it's PCI base */
 	if (np == chip->of_node) {
-		sprintf(dev->ofdev.dev.bus_id, "%1d.%08lx:%.*s",
+		sprintf(dev->ofdev.dev.bus_id, "%1d.%016llx:%.*s",
 			chip->lbus.index,
 #ifdef CONFIG_PCI
-			pci_resource_start(chip->lbus.pdev, 0),
+			(unsigned long long)pci_resource_start(chip->lbus.pdev, 0),
 #else
 			0, /* NuBus may want to do something better here */
 #endif
_
