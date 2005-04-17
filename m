Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVDQSUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVDQSUE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 14:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVDQSUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 14:20:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37649 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261395AbVDQSTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 14:19:48 -0400
Date: Sun, 17 Apr 2005 20:19:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Markus.Lidel@shadowconnect.com
Subject: [2.6 patch] drivers/scsi/dpt*: remove version.h dependencies
Message-ID: <20050417181942.GA3625@stusta.de>
References: <60807403EABEB443939A5A7AA8A7458B010AAA69@otce2k01.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B010AAA69@otce2k01.adaptec.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 08:56:25AM -0400, Salyzyn, Mark wrote:
> 
> You can not remove the entries in sys_info.h (osMajorVersion & friends),
> this communicates information to the application via the ioctls and the
> structure shape is important. Change the code to zero the values, leave
> osType set to OS_LINUX.

Sorry, my fault.

Corrected patch below.

> Sincerely -- Mark Salyzyn

cu
Adrian


<--  snip  -->


This patch removes version.h dependencies.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

 drivers/scsi/dpt/sys_info.h |    4 ----
 drivers/scsi/dpt_i2o.c      |    5 -----
 drivers/scsi/dpti.h         |   12 ------------
 3 files changed, 21 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/scsi/dpti.h.old	2005-04-15 01:21:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/dpti.h	2005-04-15 01:21:26.000000000 +0200
@@ -20,15 +20,7 @@
 #ifndef _DPT_H
 #define _DPT_H
 
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,00)
-#define MAX_TO_IOP_MESSAGES   (210)
-#else
 #define MAX_TO_IOP_MESSAGES   (255)
-#endif
 #define MAX_FROM_IOP_MESSAGES (255)
 
 
@@ -321,10 +313,6 @@
 static void adpt_delay(int millisec);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-static struct pci_dev* adpt_pci_find_device(uint vendor, struct pci_dev* from);
-#endif
-
 #if defined __ia64__ 
 static void adpt_ia64_info(sysInfo_S* si);
 #endif
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/dpt_i2o.c.old	2005-04-15 01:21:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/dpt_i2o.c	2005-04-15 01:25:20.000000000 +0200
@@ -34,7 +34,6 @@
 
 #define ADDR32 (0)
 
-#include <linux/version.h>
 #include <linux/module.h>
 
 MODULE_AUTHOR("Deanna Bonds, with _lots_ of help from Mark Salyzyn");
@@ -1824,10 +1823,10 @@
 
 	memset(&si, 0, sizeof(si));
 
 	si.osType = OS_LINUX;
-	si.osMajorVersion = (u8) (LINUX_VERSION_CODE >> 16);
-	si.osMinorVersion = (u8) (LINUX_VERSION_CODE >> 8 & 0x0ff);
-	si.osRevision =     (u8) (LINUX_VERSION_CODE & 0x0ff);
+	si.osMajorVersion = 0;
+	si.osMinorVersion = 0;
+	si.osRevision = 0;
 	si.busType = SI_PCI_BUS;
 	si.processorFamily = DPTI_sig.dsProcessorFamily;
 



