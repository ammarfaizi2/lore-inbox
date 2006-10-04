Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161571AbWJDQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161571AbWJDQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJDQc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:32:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:59086 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161571AbWJDQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:34 -0400
Message-Id: <20061004161512.346170000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:23 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 13/14] spiderpic: enable new style devtree support
Content-Disposition: inline; filename=spider-pic-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This enables support for new firmware test releases.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -244,7 +244,6 @@ static unsigned int __init spider_find_c
 	int imaplen, intsize, unit;
 	struct device_node *iic;
 
-#if 0 /* Enable that when we have a way to retreive the node as well */
 	/* First, we check wether we have a real "interrupts" in the device
 	 * tree in case the device-tree is ever fixed
 	 */
@@ -252,9 +251,8 @@ static unsigned int __init spider_find_c
 	if (of_irq_map_one(pic->of_node, 0, &oirq) == 0) {
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
-		goto bail;
+		return virq;
 	}
-#endif
 
 	/* Now do the horrible hacks */
 	tmp = get_property(pic->of_node, "#interrupt-cells", NULL);

--

