Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWHQNwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWHQNwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWHQNwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:52:01 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:33646 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965003AbWHQNvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:51:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oY3BMJHcBNbilXRxI3GuFSP0ZWdXL1FVVoiwSMox8BGxK8mAKyqqo4szxKoMD1+cAwLGqfWZqPIlht7HgSE1AENSHlsmqv0Q1rwqiPq+TBYGMuEC/jGsARlcPG+z706ngcFv+2NjrJpWmiSJ8bsOs3C3iZXMY1sJpNQ/lGNXmqU=
Message-ID: <44E47499.9010904@gmail.com>
Date: Thu, 17 Aug 2006 15:52:25 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 51/75] net: drivers/net/pci-skeleton.c pci_module_init
 to pci_register_driver conversion
References: <20060817132858.51.mFaGck4945.3636.michal@euridica.enternet.net.pl> <44E470AC.8070301@pobox.com>
In-Reply-To: <44E470AC.8070301@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Please just send one big patch that converts all drivers/net drivers at
> once.
> 
>     Jeff
> 
> 
> 
> 

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/3c59x.c linux-work2/drivers/net/3c59x.c
--- linux-work-clean/drivers/net/3c59x.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/net/3c59x.c	2006-08-17 05:13:16.000000000 +0200
@@ -3170,7 +3170,7 @@ static int __init vortex_init(void)
 {
 	int pci_rc, eisa_rc;

-	pci_rc = pci_module_init(&vortex_driver);
+	pci_rc = pci_register_driver(&vortex_driver);
 	eisa_rc = vortex_eisa_init();

 	if (pci_rc == 0)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/8139cp.c linux-work2/drivers/net/8139cp.c
--- linux-work-clean/drivers/net/8139cp.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/net/8139cp.c	2006-08-17 05:13:25.000000000 +0200
@@ -2098,7 +2098,7 @@ static int __init cp_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&cp_driver);
+	return pci_register_driver(&cp_driver);
 }

 static void __exit cp_exit (void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/8139too.c linux-work2/drivers/net/8139too.c
--- linux-work-clean/drivers/net/8139too.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/8139too.c	2006-08-17 05:13:30.000000000 +0200
@@ -2629,7 +2629,7 @@ static int __init rtl8139_init_module (v
 	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
 #endif

-	return pci_module_init (&rtl8139_pci_driver);
+	return pci_register_driver(&rtl8139_pci_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/acenic.c linux-work2/drivers/net/acenic.c
--- linux-work-clean/drivers/net/acenic.c	2006-08-17 00:10:47.000000000 +0200
+++ linux-work2/drivers/net/acenic.c	2006-08-17 05:13:37.000000000 +0200
@@ -725,7 +725,7 @@ static struct pci_driver acenic_pci_driv

 static int __init acenic_init(void)
 {
-	return pci_module_init(&acenic_pci_driver);
+	return pci_register_driver(&acenic_pci_driver);
 }

 static void __exit acenic_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/amd8111e.c linux-work2/drivers/net/amd8111e.c
--- linux-work-clean/drivers/net/amd8111e.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/amd8111e.c	2006-08-17 05:13:42.000000000 +0200
@@ -2158,7 +2158,7 @@ static struct pci_driver amd8111e_driver

 static int __init amd8111e_init(void)
 {
-	return pci_module_init(&amd8111e_driver);
+	return pci_register_driver(&amd8111e_driver);
 }

 static void __exit amd8111e_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/arcnet/com20020-pci.c linux-work2/drivers/net/arcnet/com20020-pci.c
--- linux-work-clean/drivers/net/arcnet/com20020-pci.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/arcnet/com20020-pci.c	2006-08-17 05:13:48.000000000 +0200
@@ -178,7 +178,7 @@ static struct pci_driver com20020pci_dri
 static int __init com20020pci_init(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
-	return pci_module_init(&com20020pci_driver);
+	return pci_register_driver(&com20020pci_driver);
 }

 static void __exit com20020pci_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/b44.c linux-work2/drivers/net/b44.c
--- linux-work-clean/drivers/net/b44.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/b44.c	2006-08-17 05:13:54.000000000 +0200
@@ -2354,7 +2354,7 @@ static int __init b44_init(void)
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
 	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));

-	return pci_module_init(&b44_driver);
+	return pci_register_driver(&b44_driver);
 }

 static void __exit b44_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/bnx2.c linux-work2/drivers/net/bnx2.c
