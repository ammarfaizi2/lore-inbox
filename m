Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWD2Xnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWD2Xnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWD2XnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65220 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750833AbWD2XnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:10 -0400
Message-Id: <20060429233920.028529000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:15 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 03/13] cell: fix interrupt priority handling
Content-Disposition: inline; filename=cell-iic-cleanup.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the priority field to test for irq validity is
completely bogus and breaks with future external interrupt
controllers.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linus-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/interrupt.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/interrupt.c	2006-04-29 22:53:41.000000000 +0200
@@ -136,8 +136,7 @@
 		 * One of these units can be connected
 		 * to an external interrupt controller.
 		 */
-		if (pending.prio > 0x3f ||
-		    pending.class != 2)
+		if (pending.class != 2)
 			break;
 		irq = IIC_EXT_OFFSET
 			+ spider_get_irq(node)

--

