Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCTEIR>; Mon, 19 Mar 2001 23:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbRCTEIH>; Mon, 19 Mar 2001 23:08:07 -0500
Received: from h0.handhelds.org ([204.123.13.90]:59909 "EHLO handhelds.org")
	by vger.kernel.org with ESMTP id <S129736AbRCTEIB>;
	Mon, 19 Mar 2001 23:08:01 -0500
Date: Mon, 19 Mar 2001 20:10:40 -0800 (PST)
From: George France <france@handhelds.org>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 2.4.2-ac20] trivial -  de4x5 driver - stops the oops on Alpha
 XP1000's
Message-ID: <Pine.LNX.4.21.0103191955220.1702-100000@handhelds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.4.2-ac20-orig/drivers/net/de4x5.c
linux-2.4.2-ac20/drivers/net/de4x5.c
--- linux-2.4.2-ac20-orig/drivers/net/de4x5.c	Mon Mar 19 17:24:04 2001
+++ linux-2.4.2-ac20/drivers/net/de4x5.c	Mon Mar 19 18:32:01 2001
@@ -429,11 +429,17 @@
                            <mporter@eng.mcd.mot.com>
                           Remove double checking for DEBUG_RX in
de4x5_dbg_rx()
 			   from report by <geert@linux-m68k.org>
- 
+      0.546  22-Feb-01    Fixes Alpha XP1000 oops.  The srom_search
function
+                           was causing a page fault when initializing the
+                           variable 'pb', on a non de4x5 PCI device, in
this
+                           case a PCI bridge (DEC chip 21152). The value
of
+                           'pb' is now only initialized if a de4x5 chip
is
+                           present. 
+                           <france@handhelds.org>  

=========================================================================
 */
 
-static const char *version = "de4x5.c:V0.545 1999/11/28
davies@maniac.ultranet.com\n";
+static const char *version = "de4x5.c:V0.546 2001/02/22
davies@maniac.ultranet.com\n";
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -2304,12 +2310,12 @@
 	/* Skip the pci_bus list entry */
 	if (list_entry(walk, struct pci_bus, devices) ==
dev->bus) continue;
 
-	pb = this_dev->bus->number;
 	vendor = this_dev->vendor;
 	device = this_dev->device << 8;
 	if (!(is_DC21040 || is_DC21041 || is_DC21140 ||
is_DC2114x)) continue;
 
 	/* Get the chip configuration revision register */
+	pb = this_dev->bus->number;
 	pcibios_read_config_dword(pb, this_dev->devfn, PCI_REVISION_ID,
&cfrv);
 
 	/* Set the device number information */


