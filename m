Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVC1Fst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVC1Fst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 00:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVC1Fre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 00:47:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:22243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbVC1Fqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 00:46:48 -0500
Date: Sun, 27 Mar 2005 21:44:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kkeil@suse.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] isdn: hfc_usb: use NULL instead of 0
Message-Id: <20050327214444.3fb002eb.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


17 of these (all different line numbers):
drivers/isdn/hisax/hfc_usb.c:139:9: warning: Using plain integer as NULL pointer


Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/isdn/hisax/hfc_usb.c |    2 +-
 drivers/isdn/hisax/hfc_usb.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/isdn/hisax/hfc_usb.c~isdn_hfcusb_null ./drivers/isdn/hisax/hfc_usb.c
--- ./drivers/isdn/hisax/hfc_usb.c~isdn_hfcusb_null	2005-03-26 21:48:11.000000000 -0800
+++ ./drivers/isdn/hisax/hfc_usb.c	2005-03-27 21:10:19.000000000 -0800
@@ -136,7 +136,7 @@ vendor_data vdata[] = {
 	 LED_SCHEME1, {0x80, -64, -32, -16}
 	 }
 	,
-	{0, 0, 0}		/* EOL element */
+	{0, 0, NULL}		/* EOL element */
 };
 
 /***************************************************************/
diff -Naurp ./drivers/isdn/hisax/hfc_usb.h~isdn_hfcusb_null ./drivers/isdn/hisax/hfc_usb.h
--- ./drivers/isdn/hisax/hfc_usb.h~isdn_hfcusb_null	2005-03-27 21:13:10.000000000 -0800
+++ ./drivers/isdn/hisax/hfc_usb.h	2005-03-27 21:13:27.000000000 -0800
@@ -91,7 +91,7 @@
 /**********/
 /* macros */
 /**********/
-#define write_usb(a,b,c)usb_control_msg((a)->dev,(a)->ctrl_out_pipe,0,0x40,(c),(b),0,0,HFC_CTRL_TIMEOUT)
+#define write_usb(a,b,c)usb_control_msg((a)->dev,(a)->ctrl_out_pipe,0,0x40,(c),(b),NULL,0,HFC_CTRL_TIMEOUT)
 #define read_usb(a,b,c) usb_control_msg((a)->dev,(a)->ctrl_in_pipe,1,0xC0,0,(b),(c),1,HFC_CTRL_TIMEOUT)
 
 


---
