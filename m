Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSLHVlk>; Sun, 8 Dec 2002 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSLHVlk>; Sun, 8 Dec 2002 16:41:40 -0500
Received: from 12-252-52-32.client.attbi.com ([12.252.52.32]:17417 "EHLO
	waltz.gonehiking.org") by vger.kernel.org with ESMTP
	id <S261732AbSLHVlj>; Sun, 8 Dec 2002 16:41:39 -0500
Subject: [PATCH] Add support for Epson 785EPX Storage device
To: linux-kernel@vger.kernel.org
Date: Sun, 8 Dec 2002 14:43:29 -0700 (MST)
Cc: marcelo@conectiva.com.br, khalid@gonehiking.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20021208214329.F0F70374C1@waltz.gonehiking.org>
From: khalid@gonehiking.org (Khalid Aziz Khalid Shuah Khan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Epson 785EPX USB printer has a PCMCIA slot that works as a USB storage
device. usb-storage driver fails to recognize this device since it
returns 0xff for Subclass. Attached patch adds support for the PCMCIA
slot to usb-storage driver.

Marcelo, please apply.

--
Khalid Aziz
khalid@gonehiking.org
khalid@fc.hp.com



--- linux-2.4.20/drivers/usb/storage/unusual_devs.h	Thu Nov 28 16:53:15 2002
+++ linux-2.4.20-785stor/drivers/usb/storage/unusual_devs.h	Sun Dec  8 08:14:37 2002
@@ -97,6 +97,13 @@
 		"DVD-CAM DZ-MV100A Camcorder",
 		US_SC_SCSI, US_PR_CB, NULL, US_FL_SINGLE_LUN),
 
+/* Reported by Khalid Aziz <khalid@gonehiking.org>
+ * This entry is needed because the device reports Sub=ff */
+UNUSUAL_DEV(  0x04b8, 0x0602, 0x0110, 0x0110,
+		"Epson",
+		"785EPX Storage",
+		US_SC_SCSI, US_PR_BULK, NULL, US_FL_SINGLE_LUN),
+
 UNUSUAL_DEV(  0x04cb, 0x0100, 0x0000, 0x2210,
 		"Fujifilm",
 		"FinePix 1400Zoom",
