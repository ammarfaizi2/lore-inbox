Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTFTXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTFTXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:43:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:10974 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264959AbTFTXn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:43:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 21 Jun 2003 01:57:24 +0200 (MEST)
Message-Id: <UTC200306202357.h5KNvOm15238.aeb@smtp.cwi.nl>
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] mtd/maps/impa7.c fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I happened to come across mtd/maps/impa7.c.
It looks like some stuff that needs <linux/mtd/partitions.h>
occurs outside #ifdef CONFIG_MTD_PARTITIONS.
Also, there is a spurious #endif.
Also, there is one of the many redefinitions for ARRAY_SIZE.
Below a patch.

Not compiled. Not tested.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/mtd/maps/impa7.c b/drivers/mtd/maps/impa7.c
--- a/drivers/mtd/maps/impa7.c	Sun Jun 15 01:40:57 2003
+++ b/drivers/mtd/maps/impa7.c	Sat Jun 21 02:25:34 2003
@@ -66,12 +66,11 @@
 	},
 };
 
-#define NB_OF(x) (sizeof (x) / sizeof (x[0]))
+static int                   mtd_parts_nb = 0;
+static struct mtd_partition *mtd_parts    = 0;
 
 #endif
 
-static int                   mtd_parts_nb = 0;
-static struct mtd_partition *mtd_parts    = 0;
 static const char *probes[] = { "cmdlinepart", NULL };
 
 int __init init_impa7(void)
@@ -119,11 +118,11 @@
 							    0);
 			if (mtd_parts_nb > 0)
 			  part_type = "command line";
-#endif
+
 			if (mtd_parts_nb <= 0)
 			{
 				mtd_parts = static_partitions;
-				mtd_parts_nb = NB_OF(static_partitions);
+				mtd_parts_nb = ARRAY_SIZE(static_partitions);
 				part_type = "static";
 			}
 			if (mtd_parts_nb <= 0)
