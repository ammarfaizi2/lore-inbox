Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbSLSKS4>; Thu, 19 Dec 2002 05:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbSLSKSz>; Thu, 19 Dec 2002 05:18:55 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:31409 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267607AbSLSKSy>;
	Thu, 19 Dec 2002 05:18:54 -0500
Date: Thu, 19 Dec 2002 11:26:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Reiser <jreiser@BitWagon.com>, AnonimoVeneziano <voloterreno@tin.it>,
       Patrick Petermair <black666@inode.at>,
       Roland Quast <rquast@hotshed.com>, LKML <linux-kernel@vger.kernel.org>
Subject: vt8235 fix, hopefully last variant
Message-ID: <20021219112640.A21164@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Can you guys try out this last take on a fix for your ATAPI device
problems? Applies against clean 2.4.20.

Please report failure/success.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=vt8235-atapi

ChangeSet@1.884, 2002-12-19 11:23:11+01:00, vojtech@suse.cz
  VIA IDE: Always use slow address setup timings for ATAPI devices.


 via82cxxx.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)


diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Thu Dec 19 11:23:42 2002
+++ b/drivers/ide/pci/via82cxxx.c	Thu Dec 19 11:23:42 2002
@@ -1,16 +1,5 @@
 /*
- * $Id: via82cxxx.c,v 3.35-ac2 2002/09/111 Alan Exp $
- *
- *  Copyright (c) 2000-2001 Vojtech Pavlik
- *
- *  Based on the work of:
- *	Michel Aubry
- *	Jeff Garzik
- *	Andre Hedrick
- */
-
-/*
- * Version 3.35
+ * Version 3.36
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -152,7 +141,7 @@
 	via_print("----------VIA BusMastering IDE Configuration"
 		"----------------");
 
-	via_print("Driver Version:                     3.35-ac");
+	via_print("Driver Version:                     3.36");
 	via_print("South Bridge:                       VIA %s",
 		via_config->name);
 
@@ -351,6 +340,10 @@
 		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
+
+	/* Always use 4 address setup clocks on ATAPI devices */
+	if (drive->media != ide_disk)
+		t.setup = 4;
 
 	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
 

--vtzGhvizbBRQ85DL--
