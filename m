Return-Path: <linux-kernel-owner+w=401wt.eu-S1759275AbWLJFQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275AbWLJFQV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 00:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759277AbWLJFQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 00:16:21 -0500
Received: from thunk.org ([69.25.196.29]:46253 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759275AbWLJFQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 00:16:20 -0500
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH] Add Ultrabay support for the T60p Thinkpad
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1GtH0P-0007WV-Q5@candygram.thunk.org>
Date: Sun, 10 Dec 2006 00:13:41 -0500
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ultrabay Support for the T60p Thinkpad

The following patch adds support for obtaining the status and ejecting
Ultrabay devices for the T60p Thinkpad; my guess is that it probably
works on T60 Thinkpads and probably more recent Lenovo latops as well.

With the 2.03 BIOS I have been able to eject a SATA drive in an Ultrabay
carrier by using the command:

  "echo 1 > /sys/class/scsi_device/1:0:0:0/device/delete"

and upon re-inserting the it back into the device and issuing the
command:

 "echo 0 0 0 > /sys/class/scsi_host/host1/scan"

have the device appear again.  (With the 1.02 BIOS the device does not
function when re-inserted, even after a warm boot; a cold reboot is
required to store the Ultrabay device's functionality.)

More complicated Ultrabay eject and insert scripts can be found on the
ThinkWiki, although it's important to comment out the "hdparm -Y" as it
apparently doesn't work or do anything, and causes the eject process to
hang for about a minute.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: 2.6.19/drivers/acpi/ibm_acpi.c
===================================================================
--- 2.6.19.orig/drivers/acpi/ibm_acpi.c	2006-12-09 18:35:09.000000000 -0500
+++ 2.6.19/drivers/acpi/ibm_acpi.c	2006-12-09 18:35:42.000000000 -0500
@@ -169,6 +169,7 @@
 #endif
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
+	   "\\_SB.PCI0.IDE0.PRIM.MSTR",	/* T60p */
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
     );				/* A21e, R30, R31 */
 
