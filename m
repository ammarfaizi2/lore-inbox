Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTLAVxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbTLAVxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:53:50 -0500
Received: from mx2.mail.ru ([194.67.23.22]:10769 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S263971AbTLAVxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:53:46 -0500
Message-ID: <3FCBB867.7030606@mail.ru>
Date: Mon, 01 Dec 2003 16:53:43 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (ICQ: 1045670, AIM: infiniteparticle)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aic79xx on Opteron compilation issues.
Content-Type: multipart/mixed;
 boundary="------------000506020700010801010904"
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506020700010801010904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The 2.4.23 kernel would not compile with aic79xx support enabled.
The error message is attached.
In a nutshell it complains about function not used.

The patch attached is just a pair of "ifndef __x86_64__" statements.

I don't know all the details, but the kernel seems to compile and the 
driver work after patching.
I tried to partition and format the drive, then copied files onto it.
While doing that, did not notice anything extraordinary in dmesg output.





--------------000506020700010801010904
Content-Type: text/plain;
 name="aic79xx_osm_pci.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aic79xx_osm_pci.c.patch"

diff -urN linux-2.4.23/drivers/scsi/aic7xxx/aic79xx_osm_pci.c linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- linux-2.4.23/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2003-08-25 07:44:42.000000000 -0400
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2003-12-01 15:51:53.000000000 -0500
@@ -52,9 +52,11 @@
 					const struct pci_device_id *ent);
 static int	ahd_linux_pci_reserve_io_regions(struct ahd_softc *ahd,
 						 u_long *base, u_long *base2);
+#ifndef __x86_64__
 static int	ahd_linux_pci_reserve_mem_region(struct ahd_softc *ahd,
 						 u_long *bus_addr,
 						 uint8_t **maddr);
+#endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void	ahd_linux_pci_dev_remove(struct pci_dev *pdev);
 
@@ -271,6 +273,9 @@
 	return (0);
 }
 
+
+#ifndef __x86_64__
+
 static int
 ahd_linux_pci_reserve_mem_region(struct ahd_softc *ahd,
 				 u_long *bus_addr,
@@ -319,6 +324,8 @@
 	return (error);
 }
 
+#endif
+
 int
 ahd_pci_map_registers(struct ahd_softc *ahd)
 {

--------------000506020700010801010904
Content-Type: text/plain;
 name="description.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="description.txt"

diff -urN linux-2.4.23/drivers/scsi/aic7xxx/aic79xx_osm_pci.c linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- linux-2.4.23/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2003-08-25 07:44:42.000000000 -0400
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2003-12-01 15:51:53.000000000 -0500
@@ -52,9 +52,11 @@
 					const struct pci_device_id *ent);
 static int	ahd_linux_pci_reserve_io_regions(struct ahd_softc *ahd,
 						 u_long *base, u_long *base2);
+#ifndef __x86_64__
 static int	ahd_linux_pci_reserve_mem_region(struct ahd_softc *ahd,
 						 u_long *bus_addr,
 						 uint8_t **maddr);
+#endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void	ahd_linux_pci_dev_remove(struct pci_dev *pdev);
 
@@ -271,6 +273,9 @@
 	return (0);
 }
 
+
+#ifndef __x86_64__
+
 static int
 ahd_linux_pci_reserve_mem_region(struct ahd_softc *ahd,
 				 u_long *bus_addr,
@@ -319,6 +324,8 @@
 	return (error);
 }
 
+#endif
+
 int
 ahd_pci_map_registers(struct ahd_softc *ahd)
 {

--------------000506020700010801010904--

