Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293638AbSCKIf0>; Mon, 11 Mar 2002 03:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293641AbSCKIfR>; Mon, 11 Mar 2002 03:35:17 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:55562 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293638AbSCKIfE>; Mon, 11 Mar 2002 03:35:04 -0500
Date: Mon, 11 Mar 2002 09:07:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [patch] Minor fix for the via82cxxx.c IDE driver.
Message-ID: <20020311090700.A19182@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

The attached patch fixes a case where the user enters a bad value for
the system bus clock. The 3.33 version will use a nonsensical value
instead of the bad value given by user.

Patch against 2.5.6, please apply.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-3.34.diff"

diff -urN linux-2.5.5/drivers/ide/via82cxxx.c linux-2.5.5-via/drivers/ide/via82cxxx.c
--- linux-2.5.5/drivers/ide/via82cxxx.c	Mon Mar 11 08:46:22 2002
+++ linux-2.5.5-via/drivers/ide/via82cxxx.c	Mon Mar 11 09:04:17 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: via82cxxx.c,v 3.33 2001/12/23 22:46:12 vojtech Exp $
+ * $Id: via82cxxx.c,v 3.34 2002/02/12 11:26:11 vojtech Exp $
  *
  *  Copyright (c) 2000-2001 Vojtech Pavlik
  *
@@ -163,7 +163,7 @@
 
 	via_print("----------VIA BusMastering IDE Configuration----------------");
 
-	via_print("Driver Version:                     3.33");
+	via_print("Driver Version:                     3.34");
 	via_print("South Bridge:                       VIA %s", via_config->name);
 
 	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
@@ -495,7 +495,7 @@
 	if (via_clock < 20000 || via_clock > 50000) {
 		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", via_clock);
 		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.\n");
-		via_clock = 33;
+		via_clock = 33333;
 	}
 
 /*

--k+w/mQv8wyuph6w0--
