Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265342AbUFBFqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbUFBFqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 01:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbUFBFqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 01:46:19 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:52471 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265342AbUFBFqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 01:46:15 -0400
Date: Wed, 2 Jun 2004 06:46:14 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] MTD: add st m50fw0* to jedec_probe.c
Message-ID: <Pine.LNX.4.58.0406020642310.16424@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore my last patch, my hardware guy pointed me at some more
chips,

so this patch adds support to the jedec probe for ST M50FW040, M50FW080
and M50FW016 all Firmware hubs for i8x0 chipsets,
http://www.st.com/stonline/products/families/memories/fl_nor/fl_fwh.htm

From: Dave Airlie <airlied@linux.ie>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

--- /storage/2.6/linux-2.6.4/drivers/mtd/chips/jedec_probe.c	2004-03-15 14:15:30.000000000 +1100
+++ linux-2.6.6/drivers/mtd/chips/jedec_probe.c	2004-06-22 21:51:55.019354760 +1000
@@ -109,6 +109,9 @@
 #define M29W160DT	0x22C4
 #define M29W160DB	0x2249
 #define M29W040B	0x00E3
+#define M50FW040	0x002C
+#define M50FW080	0x002D
+#define M50FW016	0x002E

 /* SST */
 #define SST29EE512	0x005d
@@ -1234,6 +1237,45 @@
 		.regions	= {
 			ERASEINFO(0x10000,8),
 		}
+        }, {
+		.mfr_id		= MANUFACTURER_ST,
+		.dev_id		= M50FW040,
+		.name		= "ST M50FW040",
+		.uaddr		= {
+			[0] = MTD_UADDR_UNNECESSARY,    /* x8 */
+		},
+		.DevSize	= SIZE_512KiB,
+		.CmdSet		= P_ID_INTEL_EXT,
+		.NumEraseRegions= 1,
+		.regions	= {
+			ERASEINFO(0x10000,8),
+		}
+        }, {
+		.mfr_id		= MANUFACTURER_ST,
+		.dev_id		= M50FW080,
+		.name		= "ST M50FW080",
+		.uaddr		= {
+			[0] = MTD_UADDR_UNNECESSARY,    /* x8 */
+		},
+		.DevSize	= SIZE_1MiB,
+		.CmdSet		= P_ID_INTEL_EXT,
+		.NumEraseRegions= 1,
+		.regions	= {
+			ERASEINFO(0x10000,16),
+		}
+        }, {
+		.mfr_id		= MANUFACTURER_ST,
+		.dev_id		= M50FW016,
+		.name		= "ST M50FW016",
+		.uaddr		= {
+			[0] = MTD_UADDR_UNNECESSARY,    /* x8 */
+		},
+		.DevSize	= SIZE_2MiB,
+		.CmdSet		= P_ID_INTEL_EXT,
+		.NumEraseRegions= 1,
+		.regions	= {
+			ERASEINFO(0x10000,32),
+		}
 	}, {
 		.mfr_id		= MANUFACTURER_TOSHIBA,
 		.dev_id		= TC58FVT160,
