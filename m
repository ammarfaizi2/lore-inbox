Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVCEWtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVCEWtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCEWsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:40 -0500
Received: from coderock.org ([193.77.147.115]:31909 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261300AbVCEWly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:41:54 -0500
Subject: [patch 2/4] acorn/fd1772: replace sleep_on() with wait_event()
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:41:48 +0100
Message-Id: <20050305224149.11CE41F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use wait_event() instead of the deprecated sleep_on(). Since
wait_event() expects the condition upon which the loop should return, pass in
the negation of the current conditional.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/acorn/block/fd1772.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/acorn/block/fd1772.c~wait_event-drivers_acorn_block_fd1772 drivers/acorn/block/fd1772.c
--- kj/drivers/acorn/block/fd1772.c~wait_event-drivers_acorn_block_fd1772	2005-03-05 16:11:23.000000000 +0100
+++ kj-domen/drivers/acorn/block/fd1772.c	2005-03-05 16:11:23.000000000 +0100
@@ -139,6 +139,7 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
+#include <linux/wait.h>
 
 #include <asm/arch/oldlatches.h>
 #include <asm/dma.h>
@@ -1283,8 +1284,7 @@ static void do_fd_request(request_queue_
 	if (fdc_busy) return;
 	save_flags(flags);
 	cli();
-	while (fdc_busy)
-		sleep_on(&fdc_wait);
+	wait_event(fdc_wait, !fdc_busy);
 	fdc_busy = 1;
 	ENABLE_IRQ();
 	restore_flags(flags);
_
