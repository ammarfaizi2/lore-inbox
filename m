Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUHZJdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUHZJdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268443AbUHZJbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:31:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:45247 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267745AbUHZJXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:23:21 -0400
Subject: [PATCH] ppc32: Improve workaround for 74xx CPUs with broken BTIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093512033.6539.161.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 19:20:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The previous workaround didn't enable the BTIC bit on CPUs where it
is broken. However, it seems some firmwares will unconditionally set
it, so this new patch will actually _clear_ it on CPUs where it is
broken.

Please apply,
Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc/kernel/cpu_setup_6xx.S 1.5 vs edited =====
--- 1.5/arch/ppc/kernel/cpu_setup_6xx.S	2004-07-16 02:16:53 +10:00
+++ edited/arch/ppc/kernel/cpu_setup_6xx.S	2004-08-26 19:16:36 +10:00
@@ -218,10 +218,10 @@
 
 	/* All of the bits we have to set.....
 	 */
-	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_LRSTK
+	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_LRSTK | HID0_BTIC
 BEGIN_FTR_SECTION
-	ori	r11,r11,HID0_BTIC
-END_FTR_SECTION_IFCLR(CPU_FTR_NO_BTIC)
+	xori	r11,r11,HID0_BTIC
+END_FTR_SECTION_IFSET(CPU_FTR_NO_BTIC)
 BEGIN_FTR_SECTION
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)


