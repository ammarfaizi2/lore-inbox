Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVA1V5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVA1V5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVA1V5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:57:15 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:9091 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262786AbVA1V5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:57:03 -0500
Date: Fri, 28 Jan 2005 22:56:57 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] 2.6.11-rc2 i8xx_tco.c-ICH4/6/7-patch
Message-ID: <20050128215657.GA10053@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/i8xx_tco.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/01/28 1.1984)
   [WATCHDOG] i8xx_tco.c-ICH4/6/7-patch
   
   Added support for the ICH4-M, ICH6, ICH6R, ICH6-M, ICH6W and ICH6RW
   chipsets. Also added support for the "undocumented" ICH7.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	2005-01-28 22:51:31 +01:00
+++ b/drivers/char/watchdog/i8xx_tco.c	2005-01-28 22:51:31 +01:00
@@ -1,5 +1,5 @@
 /*
- *	i8xx_tco 0.06:	TCO timer driver for i8xx chipsets
+ *	i8xx_tco 0.07:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -22,11 +22,22 @@
  *
  *	The TCO timer is implemented in the following I/O controller hubs:
  *	(See the intel documentation on http://developer.intel.com.)
- *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
- *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
- *	82801CA & 82801CAM chip : document number 290716-001, 290718-001,
- *	82801DB & 82801E   chip : document number 290744-001, 273599-001,
- *	82801EB & 82801ER  chip : document number 252516-001
+ *	82801AA  (ICH)    : document number 290655-003, 290677-014,
+ *	82801AB  (ICHO)   : document number 290655-003, 290677-014,
+ *	82801BA  (ICH2)   : document number 290687-002, 298242-027,
+ *	82801BAM (ICH2-M) : document number 290687-002, 298242-027,
+ *	82801CA  (ICH3-S) : document number 290733-003, 290739-013,
+ *	82801CAM (ICH3-M) : document number 290716-001, 290718-007,
+ *	82801DB  (ICH4)   : document number 290744-001, 290745-020,
+ *	82801DBM (ICH4-M) : document number 252337-001, 252663-005,
+ *	82801E   (C-ICH)  : document number 273599-001, 273645-002,
+ *	82801EB  (ICH5)   : document number 252516-001, 252517-003,
+ *	82801ER  (ICH5R)  : document number 252516-001, 252517-003,
+ *	82801FB  (ICH6)   : document number 301473-002, 301474-007,
+ *	82801FR  (ICH6R)  : document number 301473-002, 301474-007,
+ *	82801FBM (ICH6-M) : document number 301473-002, 301474-007,
+ *	82801FW  (ICH6W)  : document number 301473-001, 301474-007,
+ *	82801FRW (ICH6RW) : document number 301473-001, 301474-007
  *
  *  20000710 Nils Faerber
  *	Initial Version 0.01
@@ -49,6 +60,9 @@
  *  20030921 Wim Van Sebroeck <wim@iguana.be>
  *	0.06 change i810_margin to heartbeat, use module_param,
  *	     added notify system support, renamed module to i8xx_tco.
+ *  20050128 Wim Van Sebroeck <wim@iguana.be>
+ *	0.07 Added support for the ICH4-M, ICH6, ICH6R, ICH6-M, ICH6W and ICH6RW
+ *	     chipsets. Also added support for the "undocumented" ICH7 chipset.
  */
 
 /*
@@ -73,7 +87,7 @@
 #include "i8xx_tco.h"
 
 /* Module and version information */
-#define TCO_VERSION "0.06"
+#define TCO_VERSION "0.07"
 #define TCO_MODULE_NAME "i8xx TCO timer"
 #define TCO_DRIVER_NAME   TCO_MODULE_NAME ", v" TCO_VERSION
 #define PFX TCO_MODULE_NAME ": "
@@ -360,8 +374,14 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE (pci, i8xx_tco_pci_tbl);
