Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUHYJbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUHYJbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUHYJ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:29:24 -0400
Received: from webapps.arcom.com ([194.200.159.168]:46602 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S264246AbUHYJSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:18:17 -0400
Subject: [PATCH] MTD: Additional JEDEC device types
From: Ian Campbell <icampbell@arcom.com>
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1093425445.19804.14.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 10:18:14 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Aug 2004 09:21:15.0218 (UTC) FILETIME=[DED73B20:01C48A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a resend of a patch sent on 17 August and ack'd by David
Woodhouse then.

The patch has been committed to the MTD CVS tree and adds
entries to jedec_probe.c for AMD AM29F002T, Hyundai HY29F002T and
Macronix MX29F002T parts.

This version is slightly updated from the previous once since I
accidentally added MANUFACTURER_MACRONIX when it already existed. I also
moved the new definitions to go along with the alphabetical by
manufacturer layout of the file.

Ian.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

%description
Add support for a couple of BIOS ROM devices.

%patch
Index: linux-2.6-bk/drivers/mtd/chips/jedec_probe.c
===================================================================
--- linux-2.6-bk.orig/drivers/mtd/chips/jedec_probe.c	2004-08-10 17:49:44.000000000 +0100
+++ linux-2.6-bk/drivers/mtd/chips/jedec_probe.c	2004-08-25 10:01:58.645626059 +0100
@@ -29,6 +29,7 @@
 #define MANUFACTURER_AMD	0x0001
 #define MANUFACTURER_ATMEL	0x001f
 #define MANUFACTURER_FUJITSU	0x0004
+#define MANUFACTURER_HYUNDAI	0x00AD
 #define MANUFACTURER_INTEL	0x0089
 #define MANUFACTURER_MACRONIX	0x00C2
 #define MANUFACTURER_PMC	0x009D
@@ -56,6 +57,7 @@
 #define AM29F040	0x00A4
 #define AM29LV040B	0x004F
 #define AM29F032B	0x0041
+#define AM29F002T	0x00B0
 
 /* Atmel */
 #define AT49BV512	0x0003
@@ -77,6 +79,8 @@
 #define MBM29LV400TC	0x22B9
 #define MBM29LV400BC	0x22BA
 
+/* Hyundai */
+#define HY29F002T	0x00B0
 
 /* Intel */
 #define I28F004B3T	0x00d4
@@ -106,6 +110,7 @@
 #define MX29LV160T	0x22C4
 #define MX29LV160B	0x2249
 #define MX29F016	0x00AD
+#define MX29F002T	0x00B0
 #define MX29F004T	0x0045
 #define MX29F004B	0x0046
 
@@ -507,6 +512,17 @@
 			ERASEINFO(0x10000,8),
 		}
 	}, {
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
 		.mfr_id		= MANUFACTURER_ATMEL,
 		.dev_id		= AT49BV512,
 		.name		= "Atmel AT49BV512",
@@ -752,6 +768,17 @@
 			ERASEINFO(0x04000,1)
 		}
 	}, {
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
 		.mfr_id		= MANUFACTURER_INTEL,
 		.dev_id		= I28F004B3B,
 		.name		= "Intel 28F004B3B",
@@ -1135,6 +1162,17 @@
 			ERASEINFO(0x10000,7),
 		}
 	}, {
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
+	}, {
 		.mfr_id		= MANUFACTURER_PMC,
 		.dev_id		= PM49FL002,
 		.name		= "PMC Pm49FL002",
@@ -1570,7 +1608,7 @@
 			ERASEINFO(0x02000, 2),
 			ERASEINFO(0x04000, 1),
 		}
-	} 
+	}
 };
 
 


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

