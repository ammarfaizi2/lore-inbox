Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967436AbWK2Pcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967436AbWK2Pcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 10:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967434AbWK2Pcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 10:32:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43404 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967433AbWK2Pcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 10:32:35 -0500
Date: Wed, 29 Nov 2006 15:39:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: pata_via in 2.6.19-rc6: UDMA/66 hdd downgraded to UDMA/33
Message-ID: <20061129153921.1c27e19d@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0611251718210.2557@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
	<20061125160342.4e9ddef0@localhost.localdomain>
	<Pine.LNX.4.64.0611251718210.2557@bizon.gios.gov.pl>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this fix it

--- drivers/ata/pata_via.c~	2006-11-29 15:16:10.961387472 +0000
+++ drivers/ata/pata_via.c	2006-11-29 15:17:08.784597008 +0000
@@ -60,7 +60,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.2.0"
+#define DRV_VERSION "0.2.1"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -159,10 +159,13 @@
 			return -ENOENT;
 	}
 
-	if ((config->flags & VIA_UDMA) >= VIA_UDMA_66)
+	if ((config->flags & VIA_UDMA) >= VIA_UDMA_100)
 		ap->cbl = via_cable_detect(ap);
-	else
+	/* The UDMA66 series has no cable detect so do drive side detect */
+	else if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
 		ap->cbl = ATA_CBL_PATA40;
+		
+
 	return ata_std_prereset(ap);
 }
 
