Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUIXFgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUIXFgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUIXFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:36:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:7139 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267769AbUIXFgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:36:02 -0400
Subject: [PATCH] ppc32/64: Fix warning in pmac ide
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096004132.4011.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 15:35:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is a gcc error, but let's fix it anyway, it isn't a perf critical
codepath and warnings are ugly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


diff -urN linux-2.5/drivers/ide/ppc/pmac.c linux-lappy/drivers/ide/ppc/pmac.c
--- linux-2.5/drivers/ide/ppc/pmac.c	2004-09-24 14:33:57.000000000 +1000
+++ linux-lappy/drivers/ide/ppc/pmac.c	2004-09-24 14:46:20.000000000 +1000
@@ -792,7 +792,7 @@
 set_timings_mdma(ide_drive_t *drive, int intf_type, u32 *timings, u32 *timings2,
 			u8 speed, int drive_cycle_time)
 {
-	int cycleTime, accessTime, recTime;
+	int cycleTime, accessTime = 0, recTime = 0;
 	unsigned accessTicks, recTicks;
 	struct mdma_timings_t* tm = NULL;
 	int i;


