Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbTC0Q7T>; Thu, 27 Mar 2003 11:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbTC0Q7T>; Thu, 27 Mar 2003 11:59:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49285
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261895AbTC0Q7R>; Thu, 27 Mar 2003 11:59:17 -0500
Date: Thu, 27 Mar 2003 18:16:46 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271816.h2RIGkgj019646@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment that the irq_nosync stuff needs revisiting
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/ide/ide-iops.c linux-2.5.66-ac1/drivers/ide/ide-iops.c
--- linux-2.5.66-bk3/drivers/ide/ide-iops.c	2003-03-27 17:13:18.000000000 +0000
+++ linux-2.5.66-ac1/drivers/ide/ide-iops.c	2003-03-26 20:05:24.000000000 +0000
@@ -903,6 +903,14 @@
          * Select the drive, and issue the SETFEATURES command
          */
 	disable_irq_nosync(hwif->irq);
+	
+	/*
+	 *	FIXME: we race against the running IRQ here if
+	 *	this is called from non IRQ context. If we use
+	 *	disable_irq() we hang on the error path. Work
+	 *	is needed.
+	 */
+	 
 	udelay(1);
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 0);
