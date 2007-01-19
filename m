Return-Path: <linux-kernel-owner+w=401wt.eu-S932830AbXASBDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbXASBDL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932824AbXASBDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 20:03:11 -0500
Received: from lixom.net ([66.141.50.11]:54381 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932809AbXASBDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 20:03:09 -0500
X-Greylist: delayed 1662 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 20:03:09 EST
Date: Thu, 18 Jan 2007 18:39:59 -0600
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sata_mv HighPoint 2310 support (88SX7042)
Message-ID: <20070119003959.GA23298@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the following patch, my HighPoint 2310 with a Marvell 88SX7042 on
it seems to work OK.

The controller only has 4 ports, with MV_FLAG_DUAL_HC it seems to init 8
ports and fails miserably at probe time. There are no other devices mapped
to that chip, maybe it was just incorrectly specified in the first place?


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/drivers/ata/sata_mv.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_mv.c
+++ linux-2.6/drivers/ata/sata_mv.c
@@ -523,8 +523,7 @@ static const struct ata_port_info mv_por
 	},
 	{  /* chip_7042 */
 		.sht		= &mv_sht,
-		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				   MV_FLAG_DUAL_HC),
+		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv_iie_ops,
@@ -545,6 +544,8 @@ static const struct pci_device_id mv_pci
 
 	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
 
+	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+
 	{ }			/* terminate list */
 };
 