--- linux-work-clean/drivers/net/bnx2.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/bnx2.c	2006-08-17 05:14:02.000000000 +0200
@@ -6015,7 +6015,7 @@ static struct pci_driver bnx2_pci_driver

 static int __init bnx2_init(void)
 {
-	return pci_module_init(&bnx2_pci_driver);
+	return pci_register_driver(&bnx2_pci_driver);
 }

 static void __exit bnx2_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/cassini.c linux-work2/drivers/net/cassini.c
--- linux-work-clean/drivers/net/cassini.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/cassini.c	2006-08-17 05:14:07.000000000 +0200
@@ -5245,7 +5245,7 @@ static int __init cas_init(void)
 	else
 		link_transition_timeout = 0;

-	return pci_module_init(&cas_driver);
+	return pci_register_driver(&cas_driver);
 }

 static void __exit cas_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/chelsio/cxgb2.c linux-work2/drivers/net/chelsio/cxgb2.c
--- linux-work-clean/drivers/net/chelsio/cxgb2.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/chelsio/cxgb2.c	2006-08-17 05:14:12.000000000 +0200
@@ -1243,7 +1243,7 @@ static struct pci_driver driver = {

 static int __init t1_init_module(void)
 {
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }

 static void __exit t1_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/defxx.c linux-work2/drivers/net/defxx.c
--- linux-work-clean/drivers/net/defxx.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/defxx.c	2006-08-17 05:14:19.000000000 +0200
@@ -3444,7 +3444,7 @@ static int __init dfx_init(void)
 {
 	int rc_pci, rc_eisa;

-	rc_pci = pci_module_init(&dfx_driver);
+	rc_pci = pci_register_driver(&dfx_driver);
 	if (rc_pci >= 0) dfx_have_pci = 1;
 	
 	rc_eisa = dfx_eisa_init();
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/dl2k.c linux-work2/drivers/net/dl2k.c
--- linux-work-clean/drivers/net/dl2k.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/dl2k.c	2006-08-17 05:14:25.000000000 +0200
@@ -1815,7 +1815,7 @@ static struct pci_driver rio_driver = {
 static int __init
 rio_init (void)
 {
-	return pci_module_init (&rio_driver);
+	return pci_register_driver(&rio_driver);
 }

 static void __exit
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/e1000/e1000_main.c linux-work2/drivers/net/e1000/e1000_main.c
--- linux-work-clean/drivers/net/e1000/e1000_main.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/e1000/e1000_main.c	2006-08-17 05:14:36.000000000 +0200
@@ -245,7 +245,7 @@ e1000_init_module(void)

 	printk(KERN_INFO "%s\n", e1000_copyright);

-	ret = pci_module_init(&e1000_driver);
+	ret = pci_register_driver(&e1000_driver);

 	return ret;
 }
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/e100.c linux-work2/drivers/net/e100.c
--- linux-work-clean/drivers/net/e100.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/e100.c	2006-08-17 05:14:31.000000000 +0200
@@ -2820,7 +2820,7 @@ static int __init e100_init_module(void)
 		printk(KERN_INFO PFX "%s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 		printk(KERN_INFO PFX "%s\n", DRV_COPYRIGHT);
 	}
-	return pci_module_init(&e100_driver);
+	return pci_register_driver(&e100_driver);
 }

 static void __exit e100_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/eepro100.c linux-work2/drivers/net/eepro100.c
--- linux-work-clean/drivers/net/eepro100.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/eepro100.c	2006-08-17 05:14:42.000000000 +0200
@@ -2385,7 +2385,7 @@ static int __init eepro100_init_module(v
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&eepro100_driver);
+	return pci_register_driver(&eepro100_driver);
 }

 static void __exit eepro100_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/epic100.c linux-work2/drivers/net/epic100.c
