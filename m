Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVBWSlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVBWSlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVBWSlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:41:02 -0500
Received: from mail13.svc.cra.dublin.eircom.net ([159.134.118.29]:21773 "HELO
	mail13.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S261529AbVBWSkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:40:53 -0500
Message-ID: <421CCE98.4090406@eircom.net>
Date: Wed, 23 Feb 2005 18:42:32 +0000
From: Telemaque Ndizihiwe <telendiz@eircom.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: duncan.sands@free.fr
CC: linux-usb-devel@lists.sourceforge.net, torvalds@osdl.org, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] Replaces (2 * HZ) with DATA_TIMEOUT in /drivers/usb/atm/speedtch.c
Content-Type: multipart/mixed;
 boundary="------------000009050606090008070108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000009050606090008070108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This Patch replaces "(2 * HZ)" with "DATA_TIMEOUT" which is defined as
     #define DATA_TIMEOUT (2 * HZ)
in /drivers/usb/atm/speedtch.c in kernel 2.6.10.

Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>


--- linux-2.6.10/drivers/usb/atm/speedtch.c.orig    2005-02-20 
12:44:22.235267848 +0000
+++ linux-2.6.10/drivers/usb/atm/speedtch.c    2005-02-20 
12:50:52.205983288 +0000
@@ -494,7 +494,7 @@ static void speedtch_upload_firmware(str
     /* URB 7 */
     if (dl_512_first) {    /* some modems need a read before writing 
the firmware */
         ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, 
SPEEDTCH_ENDPOINT_FIRMWARE),
-                   buffer, 0x200, &actual_length, 2 * HZ);
+                   buffer, 0x200, &actual_length, DATA_TIMEOUT);
 
         if (ret < 0 && ret != -ETIMEDOUT)
             dbg("speedtch_upload_firmware: read BLOCK0 from modem 
failed (%d)!", ret);


--------------000009050606090008070108
Content-Type: text/plain;
 name="patch-usb-speedtch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-usb-speedtch"

--- linux-2.6.10/drivers/usb/atm/speedtch.c.orig	2005-02-20 12:44:22.235267848 +0000
+++ linux-2.6.10/drivers/usb/atm/speedtch.c	2005-02-20 12:50:52.205983288 +0000
@@ -494,7 +494,7 @@ static void speedtch_upload_firmware(str
 	/* URB 7 */
 	if (dl_512_first) {	/* some modems need a read before writing the firmware */
 		ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, SPEEDTCH_ENDPOINT_FIRMWARE),
-				   buffer, 0x200, &actual_length, 2 * HZ);
+				   buffer, 0x200, &actual_length, DATA_TIMEOUT);
 
 		if (ret < 0 && ret != -ETIMEDOUT)
 			dbg("speedtch_upload_firmware: read BLOCK0 from modem failed (%d)!", ret);

--------------000009050606090008070108--
