Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUDVQRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUDVQRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUDVQRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:17:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:1494 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264154AbUDVQRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:17:44 -0400
Date: Thu, 22 Apr 2004 18:17:37 +0200 (MEST)
Message-Id: <200404221617.i3MGHbaS014794@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.6.6-rc2] clean up Pentium M quirk code in nmi.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the Pentium M quirk code in
nmi.c, and eliminates an unnecessary apic_read().

Local APIC accesses are not zero-cycle; let's not
inflict more damage than we must.

/Mikael

diff -ruN linux-2.6.6-rc2/arch/i386/kernel/nmi.c linux-2.6.6-rc2.nmi-fix/arch/i386/kernel/nmi.c
--- linux-2.6.6-rc2/arch/i386/kernel/nmi.c	2004-04-22 12:33:48.000000000 +0200
+++ linux-2.6.6-rc2.nmi-fix/arch/i386/kernel/nmi.c	2004-04-22 13:09:54.000000000 +0200
@@ -462,8 +462,7 @@
 			/* Only P6 based Pentium M need to re-unmask
 			 * the apic vector but it doesn't hurt
 			 * other P6 variant */
-			apic_write(APIC_LVTPC,
-				   apic_read(APIC_LVTPC) & ~APIC_LVT_MASKED);
+			apic_write(APIC_LVTPC, APIC_DM_NMI);
 		}
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
 	}
