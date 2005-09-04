Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVIDXdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVIDXdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVIDXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:32:37 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:62081 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932155AbVIDXbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:19 -0400
Message-Id: <20050904232337.296861000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:53 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       Domen Puncer <domen@coderock.org>
Content-Disposition: inline; filename=dvb-ttusb-budget-time_after-cleanup.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 54/54] ttusb-budget: use time_after_eq()
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>

Use of the time_after_eq() macro, defined at linux/jiffies.h, which deal
with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-09-04 22:28:03.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-09-04 22:31:06.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/errno.h>
+#include <linux/jiffies.h>
 #include <asm/semaphore.h>
 
 #include "dvb_frontend.h"
@@ -570,7 +571,8 @@ static void ttusb_handle_sec_data(struct
 				  const u8 * data, int len);
 #endif
 
-static int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
+static int numpkt = 0, numts, numstuff, numsec, numinvalid;
+static unsigned long lastj;
 
 static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
 			   int len)
@@ -779,7 +781,7 @@ static void ttusb_iso_irq(struct urb *ur
 			u8 *data;
 			int len;
 			numpkt++;
-			if ((jiffies - lastj) >= HZ) {
+			if (time_after_eq(jiffies, lastj + HZ)) {
 #if DEBUG > 2
 				printk
 				    ("frames/s: %d (ts: %d, stuff %d, sec: %d, invalid: %d, all: %d)\n",

--

