Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUIXFsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUIXFsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUIXFpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:45:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:11747 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267807AbUIXFmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:42:55 -0400
Subject: [PATCH] ppc32: Fix warning in pmac battery code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096004543.4011.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 15:42:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The battery calculation code in via-pmu triggers a few warnings
(and actually, one of them would lead to a real error if we ever
get an unrecognized type from the PMU). Fix this.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/drivers/macintosh/via-pmu.c linux-lappy/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2004-09-24 14:34:05.000000000 +1000
+++ linux-lappy/drivers/macintosh/via-pmu.c	2004-09-24 14:45:46.000000000 +1000
@@ -747,6 +747,8 @@
 		pmu_power_flags &= ~PMU_PWR_AC_PRESENT;
 
 
+	capa = max = amperage = voltage = 0;
+	
 	if (req->reply[1] & 0x04) {
 		bat_flags |= PMU_BATT_PRESENT;
 		switch(req->reply[0]) {
@@ -766,8 +768,7 @@
 					req->reply_len, req->reply[0], req->reply[1], req->reply[2], req->reply[3]);
 				break;
 		}
-	} else
-		capa = max = amperage = voltage = 0;
+	}
 
 	if ((req->reply[1] & 0x01) && (amperage > 0))
 		bat_flags |= PMU_BATT_CHARGING;


