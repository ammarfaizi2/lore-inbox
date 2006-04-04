Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWDDOPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWDDOPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWDDOPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:15:25 -0400
Received: from web35506.mail.mud.yahoo.com ([66.163.179.130]:23231 "HELO
	web35506.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932205AbWDDOPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:15:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tmE+QGb4tGAe4PqcZBXWBBbIDxQ/SUNsNLZ7TFLTXtAiEp/CmydWecEdRYM0J8sgOPhgOfaNSspbYwO/TEvUh/3+W2BhdIs4YQ+Syq7BCzqTw4ACN6JdUz+4dvfmsm4/HyqhttvUbjbw+TKXfTFdE1lhJfYS7Kt8WLRxD6mKlls=  ;
Message-ID: <20060404141520.7778.qmail@web35506.mail.mud.yahoo.com>
Date: Tue, 4 Apr 2006 07:15:20 -0700 (PDT)
From: Denis Sunko <nim4daz@yahoo.com>
Subject: [PATCH] unusual_devs.h, kernel 2.6.15.6
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, greg@kroah.com, david@2gen.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an UNUSUAL_DEV entry which prevents a particular usb
drive from flooding the console with useless SCSI messages. It is
patterned after similar ones for other manufacturers. I also took the
opportunity to correct the order of entries, manufacturer 0x0451 was
out of order.

I thank David Härdeman for help with this one.

Denis Sunko

--- linux-2.6.15.6-vanilla/drivers/usb/storage/unusual_devs.h	2006-04-04 14:15:10.000000000 +0200
+++ linux-2.6.15.6-patched/drivers/usb/storage/unusual_devs.h	2006-04-04 14:07:39.000000000 +0200
@@ -127,6 +127,14 @@
  		US_SC_SCSI, US_PR_DPCM_USB, NULL, 0 ),
 #endif
 
+/* Patch submitted by Daniel Drake <dsd@gentoo.org>
+ * Device reports nonsense bInterfaceProtocol 6 when connected over USB2 */
+UNUSUAL_DEV(  0x0451, 0x5416, 0x0100, 0x0100,
+		"Neuros Audio",
+		"USB 2.0 HD 2.5",
+		US_SC_DEVICE, US_PR_BULK, NULL,
+		US_FL_NEED_OVERRIDE ),
+
 /*
  * Pete Zaitcev <zaitcev@yahoo.com>, from Patrick C. F. Ernzer, bz#162559.
  * The key does not actually break, but it returns zero sense which
@@ -137,13 +145,14 @@
 		"USB Mass Storage Device",
 		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
 
-/* Patch submitted by Daniel Drake <dsd@gentoo.org>
- * Device reports nonsense bInterfaceProtocol 6 when connected over USB2 */
-UNUSUAL_DEV(  0x0451, 0x5416, 0x0100, 0x0100,
-		"Neuros Audio",
-		"USB 2.0 HD 2.5",
-		US_SC_DEVICE, US_PR_BULK, NULL,
-		US_FL_NEED_OVERRIDE ),
+/*
+ * Denis Sunko <nim4daz@yahoo.com>
+ * The key makes the SCSI stack print confusing (but harmless) messages
+ */
+UNUSUAL_DEV(  0x0457, 0x0151, 0x0100, 0x0100,
+		"Silicon Integrated Systems Corp.",
+		"Drive UT_USB20",
+		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
 
 /* Patch submitted by Philipp Friedrich <philipp@void.at> */
 UNUSUAL_DEV(  0x0482, 0x0100, 0x0100, 0x0100,


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
