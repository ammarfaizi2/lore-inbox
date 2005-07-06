Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVGFCWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVGFCWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVGFCTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:19:40 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:59544 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262040AbVGFCTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:14 -0400
Subject: [PATCH] [9/48] Suspend2 2.1.9.8 for 2.6.12: 354-disable-mce-checking-during-suspend-avoid-smp-deadlock.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <11206164401343@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 360-reset-kswapd-max-order-after-resume.patch-old/mm/vmscan.c 360-reset-kswapd-max-order-after-resume.patch-new/mm/vmscan.c
--- 360-reset-kswapd-max-order-after-resume.patch-old/mm/vmscan.c	2005-07-06 11:18:05.000000000 +1000
+++ 360-reset-kswapd-max-order-after-resume.patch-new/mm/vmscan.c	2005-07-04 23:14:20.000000000 +1000
@@ -1228,8 +1228,10 @@ static int kswapd(void *p)
 	order = 0;
 	for ( ; ; ) {
 		unsigned long new_order;
-
-		try_to_freeze();
+		if (freezing(current)) {
+			try_to_freeze();
+			pgdat->kswapd_max_order = 0;
+		}
 
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
 		new_order = pgdat->kswapd_max_order;