--- linux-work-clean/drivers/net/epic100.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/epic100.c	2006-08-17 05:14:49.000000000 +0200
@@ -1604,7 +1604,7 @@ static int __init epic_init (void)
 		version, version2, version3);
 #endif

-	return pci_module_init (&epic_driver);
+	return pci_register_driver(&epic_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/fealnx.c linux-work2/drivers/net/fealnx.c
--- linux-work-clean/drivers/net/fealnx.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/fealnx.c	2006-08-17 05:14:55.000000000 +0200
@@ -1984,7 +1984,7 @@ static int __init fealnx_init(void)
 	printk(version);
 #endif

-	return pci_module_init(&fealnx_driver);
+	return pci_register_driver(&fealnx_driver);
 }

 static void __exit fealnx_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/forcedeth.c linux-work2/drivers/net/forcedeth.c
--- linux-work-clean/drivers/net/forcedeth.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/forcedeth.c	2006-08-17 05:15:01.000000000 +0200
@@ -4668,7 +4668,7 @@ static struct pci_driver driver = {
 static int __init init_nic(void)
 {
 	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }

 static void __exit exit_nic(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/hp100.c linux-work2/drivers/net/hp100.c
--- linux-work-clean/drivers/net/hp100.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/hp100.c	2006-08-17 05:15:07.000000000 +0200
@@ -3031,7 +3031,7 @@ static int __init hp100_module_init(void
 		goto out2;
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&hp100_pci_driver);
+	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV)
 		goto out3;
 #endif
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/ixgb/ixgb_main.c linux-work2/drivers/net/ixgb/ixgb_main.c
--- linux-work-clean/drivers/net/ixgb/ixgb_main.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/ixgb/ixgb_main.c	2006-08-17 05:15:16.000000000 +0200
@@ -173,7 +173,7 @@ ixgb_init_module(void)

 	printk(KERN_INFO "%s\n", ixgb_copyright);

-	return pci_module_init(&ixgb_driver);
+	return pci_register_driver(&ixgb_driver);
 }

 module_init(ixgb_init_module);
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/natsemi.c linux-work2/drivers/net/natsemi.c
--- linux-work-clean/drivers/net/natsemi.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/natsemi.c	2006-08-17 05:15:22.000000000 +0200
@@ -3275,7 +3275,7 @@ static int __init natsemi_init_mod (void
 	printk(version);
 #endif

-	return pci_module_init (&natsemi_driver);
+	return pci_register_driver(&natsemi_driver);
 }

 static void __exit natsemi_exit_mod (void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/ne2k-pci.c linux-work2/drivers/net/ne2k-pci.c
--- linux-work-clean/drivers/net/ne2k-pci.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/ne2k-pci.c	2006-08-17 05:15:27.000000000 +0200
@@ -702,7 +702,7 @@ static int __init ne2k_pci_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&ne2k_driver);
+	return pci_register_driver(&ne2k_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/ns83820.c linux-work2/drivers/net/ns83820.c
--- linux-work-clean/drivers/net/ns83820.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/ns83820.c	2006-08-17 05:15:34.000000000 +0200
@@ -2336,7 +2336,7 @@ static struct pci_driver driver = {
 static int __init ns83820_init(void)
 {
 	printk(KERN_INFO "ns83820.c: National Semiconductor DP83820 10/100/1000 driver.\n");
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }

 static void __exit ns83820_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/pci-skeleton.c linux-work2/drivers/net/pci-skeleton.c
--- linux-work-clean/drivers/net/pci-skeleton.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/pci-skeleton.c	2006-08-17 05:15:43.000000000 +0200
@@ -1963,7 +1963,7 @@ static int __init netdrv_init_module (vo
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&netdrv_pci_driver);
+	return pci_register_driver(&netdrv_pci_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/pcnet32.c linux-work2/drivers/net/pcnet32.c
--- linux-work-clean/drivers/net/pcnet32.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/pcnet32.c	2006-08-17 05:15:52.000000000 +0200
@@ -2969,7 +2969,7 @@ static int __init pcnet32_init_module(vo
 		tx_start = tx_start_pt;

 	/* find the PCI devices */
-	if (!pci_module_init(&pcnet32_driver))
+	if (!pci_register_driver(&pcnet32_driver))
 		pcnet32_have_pci = 1;

 	/* should we find any remaining VLbus devices ? */
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/r8169.c linux-work2/drivers/net/r8169.c
--- linux-work-clean/drivers/net/r8169.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/r8169.c	2006-08-17 05:15:58.000000000 +0200
@@ -2910,7 +2910,7 @@ static struct pci_driver rtl8169_pci_dri
 static int __init
 rtl8169_init_module(void)
 {
-	return pci_module_init(&rtl8169_pci_driver);
+	return pci_register_driver(&rtl8169_pci_driver);
 }

 static void __exit
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/rrunner.c linux-work2/drivers/net/rrunner.c
--- linux-work-clean/drivers/net/rrunner.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/rrunner.c	2006-08-17 05:16:04.000000000 +0200
@@ -1736,7 +1736,7 @@ static struct pci_driver rr_driver = {

 static int __init rr_init_module(void)
 {
-	return pci_module_init(&rr_driver);
+	return pci_register_driver(&rr_driver);
 }

 static void __exit rr_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/s2io.c linux-work2/drivers/net/s2io.c
--- linux-work-clean/drivers/net/s2io.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/s2io.c	2006-08-17 05:16:10.000000000 +0200
@@ -7233,7 +7233,7 @@ static void __devexit s2io_rem_nic(struc

 int __init s2io_starter(void)
 {
-	return pci_module_init(&s2io_driver);
+	return pci_register_driver(&s2io_driver);
 }

 /**
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/saa9730.c linux-work2/drivers/net/saa9730.c
--- linux-work-clean/drivers/net/saa9730.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-work2/drivers/net/saa9730.c	2006-08-17 05:16:21.000000000 +0200
@@ -1131,7 +1131,7 @@ static struct pci_driver saa9730_driver

 static int __init saa9730_init(void)
 {
-	return pci_module_init(&saa9730_driver);
+	return pci_register_driver(&saa9730_driver);
 }

 static void __exit saa9730_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sis190.c linux-work2/drivers/net/sis190.c
--- linux-work-clean/drivers/net/sis190.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/sis190.c	2006-08-17 05:16:27.000000000 +0200
@@ -1871,7 +1871,7 @@ static struct pci_driver sis190_pci_driv

 static int __init sis190_init_module(void)
 {
-	return pci_module_init(&sis190_pci_driver);
+	return pci_register_driver(&sis190_pci_driver);
 }

 static void __exit sis190_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sis900.c linux-work2/drivers/net/sis900.c
--- linux-work-clean/drivers/net/sis900.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/sis900.c	2006-08-17 05:16:32.000000000 +0200
@@ -2495,7 +2495,7 @@ static int __init sis900_init_module(voi
 	printk(version);
 #endif

-	return pci_module_init(&sis900_pci_driver);
+	return pci_register_driver(&sis900_pci_driver);
 }

 static void __exit sis900_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sk98lin/skge.c linux-work2/drivers/net/sk98lin/skge.c
--- linux-work-clean/drivers/net/sk98lin/skge.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/sk98lin/skge.c	2006-08-17 05:16:39.000000000 +0200
@@ -5133,7 +5133,7 @@ static struct pci_driver skge_driver = {

 static int __init skge_init(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }

 static void __exit skge_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/skfp/skfddi.c linux-work2/drivers/net/skfp/skfddi.c
--- linux-work-clean/drivers/net/skfp/skfddi.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/skfp/skfddi.c	2006-08-17 05:16:45.000000000 +0200
@@ -2280,7 +2280,7 @@ static struct pci_driver skfddi_pci_driv

 static int __init skfd_init(void)
 {
-	return pci_module_init(&skfddi_pci_driver);
+	return pci_register_driver(&skfddi_pci_driver);
 }

 static void __exit skfd_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/skge.c linux-work2/drivers/net/skge.c
--- linux-work-clean/drivers/net/skge.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/skge.c	2006-08-17 05:17:04.000000000 +0200
@@ -3510,7 +3510,7 @@ static struct pci_driver skge_driver = {

 static int __init skge_init_module(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }

 static void __exit skge_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/starfire.c linux-work2/drivers/net/starfire.c
--- linux-work-clean/drivers/net/starfire.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/starfire.c	2006-08-17 05:17:15.000000000 +0200
@@ -2053,7 +2053,7 @@ static int __init starfire_init (void)
 		return -ENODEV;
 	}

-	return pci_module_init (&starfire_driver);
+	return pci_register_driver(&starfire_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sundance.c linux-work2/drivers/net/sundance.c
--- linux-work-clean/drivers/net/sundance.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/sundance.c	2006-08-17 05:17:21.000000000 +0200
@@ -1733,7 +1733,7 @@ static int __init sundance_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&sundance_driver);
+	return pci_register_driver(&sundance_driver);
 }

 static void __exit sundance_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sungem.c linux-work2/drivers/net/sungem.c
--- linux-work-clean/drivers/net/sungem.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/sungem.c	2006-08-17 05:17:28.000000000 +0200
@@ -3194,7 +3194,7 @@ static struct pci_driver gem_driver = {

 static int __init gem_init(void)
 {
-	return pci_module_init(&gem_driver);
+	return pci_register_driver(&gem_driver);
 }

 static void __exit gem_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tc35815.c linux-work2/drivers/net/tc35815.c
--- linux-work-clean/drivers/net/tc35815.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tc35815.c	2006-08-17 05:17:42.000000000 +0200
@@ -1725,7 +1725,7 @@ static struct pci_driver tc35815_driver

 static int __init tc35815_init_module(void)
 {
-	return pci_module_init(&tc35815_driver);
+	return pci_register_driver(&tc35815_driver);
 }

 static void __exit tc35815_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tg3.c linux-work2/drivers/net/tg3.c
--- linux-work-clean/drivers/net/tg3.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/tg3.c	2006-08-17 05:17:47.000000000 +0200
@@ -11819,7 +11819,7 @@ static struct pci_driver tg3_driver = {

 static int __init tg3_init(void)
 {
-	return pci_module_init(&tg3_driver);
+	return pci_register_driver(&tg3_driver);
 }

 static void __exit tg3_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tokenring/3c359.c linux-work2/drivers/net/tokenring/3c359.c
--- linux-work-clean/drivers/net/tokenring/3c359.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tokenring/3c359.c	2006-08-17 05:18:07.000000000 +0200
@@ -1815,7 +1815,7 @@ static struct pci_driver xl_3c359_driver

 static int __init xl_pci_init (void)
 {
-	return pci_module_init (&xl_3c359_driver);
+	return pci_register_driver(&xl_3c359_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tokenring/lanstreamer.c linux-work2/drivers/net/tokenring/lanstreamer.c
--- linux-work-clean/drivers/net/tokenring/lanstreamer.c	2006-08-17 00:10:47.000000000 +0200
+++ linux-work2/drivers/net/tokenring/lanstreamer.c	2006-08-17 05:18:15.000000000 +0200
@@ -1998,7 +1998,7 @@ static struct pci_driver streamer_pci_dr
 };

 static int __init streamer_init_module(void) {
-  return pci_module_init(&streamer_pci_driver);
+  return pci_register_driver(&streamer_pci_driver);
 }

 static void __exit streamer_cleanup_module(void) {
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tokenring/olympic.c linux-work2/drivers/net/tokenring/olympic.c
--- linux-work-clean/drivers/net/tokenring/olympic.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tokenring/olympic.c	2006-08-17 05:18:24.000000000 +0200
@@ -1771,7 +1771,7 @@ static struct pci_driver olympic_driver

 static int __init olympic_pci_init(void)
 {
-	return pci_module_init (&olympic_driver) ;
+	return pci_register_driver(&olympic_driver);
 }

 static void __exit olympic_pci_cleanup(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/de2104x.c linux-work2/drivers/net/tulip/de2104x.c
--- linux-work-clean/drivers/net/tulip/de2104x.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tulip/de2104x.c	2006-08-17 05:18:32.000000000 +0200
@@ -2172,7 +2172,7 @@ static int __init de_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&de_driver);
+	return pci_register_driver(&de_driver);
 }

 static void __exit de_exit (void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/de4x5.c linux-work2/drivers/net/tulip/de4x5.c
--- linux-work-clean/drivers/net/tulip/de4x5.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/tulip/de4x5.c	2006-08-17 05:18:44.000000000 +0200
@@ -5755,7 +5755,7 @@ static int __init de4x5_module_init (voi
 	int err = 0;

 #ifdef CONFIG_PCI
-	err = pci_module_init (&de4x5_pci_driver);
+	err = pci_register_driver(&de4x5_pci_driver);
 #endif
 #ifdef CONFIG_EISA
 	err |= eisa_driver_register (&de4x5_eisa_driver);
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/dmfe.c linux-work2/drivers/net/tulip/dmfe.c
--- linux-work-clean/drivers/net/tulip/dmfe.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tulip/dmfe.c	2006-08-17 05:18:50.000000000 +0200
@@ -2039,7 +2039,7 @@ static int __init dmfe_init_module(void)
 	if (HPNA_NoiseFloor > 15)
 		HPNA_NoiseFloor = 0;

-	rc = pci_module_init(&dmfe_driver);
+	rc = pci_register_driver(&dmfe_driver);
 	if (rc < 0)
 		return rc;

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/tulip_core.c linux-work2/drivers/net/tulip/tulip_core.c
--- linux-work-clean/drivers/net/tulip/tulip_core.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/tulip/tulip_core.c	2006-08-17 05:18:56.000000000 +0200
@@ -1860,7 +1860,7 @@ static int __init tulip_init (void)
 	tulip_max_interrupt_work = max_interrupt_work;

 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	return pci_register_driver(&tulip_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/winbond-840.c linux-work2/drivers/net/tulip/winbond-840.c
--- linux-work-clean/drivers/net/tulip/winbond-840.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/tulip/winbond-840.c	2006-08-17 05:19:02.000000000 +0200
@@ -1689,7 +1689,7 @@ static struct pci_driver w840_driver = {
 static int __init w840_init(void)
 {
 	printk(version);
-	return pci_module_init(&w840_driver);
+	return pci_register_driver(&w840_driver);
 }

 static void __exit w840_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/xircom_tulip_cb.c linux-work2/drivers/net/tulip/xircom_tulip_cb.c
--- linux-work-clean/drivers/net/tulip/xircom_tulip_cb.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tulip/xircom_tulip_cb.c	2006-08-17 05:19:07.000000000 +0200
@@ -1707,7 +1707,7 @@ static int __init xircom_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&xircom_driver);
+	return pci_register_driver(&xircom_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/typhoon.c linux-work2/drivers/net/typhoon.c
--- linux-work-clean/drivers/net/typhoon.c	2006-08-17 00:10:47.000000000 +0200
+++ linux-work2/drivers/net/typhoon.c	2006-08-17 05:19:13.000000000 +0200
@@ -2660,7 +2660,7 @@ static struct pci_driver typhoon_driver
 static int __init
 typhoon_init(void)
 {
-	return pci_module_init(&typhoon_driver);
+	return pci_register_driver(&typhoon_driver);
 }

 static void __exit
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/via-rhine.c linux-work2/drivers/net/via-rhine.c
--- linux-work-clean/drivers/net/via-rhine.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/via-rhine.c	2006-08-17 05:19:18.000000000 +0200
@@ -2005,7 +2005,7 @@ static int __init rhine_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&rhine_driver);
+	return pci_register_driver(&rhine_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/via-velocity.c linux-work2/drivers/net/via-velocity.c
--- linux-work-clean/drivers/net/via-velocity.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/via-velocity.c	2006-08-17 05:19:24.000000000 +0200
@@ -2250,7 +2250,7 @@ static int __init velocity_init_module(v
 	int ret;

 	velocity_register_notifier();
-	ret = pci_module_init(&velocity_driver);
+	ret = pci_register_driver(&velocity_driver);
 	if (ret < 0)
 		velocity_unregister_notifier();
 	return ret;
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/dscc4.c linux-work2/drivers/net/wan/dscc4.c
--- linux-work-clean/drivers/net/wan/dscc4.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/dscc4.c	2006-08-17 05:19:30.000000000 +0200
@@ -2062,7 +2062,7 @@ static struct pci_driver dscc4_driver =

 static int __init dscc4_init_module(void)
 {
-	return pci_module_init(&dscc4_driver);
+	return pci_register_driver(&dscc4_driver);
 }

 static void __exit dscc4_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/farsync.c linux-work2/drivers/net/wan/farsync.c
--- linux-work-clean/drivers/net/wan/farsync.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/farsync.c	2006-08-17 05:19:37.000000000 +0200
@@ -2697,7 +2697,7 @@ fst_init(void)
 	for (i = 0; i < FST_MAX_CARDS; i++)
 		fst_card_array[i] = NULL;
 	spin_lock_init(&fst_work_q_lock);
-	return pci_module_init(&fst_driver);
+	return pci_register_driver(&fst_driver);
 }

 static void __exit
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/lmc/lmc_main.c linux-work2/drivers/net/wan/lmc/lmc_main.c
--- linux-work-clean/drivers/net/wan/lmc/lmc_main.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/lmc/lmc_main.c	2006-08-17 05:19:43.000000000 +0200
@@ -1790,7 +1790,7 @@ static struct pci_driver lmc_driver = {

 static int __init init_lmc(void)
 {
-    return pci_module_init(&lmc_driver);
+    return pci_register_driver(&lmc_driver);
 }

 static void __exit exit_lmc(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/pc300_drv.c linux-work2/drivers/net/wan/pc300_drv.c
--- linux-work-clean/drivers/net/wan/pc300_drv.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/pc300_drv.c	2006-08-17 05:19:51.000000000 +0200
@@ -3677,7 +3677,7 @@ static struct pci_driver cpc_driver = {

 static int __init cpc_init(void)
 {
-	return pci_module_init(&cpc_driver);
+	return pci_register_driver(&cpc_driver);
 }

 static void __exit cpc_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/pci200syn.c linux-work2/drivers/net/wan/pci200syn.c
--- linux-work-clean/drivers/net/wan/pci200syn.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/pci200syn.c	2006-08-17 05:19:56.000000000 +0200
@@ -476,7 +476,7 @@ static int __init pci200_init_module(voi
 		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
 		return -EINVAL;
 	}
-	return pci_module_init(&pci200_pci_driver);
+	return pci_register_driver(&pci200_pci_driver);
 }


diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/wanxl.c linux-work2/drivers/net/wan/wanxl.c
--- linux-work-clean/drivers/net/wan/wanxl.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/wanxl.c	2006-08-17 05:20:02.000000000 +0200
@@ -837,7 +837,7 @@ static int __init wanxl_init_module(void
 #ifdef MODULE
 	printk(KERN_INFO "%s\n", version);
 #endif
-	return pci_module_init(&wanxl_pci_driver);
+	return pci_register_driver(&wanxl_pci_driver);
 }

 static void __exit wanxl_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/atmel_pci.c linux-work2/drivers/net/wireless/atmel_pci.c
--- linux-work-clean/drivers/net/wireless/atmel_pci.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/atmel_pci.c	2006-08-17 05:20:06.000000000 +0200
@@ -76,7 +76,7 @@ static void __devexit atmel_pci_remove(s

 static int __init atmel_init_module(void)
 {
-	return pci_module_init(&atmel_driver);
+	return pci_register_driver(&atmel_driver);
 }

 static void __exit atmel_cleanup_module(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/ipw2100.c linux-work2/drivers/net/wireless/ipw2100.c
--- linux-work-clean/drivers/net/wireless/ipw2100.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/ipw2100.c	2006-08-17 05:20:12.000000000 +0200
@@ -6531,7 +6531,7 @@ static int __init ipw2100_init(void)
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);

-	ret = pci_module_init(&ipw2100_pci_driver);
+	ret = pci_register_driver(&ipw2100_pci_driver);

 #ifdef CONFIG_IPW2100_DEBUG
 	ipw2100_debug_level = debug;
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/ipw2200.c linux-work2/drivers/net/wireless/ipw2200.c
--- linux-work-clean/drivers/net/wireless/ipw2200.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/wireless/ipw2200.c	2006-08-17 05:20:17.000000000 +0200
@@ -11753,7 +11753,7 @@ static int __init ipw_init(void)
 	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
 	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");

-	ret = pci_module_init(&ipw_driver);
+	ret = pci_register_driver(&ipw_driver);
 	if (ret) {
 		IPW_ERROR("Unable to initialize PCI module\n");
 		return ret;
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_nortel.c linux-work2/drivers/net/wireless/orinoco_nortel.c
--- linux-work-clean/drivers/net/wireless/orinoco_nortel.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_nortel.c	2006-08-17 05:20:22.000000000 +0200
@@ -304,7 +304,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_nortel_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_nortel_driver);
+	return pci_register_driver(&orinoco_nortel_driver);
 }

 static void __exit orinoco_nortel_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_pci.c linux-work2/drivers/net/wireless/orinoco_pci.c
--- linux-work-clean/drivers/net/wireless/orinoco_pci.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_pci.c	2006-08-17 05:20:26.000000000 +0200
@@ -244,7 +244,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_pci_driver);
+	return pci_register_driver(&orinoco_pci_driver);
 }

 static void __exit orinoco_pci_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_plx.c linux-work2/drivers/net/wireless/orinoco_plx.c
--- linux-work-clean/drivers/net/wireless/orinoco_plx.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_plx.c	2006-08-17 05:20:31.000000000 +0200
@@ -351,7 +351,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_plx_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_plx_driver);
+	return pci_register_driver(&orinoco_plx_driver);
 }

 static void __exit orinoco_plx_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_tmd.c linux-work2/drivers/net/wireless/orinoco_tmd.c
--- linux-work-clean/drivers/net/wireless/orinoco_tmd.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_tmd.c	2006-08-17 05:20:37.000000000 +0200
@@ -228,7 +228,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_tmd_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_tmd_driver);
+	return pci_register_driver(&orinoco_tmd_driver);
 }

 static void __exit orinoco_tmd_exit(void)
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/prism54/islpci_hotplug.c linux-work2/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-work-clean/drivers/net/wireless/prism54/islpci_hotplug.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/prism54/islpci_hotplug.c	2006-08-17 05:20:43.000000000 +0200
@@ -313,7 +313,7 @@ prism54_module_init(void)

 	__bug_on_wrong_struct_sizes ();

-	return pci_module_init(&prism54_driver);
+	return pci_register_driver(&prism54_driver);
 }

 /* by the time prism54_module_exit() terminates, as a postcondition
diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/yellowfin.c linux-work2/drivers/net/yellowfin.c
--- linux-work-clean/drivers/net/yellowfin.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/yellowfin.c	2006-08-17 05:20:50.000000000 +0200
@@ -1434,7 +1434,7 @@ static int __init yellowfin_init (void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&yellowfin_driver);
+	return pci_register_driver(&yellowfin_driver);
 }


