Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVBTNkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVBTNkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 08:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBTNkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 08:40:13 -0500
Received: from mail08.svc.cra.dublin.eircom.net ([159.134.118.24]:14951 "HELO
	mail08.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S261622AbVBTNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 08:40:08 -0500
Subject: [PATCH] Replaces (2 * HZ) with DATA_TIMEOUT in
	/drivers/usb/atm/speedtch.c
From: Telemaque Ndizihiwe <telendiz@eircom.net>
To: duncan.sands@free.fr
Cc: linux-usb-devel@lists.sourceforge.net, torvalds@osdl.org, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 20 Feb 2005 13:41:39 +0000
Message-Id: <1108906899.3769.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch replaces "(2 * HZ)" with "DATA_TIMEOUT" which is defined as
	#define DATA_TIMEOUT (2 * HZ)
in /drivers/usb/atm/speedtch.c in kernel 2.6.10.

Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>

--- linux-2.6.10/drivers/usb/atm/speedtch.c.orig	2005-02-20
12:44:22.235267848 +0000
+++ linux-2.6.10/drivers/usb/atm/speedtch.c	2005-02-20
12:50:52.205983288 +0000
@@ -494,7 +494,7 @@ static void speedtch_upload_firmware(str
 	/* URB 7 */
 	if (dl_512_first) {	/* some modems need a read before writing the
firmware */
 		ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev,
SPEEDTCH_ENDPOINT_FIRMWARE),
-				   buffer, 0x200, &actual_length, 2 * HZ);
+				   buffer, 0x200, &actual_length, DATA_TIMEOUT);
 
 		if (ret < 0 && ret != -ETIMEDOUT)
 			dbg("speedtch_upload_firmware: read BLOCK0 from modem failed (%d)!",
ret);



