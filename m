Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTAYFHu>; Sat, 25 Jan 2003 00:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTAYFHu>; Sat, 25 Jan 2003 00:07:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266175AbTAYFHt>;
	Sat, 25 Jan 2003 00:07:49 -0500
Date: Fri, 24 Jan 2003 21:11:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] discarded section errors (2.5.59)
Message-ID: <Pine.LNX.4.33L2.0301242005080.11347-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a few mismatched init/exit code sections that
I ran into while doing a "build everything in-kernel" (allyesconfig).

Is the use of __devexit_p() correct and OK?

Thanks,
-- 
~Randy




--- ./drivers/net/wan/dscc4.c%FIXIT	Thu Jan 16 18:21:47 2003
+++ ./drivers/net/wan/dscc4.c	Fri Jan 24 16:45:40 2003
@@ -1787,7 +1787,7 @@
 	return -ENOMEM;
 }

-static void __exit dscc4_remove_one(struct pci_dev *pdev)
+static void __devexit dscc4_remove_one(struct pci_dev *pdev)
 {
 	struct dscc4_pci_priv *ppriv;
 	struct dscc4_dev_priv *root;
@@ -1867,7 +1867,7 @@
 	.name		= DRV_NAME,
 	.id_table	= dscc4_pci_tbl,
 	.probe		= dscc4_init_one,
-	.remove		= dscc4_remove_one,
+	.remove		= __devexit_p(dscc4_remove_one),
 };

 static int __init dscc4_init_module(void)
--- ./drivers/isdn/hardware/eicon/diva_didd.c%FIXIT	Thu Jan 16 18:22:19 2003
+++ ./drivers/isdn/hardware/eicon/diva_didd.c	Fri Jan 24 16:52:19 2003
@@ -120,7 +120,7 @@
 	return (0);
 }

-static void DIVA_EXIT_FUNCTION remove_proc(void)
+static void remove_proc(void)
 {
 	remove_proc_entry(DRIVERLNAME, proc_net_isdn_eicon);
 	remove_proc_entry(main_proc_dir, proc_net_isdn);
--- ./sound/pci/rme9652/hammerfall_mem.c%FIXIT	Thu Jan 16 18:21:39 2003
+++ ./sound/pci/rme9652/hammerfall_mem.c	Fri Jan 24 16:28:33 2003
@@ -178,7 +178,7 @@
 	printk ("Hammerfall memory allocator: unknown buffer address or PCI device ID");
 }

-static void __exit hammerfall_free_buffers (void)
+static void hammerfall_free_buffers (void)

 {
 	int i;


