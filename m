Return-Path: <linux-kernel-owner+w=401wt.eu-S1030217AbXAKOoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbXAKOoE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbXAKOoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:44:04 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1194 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030217AbXAKOoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:44:01 -0500
Date: Thu, 11 Jan 2007 14:43:54 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 11/10] TURBOchannel resources off-by-one fix 
Message-ID: <Pine.LNX.4.64N.0701111439070.11394@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a trivial fix to resource reservation of TURBOchannel areas, 
where the end is one byte too far.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-sysfs-resource-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/tc/tc.c linux-mips-2.6.18-20060920/drivers/tc/tc.c
--- linux-mips-2.6.18-20060920.macro/drivers/tc/tc.c	2006-12-19 23:03:11.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/tc/tc.c	2006-12-28 18:51:49.000000000 +0000
@@ -160,7 +160,7 @@ static int __init tc_init(void)
 		tc_bus.resource[0].start = tc_bus.slot_base;
 		tc_bus.resource[0].end = tc_bus.slot_base +
 					 (tc_bus.info.slot_size << 20) *
-					 tc_bus.num_tcslots;
+					 tc_bus.num_tcslots - 1;
 		tc_bus.resource[0].name = tc_bus.name;
 		tc_bus.resource[0].flags = IORESOURCE_MEM;
 		if (request_resource(&iomem_resource,
@@ -172,7 +172,7 @@ static int __init tc_init(void)
 			tc_bus.resource[1].start = tc_bus.ext_slot_base;
 			tc_bus.resource[1].end = tc_bus.ext_slot_base +
 						 tc_bus.ext_slot_size *
-						 tc_bus.num_tcslots;
+						 tc_bus.num_tcslots - 1;
 			tc_bus.resource[1].name = tc_bus.name;
 			tc_bus.resource[1].flags = IORESOURCE_MEM;
 			if (request_resource(&iomem_resource,
