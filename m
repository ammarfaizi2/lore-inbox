Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269888AbUJMWiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269888AbUJMWiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269890AbUJMWiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:38:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50324 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269888AbUJMWiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:38:08 -0400
Date: Thu, 14 Oct 2004 00:33:40 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, chas@cmf.nrl.navy.mil,
       greg@kroah.com
Subject: Re: [KJ] [PATCH 2.6] firestream.c replace pci_find_device with pci_get_device
Message-ID: <20041013223340.GA32276@electric-eye.fr.zoreil.com>
References: <194130000.1097705759@w-hlinder.beaverton.ibm.com> <196320000.1097705843@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196320000.1097705843@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> :
[...]

Too complicated.


Removal of dead code.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/atm/firestream.c~firestream-10 drivers/atm/firestream.c
--- linux-2.6.9-rc3/drivers/atm/firestream.c~firestream-10	2004-10-14 00:28:36.000000000 +0200
+++ linux-2.6.9-rc3-fr/drivers/atm/firestream.c	2004-10-14 00:29:18.000000000 +0200
@@ -2012,66 +2012,6 @@ void __devexit firestream_remove_one (st
 	func_exit ();
 }
 
-
-#if 0
-int __init fs_detect(void)
-{
-	struct pci_dev  *pci_dev;
-	int devs = 0;
-
-	func_enter ();
-	pci_dev = NULL;
-	while ((pci_dev = pci_find_device(PCI_VENDOR_ID_FUJITSU_ME,
-					  PCI_DEVICE_ID_FUJITSU_FS50, 
-					  pci_dev))) {
-		if (fs_register_and_init (pci_dev, &fs_pci_tbl[0]))
-			break;
-		devs++;
-	}
-
-	while ((pci_dev = pci_find_device(PCI_VENDOR_ID_FUJITSU_ME,
-					  PCI_DEVICE_ID_FUJITSU_FS155, 
-					  pci_dev))) {
-		if (fs_register_and_init (pci_dev, FS_IS155)) 
-			break;
-		devs++;
-	}
-	func_exit ();
-	return devs;
-}
-#else
-
-#if 0
-int __init init_PCI (void)
-{ /* Begin init_PCI */
-	
-	int pci_count;
-	printk ("init_PCI\n");
-	/*
-	  memset (&firestream_driver, 0, sizeof (firestream_driver));
-	  firestream_driver.name = "firestream";
-	  firestream_driver.id_table = firestream_pci_tbl;
-	  firestream_driver.probe = fs_register_and_init;
-	*/
-	pci_count = pci_register_driver (&firestream_driver);
-	
-	if (pci_count <= 0) {
-		pci_unregister_driver (&firestream_driver);
-		pci_count = 0;
-	}
-
-	return(pci_count);
-
-} /* End init_PCI */
-#endif
-#endif
-
-/*
-#ifdef MODULE
-#define firestream_init init_module
-#endif 
-*/
-
 static struct pci_device_id firestream_pci_tbl[] = {
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS50, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, FS_IS50},

_
