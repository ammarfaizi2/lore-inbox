Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTGKRxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbTGKRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:52:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:644
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264683AbTGKRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:51:29 -0400
Date: Fri, 11 Jul 2003 19:05:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111805.h6BI5G8C017224@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: genrtc sets owner fields so..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/char/genrtc.c linux-2.5.75-ac1/drivers/char/genrtc.c
--- linux-2.5.75/drivers/char/genrtc.c	2003-07-10 21:14:22.000000000 +0100
+++ linux-2.5.75-ac1/drivers/char/genrtc.c	2003-07-11 14:29:57.000000000 +0100
@@ -355,8 +355,6 @@
 	if (gen_rtc_status & RTC_IS_OPEN)
 		return -EBUSY;
 
-	MOD_INC_USE_COUNT;
-
 	gen_rtc_status |= RTC_IS_OPEN;
 	gen_rtc_irq_data = 0;
 	irq_active = 0;
@@ -374,8 +372,6 @@
 	gen_clear_rtc_irq_bit(RTC_PIE|RTC_AIE|RTC_UIE);
 
 	gen_rtc_status &= ~RTC_IS_OPEN;
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
