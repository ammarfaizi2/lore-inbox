Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVBDHix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVBDHix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVBDHaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:30:11 -0500
Received: from [211.58.254.17] ([211.58.254.17]:42921 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263305AbVBDHNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:24 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 10/14] ide_pci: Removes SPLIT_BYTE macro from pdc202xx_old
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071319.16B3E1326FB@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


10_ide_pci_pdc202xx_old_cleanup.patch

	Removes SPLIT_BYTE macro from ide/pci/pdc202xx_old driver.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/pdc202xx_old.c	2005-02-04 16:07:36.544417372 +0900
+++ linux-idepci-export/drivers/ide/pci/pdc202xx_old.c	2005-02-04 16:08:26.197330649 +0900
@@ -69,7 +69,8 @@
 		((sc1c & 0x02) == 0x02) ? "8" :
 		((sc1c & 0x01) == 0x01) ? "6" :
 		((sc1c & 0x00) == 0x00) ? "4" : "??");
-	SPLIT_BYTE(sc1e, hi, lo);
+	hi = sc1e >> 4;
+	lo = sc1e & 0xf;
 	p += sprintf(p, "Status Polling Period                : %d\n", hi);
 	p += sprintf(p, "Interrupt Check Status Polling Delay : %d\n", lo);
 #endif
Index: linux-idepci-export/drivers/ide/pci/pdc202xx_old.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/pdc202xx_old.h	2005-02-04 16:07:36.544417372 +0900
+++ linux-idepci-export/drivers/ide/pci/pdc202xx_old.h	2005-02-04 16:08:26.197330649 +0900
@@ -5,10 +5,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-
 #define PDC202XX_DEBUG_DRIVE_INFO		0
 
 static const char *pdc_quirk_drives[] = {
