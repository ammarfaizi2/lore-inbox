Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUIAVP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUIAVP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUIAVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:10:41 -0400
Received: from baikonur.stro.at ([213.239.196.228]:59076 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267840AbUIAUzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:55:45 -0400
Subject: [patch 01/25]  drivers/char/amiserial.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:55:44 +0200
Message-ID: <E1C2c8u-0007Ft-Ds@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/amiserial.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN drivers/char/amiserial.c~min-max-char_amiserial drivers/char/amiserial.c
--- linux-2.6.9-rc1-bk7/drivers/char/amiserial.c~min-max-char_amiserial	2004-09-01 19:33:30.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/amiserial.c	2004-09-01 19:33:30.000000000 +0200
@@ -118,10 +118,6 @@ static struct serial_state rs_table[1];
 
 #define NR_PORTS	(sizeof(rs_table)/sizeof(struct serial_state))
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the copy_from_user blocks while swapping in a page,
@@ -1610,7 +1606,7 @@ static void rs_wait_until_sent(struct tt
 	if (char_time == 0)
 		char_time = 1;
 	if (timeout)
-	  char_time = MIN(char_time, timeout);
+	  char_time = min_t(unsigned long, char_time, timeout);
 	/*
 	 * If the transmitter hasn't cleared in twice the approximate
 	 * amount of time to send the entire FIFO, it probably won't

_
