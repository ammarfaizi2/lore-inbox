Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315446AbSENIbU>; Tue, 14 May 2002 04:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315469AbSENIbT>; Tue, 14 May 2002 04:31:19 -0400
Received: from mailg.telia.com ([194.22.194.26]:52972 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S315446AbSENIbS>;
	Tue, 14 May 2002 04:31:18 -0400
From: "Christer Nilsson" <christer.nilsson@kretskompaniet.se>
To: <greg@kroah.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.19-pre8  Fix for Intuos tablet in wacom.c
Date: Tue, 14 May 2002 10:31:45 +0200
Message-ID: <IBEJLIFNGHPKEKCKODPDEECADPAA.christer.nilsson@kretskompaniet.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The changes between 2.4.19-pre7 and 2.4.18-pre8 broke the Intuos part in
wacom.c
This will fix it.

--- linux/drivers/usb/wacom.c.org	Tue May 14 00:40:12 2002
+++ linux/drivers/usb/wacom.c	Tue May 14 00:41:31 2002
@@ -288,8 +288,8 @@
 	x = ((__u32)data[2] << 8) | data[3];
 	y = ((__u32)data[4] << 8) | data[5];

-	input_report_abs(dev, ABS_X, wacom->x);
-	input_report_abs(dev, ABS_Y, wacom->y);
+	input_report_abs(dev, ABS_X, wacom->x = x);
+	input_report_abs(dev, ABS_Y, wacom->y = y);
 	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);

 	if ((data[1] & 0xb8) == 0xa0) {						/* general pen packet */


Christer Nilsson


