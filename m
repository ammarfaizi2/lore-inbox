Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSLKGAE>; Wed, 11 Dec 2002 01:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbSLKGAD>; Wed, 11 Dec 2002 01:00:03 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:5393
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265657AbSLKGAA>; Wed, 11 Dec 2002 01:00:00 -0500
Subject: [PATCH] fix trivial drivers/char/agp/generic.c compile warning
From: Robert Love <rml@tech9.net>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039586875.8018.23.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 01:07:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.51, I get:

 drivers/char/agp/generic.c: In function `agp_generic_create_gatt_table':
 drivers/char/agp/generic.c:472: warning: assignment from incompatible pointer type

gatt_table_real used to be 'u32' but now it is 'unsigned long'... and a
typecast was not updated.

Trivial patch applied, against 2.5.51.

	Robert Love


 drivers/char/agp/generic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -urN linux-2.5.51/drivers/char/agp/generic.c linux/drivers/char/agp/generic.c
--- linux-2.5.51/drivers/char/agp/generic.c	2002-12-10 17:45:01.000000000 -0500
+++ linux/drivers/char/agp/generic.c	2002-12-11 01:00:28.000000000 -0500
@@ -469,8 +469,8 @@
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		SetPageReserved(page);
 
-	agp_bridge.gatt_table_real = (u32 *) table;
-	agp_gatt_table = (void *)table; 
+	agp_bridge.gatt_table_real = (unsigned long *) table;
+	agp_gatt_table = (void *)table;
 	CACHE_FLUSH();
 	agp_bridge.gatt_table = ioremap_nocache(virt_to_phys(table),
 					(PAGE_SIZE * (1 << page_order)));




