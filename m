Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbUKPPuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUKPPuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUKPPuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:50:06 -0500
Received: from mail19.bluewin.ch ([195.186.18.65]:26034 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S262002AbUKPPuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:50:00 -0500
Date: Tue, 16 Nov 2004 16:49:43 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] visor: Always do generic_startup
Message-ID: <20041116154943.GA13874@k3.hellgate.ch>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

generic_startup in visor.c was not called for some hardware, resulting
in attempts to access memory that had never been allocated, which in
turn caused the problem several people reported with recent (2.6.10ish)
kernels.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.10-rc2/drivers/usb/serial/visor.c.orig	2004-11-16 16:03:05.000000000 +0100
+++ linux-2.6.10-rc2/drivers/usb/serial/visor.c	2004-11-16 16:31:24.235249944 +0100
@@ -930,7 +930,7 @@ static int treo_attach (struct usb_seria
 	if (!((serial->dev->descriptor.idVendor == HANDSPRING_VENDOR_ID) ||
 	      (serial->dev->descriptor.idVendor == KYOCERA_VENDOR_ID)) ||
 	    (serial->num_interrupt_in == 0))
-		return 0;
+		goto generic_startup;
 
 	dbg("%s", __FUNCTION__);
 
@@ -957,6 +957,7 @@ static int treo_attach (struct usb_seria
 	COPY_PORT(serial->port[1], swap_port);
 	kfree(swap_port);
 
+generic_startup:
 	return generic_startup(serial);
 }
 
