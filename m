Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUDCE1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUDCE1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:27:17 -0500
Received: from waste.org ([209.173.204.2]:65005 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261597AbUDCE1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:27:13 -0500
Date: Fri, 2 Apr 2004 22:27:09 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] enable suspend-on-halt for NS Geode
Message-ID: <20040403042709.GX6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This enables deep powersaving mode on Geode boxes

From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: NS Geode, enable Suspend-on-Halt


Index: linux-2.6.0-test11/arch/i386/kernel/cpu/cyrix.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test11/arch/i386/kernel/cpu/cyrix.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cyrix.c


 tiny-mpm/arch/i386/kernel/cpu/cyrix.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/cyrix.c~geode arch/i386/kernel/cpu/cyrix.c
--- tiny/arch/i386/kernel/cpu/cyrix.c~geode	2004-03-20 12:14:39.000000000 -0600
+++ tiny-mpm/arch/i386/kernel/cpu/cyrix.c	2004-03-20 12:14:39.000000000 -0600
@@ -167,7 +167,10 @@ static void __init geode_configure(void)
 	unsigned long flags;
 	u8 ccr3, ccr4;
 	local_irq_save(flags);
-	
+
+	/* Suspend on halt power saving and enable #SUSP pin */
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* Enable */
 	

_

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
