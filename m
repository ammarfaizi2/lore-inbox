Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUHQOWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUHQOWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUHQOWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:22:43 -0400
Received: from webapps.arcom.com ([194.200.159.168]:38415 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268248AbUHQOTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:19:16 -0400
Subject: [PATCH] MTD: Additional JEDEC device types
From: Ian Campbell <icampbell@arcom.com>
To: torvalds@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1092752350.9001.109.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 15:19:11 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2004 14:21:53.0515 (UTC) FILETIME=[8B32EBB0:01C48465]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following patch was just committed to the MTD CVS tree and adds
entries to jedec_probe.c for AMD AM29F002T, Hyundai HY29F002T and
Macronix MX29F002T parts.

Please apply.

Cheers,
Ian.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

%description
Add support for a couple of BIOS ROM devices.

%patch
Index: linux-2.6-bk/drivers/mtd/chips/jedec_probe.c
===================================================================
--- linux-2.6-bk.orig/drivers/mtd/chips/jedec_probe.c	2004-08-10 17:49:44.000000000 +0100
+++ linux-2.6-bk/drivers/mtd/chips/jedec_probe.c	2004-08-17 09:28:05.001562971 +0100
@@ -36,7 +36,8 @@
 #define MANUFACTURER_ST		0x0020
 #define MANUFACTURER_TOSHIBA	0x0098
 #define MANUFACTURER_WINBOND	0x00da
-
+#define MANUFACTURER_HYUNDAI	0x00AD
+#define MANUFACTURER_MACRONIX	0x00C2
 
 /* AMD */
 #define AM29DL800BB	0x22C8
@@ -56,6 +57,7 @@
 #define AM29F040	0x00A4
 #define AM29LV040B	0x004F
 #define AM29F032B	0x0041
+#define AM29F002T	0x00B0
 
 /* Atmel */
 #define AT49BV512	0x0003
@@ -154,6 +156,11 @@
 /* Winbond */
 #define W49V002A	0x00b0
 
+/* Hyundai */
+#define HY29F002T	0x00B0
+
+/* Macronix */
+#define MX29F002T	0x00B0
 
 /*
  * Unlock address sets for AMD command sets.
@@ -1570,7 +1577,40 @@
 			ERASEINFO(0x02000, 2),
 			ERASEINFO(0x04000, 1),
 		}
-	} 
+	}, {
+		mfr_id: MANUFACTURER_AMD,
+		dev_id: AM29F002T,
+		name: "AMD AM29F002T",
+		DevSize: SIZE_256KiB,
+		NumEraseRegions: 4,
+		regions: {ERASEINFO(0x10000,3),
+			  ERASEINFO(0x08000,1),
+			  ERASEINFO(0x02000,2),
+			  ERASEINFO(0x04000,1)
+		}
+	}, {
+		mfr_id: MANUFACTURER_HYUNDAI,
+		dev_id: HY29F002T,
+		name: "Hyundai HY29F002T",
+		DevSize: SIZE_256KiB,
+		NumEraseRegions: 4,
+		regions: {ERASEINFO(0x10000,3),
+			  ERASEINFO(0x08000,1),
+			  ERASEINFO(0x02000,2),
+			  ERASEINFO(0x04000,1)
+		}
+	}, {
+		mfr_id: MANUFACTURER_MACRONIX,
+		dev_id: MX29F002T,
+		name: "Macronix MX29F002T",
+		DevSize: SIZE_256KiB,
+		NumEraseRegions: 4,
+		regions: {ERASEINFO(0x10000,3),
+			  ERASEINFO(0x08000,1),
+			  ERASEINFO(0x02000,2),
+			  ERASEINFO(0x04000,1)
+		}
+	}
 };
 
 


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

