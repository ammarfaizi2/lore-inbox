Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbULVWCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbULVWCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 17:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbULVWCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 17:02:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:32679 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262059AbULVWC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 17:02:26 -0500
Date: Wed, 22 Dec 2004 14:01:39 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 1/2] USB: drivers/usb/atm/usb_atm.c: fix nonzero snd_padding case
Message-ID: <20041222220139.GA9864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the patch to fix the case when snd_padding is not zero, updated
according to Duncan's comments.  Also it changes the driver name to reflect
its generic nature.

Signed-off-by: Roman Kagan <rkagan@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- linux-2.6.10-rc3.debug/drivers/usb/atm/usb_atm.c	2004-12-22 19:30:54.000000000 +0300
+++ linux-2.6.10-rc3.test/drivers/usb/atm/usb_atm.c	2004-12-22 19:31:32.652744999 +0300
@@ -94,7 +94,7 @@
 
 #define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@free.fr>"
 #define DRIVER_VERSION	"1.8"
-#define DRIVER_DESC	"Alcatel SpeedTouch USB driver version " DRIVER_VERSION
+#define DRIVER_DESC	"Generic USB ATM/DSL I/O, version " DRIVER_VERSION
 
 static unsigned int num_rcv_urbs = UDSL_DEFAULT_RCV_URBS;
 static unsigned int num_snd_urbs = UDSL_DEFAULT_SND_URBS;
@@ -369,10 +369,6 @@
 	if (!(ctrl->num_cells -= ne) || !(howmany -= ne))
 		goto out;
 
-	if (instance->snd_padding) {
-		memset(target, 0, instance->snd_padding);
-		target += instance->snd_padding;
-	}
 	udsl_fill_cell_header(target, ctrl->atm_data.vcc);
 	target += ATM_CELL_HEADER;
 	memcpy(target, skb->data, skb->len);
@@ -387,6 +383,10 @@
 			goto out;
 		}
 
+		if (instance->snd_padding) {
+			memset(target, 0, instance->snd_padding);
+			target += instance->snd_padding;
+		}
 		udsl_fill_cell_header(target, ctrl->atm_data.vcc);
 		target += ATM_CELL_HEADER;
 		memset(target, 0, ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER);


