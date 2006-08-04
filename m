Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWHDIbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWHDIbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWHDIbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:31:17 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:53753 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161102AbWHDIbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:31:16 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] MTD jedec_probe: Recognize Atmel AT49BV6416
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Fri, 04 Aug 2006 10:28:33 +0200
Message-Id: <11546801142874-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel AT49BV6416 is used on the AT32STK1000 development board for
AVR32. This patch makes jedec_probe recognize it.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/mtd/chips/jedec_probe.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 8f39d0a..173530b 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -67,6 +67,7 @@ #define AT49BV16X	0x00C0
 #define AT49BV16XT	0x00C2
 #define AT49BV32X	0x00C8
 #define AT49BV32XT	0x00C9
+#define AT49BV6416	0x00D6
 
 /* Fujitsu */
 #define MBM29F040C	0x00A4
@@ -630,6 +631,20 @@ static const struct amd_flash_info jedec
 			ERASEINFO(0x02000,8)
 		}
 	}, {
+		.mfr_id		= MANUFACTURER_ATMEL,
+		.dev_id		= AT49BV6416,
+		.name		= "Atmel AT49BV6416",
+		.uaddr		= {
+			[1] = MTD_UADDR_0x0555_0x0AAA,	/* x16 */
+		},
+		.DevSize	= SIZE_8MiB,
+		.CmdSet		= P_ID_AMD_STD,
+		.NumEraseRegions = 2,
+		.regions	= {
+			 ERASEINFO(0x02000, 8),
+			 ERASEINFO(0x10000, 127)
+		 }
+	}, {
 		.mfr_id		= MANUFACTURER_FUJITSU,
 		.dev_id		= MBM29F040C,
 		.name		= "Fujitsu MBM29F040C",
-- 
1.4.0

