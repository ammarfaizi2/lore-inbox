Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTGOTEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTGOTEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:04:48 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:29660 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S269509AbTGOTEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:04:42 -0400
Date: Tue, 15 Jul 2003 21:18:27 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][WATCHDOG] 2.6.0-test1 - i810-tco patch
Message-ID: <20030715211827.A459@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

included a patch against 2.5.0-test1. It adds support for the 82801EB and 82801ER I/O Controller Hub's (ICH5 & ICH5R). This will add watchdog support for the i865 and i875 motherboard chipsets.
It also removes some extra trailing spaces in the source files.

Greetings,
Wim.

------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1469  -> 1.1470 
#	drivers/char/watchdog/i810-tco.c	1.17    -> 1.18   
#	drivers/char/watchdog/i810-tco.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/15	wim@iguana.be	1.1470
# [WATCHDOG] Include support for the 82801EB and 82801ER I/O Controller Hub's.
# --------------------------------------------
#
diff -Nru a/drivers/char/watchdog/i810-tco.c b/drivers/char/watchdog/i810-tco.c
--- a/drivers/char/watchdog/i810-tco.c	Tue Jul 15 20:40:14 2003
+++ b/drivers/char/watchdog/i810-tco.c	Tue Jul 15 20:40:14 2003
@@ -25,7 +25,8 @@
  *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
  *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
  *	82801CA & 82801CAM chip : document number 290716-001, 290718-001,
- *	82801DB & 82801E   chip : document number 290744-001, 273599-001
+ *	82801DB & 82801E   chip : document number 290744-001, 273599-001,
+ *	82801EB & 82801ER  chip : document number 252516-001
  *
  *  20000710 Nils Faerber
  *	Initial Version 0.01
@@ -42,9 +43,11 @@
  *	     clean up ioctls (WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and
  *	     WDIOC_SETOPTIONS), made i810tco_getdevice __init,
  *	     removed boot_status, removed tco_timer_read,
- *	     added support for 82801DB and 82801E chipset, general cleanup.
+ *	     added support for 82801DB and 82801E chipset,
+ *	     added support for 82801EB and 8280ER chipset,
+ *	     general cleanup.
  */
- 
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -164,7 +167,7 @@
  * Reload (trigger) the timer. Lock is needed so we don't reload it during
  * a reprogramming event
  */
- 
+
 static void tco_timer_reload (void)
 {
 	spin_lock(&tco_lock);
@@ -307,6 +310,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
diff -Nru a/drivers/char/watchdog/i810-tco.h b/drivers/char/watchdog/i810-tco.h
--- a/drivers/char/watchdog/i810-tco.h	Tue Jul 15 20:40:14 2003
+++ b/drivers/char/watchdog/i810-tco.h	Tue Jul 15 20:40:14 2003
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.05:	TCO timer driver for i8xx chipsets
+ *	i810-tco:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -8,7 +8,7 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
+ *
  *	Neither kernel concepts nor Nils Faerber admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
