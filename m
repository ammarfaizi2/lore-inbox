Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWFSSvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWFSSvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWFSStz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:49:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:2260 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932459AbWFSSnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:22 -0400
Message-Id: <20060619183404.213201000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:17 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 02/20] cell: fix interrupt priority handling
Content-Disposition: inline; filename=cell-iic-cleanup.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the priority field to test for irq validity is
completely bogus and breaks with future external interrupt
controllers.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Index: powerpc.git/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/interrupt.c
+++ powerpc.git/arch/powerpc/platforms/cell/interrupt.c
@@ -117,8 +117,7 @@ static int iic_external_get_irq(struct c
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

