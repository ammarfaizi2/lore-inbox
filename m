Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVA2TTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVA2TTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVA2TP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:15:27 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:45952 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261558AbVA2TOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:14:25 -0500
To: linux-kernel@vger.kernel.org, ftdi-usb-sio-devel@sourceforge.net
Subject: patch - ftdi_sio.c floods my logs with "write request of 0 bytes"
From: "Elias Oltmanns" <oltmanns@uni-bonn.de>
Date: Sat, 29 Jan 2005 19:14:18 +0000
Message-ID: <873bwkcak5.fsf@denkblock.local>
User-Agent: Gnus/5.1007 (Gnus v5.10.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

unfortunately, I'm everything else but a developer, so please be a bit
patient with me.

As indicated by the subject, I got annoyed by the error message
mentioned flooding my log files. Comparing ftdi_sio.c to some of the
other usb->serial converter drivers, I decided to apply the following
small patch:

________
--- linux-2.6.10.orig/drivers/usb/serial/ftdi_sio.c	2004-12-24 21:35:24.000000000 +0000
+++ linux-2.6.10/drivers/usb/serial/ftdi_sio.c	2005-01-29 17:10:11.000000000 +0000
@@ -1518,7 +1518,7 @@
 	dbg("%s port %d, %d bytes", __FUNCTION__, port->number, count);
 
 	if (count == 0) {
-		err("write request of 0 bytes");
+		dbg("%s - write request of 0 bytes", __FUNCTION__);
 		return 0;
 	}
 	
________

It solved my problem but I can't judge, of course, whether the use of
err() instead of dbg() is justified or even common in this place, as,
for instance, ftdi_sio.c is considered experimental. Therefore I would
be grateful to get a short response.

Thank you very much in advance,

Elias
