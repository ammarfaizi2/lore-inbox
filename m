Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbUL0XuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbUL0XuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUL0XuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:50:23 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:9720 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262004AbUL0XuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:50:14 -0500
Date: Tue, 28 Dec 2004 08:50:00 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       dwmw2@redhat.com
Subject: [PATCH 2.6.10] mtd: added NEC uPD29F064115 support
Message-Id: <20041228085000.5d2c4625.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added NEC uPD29F064115 support to jedec_probe.c.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/drivers/mtd/chips/jedec_probe.c a/drivers/mtd/chips/jedec_probe.c
--- a-orig/drivers/mtd/chips/jedec_probe.c	Sat Dec 25 06:35:40 2004
+++ a/drivers/mtd/chips/jedec_probe.c	Tue Dec 28 00:56:41 2004
@@ -32,6 +32,7 @@
 #define MANUFACTURER_HYUNDAI	0x00AD
 #define MANUFACTURER_INTEL	0x0089
 #define MANUFACTURER_MACRONIX	0x00C2
+#define MANUFACTURER_NEC	0x0010
 #define MANUFACTURER_PMC	0x009D
 #define MANUFACTURER_SST	0x00BF
 #define MANUFACTURER_ST		0x0020
@@ -115,6 +116,9 @@
 #define MX29F004T	0x0045
 #define MX29F004B	0x0046
 
+/* NEC */
+#define UPD29F064115	0x221C
+
 /* PMC */
 #define PM49FL002	0x006D
 #define PM49FL004	0x006E
@@ -1186,6 +1190,22 @@
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
+		}
+	}, {
+		.mfr_id		= MANUFACTURER_NEC,
+		.dev_id		= UPD29F064115,
+		.name		= "NEC uPD29F064115",
+		.uaddr		= {
+			[0] = MTD_UADDR_0x0555_0x02AA,  /* x8 */
+			[1] = MTD_UADDR_0x0555_0x02AA,  /* x16 */
+		},
+		.DevSize	= SIZE_8MiB,
+		.CmdSet		= P_ID_AMD_STD,
+		.NumEraseRegions= 3,
+		.regions	= {
+			ERASEINFO(0x2000,8),
+			ERASEINFO(0x10000,126),
+			ERASEINFO(0x2000,8),
 		}
 	}, {
 		.mfr_id		= MANUFACTURER_PMC,
