Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSHTN3T>; Tue, 20 Aug 2002 09:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSHTN3S>; Tue, 20 Aug 2002 09:29:18 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:24980 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S317117AbSHTN3S>;
	Tue, 20 Aug 2002 09:29:18 -0400
Date: Tue, 20 Aug 2002 15:32:48 +0200
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, torvalds@transmeta.com
Subject: [PATCH] __devexit_p in drivers/net/tulip/de2104x.c
Message-ID: <20020820133248.GA577@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds __devexit_p to de_remove_one in drivers/net/tulip/de2104x.c to make it
possible to compile it with new binutils

-- 

//anders/g

--- a/drivers/net/tulip/de2104x.c	Tue Aug 20 15:28:00 2002
+++ b/drivers/net/tulip/de2104x.c	Tue Aug 20 15:28:00 2002
@@ -2136,7 +2136,7 @@
 	return rc;
 }
 
-static void __exit de_remove_one (struct pci_dev *pdev)
+static void __devexit de_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct de_private *de = dev->priv;
@@ -2216,7 +2216,7 @@
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
-	.remove		= de_remove_one,
+	.remove		= __devexit_p(de_remove_one),
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,
